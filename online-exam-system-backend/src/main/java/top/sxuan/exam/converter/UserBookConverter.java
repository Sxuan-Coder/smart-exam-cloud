package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.UserBook;
import top.sxuan.exam.model.vo.userbook.ReUserExamBookVO;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface UserBookConverter {

    List<ReUserExamBookVO> listEntityToVo(List<UserBook> list);

}
