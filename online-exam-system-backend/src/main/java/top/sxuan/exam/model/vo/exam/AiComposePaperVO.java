package top.sxuan.exam.model.vo.exam;

import top.sxuan.exam.model.vo.question.QuestionVO;
import lombok.Data;

import java.util.List;

/**
 * AI 自动组卷预览返回对象
 */
@Data
public class AiComposePaperVO {

	// 预览ID（用于确认生成时回传）
	private String previewId;

	// 试卷标题
	private String title;

	// 总分
	private Integer totalScore;

	// 单选题列表
	private List<AiComposedQuestionVO> radioQuestions;

	// 多选题列表
	private List<AiComposedQuestionVO> multiQuestions;

	// 判断题列表
	private List<AiComposedQuestionVO> judgeQuestions;

	// 简答题列表
	private List<AiComposedQuestionVO> saqQuestions;

	/**
	 * 组卷题目详情（包含来源标识）
	 */
	@Data
	public static class AiComposedQuestionVO {
		// 题目ID（题库题目有值，AI生成为null）
		private Integer questionId;

		// 题干
		private String content;

		// 图片
		private String image;

		// 题目类型：1单选 2多选 3判断 4简答
		private Integer quType;

		// 难度等级：1简单 2中等 3困难
		private Integer quLevel;

		// 知识点
		private String knowledgePoint;

		// 选项列表（JSON字符串，仅选择题）
		private String options;

		// 正确答案
		private String answer;

		// 解析
		private String analysis;

		// 来源：REPO-题库, AI-AI生成
		private String source;

		// 分值
		private Integer score;
	}
}
