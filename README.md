<div align="center">

# 智慧考试云平台 · Smart Exam Cloud

一站式、多角色、AI 赋能的在线考试云平台

<p>
  <img alt="Spring Boot" src="https://img.shields.io/badge/Spring%20Boot-2.x-6DB33F?logo=springboot&logoColor=white">
  <img alt="Vue" src="https://img.shields.io/badge/Vue-2.7-42B883?logo=vuedotjs&logoColor=white">
  <img alt="MyBatis-Plus" src="https://img.shields.io/badge/MyBatis--Plus-3.x-BA2649">
  <img alt="MySQL" src="https://img.shields.io/badge/MySQL-8.x-4479A1?logo=mysql&logoColor=white">
  <img alt="Redis" src="https://img.shields.io/badge/Redis-7.x-DC382D?logo=redis&logoColor=white">
  <img alt="LangChain4j" src="https://img.shields.io/badge/LangChain4j-AI-1C3C3C">
  <img alt="Element UI" src="https://img.shields.io/badge/Element%20UI-2.x-409EFF">
  <img alt="Vite" src="https://img.shields.io/badge/Vite-4.x-646CFF?logo=vite&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-AGPL--3.0-blue">
  <img alt="Java" src="https://img.shields.io/badge/Java-1.8-ED8B00?logo=openjdk&logoColor=white">
</p>

</div>

---

<p align="center">
  <a href="#功能特性">功能特性</a> ·
  <a href="#技术栈">技术栈</a> ·
  <a href="#项目结构">项目结构</a> ·
  <a href="#快速开始">快速开始</a> ·
  <a href="#配置说明">配置说明</a> ·
  <a href="#部署">部署</a> ·
  <a href="#贡献">贡献</a> ·
  <a href="#许可证">许可证</a>
</p>

---

## 简介

Smart Exam Cloud 是一款功能完整、界面友好、部署简单的智慧考试云平台。后端采用 Spring Boot + MyBatis-Plus + Spring Security 的成熟架构，前端基于 Vue 2 + Element UI 构建，深度集成 **AI 智能组卷与阅卷**，覆盖学生、教师、管理员三类角色的完整考试与教学场景。

> ⚠️ 本项目面向学习。生产环境部署前，请务必阅读 [安全须知](#安全须知)。

## 功能特性

### 学生端 — 沉浸式学习体验
- **在线考试**：单选 / 多选 / 判断 / 简答等多种题型，支持自动倒计时、进度保存、自动交卷。
- **AI 智能阅卷**：客观题秒级判分，主观题由 AI 给出评分建议与分析。
- **防作弊体系**：基于浏览器 Visibility API 的实时切屏检测 + 考试异常锁定机制。
- **学习管理**：考试记录回顾、智能错题本、成绩达标自动生成荣誉证书（HTML2Canvas + JsPDF）。
- **互动社区**：支持发布动态、多级评论嵌套、点赞互动。
- **系统通知**：全站公告 / 班级通知实时送达。

### 教师端 — 减负增效
- **班级管理**：创建班级、口令一键进班、学习进度监控。
- **智慧题库**：多级分类，支持手动录入、Excel 批量导入、**AI 智能生成试题**。
- **考试全流程**：固定选题 / 随机抽题 / **AI 一键组卷**，实时考场监控与成绩分布。
- **成绩分析**：多维度报表统计，成绩单批量导出。

### 管理员端 — 全局治理
- 全权管理（覆盖教师端功能）。
- 用户角色与权限的集中式管控。
- 操作日志审计，系统运行安全合规。

## 技术栈

| 分层 | 选型 |
| --- | --- |
| 后端框架 | Spring Boot 2.x、Spring Security、JWT |
| 持久层 | MyBatis-Plus、Druid 连接池、MySQL |
| 缓存与中间件 | Redis |
| 对象存储 | 阿里云 OSS / MinIO（可切换） |
| AI 能力 | LangChain4j（OpenAI 兼容）、Milvus 向量库、Dify |
| 接口文档 | Knife4j (OpenAPI 2 / Swagger) |
| 工具 | Hutool、Lombok、EasyExcel、ip2region |
| 前端框架 | Vue 2.7、Vue Router、Vuex |
| UI | Element UI |
| 构建 | Vite、pnpm |

## 项目结构

```
smart-exam-cloud/
├── online-exam-system-backend/      # 后端 Spring Boot 服务
│   ├── src/main/java/               # Java 源码
│   ├── src/main/resources/          # 配置文件、MyBatis Mapper
│   ├── img/                         # 架构 / ER 图
│   └── pom.xml
├── online-exam-system-frontend/     # 前端 Vue 应用
│   ├── src/
│   ├── public/
│   └── package.json
├── sql/                             # 数据库初始化脚本
│   └── db_exam.sql
├── docs/                            # 项目文档
└── README.md
```

## 快速开始

### 环境要求

- **JDK** 1.8
- **Maven** 3.6+
- **Node.js** 16+ 与 **pnpm**（`npm i -g pnpm`）
- **MySQL** 8.x
- **Redis** 6+
- （可选）MinIO / Milvus，用于本地对象存储与向量检索

### 1. 克隆仓库

```bash
git clone <your-repo-url>.git
cd smart-exam-cloud
```

### 2. 初始化数据库

创建数据库 `db_exam`，导入初始化脚本：

```bash
mysql -uroot -p -e "CREATE DATABASE db_exam DEFAULT CHARACTER SET utf8mb4;"
mysql -uroot -p db_exam < sql/db_exam.sql
```

### 3. 配置后端

后端配置位于 `online-exam-system-backend/src/main/resources/`，默认激活 `dev` profile。

> 真实的 `application-dev.yml` 已在 `.gitignore` 中排除，**不会进入仓库**。仓库仅提供模板 `application-dev-example.yml`。

首次运行请复制模板并填入你自己的密钥：

```bash
cd online-exam-system-backend/src/main/resources
cp application-dev-example.yml application-dev.yml
# Windows PowerShell: Copy-Item application-dev-example.yml application-dev.yml
```

然后编辑 `application-dev.yml`，按文件中的 `TODO` 提示填写：MySQL 密码、JWT 密钥（≥ 64 字符随机串）、OSS / MinIO / LLM / Embedding / Dify / Milvus 等凭证。

> 💡 生产环境（`prod` profile）的 `application-prod.yml` 使用 `${ENV_VAR}` 占位符，建议通过**系统环境变量**注入，避免在文件中硬编码密钥：

```bash
export DB_PASSWORD=your-mysql-password
export JWT_SECRET=$(openssl rand -hex 32)   # 至少 64 字符的随机字符串
export OSS_ACCESS_KEY_ID=your-oss-ak
export OSS_ACCESS_KEY_SECRET=your-oss-sk
# 其余变量见下表
```

### 4. 启动后端

```bash
cd online-exam-system-backend
mvn clean spring-boot:run
# 默认端口 8080，接口文档：http://localhost:8080/doc.html
```

### 5. 启动前端

```bash
cd online-exam-system-frontend
pnpm install
pnpm dev          # 开发模式，默认 http://localhost:9528
```

构建生产包：

```bash
pnpm build:prod   # 产物输出到 dist/
```

## 配置说明

| 环境变量 | 说明 | 默认 / 示例 |
| --- | --- | --- |
| `DB_PASSWORD` | MySQL 密码 | 无，必填 |
| `JWT_SECRET` | JWT 签名密钥（≥ 64 字符） | 无，必填 |
| `OSS_ACCESS_KEY_ID` | 阿里云 OSS AccessKey ID | 使用本地存储可不配 |
| `OSS_ACCESS_KEY_SECRET` | 阿里云 OSS AccessKey Secret | 同上 |
| `MINIO_ACCESS_KEY` / `MINIO_SECRET_KEY` | MinIO 凭证 | `admin` / 无 |
| `LLM_API_KEY` / `LLM_BASE_URL` / `LLM_MODEL` | 大语言模型配置 | 视服务商而定 |
| `EMBEDDING_API_KEY` | Embedding 模型密钥 | 无 |
| `DIFY_API_KEY` | Dify 应用密钥 | 无 |
| `MILVUS_USERNAME` / `MILVUS_PASSWORD` | Milvus 凭证 | `root` / 无 |

存储方式可在 `application-*.yml` 中通过 `online-exam.storage.type` 在 `aliyun` 与 `minio` 间切换。

## 部署

- **前端**：`pnpm build:prod` 后将 `dist/` 部署到 Nginx，反向代理 `/api` 到后端 8080 端口。
- **后端**：`mvn clean package -DskipTests`，使用 `java -jar target/*.jar --spring.profiles.active=prod` 启动，通过环境变量或外部 `application-prod.yml` 注入生产配置。
- 生产环境强烈建议：HTTPS、独立的数据库账号与最小权限、定期轮换 JWT 密钥与 API Key。

## 安全须知

在公开仓库中请遵守以下原则：

1. **绝不提交真实密钥**：数据库密码、JWT 密钥、AccessKey、API Key 等，请只填写在本地被 `.gitignore` 排除的 `application-dev.yml` 中，或通过生产环境变量注入。仓库内只保留 `application-dev-example.yml` 模板与使用占位符的 `application-prod.yml`。
2. **历史泄露需轮换**：如果密钥曾被提交到 Git 历史，**仅删除当前文件是不够的**，必须立即在对应服务商控制台**吊销并重签**相关密钥（阿里云 AK、LLM/Embedding/Dify Key、JWT Secret 等）。
3. **最小权限**：生产数据库账号应仅授予业务所需的最小权限。
4. **CORS 与端口**：生产环境关闭 Swagger 公开访问，限制数据库、Redis、MinIO 端口的公网暴露。

## 贡献

欢迎提交 Issue 与 Pull Request。提交前请：

1. 确保本地 `pnpm lint` 与后端编译通过。
2. 不要在代码或提交信息中包含任何真实密钥。
3. 遵循现有代码风格与提交规范（`<type>(scope): <summary>`）。

## 许可证

本项目采用 [**AGPL-3.0 License**](LICENSE) 开源。

> ⚠️ **AGPL-3.0 的网络条款**：如果你修改了本项目并通过网络提供服务（例如部署成在线服务供他人使用），**必须向这些用户提供修改后的完整源代码**。在使用或二次开发前，请务必阅读 [LICENSE](LICENSE) 全文以了解你的义务。
