package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Repo;
import top.sxuan.exam.model.vo.repo.RepoVO;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface RepoConverter {

    List<RepoVO> listEntityToVo(List<Repo> list);

}
