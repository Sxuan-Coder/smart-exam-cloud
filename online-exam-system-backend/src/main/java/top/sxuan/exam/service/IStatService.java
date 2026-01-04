package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.ExamGrade;
import top.sxuan.exam.model.vo.stat.AllStatsVO;
import top.sxuan.exam.model.vo.stat.DailyVO;
import top.sxuan.exam.model.vo.stat.GradeExamVO;
import top.sxuan.exam.model.vo.stat.GradeStudentVO;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 统计管理服务接口
 *
 */
public interface IStatService extends IService<ExamGrade> {

    /**
     * 各班人数统计
     *
     * @return 响应结果
     */
    Result<List<GradeStudentVO>> getStudentGradeCount();

    /**
     * 各班级的试卷数统计
     */
    Result<List<GradeExamVO>> getExamGradeCount();

    /**
     * 统计所有班级、试卷、试题数量
     */
    Result<AllStatsVO> getAllCount();

    /**
     * 获取用户登录时间统计
     */
    Result<List<DailyVO>> getDaily();
}
