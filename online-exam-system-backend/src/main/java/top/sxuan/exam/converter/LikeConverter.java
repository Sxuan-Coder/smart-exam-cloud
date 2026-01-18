package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Like;
import top.sxuan.exam.model.form.like.LikeForm;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface LikeConverter {
    Like formToEntity(LikeForm likeForm);
}
