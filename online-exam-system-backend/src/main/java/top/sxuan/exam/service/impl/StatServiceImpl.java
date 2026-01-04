package top.sxuan.exam.service.impl;

import top.sxuan.exam.common.exception.ServiceRuntimeException;
import top.sxuan.exam.mapper.*;
import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.*;
import top.sxuan.exam.model.vo.stat.AllStatsVO;
import top.sxuan.exam.model.vo.stat.DailyVO;
import top.sxuan.exam.model.vo.stat.GradeExamVO;
import top.sxuan.exam.model.vo.stat.GradeStudentVO;
import top.sxuan.exam.service.IStatService;
import top.sxuan.exam.utils.SecurityUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 统计管理服务实现类
 *
 */
@Service
public class StatServiceImpl extends ServiceImpl<ExamGradeMapper, ExamGrade> implements IStatService {

    @Resource
    private StatMapper statMapper;
    @Resource
    private GradeMapper gradeMapper;
    @Resource
    private ExamMapper examMapper;
    @Resource
    private QuestionMapper questionMapper;
    @Resource
    private UserDailyLoginDurationMapper userDailyLoginDurationMapper;
    @Resource
    private UserGradeMapper userGradeMapper;

    @Override
    public Result<List<GradeStudentVO>> getStudentGradeCount() {
        // 获取班级
        List<GradeStudentVO> gradeStudentVOs;
        Integer userId = SecurityUtil.getUserId();
        Integer roleCode = SecurityUtil.getRoleCode();
        if (roleCode == 2) {
            List<Integer> gradeIdList = userGradeMapper.getGradeIdListByUserId(userId);
            if (gradeIdList.isEmpty()) {
                throw new ServiceRuntimeException("教师还没加入班级暂无数据");
            }
            gradeStudentVOs = statMapper.StudentGradeCount(2, userId, gradeIdList);
        } else {
            gradeStudentVOs = statMapper.StudentGradeCount(3, userId, null);
        }
        return Result.success("查询成功", gradeStudentVOs);
    }

    @Override
    public Result<List<GradeExamVO>> getExamGradeCount() {
        // 获取班级
        List<GradeExamVO> gradeExamVOs;
        Integer userId = SecurityUtil.getUserId();
        Integer roleCode = SecurityUtil.getRoleCode();
        if (roleCode == 2) {
            List<Integer> gradeIdList = userGradeMapper.getGradeIdListByUserId(userId);
            if (gradeIdList.isEmpty()) {
                throw new ServiceRuntimeException("教师还没加入班级暂无数据");
            }
            gradeExamVOs = statMapper.ExamGradeCount(2, userId, gradeIdList);
        } else {
            gradeExamVOs = statMapper.ExamGradeCount(3, userId, null);
        }
        return Result.success("查询成功", gradeExamVOs);
    }

    @Override
    public Result<AllStatsVO> getAllCount() {
        AllStatsVO allStatsVO = new AllStatsVO();
        Integer roleCode = SecurityUtil.getRoleCode();
        Integer userId = SecurityUtil.getUserId();
        if (roleCode == 3) {
            allStatsVO.setClassCount(gradeMapper.selectCount(new LambdaQueryWrapper<Grade>()
                    .eq(Grade::getIsDeleted, 0)).intValue());
            allStatsVO.setExamCount(examMapper.selectCount(new LambdaQueryWrapper<Exam>()
                    .eq(Exam::getIsDeleted, 0)).intValue());
            allStatsVO.setQuestionCount(questionMapper.selectCount(new LambdaQueryWrapper<Question>()
                    .eq(Question::getIsDeleted, 0)).intValue());
        } else if (roleCode == 2) {
            allStatsVO.setClassCount(userGradeMapper.selectCount(new LambdaQueryWrapper<UserGrade>()
                    .eq(UserGrade::getIsDeleted, 0)
                    .eq(UserGrade::getUId, userId)).intValue());
            allStatsVO.setExamCount(examMapper.selectCount(
                    new LambdaQueryWrapper<Exam>()
                            .eq(Exam::getIsDeleted, 0)
                            .eq(Exam::getUserId, userId))
                    .intValue());
            allStatsVO.setQuestionCount(questionMapper.selectCount(
                    new LambdaQueryWrapper<Question>()
                            .eq(Question::getIsDeleted, 0)
                            .eq(Question::getUserId, userId))
                    .intValue());
        }
        return Result.success("查询成功", allStatsVO);
    }

    @Override
    public Result<List<DailyVO>> getDaily() {
        List<DailyVO> daily = userDailyLoginDurationMapper.getDaily(SecurityUtil.getUserId());
        return Result.success("请求成功", daily);
    }
}
