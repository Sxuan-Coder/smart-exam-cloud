package top.sxuan.exam.common.exception;

/**
 * 说明：
 * 自定义服务异常类
 *
 */
public class ServiceRuntimeException extends RuntimeException {
    /**
     * 自定义服务异常类构造器
     *
     * @param msg
     */
    public ServiceRuntimeException(String msg) {
        super(msg);
    }
}
