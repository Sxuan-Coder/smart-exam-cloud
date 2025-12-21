package top.sxuan.exam.model.form.question;

import lombok.Data;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * AI 出题请求对象
 */
@Data
public class AiGenerateQuestionForm {

	@NotBlank(message = "参考文本不能为空")
	private String text;

	@NotNull(message = "题目类型不能为空")
	@Min(value = 1, message = "题目类型只能是：1单选2多选3判断4简答")
	@Max(value = 4, message = "题目类型只能是：1单选2多选3判断4简答")
	private Integer quType;

	@NotNull(message = "题目数量不能为空")
	@Min(value = 1, message = "最少生成 1 道题")
	@Max(value = 10, message = "单次最多生成 10 道题")
	private Integer count;
}
