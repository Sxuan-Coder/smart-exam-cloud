package top.sxuan.exam.service.impl;

import top.sxuan.exam.mapper.UserDailyLoginDurationMapper;
import top.sxuan.exam.mapper.UserExamsScoreMapper;
import top.sxuan.exam.model.entity.UserDailyLoginDuration;
import top.sxuan.exam.model.entity.UserExamsScore;
import top.sxuan.exam.service.IUserDailyLoginDurationService;
import top.sxuan.exam.service.IUserExamsScoreService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 */
@Service
public class UserDailyLoginDurationServiceImpl extends ServiceImpl<UserDailyLoginDurationMapper, UserDailyLoginDuration>
		implements IUserDailyLoginDurationService {
}
