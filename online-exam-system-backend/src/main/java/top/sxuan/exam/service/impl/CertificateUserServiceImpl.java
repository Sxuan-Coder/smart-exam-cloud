package top.sxuan.exam.service.impl;

import top.sxuan.exam.mapper.CertificateUserMapper;
import top.sxuan.exam.model.entity.CertificateUser;
import top.sxuan.exam.service.ICertificateUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * 服务实现类
 *
 */
@Service
public class CertificateUserServiceImpl extends ServiceImpl<CertificateUserMapper, CertificateUser>
		implements ICertificateUserService {

}
