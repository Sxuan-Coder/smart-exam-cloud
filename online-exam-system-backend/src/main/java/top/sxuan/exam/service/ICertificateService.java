package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Certificate;
import top.sxuan.exam.model.form.cretificate.CertificateForm;
import top.sxuan.exam.model.vo.certificate.MyCertificateVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 证书服务接口
 *
 */
public interface ICertificateService extends IService<Certificate> {

    /**
     * 添加证书
     *
     */
    // 新增证书的addCertificate方法（在CertificateController中调用）
    Result<String> addCertificate(CertificateForm certificateForm);

    /**
     * 分页查询证书
     *
     */
    // 获取后台分页证书 实现类
    Result<IPage<Certificate>> pagingCertificate(Integer pageNum, Integer pageSize, String certificateName,
            String certificationUnit);

    /**
     * 修改公告

     */
    // 修改证书
    Result<String> updateCertificate(CertificateForm certificateForm);

    /**
     * 删除公告
     *

     */
    Result<String> deleteCertificate(Integer id);

    /**
     * 分页查已获证书
     *
     */
    Result<IPage<MyCertificateVO>> getMyCertificatePaging(Integer pageNum, Integer pageSize, String examName);
}
