package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.ExerciseRecord;
import top.sxuan.exam.model.form.exercise.ExerciseFillAnswerFrom;
import top.sxuan.exam.model.vo.question.QuestionVO;
import top.sxuan.exam.model.vo.exercise.AnswerInfoVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface ExerciseConverter {
    @Mappings({
            @Mapping(source = "quId", target = "questionId"),
            @Mapping(source = "quType", target = "questionType")
    })
    ExerciseRecord fromToEntity(ExerciseFillAnswerFrom exerciseFillAnswerFrom);

    AnswerInfoVO quVOToAnswerInfoVO(QuestionVO questionVO);
}
