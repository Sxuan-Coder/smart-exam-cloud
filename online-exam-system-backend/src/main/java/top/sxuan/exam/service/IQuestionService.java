package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Question;
import top.sxuan.exam.model.form.question.AiGenerateQuestionForm;
import top.sxuan.exam.model.form.question.QuestionFrom;
import top.sxuan.exam.model.vo.question.QuestionVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 试题管理服务接口
 *
 */
public interface IQuestionService extends IService<Question> {

    /**
     * 单题添加
     *
     * @param questionFrom 传参
     * @return 响应
     */
    Result<String> addSingleQuestion(QuestionFrom questionFrom);

    /**
     * 批量删除试题
     *
     * @param ids 试题id
     * @return 响应
     */
    Result<String> deleteBatchByIds(String ids);

    /**
     * 分页查询试题
     *
     * @param pageNum  页码
     * @param pageSize 每页大小
     * @param content  试题名
     * @param type     试题类型
     * @param repoId   题库id
     * @return 响应
     */
    Result<IPage<QuestionVO>> pagingQuestion(Integer pageNum, Integer pageSize, String content, Integer type,
            Integer repoId);

    /**
     * 根据试题id获取单题详情
     *
     * @param id 试题id
     * @return 结果集
     */
    Result<QuestionVO> querySingle(Integer id);

    /**
     * 修改试题
     *
     * @param questionFrom 需要修改的试题
     * @return 结果
     */
    Result<String> updateQuestion(QuestionFrom questionFrom);

    /**
     * 批量导入试题
     *
     * @param id   题库Id
     * @param file Excel文件
     * @return 响应结果
     */
    Result<String> importQuestion(Integer id, MultipartFile file);

    /**
     * AI 自动生成题目
     *
     * @param form 请求参数
     * @return 生成的题目列表
     */
    Result<List<QuestionVO>> generateQuestions(AiGenerateQuestionForm form);

    /**
     * 批量添加试题
     *
     * @param list 试题列表
     * @return 结果
     */
    Result<String> batchAddQuestion(List<QuestionFrom> list);
}
