package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Repo;
import top.sxuan.exam.model.vo.record.ExerciseRecordVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface RecordConverter {

    Page<ExerciseRecordVO> pageRepoEntityToVo(Page<Repo> page);

}
