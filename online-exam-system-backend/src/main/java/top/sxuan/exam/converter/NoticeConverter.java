package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Notice;
import top.sxuan.exam.model.form.notice.NoticeForm;
import top.sxuan.exam.model.vo.notice.NoticeVO;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;

/**
 */
@Component
@Mapper(componentModel = "spring")
public interface NoticeConverter {

    Notice formToEntity(NoticeForm noticeForm);

    Page<NoticeVO> pageEntityToVo(Page<Notice> noticePage);

    NoticeVO NoticeToNoticeVO(Notice notice);
}
