package top.sxuan.exam.service;

import top.sxuan.exam.model.entity.Log;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
 * 说明：
 * 日志记录服务（主要记录登录日志）
 *
 */
public interface ILogService {
    /**
     * 记录登录日志
     *
     */
    Log add(Log log);

    /**
     * 分页查询登录日志

     */
    Page<Log> getPage(Integer pageNum, Integer pageSize);
}
