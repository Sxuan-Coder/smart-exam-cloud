package top.sxuan.exam.config;

import top.sxuan.exam.filter.VerifyTokenFilter;
import top.sxuan.exam.common.result.Result;
import top.sxuan.exam.utils.ResponseUtil;

import javax.annotation.Resource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Spring Security 权限配置类
 * 该类用于配置 Spring Security 的相关规则，包括请求授权、异常处理、过滤器等
 * 已重构为 Spring Security 5.7+ 推荐的 SecurityFilterChain 模式
 *
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

        @Resource
        private ResponseUtil responseUtil;

        @Resource
        private VerifyTokenFilter verifyTokenFilter;

        /**
         * 配置 SecurityFilterChain，定义请求的授权规则、异常处理方式、过滤器链等
         */
        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
                // 开启 CORS 支持，并禁用 CSRF 保护
                http.cors().and().csrf().disable();

                // 配置请求的授权规则
                http.authorizeRequests()
                                .antMatchers(
                                                // 用户登录相关的接口
                                                "/api/auths/**",
                                                // Swagger/Knife4j 相关的资源路径
                                                "/webjars/**",
                                                "/swagger-ui.html",
                                                "/swagger-resources/**",
                                                "/v2/api-docs",
                                                "/v3/api-docs/**",
                                                "/swagger-resources/configuration/ui",
                                                "/swagger-resources/configuration/security",
                                                "/doc.html",
                                                // WebSocket 相关路径
                                                "/ws/**",
                                                "/ws-app/**")
                                .permitAll()
                                .anyRequest().authenticated();

                // 配置异常处理器
                http.exceptionHandling()
                                .accessDeniedHandler((request, response, accessDeniedException) -> responseUtil
                                                .response(response, Result.failed("你没有该资源的访问权限")));

                // 禁用基于表单的登录页面
                http.formLogin().disable();

                // 将自定义的验证 token 过滤器添加到过滤器链中
                http.addFilterBefore(verifyTokenFilter, UsernamePasswordAuthenticationFilter.class);

                return http.build();
        }
}