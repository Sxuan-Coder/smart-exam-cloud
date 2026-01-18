package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.ExamQuAnswer;
import top.sxuan.exam.model.form.exam_qu_answer.ExamQuAnswerAddForm;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface ExamQuAnswerConverter {

    @Mapping(target = "questionId", source = "quId")
    ExamQuAnswer formToEntity(ExamQuAnswerAddForm examQuAnswerAddForm);

}
