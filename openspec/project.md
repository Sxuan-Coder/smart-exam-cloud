# Project Context

## Purpose
该项目是一个前后端分离的智慧考试云平台。主要功能包括题目管理（单选、多选、判断、填空、大题）、试卷管理、考试安排、自动/人工阅卷、成绩统计以及 AI 辅助功能（集成 Coze 和 LangChain4j）。

## Tech Stack
- **后端 (Backend)**:
  - Spring Boot 2.7.18
  - Java 1.8
  - MyBatis-Plus 3.5.5
  - MySQL 8.0
  - Redis (Spring Data Redis + Common Pool2)
  - Spring Security + JWT (java-jwt)
  - 文件存储: MinIO / 阿里云 OSS
  - 文档: Knife4j (Swagger 替代品)
  - AI 集成: Coze SDK, LangChain4j, Milvus 向量数据库
  - 工具类: Hutool, EasyExcel, MapStruct
- **前端 (Frontend)**:
  - Vue 2.7.16
  - 构建工具: Vite 4.5
  - UI 框架: Element UI 2.13.2
  - 状态管理: Vuex 3.1
  - 路由: Vue Router 3.0
  - 图表: Echarts 4.9
  - 编辑器: Vue-Quill-Editor
  - 样式: Sass

## Project Conventions

### Code Style
- **通用原则**: 简洁、专业、代码即文档。
- **注释**: 仅保留关键中文注释，严禁使用 Emoji 符号。
- **Java**: 遵循 Standard Java Naming Conventions。接口返回统一使用 `Result` 包装类（需确认具体类名）。
- **前端**: 组件化开发，变量命名采用 camelCase，组件文件采用 PascalCase。

### Architecture Patterns
- **后端**: 典型的 MVC 架构 (Controller, Service, Mapper, Entity)。使用 DTO/VO 进行数据传输（配合 MapStruct）。
- **前端**: 基于 vue-admin-template 改造，采用页面与组件分离的模式。使用 Axios 封装 API 请求。

### UI/UX 设计规范
- **禁止 Emoji**: 所有 UI 显示、注释、图标等位置严禁使用 Emoji。
- **配色限制**: 严禁使用 AI 风格的默认配色（如紫色系、过渡渐变）。推荐深蓝（`#1E40AF`）、商务绿（`#059669`）等企业级配色。
- **背景**: 纯色背景，避免透明度效果。
- **圆角**: 适度圆角（`rounded-md`）。

### Testing Strategy
- 后端使用 JUnit 5 和 Spring Boot Test 进行单元测试和集成测试。
- 重点关注核心业务逻辑（如考试自动交卷、分数计算）。

### Git Workflow
- 分支策略: `main`/`master` 为稳定分支，功能开发在 `feature/` 分支，Bug 修复在 `hotfix/` 分支。
- Commit 规范: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`。

## Domain Context
- **业务核心**: 试题、试卷、考试、批改、成绩。
- **AI 赋能**: 系统集成了大语言模型，用于辅助出题、智能分析考试结果等。

## Important Constraints
- 必须兼容 Java 1.8 环境。
- 前端必须兼容主流浏览器（Chrome, Edge, Firefox）。
- 系统必须具备高并发下的考试稳定性。

## External Dependencies
- Redis: 用于缓存、Session 管理和分布式锁。
- MinIO/OSS: 存储题目图片和用户头像。
- Coze/OpenAI: 提供 AI 接口服务。
- Milvus: 用于 AI 相关知识库向量检索。
