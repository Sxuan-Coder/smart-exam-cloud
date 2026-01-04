package top.sxuan.exam.service.impl;

import top.sxuan.exam.common.exception.ServiceRuntimeException;
import top.sxuan.exam.mapper.LogMapper;
import top.sxuan.exam.model.entity.Log;
import top.sxuan.exam.service.ILogService;
import top.sxuan.exam.utils.SecurityUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 说明：
 *
 */
@Service
public class LogServiceImpl implements ILogService {
    @Autowired
    private LogMapper logMapper;

    @Override
    public Log add(Log log) {
        int insert = logMapper.insert(log);
        if (insert > 0) {
            return log;
        }
        throw new ServiceRuntimeException("添加日志失败");
    }

    @Override
    public Page<Log> getPage(Integer pageNum, Integer pageSize) {
        Integer userId = SecurityUtil.getUserId();
        Page<Log> page = new Page<>(pageNum, pageSize);
        LambdaQueryWrapper<Log> query = new LambdaQueryWrapper<>();
        query.eq(Log::getUserId, userId)
                .orderByDesc(Log::getCreateTime);
        page = logMapper.selectPage(page, query);
        return page;
    }
}
