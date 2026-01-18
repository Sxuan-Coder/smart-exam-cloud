package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Exam;
import top.sxuan.exam.model.entity.ExamQuestion;
import top.sxuan.exam.model.entity.Option;
import top.sxuan.exam.model.form.exam.ExamAddForm;
import top.sxuan.exam.model.form.exam.ExamUpdateForm;
import top.sxuan.exam.model.vo.exam.*;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;
import top.sxuan.exam.model.vo.exam.*;

import java.util.List;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface ExamConverter {

    Page<ExamVO> pageEntityToVo(Page<Exam> examPage);

    Exam formToEntity(ExamUpdateForm examUpdateForm);

    Exam formToEntity(ExamAddForm examAddForm);

    List<ExamDetailRespVO> listEntityToExamDetailRespVO(List<ExamQuestion> examQuestion);

    ExamDetailVO examToExamDetailVO(Exam exam);

    ExamGradeListVO entityToExamGradeListVO(Exam exam);

    ExamQuestionVO examQuestionEntityToVO(ExamQuestion examQuestion);

    List<ExamQuestionVO> examQuestionListEntityToVO(List<ExamQuestion> examQuestion);

    List<OptionVO> opListEntityToVO(List<Option> examQuestion);
}
