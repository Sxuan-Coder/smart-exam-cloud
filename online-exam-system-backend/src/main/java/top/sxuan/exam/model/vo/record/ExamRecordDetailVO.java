package top.sxuan.exam.model.vo.record;

import top.sxuan.exam.model.entity.Option;
import lombok.Data;

import java.util.List;

/**
 */
@Data
public class ExamRecordDetailVO {
    // 1、题干 2、选项 3、自己的答案 4、正确的答案 5、是否正确 6、试题分析
    /**
     * 题干
     */
    private String title;
    /**
     * 题干图片
     */
    private String image;
    /**
     * 选项
     */
    private List<Option> option;
    /**
     * 我的答案
     */
    private String myOption;
    /**
     * 正确答案
     */
    private String rightOption;
    /**
     * 是否正确
     */
    private Integer isRight;
    /**
     * 试题分析
     */
    private String analyse;
    /**
     * 试题类型
     */
    private Integer quType;

    /**
     * AI评分得分
     */
    private Double aiScore;

    /**
     * AI评分简评
     */
    private String aiReason;

    /**
     * AI详细评分反馈(JSON)
     */
    private String aiGradingDetail;
}
