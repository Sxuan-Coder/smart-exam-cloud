package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.ExamQuAnswer;
import top.sxuan.exam.model.vo.score.QuestionAnalyseVO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 */
public interface IExamQuAnswerService extends IService<ExamQuAnswer> {

    /**
     * 获取某场考试某题作答情况
     * 
     * @param examId     考试id
     * @param questionId 试题id
     * @return 结果
     */
    Result<QuestionAnalyseVO> questionAnalyse(Integer examId, Integer questionId);

}
