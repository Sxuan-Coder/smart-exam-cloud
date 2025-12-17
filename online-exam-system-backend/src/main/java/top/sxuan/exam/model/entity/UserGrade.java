package top.sxuan.exam.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户班级关联实体类
 *
 */
@TableName("t_user_grade")
@Data
public class UserGrade {

    @TableId(value = "id", type = IdType.AUTO)

    @ApiModelProperty("用户班级关联表ID")
    private Integer id;

    @ApiModelProperty("用户ID")
    private Integer uId;

    @ApiModelProperty("班级ID")
    private Integer gId;

    @TableLogic
    @ApiModelProperty("逻辑删除字段")
    private Integer isDeleted;
}
