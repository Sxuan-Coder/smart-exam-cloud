package top.sxuan.exam.service;

import top.sxuan.exam.model.entity.ExamQuAnswer;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 自动评分接口
 *
 */
public interface IAutoScoringService extends IService<ExamQuAnswer> {
    /**
     * 自动评分服务
     * 
     * @param examId 考试ID
     * @param userId 用户ID
     * @return 评分结果列表
     */
    void autoScoringExam(Integer examId, Integer userId);
}