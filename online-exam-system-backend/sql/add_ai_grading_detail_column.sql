-- 为 t_exam_qu_answer 表添加 ai_grading_detail 字段
-- 用于存储 AI 详细评分反馈(JSON 格式)

ALTER TABLE `t_exam_qu_answer` 
ADD COLUMN `ai_grading_detail` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'AI 详细评分反馈(JSON格式)' 
AFTER `ai_reason`;
