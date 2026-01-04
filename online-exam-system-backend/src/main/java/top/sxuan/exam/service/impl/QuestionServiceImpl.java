package top.sxuan.exam.service.impl;

import top.sxuan.exam.common.exception.ServiceRuntimeException;
import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.converter.QuestionConverter;
import top.sxuan.exam.mapper.ExerciseRecordMapper;
import top.sxuan.exam.mapper.OptionMapper;
import top.sxuan.exam.mapper.QuestionMapper;
import top.sxuan.exam.model.entity.ExerciseRecord;
import top.sxuan.exam.model.entity.Option;
import top.sxuan.exam.model.entity.Question;
import top.sxuan.exam.model.form.question.AiGenerateQuestionForm;
import top.sxuan.exam.model.form.question.QuestionExcelFrom;
import top.sxuan.exam.model.form.question.QuestionFrom;
import top.sxuan.exam.model.vo.question.QuestionVO;
import top.sxuan.exam.service.IQuestionService;
import top.sxuan.exam.utils.agent.AIChat;
import top.sxuan.exam.utils.agent.Constants;
import top.sxuan.exam.utils.SecurityUtil;
import top.sxuan.exam.utils.excel.ExcelUtils;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.*;

/**
 * 试题管理实现类
 *
 */
@Slf4j
@Service
public class QuestionServiceImpl extends ServiceImpl<QuestionMapper, Question> implements IQuestionService {

    @Resource
    private QuestionConverter questionConverter;
    @Resource
    private QuestionMapper questionMapper;
    @Resource
    private OptionMapper optionMapper;
    @Resource
    private ExerciseRecordMapper exerciseRecordMapper;
    @Resource
    private AIChat aiChat;

    @Override
    @Transactional
    public Result<String> addSingleQuestion(QuestionFrom questionFrom) {
        // 入参校验
        List<Option> options = questionFrom.getOptions();
        if (questionFrom.getQuType() != 4 && (Objects.isNull(options) || options.size() < 2)) {
            return Result.failed("非简答题的试题选项不能少于两个");
        }
        Question question = questionConverter.fromToEntity(questionFrom);
        // 开始添加题干
        questionMapper.insert(question);
        // 根据试题类型添加选项
        if (question.getQuType() == 4) {
            // 简答题添加选项
            Option option = questionFrom.getOptions().get(0);
            option.setQuId(question.getId());
            optionMapper.insert(option);
        } else {
            // 非简答题添加选项
            // 把新建试题获取的id，填入选项中
            options.forEach(option -> {
                option.setQuId(question.getId());
            });
            optionMapper.insertBatch(options);
        }
        return Result.success("单题添加成功");

    }

    @Override
    @Transactional
    public Result<String> deleteBatchByIds(String ids) {
        List<Integer> qIdList = Arrays.stream(ids.split(",")).map(Integer::parseInt)
                .collect(java.util.stream.Collectors.toList());
        // 删除用户刷题记录表
        LambdaUpdateWrapper<ExerciseRecord> updateWrapper = new LambdaUpdateWrapper<ExerciseRecord>()
                .in(ExerciseRecord::getQuestionId, qIdList);
        exerciseRecordMapper.delete(updateWrapper);
        // 先删除选项
        optionMapper.deleteBatchIds(qIdList);
        // 再删除试题
        questionMapper.deleteBatchIds(qIdList);
        return Result.success("批量删除试题成功");
    }

    @Override
    public Result<IPage<QuestionVO>> pagingQuestion(Integer pageNum, Integer pageSize, String title, Integer type,
            Integer repoId) {
        IPage<QuestionVO> page = new Page<>(pageNum, pageSize);
        // 获取用户和角色代码
        Integer userId = SecurityUtil.getUserId();
        Integer roleCode = SecurityUtil.getRoleCode();
        // 查询分页试题
        page = questionMapper.selectQuestionPage(page, userId, roleCode, title, type, repoId);
        return Result.success("分页查询试题成功", page);
    }

    @Override
    public Result<QuestionVO> querySingle(Integer id) {
        QuestionVO result = questionMapper.selectSingle(id);
        return Result.success("根据试题id获取单题详情成功", result);
    }

    @Override
    @Transactional
    public Result<String> updateQuestion(QuestionFrom questionFrom) {
        // 修改试题
        Question question = questionConverter.fromToEntity(questionFrom);
        questionMapper.updateById(question);
        // 修改选项
        List<Option> options = questionFrom.getOptions();
        for (Option option : options) {
            optionMapper.updateById(option);
        }
        return Result.success("修改试题成功");
    }

    @SneakyThrows(Exception.class)
    @Override
    @Transactional
    public Result<String> importQuestion(Integer id, MultipartFile file) {
        if (!ExcelUtils.isExcel(Objects.requireNonNull(file.getOriginalFilename()))) {
            throw new ServiceRuntimeException("该文件不是一个合法的Excel文件");
        }

        try {
            List<QuestionExcelFrom> questionExcelFroms = ExcelUtils.readMultipartFile(file, QuestionExcelFrom.class);
            // 类型转换
            List<QuestionFrom> list = QuestionExcelFrom.converterQuestionFrom(questionExcelFroms);

            for (QuestionFrom questionFrom : list) {
                Question question = questionConverter.fromToEntity(questionFrom);
                question.setRepoId(id);
                // 添加单题获取Id
                questionMapper.insert(question);
                // 批量添加选项
                List<Option> options = questionFrom.getOptions();
                final int[] count = { 0 };
                options.forEach(option -> {
                    // 简答题答案默认给正确
                    if (question.getQuType() == 4) {
                        option.setIsRight(1);
                    }
                    option.setSort(++count[0]);
                    option.setQuId(question.getId());
                });
                // 避免简答题没有答案
                if (!options.isEmpty()) {
                    optionMapper.insertBatch(options);
                }
            }

            return Result.success("导入试题成功");
        } catch (ServiceRuntimeException e) {
            // 捕获并返回业务异常，保留详细错误信息
            return Result.failed(e.getMessage());
        } catch (Exception e) {
            // 捕获其他异常
            return Result.failed("导入试题失败：" + e.getMessage());
        }
    }

    @Override
    @SneakyThrows(Exception.class)
    public Result<List<QuestionVO>> generateQuestions(AiGenerateQuestionForm form) {
        // 1. 构建 Prompt
        String userPrompt = String.format("请根据以下文本生成 %d 道题目类型为 %d 的试题：\n%s",
                form.getCount(), form.getQuType(), form.getText());

        // 2. 调用 AI
        String rawResponse = aiChat.getChatResponse(Constants.generateQuestionSystemMessage + "\n" + userPrompt);

        log.info("AI 原始返回内容长度: {} 字符", rawResponse.length());

        // 3. 多层策略提取 JSON
        String jsonContent = extractJsonFromResponse(rawResponse);

        if (jsonContent == null) {
            log.error("无法从 AI 返回中提取有效 JSON，原始内容: {}", rawResponse);
            return Result.failed("AI 返回格式无法识别，请重试");
        }

        log.info("提取到的 JSON 内容: {}", jsonContent.substring(0, Math.min(200, jsonContent.length())) + "...");

        // 4. 清理 JSON 内容,移除可能导致解析失败的字符
        jsonContent = cleanJsonContent(jsonContent);

        try {
            JSONArray array = JSONUtil.parseArray(jsonContent);
            List<QuestionVO> resultList = new ArrayList<>();

            for (int i = 0; i < array.size(); i++) {
                JSONObject obj = array.getJSONObject(i);
                QuestionVO vo = new QuestionVO();
                vo.setQuType(obj.getInt("quType"));
                vo.setContent(obj.getStr("content"));
                vo.setAnalysis(obj.getStr("analysis"));
                vo.setQuLevel(obj.getInt("quLevel"));
                vo.setKnowledgePoint(obj.getStr("knowledgePoint"));

                JSONArray optArray = obj.getJSONArray("options");
                if (optArray != null) {
                    List<Option> options = new ArrayList<>();
                    for (int j = 0; j < optArray.size(); j++) {
                        JSONObject optObj = optArray.getJSONObject(j);
                        Option option = new Option();
                        option.setContent(optObj.getStr("content"));
                        option.setIsRight(optObj.getInt("isRight"));
                        option.setSort(j + 1);
                        options.add(option);
                    }
                    vo.setOptions(options);
                }
                resultList.add(vo);
            }
            log.info("成功解析 {} 道题目", resultList.size());
            return Result.success("AI 生成题目成功", resultList);
        } catch (Exception e) {
            log.error("JSON 解析失败，清理后的内容: {}", jsonContent, e);
            return Result.failed("AI 返回格式解析失败: " + e.getMessage());
        }
    }

    /**
     * 多层策略从 AI 返回中提取 JSON 内容
     * 
     * @param rawResponse AI 原始返回
     * @return 提取的 JSON 字符串，如果所有策略都失败则返回 null
     */
    private String extractJsonFromResponse(String rawResponse) {
        if (rawResponse == null || rawResponse.trim().isEmpty()) {
            log.warn("AI 原始返回内容为空或只包含空白字符");
            return null;
        }

        String content = rawResponse.trim();
        log.debug("开始提取 JSON，原始内容（截断前200字符）: {}", content.substring(0, Math.min(200, content.length())));

        // 策略1: 移除 markdown 代码块标记 (```json 或 ```)
        if (content.contains("```")) {
            log.debug("检测到 markdown 代码块，尝试移除");
            // 移除所有可能的代码块标记
            content = content.replaceAll("```json\\s*", "")
                    .replaceAll("```\\s*", "")
                    .trim();
            log.debug("移除 markdown 标记后内容（截断前200字符）: {}", content.substring(0, Math.min(200, content.length())));
        }

        // 策略2: 提取 JSON 数组 (查找第一个 [ 和最后一个 ])
        if (!content.startsWith("[")) {
            log.debug("内容不以 [ 开头，尝试提取 JSON 数组");
            int start = content.indexOf("[");
            int end = content.lastIndexOf("]");
            if (start != -1 && end != -1 && end > start) {
                content = content.substring(start, end + 1);
                log.debug("成功提取 JSON 数组，长度: {}", content.length());
            } else {
                log.warn("未找到有效的 JSON 数组边界，内容（截断前200字符）: {}", content.substring(0, Math.min(200, content.length())));
            }
        }

        // 策略3: 清理可能的前后缀文本
        content = content.trim();

        // 策略4: 移除可能的 BOM 和特殊字符
        if (content.startsWith("\uFEFF")) {
            content = content.substring(1);
            log.debug("移除 BOM 字符");
        }

        // 策略5: 验证是否为有效的 JSON 数组格式
        if (!content.startsWith("[") || !content.endsWith("]")) {
            log.warn("提取的内容不是有效的 JSON 数组格式，尝试进行括号匹配修复。内容（截断前200字符）: {}",
                    content.substring(0, Math.min(200, content.length())));
            // 最后尝试：查找任何看起来像 JSON 数组的部分
            int start = content.indexOf("[");
            int end = -1;
            if (start != -1) {
                // 从后往前找匹配的 ]
                int bracketCount = 0;
                for (int i = content.length() - 1; i >= start; i--) {
                    if (content.charAt(i) == ']') {
                        bracketCount++;
                    } else if (content.charAt(i) == '[') {
                        bracketCount--;
                        // 如果括号匹配平衡且当前是最后一个 [，则找到对应的 ]
                        if (bracketCount == 0) {
                            // 找到从当前 [ 之后第一个 ] 的位置
                            end = content.indexOf(']', i);
                            if (end != -1) {
                                break;
                            }
                        }
                    }
                }
                if (end != -1) {
                    content = content.substring(start, end + 1);
                    log.debug("通过括号匹配提取 JSON，长度: {}", content.length());
                }
            }
        }

        // 最终验证
        if (content.startsWith("[") && content.endsWith("]")) {
            log.debug("JSON 提取成功，最终内容（截断前200字符）: {}", content.substring(0, Math.min(200, content.length())));
            return content;
        }

        log.error("所有提取策略均失败，无法从 AI 返回中获取有效 JSON。最终处理内容（截断前200字符）: {}",
                content.substring(0, Math.min(200, content.length())));
        return null;
    }

    /**
     * 清理 JSON 内容,移除可能导致解析失败的字符
     * 
     * @param jsonContent 原始 JSON 字符串
     * @return 清理后的 JSON 字符串
     */
    private String cleanJsonContent(String jsonContent) {
        if (jsonContent == null || jsonContent.isEmpty()) {
            return jsonContent;
        }

        String cleaned = jsonContent;

        // 1. 移除不可见的控制字符(保留换行、制表符、回车)
        cleaned = cleaned.replaceAll("[\\u0000-\\u0008\\u000B\\u000C\\u000E-\\u001F\\u007F-\\u009F]", "");

        // 2. 确保所有换行符都是标准的 \n (JSON 允许的转义字符)
        // 注意: JSON 字符串内的换行符应该是 \\n (转义后的),不应该是实际的换行符
        // 但如果 AI 返回的 JSON 已经包含了转义后的换行符,就不需要处理

        // 3. 移除 Zero Width Space 等不可见字符
        cleaned = cleaned.replace("\u200B", "") // Zero Width Space
                .replace("\u200C", "") // Zero Width Non-Joiner
                .replace("\u200D", "") // Zero Width Joiner
                .replace("\uFEFF", ""); // BOM

        // 4. 检查并修复可能的 JSON 格式问题
        // 如果清理后的内容与原始内容不同,记录日志
        if (!cleaned.equals(jsonContent)) {
            log.debug("JSON 清理完成,移除了 {} 个字符", jsonContent.length() - cleaned.length());
        }

        return cleaned;
    }

    @Override
    @Transactional
    public Result<String> batchAddQuestion(List<QuestionFrom> list) {
        if (list == null || list.isEmpty()) {
            return Result.failed("试题列表不能为空");
        }
        for (QuestionFrom questionFrom : list) {
            Question question = questionConverter.fromToEntity(questionFrom);
            // 添加单题获取Id
            questionMapper.insert(question);
            // 批量添加选项
            List<Option> options = questionFrom.getOptions();
            if (options != null && !options.isEmpty()) {
                final int[] count = { 0 };
                options.forEach(option -> {
                    // 简答题答案默认给正确
                    if (question.getQuType() == 4) {
                        option.setIsRight(1);
                    }
                    option.setSort(++count[0]);
                    option.setQuId(question.getId());
                });
                optionMapper.insertBatch(options);
            }
        }
        return Result.success("批量添加试题成功");
    }
}
