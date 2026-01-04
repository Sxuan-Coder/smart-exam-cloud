package top.sxuan.exam.service.impl;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import top.sxuan.exam.common.exception.ServiceRuntimeException;
import top.sxuan.exam.mapper.ExamQuAnswerMapper;
import top.sxuan.exam.model.entity.ExamQuAnswer;
import top.sxuan.exam.utils.agent.AIChat;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import top.sxuan.exam.model.vo.question.QuestionScoreVO;
import top.sxuan.exam.service.IAutoScoringService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class AutoScoringServiceImpl extends ServiceImpl<ExamQuAnswerMapper, ExamQuAnswer>
        implements IAutoScoringService {

    @Autowired
    private ExamQuAnswerMapper examQuAnswerMapper;

    @Autowired
    private AIChat aiChat;

    @Autowired
    private PlatformTransactionManager platformTransactionManager;

    @Override
    @Async
    public void autoScoringExam(Integer examId, Integer userId) {
        int maxAttempts = 3; // 最大重试次数
        long retryDelay = 5000; // 每次重试之间的间隔时间（毫秒）

        for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            // 定义事务属性
            DefaultTransactionDefinition def = new DefaultTransactionDefinition();
            def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);

            // 开启事务
            TransactionStatus status = platformTransactionManager.getTransaction(def);
            try {
                // 1. 获取考试答案
                List<QuestionScoreVO> questions = examQuAnswerMapper.getQuestionsForGrading(examId, userId);

                // 2. 构建评分请求并转化为 JSON 字符串
                String scoringRequest = JSONUtil.toJsonStr(questions);

                // 调用 AI 聊天接口，返回结果是 JSON 格式
                String response = aiChat.getChatResponse(scoringRequest).trim();
                System.out.println(response);
                String scoringResult = response; // 默认尝试解析全文

                // 尝试提取 JSON 对象部分
                Pattern pattern = Pattern.compile("```json\\r?\\n?(.*?)\\r?\\n?```|(\\{(?:.|\n)*\\})", Pattern.DOTALL);
                Matcher matcher = pattern.matcher(response);
                if (matcher.find()) {
                    scoringResult = matcher.group(1) != null ? matcher.group(1).trim() : matcher.group(2).trim();
                } else {
                    // 如果没找到标记，尝试找第一个 { 和最后一个 }
                    int start = response.indexOf("{");
                    int end = response.lastIndexOf("}");
                    if (start != -1 && end != -1 && end > start) {
                        scoringResult = response.substring(start, end + 1);
                    }
                }

                // 4. 解析评分结果
                JSONArray scoreArray = JSONUtil
                        .parseArray(JSONUtil
                                .parseObj(scoringResult)
                                .getStr("评分结果"));

                // 5. 更新ai评分和扣分原因到数据库
                for (int i = 0; i < scoreArray.size(); i++) {
                    JSONObject item = scoreArray.getJSONObject(i);
                    ExamQuAnswer examQuAnswer = new ExamQuAnswer();
                    examQuAnswer.setQuestionId(Integer.valueOf(item.getStr("题目ID")));
                    examQuAnswer.setAiScore(item.getDouble("最终得分"));

                    JSONObject gradingDetail = item.getJSONObject("评分详情");
                    if (gradingDetail != null) {
                        // 存储详细 JSON 结构
                        examQuAnswer.setAiGradingDetail(JSONUtil.toJsonStr(gradingDetail));

                        // 提取扣分明细作为主要原因展示
                        JSONArray deductions = gradingDetail.getJSONArray("deductionDetails");
                        if (deductions != null && !deductions.isEmpty()) {
                            StringBuilder reasoning = new StringBuilder();
                            for (Object d : deductions) {
                                if (reasoning.length() > 0)
                                    reasoning.append("; ");
                                reasoning.append(d.toString());
                            }
                            examQuAnswer.setAiReason(reasoning.toString());
                        } else {
                            examQuAnswer.setAiReason("符合标准，记录良好");
                        }
                    }

                    // 构建查询条件
                    LambdaQueryWrapper<ExamQuAnswer> queryWrapper = new LambdaQueryWrapper<>();
                    queryWrapper.eq(ExamQuAnswer::getExamId, examId)
                            .eq(ExamQuAnswer::getUserId, userId)
                            .eq(ExamQuAnswer::getQuestionId, examQuAnswer.getQuestionId());

                    // 获取当前需要评分的记录
                    ExamQuAnswer existingRecord = getOne(queryWrapper);
                    if (existingRecord != null) {
                        // 如果存在，更新记录
                        examQuAnswer.setId(existingRecord.getId());
                        updateById(examQuAnswer);
                    } else {
                        // 否则抛出异常
                        throw new ServiceRuntimeException(
                                "ai评分失败！找不到对应答题记录 [题目ID: " + examQuAnswer.getQuestionId() + "]");
                    }
                }

                // ai评分成功，提交事务，跳出重试循环
                platformTransactionManager.commit(status);
                return;
            } catch (Exception e) {
                // 回滚事务
                platformTransactionManager.rollback(status);
                // 如果达到最大重试次数，抛出异常
                if (attempt == maxAttempts) {
                    throw new RuntimeException("ai评分重试多次后仍然失败！", e);
                }

                // 等待一段时间后重试
                try {
                    TimeUnit.MILLISECONDS.sleep(retryDelay);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                    throw new RuntimeException("线程中断！", ie);
                }
            }
        }
    }
}