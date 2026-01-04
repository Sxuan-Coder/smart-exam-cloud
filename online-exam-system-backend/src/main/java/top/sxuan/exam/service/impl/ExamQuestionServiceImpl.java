package top.sxuan.exam.service.impl;

import top.sxuan.exam.mapper.ExamQuestionMapper;
import top.sxuan.exam.model.entity.ExamQuestion;
import top.sxuan.exam.service.IExamQuestionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 */
@Service
public class ExamQuestionServiceImpl extends ServiceImpl<ExamQuestionMapper, ExamQuestion>
		implements IExamQuestionService {

}
