package top.sxuan.exam.mapper;

import top.sxuan.exam.model.entity.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * 角色表 Mapper 接口
 *
 */
public interface RoleMapper extends BaseMapper<Role> {

    /**
     * 获取角色代码
     *
     * @param roleId 角色ID
     * @return 结果集
     */
    List<String> selectCodeById(Integer roleId);

}
