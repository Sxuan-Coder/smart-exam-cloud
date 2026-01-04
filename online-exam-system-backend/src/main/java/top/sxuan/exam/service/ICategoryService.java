package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Category;
import top.sxuan.exam.model.vo.category.CategoryVO;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 分类服务接口
 *
 */
public interface ICategoryService extends IService<Category> {

    /**
     * 添加分类

     */
    Result<String> addCategory(Category category);

    /**
     * 修改分类
     *

     */
    Result<String> updateCategory(Category category, Integer id);

    /**
     * 删除分类

     */
    Result<String> deleteCategory(Integer id);

    /**
     * 获取分类树

     */
    Result<List<CategoryVO>> getCategoryTree();

    /**
     * 获取一级分类列表

     */
    Result<List<CategoryVO>> getFirstLevelCategories();

    /**
     * 根据父ID获取子分类
     */
    Result<List<CategoryVO>> getChildCategories(Integer parentId);
}