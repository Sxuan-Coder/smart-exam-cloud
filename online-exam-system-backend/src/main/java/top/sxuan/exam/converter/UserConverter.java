package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.User;
import top.sxuan.exam.model.form.user.UserForm;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface UserConverter {

    User fromToEntity(UserForm userForm);

    List<User> listFromToEntity(List<UserForm> list);

}
