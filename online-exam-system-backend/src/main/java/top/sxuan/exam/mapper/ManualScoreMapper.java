package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.ManualScore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * 简答题阅卷表 Mapper 接口
 *
 */
public interface ManualScoreMapper extends BaseMapper<ManualScore> {

    /**
     * 批量添加批改分数
     *
     * @param manualScores 入参
     * @return 影响记录数
     */
    Integer insertList(List<ManualScore> manualScores);

}
