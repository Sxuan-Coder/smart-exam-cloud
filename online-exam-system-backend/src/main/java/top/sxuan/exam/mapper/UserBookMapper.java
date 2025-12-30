package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.UserBook;
import top.sxuan.exam.model.vo.userbook.UserPageBookVO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;

/**
 * 错题本表 Mapper 接口
 *
 */
public interface UserBookMapper extends BaseMapper<UserBook> {

    /**
     * 添加用户错题本
     *
     * @param userBookArrayList 用户错题本集
     * @return 添加记录数
     */
    int addUserBookList(List<UserBook> userBookArrayList);

    /**
     * 分页查询错题本
     *
     * @param page     分页对象
     * @param examName 试卷名称
     * @param userId   用户ID
     * @return 分页结果
     */
    Page<UserPageBookVO> selectPageVo(Page<UserPageBookVO> page, String examName, Integer userId);

}
