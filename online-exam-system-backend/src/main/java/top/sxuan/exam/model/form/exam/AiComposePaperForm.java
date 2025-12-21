package top.sxuan.exam.model.form.exam;

import lombok.Data;
import javax.validation.constraints.*;
import java.util.List;

/**
 * AI 自动组卷请求对象
 */
@Data
public class AiComposePaperForm {

	@NotBlank(message = "试卷标题不能为空")
	@Size(min = 3, max = 50, message = "试卷标题长度为3-50个字符")
	private String title;

	@NotNull(message = "题库ID不能为空")
	private Integer repoId;

	@NotEmpty(message = "知识点不能为空")
	private List<String> knowledgePoints;

	// 难度分布：简单题占比(0-100)
	@NotNull(message = "简单题占比不能为空")
	@Min(value = 0, message = "占比不能小于0")
	@Max(value = 100, message = "占比不能大于100")
	private Integer easyPercent;

	// 难度分布：中等题占比(0-100)
	@NotNull(message = "中等题占比不能为空")
	@Min(value = 0, message = "占比不能小于0")
	@Max(value = 100, message = "占比不能大于100")
	private Integer mediumPercent;

	// 难度分布：困难题占比(0-100)
	@NotNull(message = "困难题占比不能为空")
	@Min(value = 0, message = "占比不能小于0")
	@Max(value = 100, message = "占比不能大于100")
	private Integer hardPercent;

	// 单选题数量
	@NotNull(message = "单选题数量不能为空")
	@Min(value = 0)
	private Integer radioCount;

	// 单选题分值
	@NotNull(message = "单选题分值不能为空")
	@Min(value = 0)
	private Integer radioScore;

	// 多选题数量
	@NotNull(message = "多选题数量不能为空")
	@Min(value = 0)
	private Integer multiCount;

	// 多选题分值
	@NotNull(message = "多选题分值不能为空")
	@Min(value = 0)
	private Integer multiScore;

	// 判断题数量
	@NotNull(message = "判断题数量不能为空")
	@Min(value = 0)
	private Integer judgeCount;

	// 判断题分值
	@NotNull(message = "判断题分值不能为空")
	@Min(value = 0)
	private Integer judgeScore;

	// 简答题数量
	@NotNull(message = "简答题数量不能为空")
	@Min(value = 0)
	private Integer saqCount;

	// 简答题分值
	@NotNull(message = "简答题分值不能为空")
	@Min(value = 0)
	private Integer saqScore;

	// 总分上限
	@NotNull(message = "总分上限不能为空")
	@Min(value = 1, message = "总分必须大于0")
	private Integer totalScore;
}
