package top.sxuan.exam.model.form.userbook;

import lombok.Data;

import java.util.List;

/**
 * 重刷错题请求体
 *
 */
@Data
public class ReUserBookForm {
    // 试卷ID
    private Integer examId;

    // 试题ID
    private Integer quId;

    // 回答列表
    private String answer;
}
