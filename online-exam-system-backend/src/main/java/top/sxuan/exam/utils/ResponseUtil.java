package top.sxuan.exam.utils;

import top.sxuan.exam.common.result.Result;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
// import jakarta.annotation.Resource;
// import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 响应体封装工具类
 *
 */
@Component
public class ResponseUtil {

    @Resource
    private ObjectMapper objectMapper;

    @SneakyThrows({ JsonProcessingException.class, IOException.class })
    public void response(HttpServletResponse response, Result result) {
        String s = objectMapper.writeValueAsString(result);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(s);
        writer.flush();
        writer.close();
    }

    @SneakyThrows({ JsonProcessingException.class, IOException.class })
    public void response(HttpServletResponse response, Result result, Integer status) {
        String s = objectMapper.writeValueAsString(result);
        response.setStatus(status);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(s);
        writer.flush();
        writer.close();
    }
}
