package top.sxuan.exam.model.vo.score;

import lombok.Data;
import java.util.List;

/**
 * AI 智能判卷详细反馈对象
 */
@Data
public class AiGradingDetailVO {

	// 总分
	private Double totalScore;

	// 维度评分
	private List<DimensionScore> dimensions;

	// 扣分明细
	private List<String> deductionDetails;

	// 改进建议
	private String improvementSuggestions;

	/**
	 * 维度评分内部类
	 */
	@Data
	public static class DimensionScore {
		// 维度名称（如：知识点覆盖度）
		private String name;
		// 权重（0-1.0）
		private Double weight;
		// 该维度得分百分比（0-1.0）
		private Double scorePercent;
		// 维度评语
		private String comment;
	}
}
