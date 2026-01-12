package top.sxuan.exam.controller;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.form.like.LikeForm;
import top.sxuan.exam.service.ILikeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 */
@RestController
@RequestMapping("/api/like")
@Api(tags = "点赞相关api")
public class LikeController {

    @Resource
    private ILikeService likeService;

    @PostMapping("/doLike")
    @ApiOperation("点赞或取消点赞")
    public Result<String> doLike(@Validated @RequestBody LikeForm likeForm) {
        return likeService.doLike(likeForm);
    }
}
