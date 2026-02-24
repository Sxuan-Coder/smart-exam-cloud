# 后端模块文档

本文档详细介绍了智慧考试云平台后端的模块结构、Java 类及其功能说明。

---

## 1. 核心启动类
- **`top.sxuan.exam.ExamApplication`**: Spring Boot 项目启动入口类，配置了扫描路径及基础环境。

---

## 2. 公共基础模块 (`top.sxuan.exam.common`)

该模块包含项目通用的 AOP 切面、异常处理、校验分组、返回结果封装等。

### 2.1 AOP 切面 (`common.aop`)
- **`LogAsPect.java`**: 系统日志切面，用于记录用户操作日志，通过注解拦截请求并持久化到数据库。

### 2.2 异常处理 (`common.exception`)
- **`ServiceRuntimeException.java`**: 自定义业务运行时异常，用于在业务逻辑中抛出可控的错误信息。

### 2.3 校验分组 (`common.group`)
- **`AnswerGroup.java`**: 答题相关的参数校验分组。
- **`CertificateGroup.java`**: 证书相关的参数校验分组。
- **`QuestionGroup.java`**: 题目相关的参数校验分组。
- **`UserGroup.java`**: 用户及权限相关的参数校验分组。

### 2.4 全局处理器 (`common.handler`)
- **`GlobalExceptionHandler.java`**: 全局异常拦截器，统一处理 `ServiceRuntimeException` 及系统异常，返回标准的 JSON 格式。
- **`FiledFullHandler.java`**: MyBatis-Plus 自动填充处理器，用于自动填充 `createTime`, `updateTime` 等基础字段。

### 2.5 响应结果 (`common.result`)
- **`Result.java`**: 统一 API 响应结构体，包含状态码、消息及泛型数据。

---

## 3. 配置模块 (`top.sxuan.exam.config`)

系统各项中间件及框架的详细配置。

- **`CorsConfig.java`**: 跨域资源共享配置，允许前端应用跨域访问后端 API。
- **`MybatisPlusConfig.java`**: MyBatis-Plus 插件配置，包括分页插件及乐观锁插件。
- **`RedisConfig.java`**: Redis 序列化配置，确保数据在缓存中的正确存取。
- **`SecurityConfig.java`**: Spring Security 核心配置，定义了认证、授权规则及 JWT 过滤器。
- **`SwaggerConfig.java`**: Knife4j / Swagger 接口文档配置，方便前端在线调试。
- **`WebsocketConfig.java`**: WebSocket 基础配置，用于实现考场监控及实时通信。

---

## 4. 控制层模块 (`top.sxuan.exam.controller`)

负责接收前端请求并调用业务层逻辑，封装了 RESTful API 接口。

- **`AnswerController.java`**: 答题控制类，处理考试过程中的答案提交与存储。
- **`AuthController.java`**: 认证控制类，负责用户登录、身份校验、Token 生成及注销。
- **`CategoryController.java`**: 分类控制类，管理考试或题库的多级分类信息。
- **`CertificateController.java`**: 证书控制类，管理电子证书的生成、预览及发放。
- **`DiscussionController.java`**: 讨论控制类，负责讨论区主贴的发布、查询与删除。
- **`ExamController.java`**: 考试控制类，核心接口，包括考试列表、详情、防作弊检测及 AI 组卷入口。
- **`ExerciseController.java`**: 练习控制类，提供针对特定知识点的练习模式接口。
- **`FileController.java`**: 文件控制类，集成后端文件上传逻辑（通常对接 OSS）。
- **`GradeController.java`**: 班级控制类，管理教学班级的创建、学生分配及口令进班。
- **`LikeController.java`**: 点赞控制类，处理讨论区内容的点赞与取消点赞。
- **`LogController.java`**: 日志控制类，管理员查询系统操作行为日志。
- **`NoticeController.java`**: 通知控制类，发布和维护全站公告或班级内部通知。
- **`QuestionController.java`**: 题目控制类，支持题目的增删改查及 **AI 智能题目生成**。
- **`RecordController.java`**: 记录控制类，用户查看个人历史考试记录与答题详情。
- **`ReplyController.java`**: 回复控制类，管理讨论区帖子的二级评论及相互回复。
- **`RepoController.java`**: 题库控制类，管理题库资源（Repository）的元数据。
- **`ScoreController.java`**: 成绩控制类，提供成绩单查询、排行及批量导出功能。
- **`StatController.java`**: 统计控制类，为控制台（Dashboard）提供实时数据统计汇总。
- **`UserBookController.java`**: 错题本控制类，管理用户在考试中产生的错题收藏。
- **`UserController.java`**: 用户控制类，负责个人信息修改、密码重置及角色权限管理。

---

## 5. 业务逻辑层模块 (`top.sxuan.exam.service`)

包含了系统的核心业务逻辑定义及实现。采用了接口（Interface）与实现类（Impl）分离的设计。

### 5.1 核心业务接口
- **`IAuthService.java`**: 处理用户认证、权限校验及 Token 刷新逻辑。
- **`IExamService.java`**: 最核心的业务接口，包含考试的创建、发布、**AI 智能组卷**、防作弊监控等。
- **`IQuestionService.java`**: 题目管理逻辑，支持多种题型处理及 **AI 批量生成题目**。
- **`IAutoScoringService.java`**: 自动阅卷服务，集成 AI 判分引擎处理主观题及客观题自动打分。
- **`IManualScoreService.java`**: 处理需要老师介入的人工判分逻辑。
- **`ICategoryService.java`**: 管理课程、题目、考试的多级分类逻辑。
- **`IRepoService.java`**: 题库（Repository）的管理逻辑，包括题目的导入、导出、归类。
- **`ICertificateService.java`**: 电子证书的模板配置、生成算法及发放逻辑。
- **`IGradeService.java`**: 班级业务逻辑，处理学生的进班、班级数据统计。
- **`IDiscussionService.java`**: 讨论区核心逻辑，处理帖子发布、列表加载及热度计算。
- **`INoticeService.java`**: 系统公告与通知的精准推送逻辑。
- **`IStatService.java`**: 数据大屏展示所需的复杂统计分析逻辑。
- **`IUserBookService.java`**: 专门处理错题本的收录、移除及练习推荐逻辑。
- **`IUserService.java`**: 用户账户管理、权限分配及资料维护逻辑。
- **`IFileService.java`**: 适配不同存储介质（如 OSS/本地）的文件上传下载封装。

### 5.2 业务实现类 (`service.impl`)
该包下包含了上述所有 `I...Service` 接口的对应实现类（如 `ExamServiceImpl.java`），是业务规则落地的具体位置，通过 `@Service` 注解注入容器。

---

## 6. 数据访问层模块 (`top.sxuan.exam.mapper`)

基于 MyBatis-Plus 框架，负责与 MySQL 数据库进行交互，定义了 SQL 映射及 CRUD 操作。

- **`UserMapper.java`**: 用户基础数据访问，包括根据用户名/手机号查询用户及权限详情。
- **`ExamMapper.java`**: 考试主表数据访问，包含复杂的分页查询及关联查询。
- **`QuestionMapper.java`**: 题目数据访问，处理题目分类、难度及知识点的 SQL 过滤。
- **`RepoMapper.java`**: 题库资源数据访问，维护题库文件夹结构。
- **`CertificateMapper.java`**: 证书模版及发放记录数据访问。
- **`GradeMapper.java`**: 班级基础信息访问。
- **`DiscussionMapper.java` & `ReplyMapper.java`**: 讨论区主从表数据访问。
- **`LogMapper.java`**: 系统操作日志持久化接口。
- **关系映射接口**:
    - **`UserGradeMapper.java`**: 学生与班级的关联映射。
    - **`ExamGradeMapper.java`**: 考试与允许参加班级的关联映射。
    - **`NoticeGradeMapper.java`**: 通知公告与目标班级的关联映射。
    - **`ExamQuestionMapper.java`**: 试卷与题目的具体关联（含分数配比）。

---

## 7. 模型模块 (`top.sxuan.exam.model`)

定义了系统中的所有数据结构，按照用途划分为不同的子包。

### 7.1 数据库实体 (`model.entity`)
与数据库表结构一一对应的 Java POJO。
- **`User.java`, `Exam.java`, `Question.java`, `Grade.java`, `Repo.java`** 等核心业务实体。

### 7.2 表单提交对象 (`model.form`)
接收前端提交的表单数据，通常包含参数校验注解（如 `@NotBlank`, `@NotNull`）。
- **`AiComposePaperForm.java`**: AI 一键组卷参数对象。
- **`ExamForm.java`**: 考试创建与修改表单。
- **`QuestionForm.java`**: 题目新增与维护表单。

### 7.3 视图返回对象 (`model.vo`)
经过业务层封装后，返回给前端展示的数据结构。
- **`ExamVO.java`**: 包含考试基本信息及关联班级、题目的视图模型。
- **`QuestionVO.java`**: 题目详情视图，包含选项及正确答案的脱敏处理。
- **`StatVO.java`**: 统计图表数据结构。

### 7.4 数据传输对象与枚举 (`model.dto` / `model.enums`)
- **`enums.QuestionType`**: 定义了单选、多选、判断、简答等题型常量。
- **`enums.RoleType`**: 定义了管理员、教师、学生三种角色的权限标识。

---

## 8. 转换器模块 (`top.sxuan.exam.converter`)

负责在不同层次的数据对象之间进行转换（如 Entity 转 VO），保持层次清晰。

- **`ExamConverter.java`**: 考试模型转换，处理复杂关联字段的打平。
- **`QuestionConverter.java`**: 题目模型转换。
- **`UserConverter.java`**: 用户信息脱敏及权限列表转换。
- 以及其他所有业务模块对应的映射器，降低了 Service 层的代码耦合度。

---

## 9. 工具类模块 (`top.sxuan.exam.utils`)

提供了全站共用的基础工具函数和封装。

- **`JwtUtil.java`**: JWT Token 的生成、解析及有效性校验，是安全体系的基石。
- **`SecurityUtil.java`**: 获取当前登录用户 ID、权限等 Spring Security 上下文信息的快捷入口。
- **`CryptoUtils.java`**: 包含常用的加解密算法，用于用户密码及敏感数据的处理。
- **`IPUtils.java`**: 解析客户端请求 IP 并转换为地理位置（国家/城市）。
- **`DateTimeUtil.java`**: 统一的日期格式化及考试倒计时计算逻辑。
- **`excel` 包**: 集成了 EasyExcel，用于成绩、用户、题库的批量导入与导出。

---

## 10. 其他功能模块

### 10.1 WebSocket 通信 (`top.sxuan.exam.websocket`)
- **`WebsocketHandler.java`**: 处理前端的 WebSocket 连接，用于实现考试过程中的**切屏检测通知**、实时监控及消息推送。

### 10.2 定时任务 (`top.sxuan.exam.task`)
- **`ExamTask.java`**: 扫描系统中的考试状态，处理如自动交卷、证书补发、过期的考场封存等周期性任务。

### 10.3 过滤器与拦截器 (`top.sxuan.exam.filter`)
- **`VerifyTokenFilter.java`**: 系统核心过滤器，拦截所有请求并进行 JWT 校验，解析用户信息并存入 SecurityContext。

---

## 总结

后端代码结构遵循标准的 **MVC 架构**，通过严格的包结构划分实现了关注点分离：
- `controller` 负责接入。
- `service` 负责业务闭环。
- `mapper` 负责持久化。
- `model` 贯穿始终作为载体。
- `config` 提供基础设施保证。

结合 **AI 智能化能力**（如 `AiComposePaperForm` 和 `AutoScoringService`），本项目在传统考试系统的基础上实现了显著的技术升级。
