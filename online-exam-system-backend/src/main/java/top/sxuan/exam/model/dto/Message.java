package top.sxuan.exam.model.dto;

import top.sxuan.exam.model.enums.MessageType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 消息封装Dto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("消息封装Dto")
public class Message {
    @ApiModelProperty("消息类型")
    private MessageType type;
    @ApiModelProperty("消息具体内容")
    private Object data;
}
