package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Repo;
import top.sxuan.exam.model.vo.repo.RepoListVO;
import top.sxuan.exam.model.vo.repo.RepoVO;
import top.sxuan.exam.model.vo.exercise.ExerciseRepoVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 题库管理服务接口
 *
 */
public interface IRepoService extends IService<Repo> {

    /**
     * 添加题库
     */
    Result<String> addRepo(Repo repo);

    /**
     * 修改题库
     */
    Result<String> updateRepo(Repo repo, Integer id);

    /**
     * 根据题库id删除题库 并把试题所属题库清空

     */
    Result<String> deleteRepoById(Integer id);

    /**
     * 根据用户id获取自己的题库 教师获取自己的，管理员可以获取所有

     */
    Result<List<RepoListVO>> getRepoList(String repoTitle);

    /**
     * 分页查询题库
     *
     */
    Result<IPage<RepoVO>> pagingRepo(Integer pageNum, Integer pageSize, String title, Integer categoryId);

    /**
     * 分页获取可刷题库列表
     *
     */
    Result<IPage<ExerciseRepoVO>> getRepo(Integer pageNum, Integer pageSize, String title, Integer categoryId);

    /**
     * 按分类查询题库的方法
     */
    Result<IPage<RepoVO>> getReposByCategory(Integer categoryId, Integer pageNum, Integer pageSize);

}
