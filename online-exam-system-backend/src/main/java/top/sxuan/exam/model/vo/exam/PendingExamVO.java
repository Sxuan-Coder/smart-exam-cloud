package top.sxuan.exam.model.vo.exam;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 待考试卷 VO
 */
@Data
@ApiModel("待考试卷信息")
public class PendingExamVO {

	@ApiModelProperty("考试ID")
	private Integer id;

	@ApiModelProperty("考试标题")
	private String title;

	@ApiModelProperty("开始时间")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime startTime;

	@ApiModelProperty("结束时间")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime endTime;

	@ApiModelProperty("剩余时间(分钟)")
	private Long remainingMinutes;
}
