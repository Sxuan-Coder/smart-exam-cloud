package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Question;
import top.sxuan.exam.model.form.question.QuestionFrom;
import top.sxuan.exam.model.vo.question.QuestionVO;
import top.sxuan.exam.model.vo.exercise.QuestionSheetVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface QuestionConverter {

    @Mapping(target = "repoId", source = "repoId")
    Question fromToEntity(QuestionFrom questionFrom);

    List<QuestionSheetVO> listEntityToVO(List<Question> questions);

    @Mapping(target = "quId", source = "id")
    QuestionSheetVO entityToVO(Question question);

    QuestionVO QuestionToQuestionVO(Question question);
}
