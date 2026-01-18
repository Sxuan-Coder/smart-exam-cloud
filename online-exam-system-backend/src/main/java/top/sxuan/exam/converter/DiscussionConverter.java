package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Discussion;
import top.sxuan.exam.model.form.discussion.DiscussionForm;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface DiscussionConverter {

    Discussion formToEntity(DiscussionForm discussion);
}
