package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.User;
import top.sxuan.exam.model.entity.UserGrade;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * 教师与班级关联表 Mapper 接口
 *
 */
public interface UserGradeMapper extends BaseMapper<UserGrade> {

    /**
     * 根据班级id获取班级的所有老师
     *
     * @param gradeId 班级ID
     * @return 结果集
     */
    List<Integer> getUserListByGradeId(Integer gradeId);

    /**
     * 老师退出班级
     *
     * @param userId  用户ID
     * @param gradeId 班级ID
     * @return 影响记录数
     */
    Integer teacherExitClass(Integer userId, String gradeId);

    /**
     * 教师id获取老师的所有班级id
     *
     * @param userId 用户ID
     * @return 结果集
     */
    List<Integer> getGradeIdListByUserId(Integer userId);

}
