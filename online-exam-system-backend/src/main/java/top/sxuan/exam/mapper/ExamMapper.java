package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.Exam;
import top.sxuan.exam.model.vo.answer.AnswerExamVO;
import top.sxuan.exam.model.vo.record.ExamRecordVO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 试卷表 Mapper 接口
 *
 */
public interface ExamMapper extends BaseMapper<Exam> {

        /**
         * 获取自己创建的考试，考试id，考试考试标题，是否需要阅卷
         *
         * @param userId 用户ID
         * @return 分页结果
         */
        IPage<AnswerExamVO> selectMarkedList(@Param("page") IPage<AnswerExamVO> page, @Param("userId") Integer userId,
                        String role, String examName);

        /**
         * 查询学生的考试记录
         *
         * @param page     分页对象
         * @param userId   用户ID
         * @param examName 考试名称
         * @param isASC    是否升序
         * @return 分页结果
         */
        Page<ExamRecordVO> getExamRecordPage(Page<ExamRecordVO> page, Integer userId, String examName, Boolean isASC);

        /**
         * 查询教师创建的考试记录
         *
         * @param page     分页对象
         * @param userId   用户ID
         * @param examName 考试名称
         * @param isASC    是否升序
         * @return 分页结果
         */
        Page<ExamRecordVO> getTeacherExamRecordPage(Page<ExamRecordVO> page, Integer userId, String examName,
                        Boolean isASC);

        /**
         * 查询所有考试记录（管理员）
         *
         * @param page     分页对象
         * @param examName 考试名称
         * @param isASC    是否升序
         * @return 分页结果
         */
        Page<ExamRecordVO> getAllExamRecordPage(Page<ExamRecordVO> page, String examName, Boolean isASC);

        /**
         * 获取用户所在的班级ID列表
         *
         * @param userId 用户ID
         * @return 班级ID列表
         */
        List<Integer> getUserGradeIds(@Param("userId") Integer userId);

        /**
         * 获取考试关联的班级ID列表
         *
         * @param examId 考试ID
         * @return 班级ID列表
         */
        List<Integer> getExamGradeIds(@Param("examId") Integer examId);

}
