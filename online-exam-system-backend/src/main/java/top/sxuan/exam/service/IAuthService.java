package top.sxuan.exam.service;

import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.model.form.auth.LoginForm;
import top.sxuan.exam.model.form.user.UserForm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 权限管理接口
 *
 */
public interface IAuthService {

    /**
     * 登录

     */
    Result<String> login(HttpServletRequest request, LoginForm loginForm);

    /**
     * 用户注销

     */
    Result<String> logout(HttpServletRequest request);

    /**
     * 获取图片验证码

     */
    void getCaptcha(HttpServletRequest request, HttpServletResponse response);

    /**
     * 校验验证码

     */
    Result<String> verifyCode(HttpServletRequest request, String code);

    /**
     * 用户注册，只能注册学生

     */
    Result<String> register(HttpServletRequest request, UserForm userForm);

    /**
     * 记录学生登录时间

     */
    Result<String> sendHeartbeat(HttpServletRequest request);
}