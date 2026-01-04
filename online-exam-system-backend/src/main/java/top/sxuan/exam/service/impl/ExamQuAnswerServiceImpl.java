package top.sxuan.exam.service.impl;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.mapper.ExamQuAnswerMapper;
import top.sxuan.exam.model.entity.ExamQuAnswer;
import top.sxuan.exam.model.vo.score.QuestionAnalyseVO;
import top.sxuan.exam.service.IExamQuAnswerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DecimalFormat;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 */
@Service
public class ExamQuAnswerServiceImpl extends ServiceImpl<ExamQuAnswerMapper, ExamQuAnswer>
        implements IExamQuAnswerService {

    @Resource
    private ExamQuAnswerMapper examQuAnswerMapper;

    @Override
    public Result<QuestionAnalyseVO> questionAnalyse(Integer examId, Integer questionId) {
        QuestionAnalyseVO questionAnalyseVO = examQuAnswerMapper.questionAnalyse(examId, questionId);
        // 正确率保留两位小数
        DecimalFormat format = new DecimalFormat("#.00");
        String strAccuracy = format.format(questionAnalyseVO.getRightCount() / questionAnalyseVO.getTotalCount());
        questionAnalyseVO.setAccuracy(Double.parseDouble(strAccuracy));
        return Result.success(null, questionAnalyseVO);
    }

}
