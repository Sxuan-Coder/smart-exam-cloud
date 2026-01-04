package top.sxuan.exam.service.impl;

import top.sxuan.exam.mapper.OptionMapper;
import top.sxuan.exam.model.entity.Option;
import top.sxuan.exam.service.IOptionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 */
@Service
public class OptionServiceImpl extends ServiceImpl<OptionMapper, Option> implements IOptionService {

}
