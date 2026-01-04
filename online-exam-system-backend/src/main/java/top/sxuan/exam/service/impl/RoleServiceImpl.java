package top.sxuan.exam.service.impl;

import top.sxuan.exam.mapper.RoleMapper;
import top.sxuan.exam.model.entity.Role;
import top.sxuan.exam.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

}
