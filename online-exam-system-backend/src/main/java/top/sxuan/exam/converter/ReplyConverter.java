package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Reply;
import top.sxuan.exam.model.form.reply.ReplyForm;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface ReplyConverter {
    Reply formToEntity(ReplyForm replyForm);
}
