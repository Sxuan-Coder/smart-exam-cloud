package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import org.springframework.web.multipart.MultipartFile;

/**
 * 说明：
 *
 */
public interface IFileService {

    /**
     * 上传图片
     *
     * @param file 文件
     * @return 返回上传后的地址
     */
    Result<String> uploadImage(MultipartFile file);
}
