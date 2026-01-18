package top.sxuan.exam.converter;

import top.sxuan.exam.model.entity.Certificate;
import top.sxuan.exam.model.form.cretificate.CertificateForm;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.springframework.stereotype.Component;

/**
 * 转换器
 */
@Component
@Mapper(componentModel = "spring")
public interface CertificateConverter {

    @Mappings({
            @Mapping(target = "certificateName", source = "certificateName")
    })
    Certificate fromToEntity(CertificateForm certificateForm);
}
