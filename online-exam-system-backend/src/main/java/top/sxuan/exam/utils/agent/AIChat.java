package top.sxuan.exam.utils.agent;

/**
 * 大模型调用接口
 */
public interface AIChat {

    /**
     * 向大模型输入消息，返回结果
     *
     * @param msg 输入消息
     * @return 结果
     */
    public String getChatResponse(String msg) throws Exception;
}