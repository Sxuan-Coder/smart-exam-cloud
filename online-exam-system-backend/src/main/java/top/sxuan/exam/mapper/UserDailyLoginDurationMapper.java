package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.UserDailyLoginDuration;
import top.sxuan.exam.model.entity.UserExerciseRecord;
import top.sxuan.exam.model.vo.stat.DailyVO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.time.LocalDate;
import java.util.List;

/**
 * 用户登录时长日志表 Mapper 接口
 *
 */
public interface UserDailyLoginDurationMapper extends BaseMapper<UserDailyLoginDuration> {

    /**
     * 获取每天在线时长日志
     *
     * @param userId 用户ID
     * @return 结果集
     */
    List<DailyVO> getDaily(Integer userId);

    /**
     * 获得当天记录
     *
     * @param userId 用户ID
     * @param date   日期
     * @return 结果
     */
    UserDailyLoginDuration getTodayRecord(Integer userId, LocalDate date);
}
