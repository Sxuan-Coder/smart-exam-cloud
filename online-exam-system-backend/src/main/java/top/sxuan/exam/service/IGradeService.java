package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.entity.Grade;
import top.sxuan.exam.model.form.grade.GradeForm;
import top.sxuan.exam.model.vo.grade.GradeVO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 班级服务类
 *
 */
public interface IGradeService extends IService<Grade> {

    /**
     * 添加班级
     */
    Result<String> addGrade(GradeForm gradeForm);

    /**
     * 修改班级
     */
    Result<String> updateGrade(Integer id, GradeForm gradeForm);

    /**
     * 删除班级

     */
    Result<String> deleteGrade(Integer id);

    /**
     * 分页查找班级

     */
    Result<IPage<GradeVO>> getPaging(Integer pageNum, Integer pageSize, String gradeName);

    /**
     * 移除班级
     */
    Result<String> removeUserGrade(String ids);

    /**
     * 获取所有班级列表

     */
    Result<List<GradeVO>> getAllGrade();

    /**
     * 老师加入班级

     */
    Result teacherJoinClass(String code);

    /**
     * 老师退出班级

     */
    Result teacherExitClass(String gradeId);

    /**
     * 学生退出班级
     *
     * @return
     */
    Result userExitGrade();
}
