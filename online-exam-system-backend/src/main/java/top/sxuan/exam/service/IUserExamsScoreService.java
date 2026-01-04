package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.UserExamsScore;
import top.sxuan.exam.model.vo.score.GradeScoreVO;
import top.sxuan.exam.model.vo.score.UserScoreVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import javax.servlet.http.HttpServletResponse;

/**
 * 成绩管理服务接口
 *
 */
public interface IUserExamsScoreService extends IService<UserExamsScore> {

    /**
     * 分页获取成绩信息
     */
    Result<IPage<UserScoreVO>> pagingScore(Integer pageNum, Integer pageSize, Integer gradeId, Integer examId,
            String realName);

    /**
     * 成绩导出

     */
    void exportScores(HttpServletResponse response, Integer examId, Integer gradeId);

    /**
     * 根据班级分析考试情况
     */
    Result<IPage<GradeScoreVO>> getExamScoreInfo(Integer pageNum, Integer pageSize, String examTitle, Integer gradeId);
}
