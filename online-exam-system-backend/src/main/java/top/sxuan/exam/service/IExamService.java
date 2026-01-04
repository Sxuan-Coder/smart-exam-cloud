package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Exam;
import top.sxuan.exam.model.entity.ExamQuAnswer;
import top.sxuan.exam.model.form.exam.AiComposePaperForm;
import top.sxuan.exam.model.form.exam.ExamAddForm;
import top.sxuan.exam.model.form.exam.ExamUpdateForm;
import top.sxuan.exam.model.form.exam_qu_answer.ExamQuAnswerAddForm;
import top.sxuan.exam.model.vo.record.ExamRecordDetailVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import top.sxuan.exam.model.vo.exam.*;

import java.util.List;

/**
 * 考试服务接口
 *
 */
public interface IExamService extends IService<Exam> {
    /**
     * 创建考试
     *
     * @param examAddForm
     * @return
     */
    Result<String> createExam(ExamAddForm examAddForm);

    /**
     * 修改考试
     *
     * @param examUpdateForm
     * @return
     */
    Result<String> updateExam(ExamUpdateForm examUpdateForm, Integer examId);

    /**
     * 删除考试
     *
     * @param ids 试卷ID
     * @return
     */
    Result<String> deleteExam(String ids);

    /**
     * 教师分页查找考试列表
     *
     * @param pageNum  页码
     * @param pageSize 每页大小
     * @param title    试卷标题
     * @return
     */
    Result<IPage<ExamVO>> getPagingExam(Integer pageNum, Integer pageSize, String title);

    /**
     * 获取考试题目id列表
     *
     * @param examId 试卷ID
     * @return
     */
    Result<ExamQuestionListVO> getQuestionList(Integer examId);

    /**
     * 获取单题信息
     *
     * @param examId     试卷ID
     * @param questionId 试题ID
     * @return
     */
    Result<ExamQuDetailVO> getQuestionSingle(Integer examId, Integer questionId);

    /**
     * 题目汇总
     *
     * @param examId 试卷ID
     * @return
     */
    Result<List<ExamQuCollectVO>> getCollect(Integer examId);

    /**
     * 获取考试详情信息
     *
     * @param examId 试卷ID
     * @return
     */
    Result<ExamDetailVO> getDetail(Integer examId);

    /**
     * 考试作弊次数添加
     *
     * @return
     */
    Result<Integer> addCheat(Integer examId);

    /**
     * 填充答案
     *
     * @return
     */
    Result<String> addAnswer(ExamQuAnswerAddForm examQuAnswerForm);

    /**
     * 根据班级获得考试列表
     *
     * @param pageNum  页码
     * @param pageSize 每页大小
     * @param title    标题
     * @param isASC    是否升序排列，true为升序，false为降序
     * @return 考试列表分页结果
     */
    Result<IPage<ExamGradeListVO>> getGradeExamList(Integer pageNum, Integer pageSize, String title, Boolean isASC);

    /**
     * 交卷操作
     *
     * @param examId 试卷ID
     * @return
     */
    Result<ExamQuDetailVO> handExam(Integer examId);

    /**
     * 开始考试
     *
     * @return
     */
    Result<String> startExam(Integer examId);

    /**
     * 添加考试记录
     *
     * @param examQuAnswerForm
     * @param quType           试题类型
     * @return
     */
    Result<String> insertNewAnswer(ExamQuAnswerAddForm examQuAnswerForm, Integer quType);

    /**
     * 修改考试记录
     *
     * @param examQuAnswerForm
     * @param quType           试题类型
     * @return
     */
    Result<String> updateAnswerIfExists(ExamQuAnswerAddForm examQuAnswerForm, Integer quType);

    /**
     * 表单转化实体
     *
     * @param form
     * @param quType 试题类型
     * @return
     */
    ExamQuAnswer prepareExamQuAnswer(ExamQuAnswerAddForm form, Integer quType);

    /**
     * 判断用户是否正在考试
     *
     * @param examId 试卷ID
     * @return
     */
    boolean isUserTakingExam(Integer examId);

    /**
     * 查看考试详情
     * 
     * @param examId
     * @return
     */
    Result<List<ExamRecordDetailVO>> details(Integer examId);

    /**
     * AI 自动组卷预览
     *
     * @param form 组卷参数
     * @return 预览结果
     */
    Result<AiComposePaperVO> aiComposePaper(AiComposePaperForm form);

    /**
     * 确认 AI 组卷，生成正式试卷
     *
     * @param previewId    预览ID
     * @param gradeIds     考试班级ID（逗号分隔）
     * @param examDuration 考试时长（分钟）
     * @param passedScore  及格分
     * @return 试卷ID
     */
    Result<Integer> confirmAiComposePaper(String previewId, String gradeIds, Integer examDuration, Integer passedScore);

    /**
     * 获取学生待考试卷列表
     * 返回当前时间在考试范围内且该学生未参加的考试
     *
     * @return 待考试卷列表
     */
    Result<List<PendingExamVO>> getPendingExams();
}
