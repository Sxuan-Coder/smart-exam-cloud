package top.sxuan.exam.controller;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.vo.stat.AllStatsVO;
import top.sxuan.exam.model.vo.stat.DailyVO;
import top.sxuan.exam.model.vo.stat.GradeExamVO;
import top.sxuan.exam.model.vo.stat.GradeStudentVO;
import top.sxuan.exam.service.IStatService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 统计管理
 *
 */
@Api(tags = "统计数据相关接口")
@RestController
@RequestMapping("/api/stat")
public class StatController {

    @Resource
    private IStatService statService;

    /**
     * 各班级人数统计
     *
     * @return
     */
    @ApiOperation("各班级人数统计")
    @GetMapping("/student")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<List<GradeStudentVO>> getStudentGradeCount() {
        return statService.getStudentGradeCount();
    }

    /**
     * 各班试卷统计
     *
     * @return
     */
    @ApiOperation("各班试卷统计")
    @GetMapping("/exam")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<List<GradeExamVO>> getExamGradeCount() {
        return statService.getExamGradeCount();
    }

    /**
     * 统计所有班级、试卷、试题数量
     *
     * @return 统计结果
     */
    @ApiOperation("统计所有班级、试卷、试题数量")
    @GetMapping("/allCounts")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<AllStatsVO> getAllCount() {
        return statService.getAllCount();
    }

    /**
     * 获取用户登录时间统计
     *
     * @return
     */
    @ApiOperation("获取用户登录时间统计")
    @GetMapping("/daily")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin','role_student')")
    public Result<List<DailyVO>> getDaily() {
        return statService.getDaily();
    }

}
