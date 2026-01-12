package top.sxuan.exam.controller;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Category;
import top.sxuan.exam.model.vo.category.CategoryVO;
import top.sxuan.exam.service.ICategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 分类管理控制器
 *
 */
@Api(tags = "题库分类管理相关接口")
@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Resource
    private ICategoryService categoryService;

    /**
     * 添加分类
     *
     * @param category 分类信息
     * @return 结果
     */
    @PostMapping
    @ApiOperation("添加分类")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<String> addCategory(@Validated @RequestBody Category category) {
        return categoryService.addCategory(category);
    }

    /**
     * 修改分类
     *
     * @param category 分类信息
     * @param id       分类ID
     * @return 结果
     */
    @PutMapping("/{id}")
    @ApiOperation("修改分类")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<String> updateCategory(@Validated @RequestBody Category category, @PathVariable("id") Integer id) {
        return categoryService.updateCategory(category, id);
    }

    /**
     * 删除分类
     *
     * @param id 分类ID
     * @return 结果
     */
    @DeleteMapping("/{id}")
    @ApiOperation("删除分类")
    @PreAuthorize("hasAnyAuthority('role_teacher','role_admin')")
    public Result<String> deleteCategory(@PathVariable("id") Integer id) {
        return categoryService.deleteCategory(id);
    }

    /**
     * 获取分类树
     *
     * @return 分类树
     */
    @GetMapping("/tree")
    @ApiOperation("获取分类树")
    @PreAuthorize("hasAnyAuthority('role_student','role_teacher','role_admin')")
    public Result<List<CategoryVO>> getCategoryTree() {
        return categoryService.getCategoryTree();
    }

    /**
     * 获取一级分类
     *
     * @return 一级分类列表
     */
    @GetMapping("/first-level")
    @ApiOperation("获取一级分类")
    @PreAuthorize("hasAnyAuthority('role_student','role_teacher','role_admin')")
    public Result<List<CategoryVO>> getFirstLevelCategories() {
        return categoryService.getFirstLevelCategories();
    }

    /**
     * 获取子分类
     *
     * @param parentId 父分类ID
     * @return 子分类列表
     */
    @GetMapping("/children/{parentId}")
    @ApiOperation("获取子分类")
    @PreAuthorize("hasAnyAuthority('role_student','role_teacher','role_admin')")
    public Result<List<CategoryVO>> getChildCategories(@PathVariable("parentId") Integer parentId) {
        return categoryService.getChildCategories(parentId);
    }
}