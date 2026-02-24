# 技术设计文档: 增强AI考试功能

## Context
本系统已集成 Coze SDK 和 LangChain4j 作为AI能力提供方，现有 `AIChat` 接口抽象了AI调用。当前 `AutoScoringServiceImpl` 实现了基础的简答题AI评分，但输出格式单一。本设计需在此基础上扩展AI自动组卷和优化判卷详情。

## Goals / Non-Goals

### Goals
- 实现AI自动组卷，支持按知识点、难度、题型分布生成试卷
- 优化AI判卷，返回多维度评分和详细点评
- 保持与现有 `AIChat` 抽象的兼容性
- 前端提供直观的交互体验

### Non-Goals
- 不涉及AI模型的训练或微调
- 不改变现有客观题自动评分逻辑
- 不引入新的AI服务提供商

## Decisions

### 1. AI自动组卷架构
- **Decision**: 采用两阶段组卷策略
  1. 先从题库筛选符合条件的候选题目
  2. 若题库不足，调用AI生成新题填充
- **Alternatives considered**:
  - 纯AI生成：生成速度慢，可能与题库风格不一致
  - 纯题库筛选：无法应对题库不足情况
- **Rationale**: 两阶段策略兼顾效率和覆盖率

### 2. 组卷 Prompt 设计
- **Decision**: 输出结构化JSON，包含题目列表及其属性
- **Format**:
```json
{
  "paperTitle": "自动生成试卷",
  "questions": [
    { "type": 1, "content": "...", "options": [...], "answer": "A", "level": 2, "knowledgePoint": "..." }
  ]
}
```

### 3. 判卷详情 Prompt 优化
- **Decision**: 评分返回结构扩展为多维度
- **Dimensions**:
  - 知识点覆盖度 (0-40%)
  - 逻辑清晰度 (0-30%)
  - 表达准确性 (0-30%)
- **Output Format**:
```json
{
  "评分结果": [
    {
      "题目ID": "123",
      "最终得分": "8",
      "满分": "10",
      "评分维度": {
        "知识点覆盖": { "得分": 3, "满分": 4, "评语": "..." },
        "逻辑清晰度": { "得分": 2, "满分": 3, "评语": "..." },
        "表达准确性": { "得分": 3, "满分": 3, "评语": "..." }
      },
      "扣分原因": "...",
      "改进建议": "..."
    }
  ]
}
```

### 4. 数据库变更
- **Decision**: 扩展 `t_exam_qu_answer` 表，新增字段存储详细评分
- **New Columns**:
  - `ai_grading_detail` (TEXT): 存储JSON格式的详细评分

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| AI生成题目质量不稳定 | 组卷预览环节，教师可手动调整/替换 |
| Prompt变更导致解析失败 | 增加JSON解析容错，失败时降级为简单评分 |
| AI调用延迟影响用户体验 | 组卷和评分均采用异步处理，前端显示进度 |

## Migration Plan
1. 新增数据库字段 `ai_grading_detail`
2. 部署新Prompt，新评分走新逻辑
3. 历史数据无需迁移，仅新评分含详细维度

## Open Questions
- [ ] 是否需要支持教师自定义评分维度权重？
- [ ] AI组卷是否需要支持手动排除特定题目？
