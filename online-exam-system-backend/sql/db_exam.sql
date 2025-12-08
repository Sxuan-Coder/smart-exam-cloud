/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : db_exam

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 04/01/2026 19:50:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '分类名称',
  `parent_id` int NULL DEFAULT 0 COMMENT '父分类ID，0表示一级分类',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, '语文', 0, 1, '2025-12-24 14:33:30', 0);
INSERT INTO `t_category` VALUES (2, '数学', 0, 2, '2025-12-24 14:33:30', 0);
INSERT INTO `t_category` VALUES (3, '英语', 0, 3, '2025-12-24 14:33:30', 0);
INSERT INTO `t_category` VALUES (4, '模拟试题', 1, 1, '2025-12-24 14:33:30', 0);
INSERT INTO `t_category` VALUES (5, '历年真题', 1, 2, '2025-12-24 14:33:30', 0);
INSERT INTO `t_category` VALUES (6, '计算机', 0, 0, '2025-12-24 22:34:25', 0);
INSERT INTO `t_category` VALUES (7, '思政', 0, 0, '2026-01-03 19:02:47', 0);

-- ----------------------------
-- Table structure for t_certificate
-- ----------------------------
DROP TABLE IF EXISTS `t_certificate`;
CREATE TABLE `t_certificate`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID   证书',
  `certificate_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '证数名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '背景图片',
  `certification_nuit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '认证单位',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_certificate
-- ----------------------------
INSERT INTO `t_certificate` VALUES (73, '学习之星', NULL, '重庆师范大学', '2026-01-03 19:03:47', 0);
INSERT INTO `t_certificate` VALUES (74, '测试', NULL, '测试赛', '2026-01-04 18:31:09', 0);

-- ----------------------------
-- Table structure for t_certificate_user
-- ----------------------------
DROP TABLE IF EXISTS `t_certificate_user`;
CREATE TABLE `t_certificate_user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID   证书与用户关系表',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `exam_id` int NULL DEFAULT NULL COMMENT '考试id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '证书编号',
  `certificate_id` int NULL DEFAULT NULL COMMENT '证书id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '获奖时间      YYYY-MM-DD hh:mm:ss',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_certificate_user
-- ----------------------------
INSERT INTO `t_certificate_user` VALUES (2, 164, 120, 'ktlrQPhxIAyGSQKJhB', NULL, '2025-04-26 14:35:36');
INSERT INTO `t_certificate_user` VALUES (3, 164, 127, 'OgngSCh8T63MxFCVCG', 73, '2026-01-04 15:03:38');
INSERT INTO `t_certificate_user` VALUES (4, 164, 129, 'Wx3keDtHdPdnzZz4tl', 73, '2026-01-04 15:25:36');

-- ----------------------------
-- Table structure for t_discussion
-- ----------------------------
DROP TABLE IF EXISTS `t_discussion`;
CREATE TABLE `t_discussion`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '发布人id',
  `grade_id` int NOT NULL COMMENT '接收班级id',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_discussion
-- ----------------------------
INSERT INTO `t_discussion` VALUES (1, 163, 124, '测试发布讨论 -内容1', '测试发布讨论 -标题1', '2025-12-04 17:55:10');
INSERT INTO `t_discussion` VALUES (3, 163, 124, '222', '222', '2026-01-04 18:31:59');

-- ----------------------------
-- Table structure for t_exam
-- ----------------------------
DROP TABLE IF EXISTS `t_exam`;
CREATE TABLE `t_exam`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id    考试表',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '考试名称',
  `exam_duration` int NOT NULL COMMENT '考试时长',
  `passed_score` int NOT NULL COMMENT '及格分',
  `gross_score` int NOT NULL COMMENT '总分数',
  `max_count` int NULL DEFAULT NULL COMMENT '最大切屏次数',
  `user_id` int NULL DEFAULT NULL COMMENT '创建者id',
  `certificate_id` int NULL DEFAULT NULL COMMENT '证书id',
  `radio_count` int NULL DEFAULT NULL COMMENT '单选题数量',
  `radio_score` int NULL DEFAULT NULL COMMENT '单选题成绩     数据库存储*100，前端正常输入和展示/100',
  `multi_count` int NULL DEFAULT NULL COMMENT '多选题数量 ',
  `multi_score` int NULL DEFAULT NULL COMMENT '多选题成绩     数据库存储*100，前端正常输入和展示/100',
  `judge_count` int NULL DEFAULT NULL COMMENT '判断题数量 ',
  `judge_score` int NULL DEFAULT NULL COMMENT '判断题成绩     数据库存储*100，前端正常输入和展示/100',
  `saq_count` int NULL DEFAULT NULL COMMENT '简答题数量',
  `saq_score` int NULL DEFAULT NULL COMMENT '简答题成绩     数据库存储*100，前端正常输入和展示/100',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间     YYYY-MM-DD hh:mm:ss',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间     YYYY-MM-DD hh:mm:ss',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间     YYYY-MM-DD hh:mm:ss  ',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`, `passed_score`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exam
-- ----------------------------
INSERT INTO `t_exam` VALUES (119, 'test3', 1, 1, 21, 1, 163, NULL, 0, 0, 0, 0, 3, 7, 0, 0, '2025-12-20 16:00:00', '2025-05-14 16:00:00', '2025-04-26 14:07:42', 0);
INSERT INTO `t_exam` VALUES (120, 'test1', 100, 1, 20, 100, 163, NULL, 0, 0, 0, 0, 10, 2, 0, 0, '2025-12-09 16:00:00', '2025-05-27 16:00:00', '2025-04-26 14:34:59', 0);
INSERT INTO `t_exam` VALUES (121, '马克思期末考试', 30, 0, 0, 3, 1, NULL, 5, 0, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-09 00:00:00', '2026-01-01 03:18:49', 0);
INSERT INTO `t_exam` VALUES (122, '计算机混合试卷考试', 30, 30, 56, 3, 163, NULL, 8, 5, 2, 8, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-06 00:00:00', '2026-01-03 18:56:45', 0);
INSERT INTO `t_exam` VALUES (123, '数据结构测试', 0, 60, 90, 6, 163, 73, 0, 0, 5, 8, 0, 0, 5, 10, '2026-01-01 00:00:00', '2026-01-29 00:00:00', '2026-01-03 19:25:01', 0);
INSERT INTO `t_exam` VALUES (124, '数据结构测试2', 60, 21, 36, NULL, 1, NULL, 5, 2, 2, 5, 3, 2, 1, 10, '2026-01-04 09:36:59', '2026-01-11 09:36:59', '2026-01-04 09:36:58', 0);
INSERT INTO `t_exam` VALUES (125, '计算机网络测试2', 60, 21, 36, NULL, 1, NULL, 5, 2, 2, 5, 3, 2, 1, 10, '2026-01-04 10:53:52', '2026-01-11 10:53:52', '2026-01-04 10:53:51', 0);
INSERT INTO `t_exam` VALUES (126, '测试证书', 30, 30, 50, 5, 1, 73, 10, 5, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-05 00:00:00', '2026-01-04 15:01:07', 0);
INSERT INTO `t_exam` VALUES (127, '23323', 30, 2, 3, 5, 1, 73, 1, 3, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-05 00:00:00', '2026-01-04 15:02:51', 0);
INSERT INTO `t_exam` VALUES (128, '2222', 30, 3, 3, 2, 163, 73, 1, 3, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-04 00:00:00', '2026-01-04 15:23:39', 0);
INSERT INTO `t_exam` VALUES (129, '11111', 30, 0, 0, 2, 163, 73, 1, 0, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-07 00:00:00', '2026-01-04 15:25:00', 0);
INSERT INTO `t_exam` VALUES (130, '测试看看', 60, 5, 9, NULL, 163, NULL, 1, 2, 1, 5, 1, 2, 0, 0, '2026-01-04 16:08:49', '2026-01-11 16:08:49', '2026-01-04 16:08:49', 0);
INSERT INTO `t_exam` VALUES (131, '2222', 30, 2, 4, 3, 1, 73, 2, 2, 0, 0, 0, 0, 0, 0, '2026-01-01 00:00:00', '2026-01-05 00:00:00', '2026-01-04 18:29:17', 0);
INSERT INTO `t_exam` VALUES (132, '2222', 60, 4, 7, NULL, 163, NULL, 2, 1, 2, 1, 1, 1, 1, 2, '2026-01-04 18:34:01', '2026-01-11 18:34:01', '2026-01-04 18:34:01', 0);

-- ----------------------------
-- Table structure for t_exam_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_exam_grade`;
CREATE TABLE `t_exam_grade`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   考试与班级关系表',
  `exam_id` int NULL DEFAULT NULL COMMENT '考试id  唯一',
  `grade_id` int NULL DEFAULT NULL COMMENT '班级id  唯一',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 219 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exam_grade
-- ----------------------------
INSERT INTO `t_exam_grade` VALUES (202, 116, 124);
INSERT INTO `t_exam_grade` VALUES (203, 117, 124);
INSERT INTO `t_exam_grade` VALUES (204, 118, 124);
INSERT INTO `t_exam_grade` VALUES (205, 119, 124);
INSERT INTO `t_exam_grade` VALUES (206, 120, 124);
INSERT INTO `t_exam_grade` VALUES (207, 121, 124);
INSERT INTO `t_exam_grade` VALUES (208, 122, 124);
INSERT INTO `t_exam_grade` VALUES (209, 123, 124);
INSERT INTO `t_exam_grade` VALUES (210, 124, 124);
INSERT INTO `t_exam_grade` VALUES (211, 125, 124);
INSERT INTO `t_exam_grade` VALUES (212, 126, 124);
INSERT INTO `t_exam_grade` VALUES (213, 127, 124);
INSERT INTO `t_exam_grade` VALUES (214, 128, 124);
INSERT INTO `t_exam_grade` VALUES (215, 129, 124);
INSERT INTO `t_exam_grade` VALUES (216, 130, 124);
INSERT INTO `t_exam_grade` VALUES (217, 131, 124);
INSERT INTO `t_exam_grade` VALUES (218, 132, 124);

-- ----------------------------
-- Table structure for t_exam_qu_answer
-- ----------------------------
DROP TABLE IF EXISTS `t_exam_qu_answer`;
CREATE TABLE `t_exam_qu_answer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id  考试记录答案',
  `user_id` int NOT NULL COMMENT '用户id',
  `exam_id` int NOT NULL COMMENT '考试id',
  `question_id` int NOT NULL COMMENT '试题id',
  `question_type` int NULL DEFAULT NULL COMMENT '题目类型',
  `answer_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '答案id  用于客观题，多选题id使用“，”分隔',
  `answer_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '答案内容    用于主观题',
  `checkout` int NULL DEFAULT NULL COMMENT '是否选中   0未选中  1选中',
  `is_sign` int NULL DEFAULT NULL COMMENT '是否标记   0未标记  1标记',
  `is_right` int NULL DEFAULT NULL COMMENT '是否正确   用于客观题，0错误 1正确',
  `ai_score` int NULL DEFAULT NULL COMMENT 'ai评分',
  `ai_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'ai评分原因',
  `ai_grading_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'AI 详细评分反馈(JSON格式)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `exam_id` ASC, `question_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 318 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exam_qu_answer
-- ----------------------------
INSERT INTO `t_exam_qu_answer` VALUES (284, 164, 120, 718, 3, '2642', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (285, 164, 120, 719, 3, '2645', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (286, 164, 120, 720, 3, '2647', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (287, 164, 120, 721, 3, '2648', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (288, 164, 120, 722, 3, '2651', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (289, 164, 120, 723, 3, '2652', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (290, 164, 120, 724, 3, '2655', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (291, 164, 120, 725, 3, '2656', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (292, 164, 120, 726, 3, '2659', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (293, 164, 120, 727, 3, '2660', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (294, 164, 121, 730, 1, '2666', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (295, 164, 121, 731, 1, '2672', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (296, 164, 121, 732, 1, '2674', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (297, 164, 121, 733, 1, '2678', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (298, 164, 121, 734, 1, '2682', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (299, 164, 122, 735, 1, '2689', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (300, 164, 122, 736, 1, '2691', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (301, 164, 122, 737, 1, '2696', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (302, 164, 122, 738, 1, '2700', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (303, 164, 122, 739, 1, '2703', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (304, 164, 122, 740, 1, '2707', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (305, 164, 122, 741, 1, '2712', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (306, 164, 122, 742, 1, '2716', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (307, 164, 122, 743, 2, '2718,2719', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (308, 164, 122, 744, 2, '2722', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (309, 164, 125, 764, 1, '2775', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (310, 164, 125, 774, 4, NULL, '', NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (311, 164, 126, 730, 1, '2666', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (312, 164, 126, 731, 1, '2672', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (313, 164, 127, 730, 1, '2666', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (314, 164, 123, 743, 2, '2718,2719', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (315, 164, 130, 775, 1, '2811', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (316, 164, 130, 776, 2, '2815', NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO `t_exam_qu_answer` VALUES (317, 164, 130, 777, 3, '2816', NULL, NULL, NULL, 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_exam_question
-- ----------------------------
DROP TABLE IF EXISTS `t_exam_question`;
CREATE TABLE `t_exam_question`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id  考试题目表',
  `exam_id` int NOT NULL COMMENT '考试id',
  `question_id` int NOT NULL COMMENT '题目id',
  `score` int NOT NULL COMMENT '分值',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `type` int NULL DEFAULT NULL COMMENT '试题类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 611 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exam_question
-- ----------------------------
INSERT INTO `t_exam_question` VALUES (521, 118, 718, 7, 0, 3);
INSERT INTO `t_exam_question` VALUES (522, 118, 718, 7, 0, 3);
INSERT INTO `t_exam_question` VALUES (523, 118, 719, 7, 1, 3);
INSERT INTO `t_exam_question` VALUES (524, 118, 720, 7, 2, 3);
INSERT INTO `t_exam_question` VALUES (525, 118, 718, 7, 0, 3);
INSERT INTO `t_exam_question` VALUES (526, 118, 719, 7, 1, 3);
INSERT INTO `t_exam_question` VALUES (527, 119, 718, 7, 0, 3);
INSERT INTO `t_exam_question` VALUES (528, 119, 719, 7, 1, 3);
INSERT INTO `t_exam_question` VALUES (529, 119, 720, 7, 2, 3);
INSERT INTO `t_exam_question` VALUES (530, 120, 718, 2, 0, 3);
INSERT INTO `t_exam_question` VALUES (531, 120, 719, 2, 1, 3);
INSERT INTO `t_exam_question` VALUES (532, 120, 720, 2, 2, 3);
INSERT INTO `t_exam_question` VALUES (533, 120, 721, 2, 3, 3);
INSERT INTO `t_exam_question` VALUES (534, 120, 722, 2, 4, 3);
INSERT INTO `t_exam_question` VALUES (535, 120, 723, 2, 5, 3);
INSERT INTO `t_exam_question` VALUES (536, 120, 724, 2, 6, 3);
INSERT INTO `t_exam_question` VALUES (537, 120, 725, 2, 7, 3);
INSERT INTO `t_exam_question` VALUES (538, 120, 726, 2, 8, 3);
INSERT INTO `t_exam_question` VALUES (539, 120, 727, 2, 9, 3);
INSERT INTO `t_exam_question` VALUES (540, 121, 730, 0, 0, 1);
INSERT INTO `t_exam_question` VALUES (541, 121, 731, 0, 1, 1);
INSERT INTO `t_exam_question` VALUES (542, 121, 732, 0, 2, 1);
INSERT INTO `t_exam_question` VALUES (543, 121, 733, 0, 3, 1);
INSERT INTO `t_exam_question` VALUES (544, 121, 734, 0, 4, 1);
INSERT INTO `t_exam_question` VALUES (545, 122, 735, 5, 0, 1);
INSERT INTO `t_exam_question` VALUES (546, 122, 736, 5, 1, 1);
INSERT INTO `t_exam_question` VALUES (547, 122, 737, 5, 2, 1);
INSERT INTO `t_exam_question` VALUES (548, 122, 738, 5, 3, 1);
INSERT INTO `t_exam_question` VALUES (549, 122, 739, 5, 4, 1);
INSERT INTO `t_exam_question` VALUES (550, 122, 740, 5, 5, 1);
INSERT INTO `t_exam_question` VALUES (551, 122, 741, 5, 6, 1);
INSERT INTO `t_exam_question` VALUES (552, 122, 742, 5, 7, 1);
INSERT INTO `t_exam_question` VALUES (553, 122, 743, 8, 8, 2);
INSERT INTO `t_exam_question` VALUES (554, 122, 744, 8, 9, 2);
INSERT INTO `t_exam_question` VALUES (555, 123, 743, 8, 0, 2);
INSERT INTO `t_exam_question` VALUES (556, 123, 744, 8, 3, 2);
INSERT INTO `t_exam_question` VALUES (557, 123, 745, 8, 4, 2);
INSERT INTO `t_exam_question` VALUES (558, 123, 746, 8, 2, 2);
INSERT INTO `t_exam_question` VALUES (559, 123, 747, 8, 1, 2);
INSERT INTO `t_exam_question` VALUES (560, 123, 752, 10, 6, 4);
INSERT INTO `t_exam_question` VALUES (561, 123, 748, 10, 9, 4);
INSERT INTO `t_exam_question` VALUES (562, 123, 749, 10, 7, 4);
INSERT INTO `t_exam_question` VALUES (563, 123, 750, 10, 8, 4);
INSERT INTO `t_exam_question` VALUES (564, 123, 751, 10, 5, 4);
INSERT INTO `t_exam_question` VALUES (565, 124, 753, 2, 0, NULL);
INSERT INTO `t_exam_question` VALUES (566, 124, 754, 2, 1, NULL);
INSERT INTO `t_exam_question` VALUES (567, 124, 755, 2, 2, NULL);
INSERT INTO `t_exam_question` VALUES (568, 124, 756, 2, 3, NULL);
INSERT INTO `t_exam_question` VALUES (569, 124, 757, 2, 4, NULL);
INSERT INTO `t_exam_question` VALUES (570, 124, 758, 5, 5, NULL);
INSERT INTO `t_exam_question` VALUES (571, 124, 759, 5, 6, NULL);
INSERT INTO `t_exam_question` VALUES (572, 124, 760, 2, 7, NULL);
INSERT INTO `t_exam_question` VALUES (573, 124, 761, 2, 8, NULL);
INSERT INTO `t_exam_question` VALUES (574, 124, 762, 2, 9, NULL);
INSERT INTO `t_exam_question` VALUES (575, 124, 763, 10, 10, NULL);
INSERT INTO `t_exam_question` VALUES (576, 125, 764, 2, 0, 1);
INSERT INTO `t_exam_question` VALUES (577, 125, 765, 2, 1, 1);
INSERT INTO `t_exam_question` VALUES (578, 125, 766, 2, 2, 1);
INSERT INTO `t_exam_question` VALUES (579, 125, 767, 2, 3, 1);
INSERT INTO `t_exam_question` VALUES (580, 125, 768, 2, 4, 1);
INSERT INTO `t_exam_question` VALUES (581, 125, 769, 5, 5, 2);
INSERT INTO `t_exam_question` VALUES (582, 125, 770, 5, 6, 2);
INSERT INTO `t_exam_question` VALUES (583, 125, 771, 2, 7, 3);
INSERT INTO `t_exam_question` VALUES (584, 125, 772, 2, 8, 3);
INSERT INTO `t_exam_question` VALUES (585, 125, 773, 2, 9, 3);
INSERT INTO `t_exam_question` VALUES (586, 125, 774, 10, 10, 4);
INSERT INTO `t_exam_question` VALUES (587, 126, 730, 5, 0, 1);
INSERT INTO `t_exam_question` VALUES (588, 126, 731, 5, 1, 1);
INSERT INTO `t_exam_question` VALUES (589, 126, 732, 5, 2, 1);
INSERT INTO `t_exam_question` VALUES (590, 126, 733, 5, 3, 1);
INSERT INTO `t_exam_question` VALUES (591, 126, 734, 5, 4, 1);
INSERT INTO `t_exam_question` VALUES (592, 126, 735, 5, 5, 1);
INSERT INTO `t_exam_question` VALUES (593, 126, 736, 5, 6, 1);
INSERT INTO `t_exam_question` VALUES (594, 126, 737, 5, 7, 1);
INSERT INTO `t_exam_question` VALUES (595, 126, 738, 5, 8, 1);
INSERT INTO `t_exam_question` VALUES (596, 126, 739, 5, 9, 1);
INSERT INTO `t_exam_question` VALUES (597, 127, 730, 3, 0, 1);
INSERT INTO `t_exam_question` VALUES (598, 128, 735, 3, 0, 1);
INSERT INTO `t_exam_question` VALUES (599, 129, 735, 0, 0, 1);
INSERT INTO `t_exam_question` VALUES (600, 130, 775, 2, 0, 1);
INSERT INTO `t_exam_question` VALUES (601, 130, 776, 5, 1, 2);
INSERT INTO `t_exam_question` VALUES (602, 130, 777, 2, 2, 3);
INSERT INTO `t_exam_question` VALUES (603, 131, 730, 2, 0, 1);
INSERT INTO `t_exam_question` VALUES (604, 131, 731, 2, 1, 1);
INSERT INTO `t_exam_question` VALUES (605, 132, 780, 1, 0, 1);
INSERT INTO `t_exam_question` VALUES (606, 132, 781, 1, 1, 1);
INSERT INTO `t_exam_question` VALUES (607, 132, 782, 1, 2, 2);
INSERT INTO `t_exam_question` VALUES (608, 132, 783, 1, 3, 2);
INSERT INTO `t_exam_question` VALUES (609, 132, 784, 1, 4, 3);
INSERT INTO `t_exam_question` VALUES (610, 132, 785, 2, 5, 4);

-- ----------------------------
-- Table structure for t_exam_repo
-- ----------------------------
DROP TABLE IF EXISTS `t_exam_repo`;
CREATE TABLE `t_exam_repo`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id  考试与题库',
  `exam_id` int NOT NULL COMMENT '考试id  唯一',
  `repo_id` int NULL DEFAULT NULL COMMENT '题库id  唯一',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exam_repo
-- ----------------------------
INSERT INTO `t_exam_repo` VALUES (104, 116, NULL);
INSERT INTO `t_exam_repo` VALUES (105, 117, NULL);
INSERT INTO `t_exam_repo` VALUES (106, 118, NULL);
INSERT INTO `t_exam_repo` VALUES (107, 119, NULL);
INSERT INTO `t_exam_repo` VALUES (108, 120, NULL);
INSERT INTO `t_exam_repo` VALUES (109, 121, NULL);
INSERT INTO `t_exam_repo` VALUES (110, 122, NULL);
INSERT INTO `t_exam_repo` VALUES (111, 123, 101);
INSERT INTO `t_exam_repo` VALUES (112, 126, NULL);
INSERT INTO `t_exam_repo` VALUES (113, 127, NULL);
INSERT INTO `t_exam_repo` VALUES (114, 128, NULL);
INSERT INTO `t_exam_repo` VALUES (115, 129, NULL);
INSERT INTO `t_exam_repo` VALUES (116, 131, NULL);

-- ----------------------------
-- Table structure for t_exercise_record
-- ----------------------------
DROP TABLE IF EXISTS `t_exercise_record`;
CREATE TABLE `t_exercise_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repo_id` int NOT NULL COMMENT '题库id',
  `question_id` int NOT NULL COMMENT '试题id',
  `user_id` int NOT NULL COMMENT '用户id',
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '主观题答案',
  `question_type` int NOT NULL COMMENT '题目类型',
  `options` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '客观题答案集合  用于客观题,多选题id使用\",\"分隔',
  `is_right` int NULL DEFAULT NULL COMMENT '客观题是否正确',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `repo_id`(`repo_id` ASC, `question_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_exercise_record
-- ----------------------------
INSERT INTO `t_exercise_record` VALUES (165, 101, 743, 164, '2719,2718,2720', 2, NULL, 1);
INSERT INTO `t_exercise_record` VALUES (166, 100, 735, 164, '2686', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (167, 100, 736, 164, '2690', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (168, 100, 737, 164, '2694', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (169, 100, 738, 164, '2698', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (170, 100, 739, 164, '2702', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (171, 100, 740, 164, '2707', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (172, 100, 741, 164, '2711', 1, NULL, 0);
INSERT INTO `t_exercise_record` VALUES (173, 100, 742, 164, '2717', 1, NULL, 0);

-- ----------------------------
-- Table structure for t_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_grade`;
CREATE TABLE `t_grade`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   班级表',
  `grade_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '班级名称',
  `user_id` int NULL DEFAULT NULL COMMENT '创建人id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '班级口令',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `grade_name`(`grade_name` ASC) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_grade
-- ----------------------------
INSERT INTO `t_grade` VALUES (124, '测试班级', 1, 'OQPr7cXFdLxUPq0ZpJ', 0);

-- ----------------------------
-- Table structure for t_grade_exercise
-- ----------------------------
DROP TABLE IF EXISTS `t_grade_exercise`;
CREATE TABLE `t_grade_exercise`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id  刷题表',
  `repo_id` int NULL DEFAULT NULL COMMENT '题库id',
  `grade_id` int NULL DEFAULT NULL COMMENT '班级id',
  `user_id` int NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_grade_exercise
-- ----------------------------

-- ----------------------------
-- Table structure for t_like
-- ----------------------------
DROP TABLE IF EXISTS `t_like`;
CREATE TABLE `t_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `discussion_id` int NULL DEFAULT NULL,
  `reply_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `discussion_id`(`discussion_id` ASC, `reply_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_like
-- ----------------------------
INSERT INTO `t_like` VALUES (14, 1, 21, 164, '2026-01-04 18:28:00');
INSERT INTO `t_like` VALUES (15, 1, 20, 164, '2026-01-04 18:28:02');

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录地点',
  `behavior` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作行为',
  `device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录设备',
  `user_id` int NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1481613527 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log
-- ----------------------------
INSERT INTO `t_log` VALUES (1481613429, '0|0|0|内网IP|内网IP', '设备登录', 'Windows NT 10.0', 1, '2025-12-29 19:54:26');
INSERT INTO `t_log` VALUES (1481613430, '0|0|0|内网IP|内网IP', '设备登出', 'Windows NT 10.0', 1, '2025-12-29 20:12:49');
INSERT INTO `t_log` VALUES (1481613431, '0|0|0|内网IP|内网IP', '设备登录', 'Windows NT 10.0', 164, '2025-12-29 20:13:04');
INSERT INTO `t_log` VALUES (1481613432, '0|0|0|内网IP|内网IP', '设备登出', 'Windows NT 10.0', 164, '2025-12-29 20:13:35');
INSERT INTO `t_log` VALUES (1481613433, '0|0|0|内网IP|内网IP', '设备登录', 'Windows NT 10.0', 1, '2025-12-29 20:15:49');
INSERT INTO `t_log` VALUES (1481613434, '0|0|0|内网IP|内网IP', '设备登出', 'Windows NT 10.0', 1, '2025-12-29 20:27:27');
INSERT INTO `t_log` VALUES (1481613435, '0|0|0|内网IP|内网IP', '设备登录', 'Windows NT 10.0', 1, '2025-12-29 20:27:47');
INSERT INTO `t_log` VALUES (1481613436, '0|0|0|内网IP|内网IP', '设备登录', 'Windows NT 10.0', 1, '2025-12-31 01:34:43');
INSERT INTO `t_log` VALUES (1481613437, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-01 03:10:55');
INSERT INTO `t_log` VALUES (1481613438, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-01 03:18:58');
INSERT INTO `t_log` VALUES (1481613439, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-01 03:19:06');
INSERT INTO `t_log` VALUES (1481613440, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-01 03:20:57');
INSERT INTO `t_log` VALUES (1481613441, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-01 03:21:12');
INSERT INTO `t_log` VALUES (1481613442, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-01 03:22:03');
INSERT INTO `t_log` VALUES (1481613443, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-01 03:22:12');
INSERT INTO `t_log` VALUES (1481613444, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-01 21:29:32');
INSERT INTO `t_log` VALUES (1481613445, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-03 03:08:04');
INSERT INTO `t_log` VALUES (1481613446, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-03 03:27:00');
INSERT INTO `t_log` VALUES (1481613447, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-03 18:13:48');
INSERT INTO `t_log` VALUES (1481613448, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-03 18:32:42');
INSERT INTO `t_log` VALUES (1481613449, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-03 18:32:54');
INSERT INTO `t_log` VALUES (1481613450, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-03 18:50:39');
INSERT INTO `t_log` VALUES (1481613451, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-03 18:50:46');
INSERT INTO `t_log` VALUES (1481613452, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-03 18:55:24');
INSERT INTO `t_log` VALUES (1481613453, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-03 18:55:31');
INSERT INTO `t_log` VALUES (1481613454, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-03 18:57:14');
INSERT INTO `t_log` VALUES (1481613455, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-03 18:57:20');
INSERT INTO `t_log` VALUES (1481613456, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-03 19:01:39');
INSERT INTO `t_log` VALUES (1481613457, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-03 19:01:45');
INSERT INTO `t_log` VALUES (1481613458, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-03 19:03:12');
INSERT INTO `t_log` VALUES (1481613459, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-03 19:03:18');
INSERT INTO `t_log` VALUES (1481613460, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-03 19:04:33');
INSERT INTO `t_log` VALUES (1481613461, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-03 19:04:39');
INSERT INTO `t_log` VALUES (1481613462, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-03 19:25:13');
INSERT INTO `t_log` VALUES (1481613463, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-03 19:25:20');
INSERT INTO `t_log` VALUES (1481613464, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-03 19:40:05');
INSERT INTO `t_log` VALUES (1481613465, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 09:07:27');
INSERT INTO `t_log` VALUES (1481613466, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 09:10:53');
INSERT INTO `t_log` VALUES (1481613467, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 09:12:38');
INSERT INTO `t_log` VALUES (1481613468, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 09:18:40');
INSERT INTO `t_log` VALUES (1481613469, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 09:18:47');
INSERT INTO `t_log` VALUES (1481613470, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 09:26:06');
INSERT INTO `t_log` VALUES (1481613471, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 09:33:17');
INSERT INTO `t_log` VALUES (1481613472, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 09:37:07');
INSERT INTO `t_log` VALUES (1481613473, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 09:37:15');
INSERT INTO `t_log` VALUES (1481613474, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 09:46:36');
INSERT INTO `t_log` VALUES (1481613475, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 09:46:45');
INSERT INTO `t_log` VALUES (1481613476, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 14:38:12');
INSERT INTO `t_log` VALUES (1481613477, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 14:38:22');
INSERT INTO `t_log` VALUES (1481613478, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 14:38:45');
INSERT INTO `t_log` VALUES (1481613479, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:00:01');
INSERT INTO `t_log` VALUES (1481613480, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 15:00:09');
INSERT INTO `t_log` VALUES (1481613481, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 15:01:10');
INSERT INTO `t_log` VALUES (1481613482, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:01:17');
INSERT INTO `t_log` VALUES (1481613483, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:01:58');
INSERT INTO `t_log` VALUES (1481613484, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 15:02:03');
INSERT INTO `t_log` VALUES (1481613485, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 15:03:11');
INSERT INTO `t_log` VALUES (1481613486, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:03:19');
INSERT INTO `t_log` VALUES (1481613487, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:10:45');
INSERT INTO `t_log` VALUES (1481613488, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:15:46');
INSERT INTO `t_log` VALUES (1481613489, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:16:57');
INSERT INTO `t_log` VALUES (1481613490, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 15:17:04');
INSERT INTO `t_log` VALUES (1481613491, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 15:18:32');
INSERT INTO `t_log` VALUES (1481613492, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 15:18:39');
INSERT INTO `t_log` VALUES (1481613493, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 15:23:42');
INSERT INTO `t_log` VALUES (1481613494, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:23:49');
INSERT INTO `t_log` VALUES (1481613495, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:24:24');
INSERT INTO `t_log` VALUES (1481613496, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 15:24:31');
INSERT INTO `t_log` VALUES (1481613497, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 15:25:02');
INSERT INTO `t_log` VALUES (1481613498, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:25:09');
INSERT INTO `t_log` VALUES (1481613499, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:26:03');
INSERT INTO `t_log` VALUES (1481613500, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 15:26:21');
INSERT INTO `t_log` VALUES (1481613501, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 15:27:17');
INSERT INTO `t_log` VALUES (1481613502, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 15:27:24');
INSERT INTO `t_log` VALUES (1481613503, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 15:48:00');
INSERT INTO `t_log` VALUES (1481613504, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 15:48:08');
INSERT INTO `t_log` VALUES (1481613505, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 15:52:35');
INSERT INTO `t_log` VALUES (1481613506, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 15:54:52');
INSERT INTO `t_log` VALUES (1481613507, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 15:56:07');
INSERT INTO `t_log` VALUES (1481613508, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 15:56:28');
INSERT INTO `t_log` VALUES (1481613509, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 15:56:46');
INSERT INTO `t_log` VALUES (1481613510, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 16:03:03');
INSERT INTO `t_log` VALUES (1481613511, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 16:03:48');
INSERT INTO `t_log` VALUES (1481613512, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 16:04:10');
INSERT INTO `t_log` VALUES (1481613513, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 16:04:40');
INSERT INTO `t_log` VALUES (1481613514, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 16:04:48');
INSERT INTO `t_log` VALUES (1481613515, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 16:05:28');
INSERT INTO `t_log` VALUES (1481613516, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 16:05:41');
INSERT INTO `t_log` VALUES (1481613517, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 16:08:54');
INSERT INTO `t_log` VALUES (1481613518, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 18:20:56');
INSERT INTO `t_log` VALUES (1481613519, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 18:26:14');
INSERT INTO `t_log` VALUES (1481613520, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 18:26:19');
INSERT INTO `t_log` VALUES (1481613521, '暂无信息', '设备登出', 'Windows NT 10.0', 164, '2026-01-04 18:28:19');
INSERT INTO `t_log` VALUES (1481613522, '暂无信息', '设备登录', 'Windows NT 10.0', 1, '2026-01-04 18:28:26');
INSERT INTO `t_log` VALUES (1481613523, '暂无信息', '设备登出', 'Windows NT 10.0', 1, '2026-01-04 18:31:27');
INSERT INTO `t_log` VALUES (1481613524, '暂无信息', '设备登录', 'Windows NT 10.0', 163, '2026-01-04 18:31:37');
INSERT INTO `t_log` VALUES (1481613525, '暂无信息', '设备登出', 'Windows NT 10.0', 163, '2026-01-04 18:34:39');
INSERT INTO `t_log` VALUES (1481613526, '暂无信息', '设备登录', 'Windows NT 10.0', 164, '2026-01-04 18:34:45');

-- ----------------------------
-- Table structure for t_manual_score
-- ----------------------------
DROP TABLE IF EXISTS `t_manual_score`;
CREATE TABLE `t_manual_score`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   人工评分表',
  `exam_qu_answer_id` int NULL DEFAULT NULL COMMENT '考试记录答案id',
  `user_id` int NULL DEFAULT NULL COMMENT '批改人id',
  `score` int NULL DEFAULT NULL COMMENT '得分',
  `create_time` datetime NULL DEFAULT NULL COMMENT '批改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_manual_score
-- ----------------------------

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID   公告表',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片地址',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告内容',
  `user_id` int NULL DEFAULT NULL COMMENT '创建用户ID   唯一',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  `is_public` int NULL DEFAULT NULL COMMENT '是否公开所有用户，老师为所有班级，管理员为所有用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES (115, '测试公告功能', NULL, '<p><strong>哈喽，everyone</strong></p>', 163, '2026-01-03 18:45:45', 0, 1);
INSERT INTO `t_notice` VALUES (116, '公告12', NULL, '<p>123123</p>', 1, '2026-01-04 18:31:21', 0, 1);

-- ----------------------------
-- Table structure for t_notice_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_notice_grade`;
CREATE TABLE `t_notice_grade`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID   公告班级关联表',
  `notice_id` int NULL DEFAULT NULL COMMENT '公告id',
  `grade_id` int NULL DEFAULT NULL COMMENT '班级',
  `is_deleted` int NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 199 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_notice_grade
-- ----------------------------

-- ----------------------------
-- Table structure for t_option
-- ----------------------------
DROP TABLE IF EXISTS `t_option`;
CREATE TABLE `t_option`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   选项答案表',
  `qu_id` int NOT NULL COMMENT '试题id',
  `is_right` int NULL DEFAULT NULL COMMENT '是否正确',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图片地址   0错误 1正确',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '选项内容',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2837 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_option
-- ----------------------------
INSERT INTO `t_option` VALUES (2642, 718, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2643, 718, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2644, 719, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2645, 719, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2646, 720, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2647, 720, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2648, 721, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2649, 721, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2650, 722, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2651, 722, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2652, 723, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2653, 723, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2654, 724, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2655, 724, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2656, 725, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2657, 725, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2658, 726, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2659, 726, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2660, 727, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2661, 727, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2662, 728, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2663, 728, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2664, 729, 1, NULL, '正确', 0, 0);
INSERT INTO `t_option` VALUES (2665, 729, 0, NULL, '错误', 1, 0);
INSERT INTO `t_option` VALUES (2666, 730, 1, NULL, '马克思主义哲学、马克思主义政治经济学、科学社会主义', 0, 0);
INSERT INTO `t_option` VALUES (2667, 730, 0, NULL, '辩证唯物主义、历史唯物主义、剩余价值理论', 1, 0);
INSERT INTO `t_option` VALUES (2668, 730, 0, NULL, '唯物史观、阶级斗争学说、无产阶级专政理论', 2, 0);
INSERT INTO `t_option` VALUES (2669, 730, 0, NULL, '政治经济学、科学社会主义、共产主义理论', 3, 0);
INSERT INTO `t_option` VALUES (2670, 731, 0, NULL, '实践是检验真理的唯一标准', 0, 0);
INSERT INTO `t_option` VALUES (2671, 731, 1, NULL, '物质决定意识，意识对物质具有能动作用', 1, 0);
INSERT INTO `t_option` VALUES (2672, 731, 0, NULL, '生产力决定生产关系', 2, 0);
INSERT INTO `t_option` VALUES (2673, 731, 0, NULL, '经济基础决定上层建筑', 3, 0);
INSERT INTO `t_option` VALUES (2674, 732, 0, NULL, '劳动价值论', 0, 0);
INSERT INTO `t_option` VALUES (2675, 732, 1, NULL, '剩余价值理论', 1, 0);
INSERT INTO `t_option` VALUES (2676, 732, 0, NULL, '资本积累理论', 2, 0);
INSERT INTO `t_option` VALUES (2677, 732, 0, NULL, '社会再生产理论', 3, 0);
INSERT INTO `t_option` VALUES (2678, 733, 0, NULL, '法国大革命', 0, 0);
INSERT INTO `t_option` VALUES (2679, 733, 1, NULL, '工业革命', 1, 0);
INSERT INTO `t_option` VALUES (2680, 733, 0, NULL, '美国独立战争', 2, 0);
INSERT INTO `t_option` VALUES (2681, 733, 0, NULL, '文艺复兴运动', 3, 0);
INSERT INTO `t_option` VALUES (2682, 734, 0, NULL, '科学性', 0, 0);
INSERT INTO `t_option` VALUES (2683, 734, 0, NULL, '革命性', 1, 0);
INSERT INTO `t_option` VALUES (2684, 734, 0, NULL, '实践性', 2, 0);
INSERT INTO `t_option` VALUES (2685, 734, 1, NULL, '与时俱进', 3, 0);
INSERT INTO `t_option` VALUES (2686, 735, 0, NULL, '应用层', 0, 0);
INSERT INTO `t_option` VALUES (2687, 735, 1, NULL, '传输层', 1, 0);
INSERT INTO `t_option` VALUES (2688, 735, 0, NULL, '网络层', 2, 0);
INSERT INTO `t_option` VALUES (2689, 735, 0, NULL, '数据链路层', 3, 0);
INSERT INTO `t_option` VALUES (2690, 736, 0, NULL, 'TCP是无连接协议，UDP是面向连接协议', 0, 0);
INSERT INTO `t_option` VALUES (2691, 736, 1, NULL, 'TCP提供可靠传输，UDP不保证数据可靠到达', 1, 0);
INSERT INTO `t_option` VALUES (2692, 736, 0, NULL, 'TCP传输效率高于UDP', 2, 0);
INSERT INTO `t_option` VALUES (2693, 736, 0, NULL, 'TCP和UDP都提供流量控制功能', 3, 0);
INSERT INTO `t_option` VALUES (2694, 737, 0, NULL, '21', 0, 0);
INSERT INTO `t_option` VALUES (2695, 737, 0, NULL, '25', 1, 0);
INSERT INTO `t_option` VALUES (2696, 737, 1, NULL, '80', 2, 0);
INSERT INTO `t_option` VALUES (2697, 737, 0, NULL, '443', 3, 0);
INSERT INTO `t_option` VALUES (2698, 738, 0, NULL, '传输层，提供端到端通信', 0, 0);
INSERT INTO `t_option` VALUES (2699, 738, 1, NULL, '网络层，提供路由选择和逻辑寻址', 1, 0);
INSERT INTO `t_option` VALUES (2700, 738, 0, NULL, '数据链路层，提供物理寻址', 2, 0);
INSERT INTO `t_option` VALUES (2701, 738, 0, NULL, '应用层，提供应用服务', 3, 0);
INSERT INTO `t_option` VALUES (2702, 739, 0, NULL, '物理寻址（MAC地址）', 0, 0);
INSERT INTO `t_option` VALUES (2703, 739, 0, NULL, '帧的封装与解封装', 1, 0);
INSERT INTO `t_option` VALUES (2704, 739, 0, NULL, '差错检测与纠正', 2, 0);
INSERT INTO `t_option` VALUES (2705, 739, 1, NULL, '路由选择与转发', 3, 0);
INSERT INTO `t_option` VALUES (2706, 740, 1, NULL, '将IP地址解析为MAC地址', 0, 0);
INSERT INTO `t_option` VALUES (2707, 740, 0, NULL, '将MAC地址解析为IP地址', 1, 0);
INSERT INTO `t_option` VALUES (2708, 740, 0, NULL, '将域名解析为IP地址', 2, 0);
INSERT INTO `t_option` VALUES (2709, 740, 0, NULL, '提供网络层的路由功能', 3, 0);
INSERT INTO `t_option` VALUES (2710, 741, 1, NULL, '应用层-传输层-网络层-数据链路层-物理层', 0, 0);
INSERT INTO `t_option` VALUES (2711, 741, 0, NULL, '应用层-网络层-传输层-数据链路层-物理层', 1, 0);
INSERT INTO `t_option` VALUES (2712, 741, 0, NULL, '物理层-数据链路层-网络层-传输层-应用层', 2, 0);
INSERT INTO `t_option` VALUES (2713, 741, 0, NULL, '传输层-应用层-网络层-数据链路层-物理层', 3, 0);
INSERT INTO `t_option` VALUES (2714, 742, 0, NULL, 'SYN', 0, 0);
INSERT INTO `t_option` VALUES (2715, 742, 0, NULL, 'ACK', 1, 0);
INSERT INTO `t_option` VALUES (2716, 742, 1, NULL, 'SYN+ACK', 2, 0);
INSERT INTO `t_option` VALUES (2717, 742, 0, NULL, 'FIN', 3, 0);
INSERT INTO `t_option` VALUES (2718, 743, 1, NULL, '完全二叉树的节点数为n时，其高度为⌊log₂n⌋+1', 0, 0);
INSERT INTO `t_option` VALUES (2719, 743, 1, NULL, '满二叉树一定是完全二叉树', 1, 0);
INSERT INTO `t_option` VALUES (2720, 743, 1, NULL, '任何二叉树的第i层最多有2^(i-1)个节点', 2, 0);
INSERT INTO `t_option` VALUES (2721, 743, 0, NULL, '所有叶子节点都在同一层的二叉树一定是满二叉树', 3, 0);
INSERT INTO `t_option` VALUES (2722, 744, 1, NULL, '每个节点要么是红色，要么是黑色', 0, 0);
INSERT INTO `t_option` VALUES (2723, 744, 1, NULL, '根节点必须是黑色', 1, 0);
INSERT INTO `t_option` VALUES (2724, 744, 1, NULL, '所有叶子节点（NIL节点）都是黑色', 2, 0);
INSERT INTO `t_option` VALUES (2725, 744, 0, NULL, '红色节点的父节点和子节点都必须是黑色', 3, 0);
INSERT INTO `t_option` VALUES (2726, 745, 1, NULL, '邻接矩阵适合存储稠密图，空间复杂度为O(V²)', 0, 0);
INSERT INTO `t_option` VALUES (2727, 745, 1, NULL, '邻接表适合存储稀疏图，空间复杂度为O(V+E)', 1, 0);
INSERT INTO `t_option` VALUES (2728, 745, 1, NULL, '邻接矩阵判断两个顶点是否相邻的时间复杂度为O(1)', 2, 0);
INSERT INTO `t_option` VALUES (2729, 745, 0, NULL, '邻接表遍历某个顶点的所有邻接点的时间复杂度为O(V)', 3, 0);
INSERT INTO `t_option` VALUES (2730, 746, 1, NULL, '快速排序的平均时间复杂度为O(nlogn)，最坏情况为O(n²)', 0, 0);
INSERT INTO `t_option` VALUES (2731, 746, 1, NULL, '二叉搜索树的查找操作最坏时间复杂度为O(n)', 1, 0);
INSERT INTO `t_option` VALUES (2732, 746, 1, NULL, '红黑树的插入、删除和查找操作时间复杂度均为O(logn)', 2, 0);
INSERT INTO `t_option` VALUES (2733, 746, 0, NULL, '图的深度优先遍历(DFS)时间复杂度一定是O(V)', 3, 0);
INSERT INTO `t_option` VALUES (2734, 747, 1, NULL, '递归算法的空间复杂度需要考虑递归调用栈的深度', 0, 0);
INSERT INTO `t_option` VALUES (2735, 747, 1, NULL, '归并排序的空间复杂度为O(n)，因为需要额外的辅助数组', 1, 0);
INSERT INTO `t_option` VALUES (2736, 747, 1, NULL, '图的邻接表表示法比邻接矩阵更节省空间，尤其对稀疏图', 2, 0);
INSERT INTO `t_option` VALUES (2737, 747, 0, NULL, '原地算法的空间复杂度一定是O(1)', 3, 0);
INSERT INTO `t_option` VALUES (2738, 753, 1, NULL, '每个节点要么是红色，要么是黑色，且根节点必须是黑色', 1, 0);
INSERT INTO `t_option` VALUES (2739, 753, 0, NULL, '红色节点可以有红色子节点', 2, 0);
INSERT INTO `t_option` VALUES (2740, 753, 0, NULL, '所有叶子节点必须是红色', 3, 0);
INSERT INTO `t_option` VALUES (2741, 753, 0, NULL, '树的高度必须严格等于log₂n', 4, 0);
INSERT INTO `t_option` VALUES (2742, 754, 1, NULL, '2*i + 1', 1, 0);
INSERT INTO `t_option` VALUES (2743, 754, 0, NULL, '2*i', 2, 0);
INSERT INTO `t_option` VALUES (2744, 754, 0, NULL, 'i + 1', 3, 0);
INSERT INTO `t_option` VALUES (2745, 754, 0, NULL, '2*i - 1', 4, 0);
INSERT INTO `t_option` VALUES (2746, 755, 1, NULL, '图中存在负权边', 1, 0);
INSERT INTO `t_option` VALUES (2747, 755, 0, NULL, '图中存在环路', 2, 0);
INSERT INTO `t_option` VALUES (2748, 755, 0, NULL, '图是无向图', 3, 0);
INSERT INTO `t_option` VALUES (2749, 755, 0, NULL, '图是稠密图', 4, 0);
INSERT INTO `t_option` VALUES (2750, 756, 1, NULL, 'D、A、C、B', 1, 0);
INSERT INTO `t_option` VALUES (2751, 756, 0, NULL, 'D、C、B、A', 2, 0);
INSERT INTO `t_option` VALUES (2752, 756, 0, NULL, 'C、B、D、A', 3, 0);
INSERT INTO `t_option` VALUES (2753, 756, 0, NULL, 'A、B、C、D', 4, 0);
INSERT INTO `t_option` VALUES (2754, 757, 1, NULL, '队头指针和队尾指针', 1, 0);
INSERT INTO `t_option` VALUES (2755, 757, 0, NULL, '只需要队头指针', 2, 0);
INSERT INTO `t_option` VALUES (2756, 757, 0, NULL, '只需要队尾指针', 3, 0);
INSERT INTO `t_option` VALUES (2757, 757, 0, NULL, '队头指针、队尾指针和中间指针', 4, 0);
INSERT INTO `t_option` VALUES (2758, 758, 1, NULL, '每个节点不是红色就是黑色', 1, 0);
INSERT INTO `t_option` VALUES (2759, 758, 1, NULL, '根节点必须是黑色', 2, 0);
INSERT INTO `t_option` VALUES (2760, 758, 1, NULL, '红色节点的两个子节点必须都是黑色', 3, 0);
INSERT INTO `t_option` VALUES (2761, 758, 0, NULL, '所有叶子节点到根节点的路径长度必须相同', 4, 0);
INSERT INTO `t_option` VALUES (2762, 759, 1, NULL, '栈(Stack)在栈顶进行插入和删除', 1, 0);
INSERT INTO `t_option` VALUES (2763, 759, 1, NULL, '队列(Queue)在队尾插入、队首删除', 2, 0);
INSERT INTO `t_option` VALUES (2764, 759, 0, NULL, '最小堆在堆顶进行插入和删除', 3, 0);
INSERT INTO `t_option` VALUES (2765, 759, 0, NULL, '二叉搜索树在任意位置进行插入和删除', 4, 0);
INSERT INTO `t_option` VALUES (2766, 760, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2767, 760, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2768, 761, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2769, 761, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2770, 762, 0, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2771, 762, 1, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2772, 763, 1, NULL, '红黑树的五个核心性质：\n1. 节点颜色性质：每个节点要么是红色,要么是黑色。\n2. 根节点性质：根节点必须是黑色。\n3. 叶节点性质：所有叶子节点(NIL节点)都是黑色。\n4. 红色节点性质：红色节点的两个子节点必须是黑色(即不能有两个连续的红色节点)。\n5. 黑高性质：从任一节点到其每个叶子节点的所有路径都包含相同数目的黑色节点。\n\n时间复杂度保证：这些性质确保了红黑树的最长路径不超过最短路径的2倍。由于黑高性质,最短路径至少有h个黑色节点;由于红色节点性质,最长路径最多有h个黑色节点和h个红色节点,即2h。因此树的高度被限制在2log(n+1)范围内,保证了O(log n)的操作效率。\n\n与AVL树的对比：\n1. 平衡性：AVL树是严格平衡的二叉搜索树,左右子树高度差不超过1;红黑树是弱平衡的,最长路径不超过最短路径的2倍。\n2. 旋转频率：AVL树在插入和删除时需要更频繁的旋转操作来维持严格平衡;红黑树通过颜色调整和较少的旋转即可维持平衡,因此在频繁插入删除的场景下性能更优。\n3. 应用场景：AVL树适合查询密集型应用;红黑树适合插入删除频繁的应用(如Java的TreeMap、Linux内核的进程调度)。', 1, 0);
INSERT INTO `t_option` VALUES (2773, 764, 1, NULL, '应用层', 1, 0);
INSERT INTO `t_option` VALUES (2774, 764, 0, NULL, '传输层', 2, 0);
INSERT INTO `t_option` VALUES (2775, 764, 0, NULL, '网络层', 3, 0);
INSERT INTO `t_option` VALUES (2776, 764, 0, NULL, '数据链路层', 4, 0);
INSERT INTO `t_option` VALUES (2777, 765, 1, NULL, 'HTTPS在HTTP的基础上通过TLS/SSL进行加密传输，默认使用443端口', 1, 0);
INSERT INTO `t_option` VALUES (2778, 765, 0, NULL, 'HTTPS和HTTP使用相同的端口号80', 2, 0);
INSERT INTO `t_option` VALUES (2779, 765, 0, NULL, 'HTTPS不需要证书就可以直接使用', 3, 0);
INSERT INTO `t_option` VALUES (2780, 765, 0, NULL, 'HTTP比HTTPS传输速度更快且更安全', 4, 0);
INSERT INTO `t_option` VALUES (2781, 766, 1, NULL, '将IP地址解析为MAC地址', 1, 0);
INSERT INTO `t_option` VALUES (2782, 766, 0, NULL, '将MAC地址解析为IP地址', 2, 0);
INSERT INTO `t_option` VALUES (2783, 766, 0, NULL, '将域名解析为IP地址', 3, 0);
INSERT INTO `t_option` VALUES (2784, 766, 0, NULL, '将IP地址解析为端口号', 4, 0);
INSERT INTO `t_option` VALUES (2785, 767, 1, NULL, '数据链路层', 1, 0);
INSERT INTO `t_option` VALUES (2786, 767, 0, NULL, '网络层', 2, 0);
INSERT INTO `t_option` VALUES (2787, 767, 0, NULL, '传输层', 3, 0);
INSERT INTO `t_option` VALUES (2788, 767, 0, NULL, '物理层', 4, 0);
INSERT INTO `t_option` VALUES (2789, 768, 1, NULL, '主机A广播ARP请求，主机B收到后单播回复自己的MAC地址', 1, 0);
INSERT INTO `t_option` VALUES (2790, 768, 0, NULL, '主机A直接使用IP地址发送数据，无需MAC地址', 2, 0);
INSERT INTO `t_option` VALUES (2791, 768, 0, NULL, '主机A向DNS服务器查询主机B的MAC地址', 3, 0);
INSERT INTO `t_option` VALUES (2792, 768, 0, NULL, '主机A向路由器请求获取主机B的MAC地址', 4, 0);
INSERT INTO `t_option` VALUES (2793, 769, 1, NULL, 'HTTPS使用TLS/SSL协议对传输数据进行加密', 1, 0);
INSERT INTO `t_option` VALUES (2794, 769, 1, NULL, 'HTTP默认使用80端口，HTTPS默认使用443端口', 2, 0);
INSERT INTO `t_option` VALUES (2795, 769, 1, NULL, 'HTTPS可以防止中间人攻击和数据篡改', 3, 0);
INSERT INTO `t_option` VALUES (2796, 769, 0, NULL, 'HTTP协议工作在OSI模型的传输层', 4, 0);
INSERT INTO `t_option` VALUES (2797, 770, 1, NULL, 'MAC地址工作在数据链路层，用于标识网络设备的物理地址', 1, 0);
INSERT INTO `t_option` VALUES (2798, 770, 1, NULL, 'ARP协议用于将IP地址解析为对应的MAC地址', 2, 0);
INSERT INTO `t_option` VALUES (2799, 770, 1, NULL, 'MAC地址长度为48位，通常表示为12位十六进制数', 3, 0);
INSERT INTO `t_option` VALUES (2800, 770, 0, NULL, 'ARP协议工作在网络层之上的传输层', 4, 0);
INSERT INTO `t_option` VALUES (2801, 771, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2802, 771, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2803, 772, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2804, 772, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2805, 773, 0, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2806, 773, 1, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2807, 774, 1, NULL, 'HTTPS通信中TLS握手的主要步骤：\n\n1. 客户端发送Client Hello消息，包含支持的TLS版本、加密套件列表、随机数等信息。\n\n2. 服务器响应Server Hello消息，选择加密套件，发送服务器证书（包含公钥）、随机数等。\n\n3. 客户端验证服务器证书的合法性（通过CA证书链验证），生成预主密钥（Pre-Master Secret），用服务器公钥加密后发送给服务器。\n\n4. 双方使用两个随机数和预主密钥，通过相同算法生成会话密钥（对称密钥）。\n\n5. 双方发送Finished消息，使用会话密钥加密，验证握手过程完整性。\n\n6. 握手完成后，使用协商好的对称密钥进行加密通信。\n\n安全性保障：\n- 身份认证：通过数字证书验证服务器身份\n- 数据加密：使用对称加密保护传输数据\n- 完整性校验：通过消息认证码（MAC）防止数据篡改\n- 防重放攻击：通过随机数和序列号机制\n\n网络层次：HTTPS在网络五层模型中，是在应用层（HTTP）和传输层（TCP）之间增加了TLS/SSL安全层，属于会话层安全机制。具体来说，TLS工作在传输层之上，为应用层提供安全服务。', 1, 0);
INSERT INTO `t_option` VALUES (2808, 775, 0, NULL, '15个节点', 1, 0);
INSERT INTO `t_option` VALUES (2809, 775, 0, NULL, '31个节点', 2, 0);
INSERT INTO `t_option` VALUES (2810, 775, 1, NULL, '63个节点', 3, 0);
INSERT INTO `t_option` VALUES (2811, 775, 0, NULL, '127个节点', 4, 0);
INSERT INTO `t_option` VALUES (2812, 776, 1, NULL, '红黑树是一种自平衡的二叉搜索树，通过节点着色和旋转操作保持树的平衡性', 1, 0);
INSERT INTO `t_option` VALUES (2813, 776, 1, NULL, '完全二叉树可以用数组高效存储，对于索引为i的节点，其左孩子索引为2i+1，右孩子索引为2i+2', 2, 0);
INSERT INTO `t_option` VALUES (2814, 776, 0, NULL, '无向图的邻接矩阵一定是对称矩阵，而有向图的邻接矩阵一定是非对称矩阵', 3, 0);
INSERT INTO `t_option` VALUES (2815, 776, 1, NULL, '红黑树的插入和删除操作的时间复杂度均为O(log n)，其最坏情况下的高度不超过2log(n+1)', 4, 0);
INSERT INTO `t_option` VALUES (2816, 777, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2817, 777, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2818, 780, 1, NULL, '(rear + 1) % n == front', 1, 0);
INSERT INTO `t_option` VALUES (2819, 780, 0, NULL, 'rear == front', 2, 0);
INSERT INTO `t_option` VALUES (2820, 780, 0, NULL, 'rear - front == n', 3, 0);
INSERT INTO `t_option` VALUES (2821, 780, 0, NULL, '(front + 1) % n == rear', 4, 0);
INSERT INTO `t_option` VALUES (2822, 781, 1, NULL, '2e', 1, 0);
INSERT INTO `t_option` VALUES (2823, 781, 0, NULL, 'e', 2, 0);
INSERT INTO `t_option` VALUES (2824, 781, 0, NULL, 'n²', 3, 0);
INSERT INTO `t_option` VALUES (2825, 781, 0, NULL, 'n + e', 4, 0);
INSERT INTO `t_option` VALUES (2826, 782, 1, NULL, '队列是一种先进先出(FIFO)的线性数据结构', 1, 0);
INSERT INTO `t_option` VALUES (2827, 782, 0, NULL, '在循环队列中，当队尾指针rear+1等于队头指针front时，队列一定为空', 2, 0);
INSERT INTO `t_option` VALUES (2828, 782, 1, NULL, '双端队列允许在队列的两端进行插入和删除操作', 3, 0);
INSERT INTO `t_option` VALUES (2829, 782, 1, NULL, '优先队列中元素的出队顺序取决于元素的优先级而非入队顺序', 4, 0);
INSERT INTO `t_option` VALUES (2830, 783, 0, NULL, '邻接矩阵适合存储稀疏图，空间复杂度为O(n+e)', 1, 0);
INSERT INTO `t_option` VALUES (2831, 783, 1, NULL, '对于有向图，邻接表中每条边只在一个顶点的链表中出现', 2, 0);
INSERT INTO `t_option` VALUES (2832, 783, 1, NULL, '深度优先遍历(DFS)可以用递归或栈来实现', 3, 0);
INSERT INTO `t_option` VALUES (2833, 783, 1, NULL, '广度优先遍历(BFS)通常使用队列作为辅助数据结构', 4, 0);
INSERT INTO `t_option` VALUES (2834, 784, 1, NULL, '正确', 1, 0);
INSERT INTO `t_option` VALUES (2835, 784, 0, NULL, '错误', 2, 0);
INSERT INTO `t_option` VALUES (2836, 785, 1, NULL, '在图的广度优先搜索算法中，队列起到了关键的辅助存储作用，具体体现在以下几个方面：\n\n1. **维护访问顺序**：队列的先进先出（FIFO）特性确保了顶点按照距离起始点的层次顺序被访问。先入队的顶点代表距离起始点较近的节点，会被优先处理。\n\n2. **存储待访问节点**：当访问一个顶点时，将其所有未访问的邻接顶点加入队列尾部，这样可以暂存后续需要访问的节点。\n\n3. **控制遍历过程**：通过不断从队列头部取出顶点进行访问，直到队列为空，保证了所有可达顶点都被访问且不重复。\n\n**不能使用栈替代的原因**：\n栈是后进先出（LIFO）的数据结构，如果用栈替代队列，算法会变成深度优先搜索（DFS）而非BFS。具体来说，栈会优先处理最后加入的邻接节点，导致算法沿着一条路径深入到底，而不是按层次逐层扩展。这样就无法保证按照距离起始点的最短路径顺序访问节点，违背了BFS的核心思想——逐层遍历。', 1, 0);

-- ----------------------------
-- Table structure for t_question
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   试题表',
  `qu_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '试题类型',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '试题图片',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '题干',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `analysis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '题目分析',
  `repo_id` int NULL DEFAULT NULL COMMENT '题库id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  `qu_level` int NULL DEFAULT NULL COMMENT '难度等级 (1-简单, 2-中等, 3-困难)',
  `knowledge_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '知识点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 786 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_question
-- ----------------------------
INSERT INTO `t_question` VALUES (718, '3', NULL, '112312', '2025-12-26 10:26:18', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (719, '3', NULL, '123123', '2025-12-26 10:26:26', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (720, '3', NULL, '123123', '2025-12-26 10:26:35', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (721, '3', NULL, '1231', '2025-12-26 10:26:42', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (722, '3', NULL, '123123', '2025-12-26 10:26:50', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (723, '3', NULL, '13123', '2025-12-26 11:03:51', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (724, '3', NULL, '123123', '2025-12-26 11:04:00', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (725, '3', NULL, '12312312', '2025-12-26 11:04:07', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (726, '3', NULL, '1231231', '2025-12-26 11:04:14', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (727, '3', NULL, '123123', '2025-12-26 11:04:21', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (728, '3', NULL, '123123', '2025-12-26 11:04:28', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (729, '3', NULL, '123123', '2025-12-26 11:04:36', NULL, 99, 163, 1, NULL, NULL);
INSERT INTO `t_question` VALUES (730, '1', NULL, '马克思主义理论体系的三个主要组成部分是什么？', '2026-01-01 03:16:03', '马克思主义理论体系由三个主要组成部分构成：马克思主义哲学（包括辩证唯物主义和历史唯物主义）、马克思主义政治经济学（核心是剩余价值理论）、科学社会主义（揭示了社会主义代替资本主义的历史必然性）。这三个部分相互联系、相互渗透，构成了完整的马克思主义理论体系。', 99, 1, 0, 1, '马克思主义理论体系的组成部分');
INSERT INTO `t_question` VALUES (731, '1', NULL, '马克思主义哲学的核心观点是？', '2026-01-01 03:16:03', '马克思主义哲学即辩证唯物主义和历史唯物主义，其核心观点是物质决定意识，意识对物质具有能动的反作用。这是马克思主义哲学区别于其他哲学流派的根本标志。虽然其他选项都是马克思主义的重要原理，但物质与意识的关系问题是哲学的基本问题，是马克思主义哲学的核心和基础。', 99, 1, 0, 2, '马克思主义哲学基本原理');
INSERT INTO `t_question` VALUES (732, '1', NULL, '马克思主义政治经济学的核心理论是？', '2026-01-01 03:16:03', '剩余价值理论是马克思主义政治经济学的核心和基石。该理论揭示了资本主义剥削的秘密，说明了剩余价值是雇佣工人创造的、被资本家无偿占有的超过劳动力价值的价值。剩余价值理论科学地阐明了资本主义生产的实质和资本主义剥削的秘密，为无产阶级反对资产阶级的斗争提供了理论武器。', 99, 1, 0, 2, '马克思主义政治经济学核心理论');
INSERT INTO `t_question` VALUES (733, '1', NULL, '马克思主义产生的时代背景包括哪个重要历史事件？', '2026-01-01 03:16:03', '马克思主义产生于19世纪40年代，其重要的时代背景是工业革命的深入发展。工业革命使资本主义生产方式迅速发展，资本主义社会的基本矛盾日益尖锐，无产阶级和资产阶级的对立日益明显。这为马克思主义的产生提供了经济社会条件。同时，欧洲三大工人运动（里昂工人起义、英国宪章运动、西里西亚纺织工人起义）的爆发，标志着无产阶级作为独立的政治力量登上历史舞台，为马克思主义的产生提供了阶级基础。', 99, 1, 0, 2, '马克思主义产生的历史条件');
INSERT INTO `t_question` VALUES (734, '1', NULL, '马克思主义最鲜明的品格是？', '2026-01-01 03:16:03', '与时俱进是马克思主义最鲜明的品格。马克思主义具有与时俱进的理论品质，它不是僵化的教条，而是随着实践的发展而不断发展的科学理论体系。马克思主义在指导实践的过程中，必然要随着实践的发展而发展，这是马克思主义永葆生机和活力的关键所在。虽然科学性、革命性、实践性都是马克思主义的重要特征，但与时俱进最能体现马克思主义的理论品质和生命力。', 99, 1, 0, 3, '马克思主义的理论品格');
INSERT INTO `t_question` VALUES (735, '1', NULL, '在计算机网络五层模型中，负责提供端到端可靠数据传输服务的是哪一层？', '2026-01-03 18:43:55', '传输层是五层模型中的第四层，主要负责提供端到端的数据传输服务。TCP和UDP协议都工作在传输层，其中TCP提供可靠的连接导向服务，UDP提供无连接的数据报服务。应用层负责应用程序间的通信，网络层负责路由选择和逻辑寻址，数据链路层负责相邻节点间的可靠传输。', 100, 163, 0, 1, '计算机网络五层模型');
INSERT INTO `t_question` VALUES (736, '1', NULL, '关于TCP和UDP协议的特点，下列说法正确的是？', '2026-01-03 18:43:55', 'TCP（传输控制协议）是面向连接的可靠传输协议，提供流量控制、拥塞控制、确认重传等机制，确保数据可靠到达。UDP（用户数据报协议）是无连接协议，不保证数据可靠性，但传输效率高、开销小。UDP不提供流量控制功能，适用于对实时性要求高但对可靠性要求不高的场景，如视频直播、语音通话等。', 100, 163, 0, 2, 'TCP/UDP协议特性');
INSERT INTO `t_question` VALUES (737, '1', NULL, 'HTTP协议默认工作在TCP的哪个端口号上？', '2026-01-03 18:43:55', 'HTTP（超文本传输协议）默认使用TCP的80端口。HTTPS使用443端口，FTP使用21端口，SMTP使用25端口。HTTP是应用层协议，基于TCP传输层协议工作，用于Web浏览器和服务器之间的通信。', 100, 163, 0, 1, 'HTTP协议');
INSERT INTO `t_question` VALUES (738, '1', NULL, 'IP协议工作在五层模型的哪一层，其主要功能是什么？', '2026-01-03 18:43:55', 'IP（互联网协议）工作在网络层，是TCP/IP协议族中最核心的协议之一。其主要功能包括：提供逻辑寻址（IP地址）、路由选择（确定数据包传输路径）、数据包分片与重组等。IP协议是无连接、不可靠的协议，上层协议TCP负责提供可靠性保证。', 100, 163, 0, 2, 'IP协议与网络层');
INSERT INTO `t_question` VALUES (739, '1', NULL, '数据链路层的主要功能不包括以下哪一项？', '2026-01-03 18:43:55', '数据链路层的主要功能包括：物理寻址（使用MAC地址）、帧的封装与解封装、差错检测与纠正、流量控制等，确保相邻节点间的可靠数据传输。路由选择与转发是网络层的功能，由IP协议和路由器完成。数据链路层常见协议包括以太网协议、PPP协议等。', 100, 163, 0, 2, '数据链路层功能');
INSERT INTO `t_question` VALUES (740, '1', NULL, 'ARP协议的主要作用是什么？', '2026-01-03 18:43:55', 'ARP（地址解析协议）的作用是将网络层的IP地址解析为数据链路层的MAC地址。当主机需要向同一局域网内的另一主机发送数据时，需要知道目标主机的MAC地址，此时通过广播ARP请求报文获取。RARP协议作用相反，将MAC地址解析为IP地址。DNS协议负责将域名解析为IP地址。', 100, 163, 0, 2, 'ARP协议');
INSERT INTO `t_question` VALUES (741, '1', NULL, '在计算机网络五层模型中，从上到下的正确顺序是？', '2026-01-03 18:43:55', '计算机网络五层模型从上到下依次为：应用层（HTTP、FTP等）、传输层（TCP、UDP）、网络层（IP）、数据链路层（以太网协议）、物理层（传输比特流）。每一层为上层提供服务，使用下层提供的服务。数据发送时自上而下封装，接收时自下而上解封装。', 100, 163, 0, 1, '计算机网络五层模型');
INSERT INTO `t_question` VALUES (742, '1', NULL, '关于TCP三次握手建立连接的过程，第二次握手服务器发送的报文段标志位是？', '2026-01-03 18:43:55', 'TCP三次握手过程：第一次握手，客户端发送SYN报文段；第二次握手，服务器收到SYN后，发送SYN+ACK报文段进行确认；第三次握手，客户端发送ACK报文段确认。通过三次握手建立可靠连接，确保双方都具备收发能力。SYN表示同步序列号，ACK表示确认，FIN用于断开连接。', 100, 163, 0, 3, 'TCP协议三次握手');
INSERT INTO `t_question` VALUES (743, '2', NULL, '关于二叉树的性质，以下说法正确的是？', '2026-01-03 18:48:18', '完全二叉树高度计算公式正确；满二叉树所有层都满，符合完全二叉树定义；二叉树第i层最多2^(i-1)个节点是基本性质；但叶子在同一层不一定是满二叉树，可能是完全二叉树但非满二叉树。', 101, 163, 0, 2, '二叉树');
INSERT INTO `t_question` VALUES (744, '2', NULL, '红黑树作为一种自平衡二叉搜索树，必须满足哪些性质？', '2026-01-03 18:48:18', '红黑树的五大性质包括：节点颜色为红或黑、根节点黑色、叶子节点黑色、红色节点的两个子节点必须是黑色（但父节点可以是黑色）、从任一节点到其叶子的所有路径包含相同数量的黑色节点。选项D错误，红色节点的父节点可以是黑色或红色（但不能连续出现红色）。', 101, 163, 0, 2, '红黑树');
INSERT INTO `t_question` VALUES (745, '2', NULL, '关于图的存储结构，以下描述正确的是？', '2026-01-03 18:48:18', '邻接矩阵用二维数组存储，空间O(V²)，适合稠密图；邻接表空间O(V+E)，适合稀疏图；邻接矩阵通过索引直接访问，判断相邻O(1)；邻接表遍历某顶点的邻接点时间复杂度为O(degree)，即该顶点的度数，而非O(V)。', 101, 163, 0, 2, '图');
INSERT INTO `t_question` VALUES (746, '2', NULL, '以下算法的时间复杂度分析正确的是？', '2026-01-03 18:48:18', '快速排序平均O(nlogn)，最坏退化为O(n²)；二叉搜索树最坏情况退化为链表O(n)；红黑树通过自平衡保证O(logn)；图的DFS时间复杂度为O(V+E)，需要遍历所有顶点和边，不是O(V)。', 101, 163, 0, 3, '时间空间复杂度');
INSERT INTO `t_question` VALUES (747, '2', NULL, '关于空间复杂度的分析，以下说法正确的是？', '2026-01-03 18:48:18', '递归算法空间复杂度包括调用栈深度；归并排序需要O(n)辅助空间；邻接表对稀疏图空间效率更高O(V+E) vs O(V²)；原地算法要求额外空间为O(1)，但递归原地算法（如快排）仍需O(logn)栈空间，所以不一定是O(1)。', 101, 163, 0, 2, '时间空间复杂度');
INSERT INTO `t_question` VALUES (748, '4', NULL, '请详细说明算法时间复杂度和空间复杂度的概念，并举例说明如何分析一个算法的时间复杂度。', '2026-01-03 19:22:47', '时间复杂度是指算法执行所需的计算工作量，通常用大O表示法表示，如O(n)、O(n²)等。空间复杂度是指算法执行过程中所需的内存空间。\n分析方法：\n1. 确定基本操作（如比较、赋值等）\n2. 计算基本操作的执行次数\\n3. 用大O表示法表示增长趋势\n\n例如：遍历数组求和，需要执行n次加法操作，时间复杂度为O(n)；嵌套循环遍历二维数组，外层循环n次，内层循环n次，时间复杂度为O(n²)。空间复杂度方面，若只使用固定变量存储结果，则为O(1)；若需要额外数组存储中间结果，则为O(n)。', 101, 163, 0, 2, '时间复杂度与空间复杂度');
INSERT INTO `t_question` VALUES (749, '4', NULL, '请阐述红黑树的五条基本性质，并说明红黑树相比普通二叉搜索树的优势是什么。', '2026-01-03 19:22:47', '红黑树的五条基本性质：\\n1. 每个节点要么是红色，要么是黑色\\n2. 根节点必须是黑色\\n3. 所有叶子节点（NIL节点）都是黑色\\n4. 红色节点的两个子节点必须是黑色（不能有两个连续的红色节点）\\n5. 从任一节点到其每个叶子节点的所有路径都包含相同数目的黑色节点\\n\\n优势分析：\\n红黑树通过颜色标记和旋转操作保持树的近似平衡，确保最长路径不超过最短路径的2倍。这使得查找、插入、删除操作的时间复杂度都能稳定在O(log n)，而普通二叉搜索树在最坏情况下会退化成链表，时间复杂度变为O(n)。红黑树广泛应用于Java的TreeMap、C++ STL的map等数据结构中。', 101, 163, 0, 3, '红黑树');
INSERT INTO `t_question` VALUES (750, '4', NULL, '请比较二叉树的三种遍历方式（前序、中序、后序），并以具体的二叉树为例说明每种遍历方式的访问顺序。', '2026-01-03 19:22:47', '三种遍历方式的定义：\\n1. 前序遍历（Pre-order）：根节点 -> 左子树 -> 右子树\\n2. 中序遍历（In-order）：左子树 -> 根节点 -> 右子树\\n3. 后序遍历（Post-order）：左子树 -> 右子树 -> 根节点\\n\\n示例：假设二叉树结构如下\\n    A\\n   / \\\\\\n  B   C\\n / \\\\\\nD   E\\n\\n遍历结果：\\n- 前序遍历：A -> B -> D -> E -> C\\n- 中序遍历：D -> B -> E -> A -> C\\n- 后序遍历：D -> E -> B -> C -> A\\n\\n应用场景：前序遍历常用于复制树结构；中序遍历对于二叉搜索树可得到有序序列；后序遍历常用于删除树或计算目录大小等场景。', 101, 163, 0, 2, '二叉树遍历');
INSERT INTO `t_question` VALUES (751, '4', NULL, '请说明图的两种主要存储方式（邻接矩阵和邻接表），并分析它们各自的优缺点及适用场景。', '2026-01-03 19:22:47', '两种存储方式：\\n\\n1. 邻接矩阵：使用二维数组存储，matrix[i][j]表示顶点i到顶点j是否有边（或边的权重）\\n优点：\\n- 判断两顶点间是否有边的时间复杂度为O(1)\\n- 适合稠密图\\n- 实现简单直观\\n缺点：\\n- 空间复杂度为O(V²)，V为顶点数，浪费空间\\n- 遍历所有边需要O(V²)时间\\n\\n2. 邻接表：使用链表数组，每个顶点对应一个链表存储其邻接顶点\\n优点：\\n- 空间复杂度为O(V+E)，E为边数，节省空间\\n- 遍历所有边的时间复杂度为O(V+E)\\n- 适合稀疏图\\n缺点：\\n- 判断两顶点间是否有边需要O(degree)时间\\n- 实现相对复杂\\n\\n适用场景：稠密图使用邻接矩阵，稀疏图使用邻接表。', 101, 163, 0, 2, '图的存储结构');
INSERT INTO `t_question` VALUES (752, '4', NULL, '请解释堆栈的基本特性和操作，说明堆栈在函数调用过程中的应用原理，并分析为什么递归调用容易导致栈溢出。', '2026-01-03 19:22:47', '堆栈（Stack）基本特性：\\n- 后进先出（LIFO - Last In First Out）的线性数据结构\\n- 基本操作：push（入栈）、pop（出栈）、peek（查看栈顶元素）、isEmpty（判空）\\n- 时间复杂度：所有基本操作均为O(1)\\n\\n函数调用中的应用：\\n当函数被调用时，系统会在调用栈中压入一个栈帧（Stack Frame），包含：\\n1. 函数参数\\n2. 局部变量\\n3. 返回地址\\n4. 寄存器状态\\n函数执行完毕后，栈帧被弹出，控制权返回到调用者。\\n\\n递归导致栈溢出的原因：\\n递归调用会不断压入新的栈帧，若递归深度过大或缺少终止条件，会导致栈空间耗尽，引发栈溢出错误（Stack Overflow）。解决方法包括：优化递归深度、使用尾递归优化、改用迭代实现或增大栈空间。', 101, 163, 0, 2, '堆栈结构与应用');
INSERT INTO `t_question` VALUES (753, '1', NULL, '在红黑树中，以下哪个性质是必须满足的？', '2026-01-04 09:36:58', '红黑树的基本性质包括：1)每个节点是红色或黑色；2)根节点是黑色；3)所有叶子节点(NIL)是黑色；4)红色节点的子节点必须是黑色(不能有连续的红色节点)；5)从任一节点到其每个叶子节点的路径都包含相同数目的黑色节点。选项A正确描述了红黑树的核心性质。', NULL, 1, 0, 1, '红黑树');
INSERT INTO `t_question` VALUES (754, '1', NULL, '对于一棵完全二叉树，若某节点在数组中的下标为i(从0开始)，则其左孩子节点的下标为？', '2026-01-04 09:36:59', '完全二叉树使用数组存储时，若父节点下标为i(从0开始)，则左孩子下标为2*i+1，右孩子下标为2*i+2。若从1开始编号，则左孩子为2*i，右孩子为2*i+1。本题明确从0开始，故答案为2*i+1。', NULL, 1, 0, 1, '二叉树');
INSERT INTO `t_question` VALUES (755, '1', NULL, '使用Dijkstra算法求解单源最短路径问题时，该算法不能正确处理哪种情况？', '2026-01-04 09:36:59', 'Dijkstra算法采用贪心策略，每次选择当前距离最小的未访问节点。该算法基于一个假设：已确定最短路径的节点不会因后续节点而更新。当存在负权边时，这个假设不成立，可能导致已确定的最短路径需要重新更新，因此Dijkstra算法无法处理负权边的情况。对于负权边图，应使用Bellman-Ford算法。', NULL, 1, 0, 2, '图');
INSERT INTO `t_question` VALUES (756, '1', NULL, '在一个空栈中依次压入元素A、B、C、D，若在压栈过程中允许出栈操作，则不可能得到的出栈序列是？', '2026-01-04 09:36:59', '栈的特点是后进先出(LIFO)。分析选项A(D、A、C、B)：D先出说明A、B、C、D全部入栈后D出栈，此时栈内为A、B、C(A在栈底)，下一个出栈的只能是C，不可能是A。因此D、A、C、B这个序列违反了栈的特性。其他选项都可以通过合理的入栈出栈顺序实现。', NULL, 1, 0, 2, '堆栈');
INSERT INTO `t_question` VALUES (757, '1', NULL, '用链式存储结构实现队列时，为了提高入队和出队操作的效率，通常需要设置哪些指针？', '2026-01-04 09:36:59', '队列是先进先出(FIFO)的数据结构，需要在队尾进行入队操作，在队头进行出队操作。若使用链式存储且只设置队头指针，则入队时需要遍历整个链表找到队尾，时间复杂度为O(n)；若只设置队尾指针，则出队操作无法直接定位。因此需要同时设置队头指针(front)和队尾指针(rear)，使入队和出队操作的时间复杂度都为O(1)。', NULL, 1, 0, 2, '队列');
INSERT INTO `t_question` VALUES (758, '2', NULL, '关于红黑树的性质，以下哪些说法是正确的？', '2026-01-04 09:36:59', '红黑树的五条性质包括：1)每个节点是红色或黑色；2)根节点是黑色；3)所有叶子节点(NIL)是黑色；4)红色节点的子节点必须是黑色(不能有连续的红色节点)；5)从任一节点到其每个叶子的所有路径都包含相同数目的黑色节点。选项D错误，红黑树要求的是黑色节点数量相同，而非路径长度相同。', NULL, 1, 0, 2, '红黑树');
INSERT INTO `t_question` VALUES (759, '2', NULL, '在以下数据结构中，哪些支持在O(1)时间复杂度内完成插入和删除操作？', '2026-01-04 09:36:59', '栈和队列都是线性数据结构，在特定位置(栈顶或队列两端)进行操作时时间复杂度为O(1)。而最小堆的插入和删除操作需要进行上浮或下沉调整，时间复杂度为O(log n)。二叉搜索树的插入和删除操作在平均情况下为O(log n)，最坏情况下为O(n)。因此只有A和B正确。', NULL, 1, 0, 2, '堆栈、队列');
INSERT INTO `t_question` VALUES (760, '3', NULL, '在红黑树中，根节点必须是黑色的。', '2026-01-04 09:36:59', '这是红黑树的基本性质之一。红黑树的五大性质包括：1)每个节点是红色或黑色；2)根节点是黑色；3)所有叶子节点（NIL节点）是黑色；4)红色节点的两个子节点都是黑色（不存在两个连续的红色节点）；5)从任一节点到其每个叶子的所有路径都包含相同数目的黑色节点。根节点必须为黑色是保证红黑树平衡性的重要约束。', NULL, 1, 0, 1, '红黑树');
INSERT INTO `t_question` VALUES (761, '3', NULL, '在使用邻接矩阵存储图时，无向图的邻接矩阵一定是对称矩阵。', '2026-01-04 09:36:59', '该判断正确。对于无向图，若顶点i和顶点j之间存在边，则邻接矩阵中A[i][j]=1且A[j][i]=1，因为无向图的边是双向的。因此，无向图的邻接矩阵沿主对角线对称。而有向图的邻接矩阵则不一定对称，因为从顶点i到顶点j有边不代表从j到i也有边。邻接矩阵适合存储稠密图，其空间复杂度为O(n²)。', NULL, 1, 0, 2, '图');
INSERT INTO `t_question` VALUES (762, '3', NULL, '对于一个包含n个元素的完全二叉树，采用顺序存储结构时，编号为i的节点的右孩子编号一定是2i+2（假设根节点编号为0）。', '2026-01-04 09:36:59', '该判断错误。在完全二叉树的顺序存储中（根节点编号为0），编号为i的节点其左孩子编号为2i+1，右孩子编号为2i+2，这个规律本身是正确的。但问题在于\'一定是\'这个表述——当2i+2≥n时，说明该节点不存在右孩子。完全二叉树的特点是除最后一层外其他层都是满的，最后一层从左到右连续排列，因此靠近叶子层的节点可能只有左孩子而没有右孩子。所以正确表述应该是：当2i+2<n时，右孩子编号为2i+2。', NULL, 1, 0, 3, '二叉树');
INSERT INTO `t_question` VALUES (763, '4', NULL, '请详细阐述红黑树的五个核心性质,并说明为什么这些性质能够保证红黑树在插入和删除操作后仍能维持O(log n)的时间复杂度。另外,请简要对比红黑树与AVL树在平衡性和旋转操作频率上的差异。', '2026-01-04 09:36:59', '本题综合考察了多个数据结构知识点：\n1. 红黑树的核心性质(红黑树知识点)：要求学生准确记忆并理解五个基本性质,这是红黑树的理论基础。\n2. 时间复杂度分析(二叉树知识点)：需要学生运用二叉树的高度与节点数关系,推导出红黑树的时间复杂度保证机制。\n3. 数据结构对比分析(综合应用)：要求学生从平衡性、操作效率、应用场景等多维度对比不同树结构,体现了对数据结构本质的理解。\n\n评分要点：\n- 五个性质完整准确(5分)\n- 时间复杂度推导逻辑清晰(3分)\n- AVL树对比准确且有深度(2分)\n\n常见扣分点：\n- 遗漏性质或表述不准确\n- 未能解释性质与时间复杂度的因果关系\n- 对比分析流于表面,缺乏实质性差异说明', NULL, 1, 0, 3, '红黑树、二叉树');
INSERT INTO `t_question` VALUES (764, '1', NULL, '在OSI七层模型中，HTTP协议工作在哪一层？', '2026-01-04 10:53:51', 'HTTP（超文本传输协议）是一个应用层协议，用于在Web浏览器和服务器之间传输超文本。在TCP/IP五层模型和OSI七层模型中，HTTP都属于应用层协议，它依赖于传输层的TCP协议来提供可靠的数据传输。', NULL, 1, 0, 1, '五层模型');
INSERT INTO `t_question` VALUES (765, '1', NULL, '关于HTTPS和HTTP的区别，以下说法正确的是？', '2026-01-04 10:53:51', 'HTTPS（HTTP Secure）是HTTP协议的安全版本，它通过TLS/SSL协议对传输数据进行加密，防止数据被窃听和篡改。HTTPS默认使用443端口，而HTTP使用80端口。HTTPS需要SSL/TLS证书来验证服务器身份。虽然HTTPS因加密会略微降低传输速度，但安全性大大提高。', NULL, 1, 0, 2, 'HTTP/HTTPS/TLS');
INSERT INTO `t_question` VALUES (766, '1', NULL, 'ARP协议的主要作用是什么？', '2026-01-04 10:53:52', 'ARP（Address Resolution Protocol，地址解析协议）工作在网络层和数据链路层之间，主要功能是将网络层的IP地址解析为数据链路层的MAC地址。当主机需要发送数据时，通过ARP协议找到目标IP地址对应的MAC地址，从而在局域网中完成数据帧的传输。反向操作由RARP（逆向地址解析协议）完成。', NULL, 1, 0, 1, 'ARP');
INSERT INTO `t_question` VALUES (767, '1', NULL, '在TCP/IP五层模型中，MAC地址属于哪一层的地址？', '2026-01-04 10:53:52', 'MAC地址（Media Access Control Address）是数据链路层使用的硬件地址，也称为物理地址或以太网地址。它由网络设备制造商分配，全球唯一，长度为48位（6字节），通常用十六进制表示。MAC地址用于在同一网络段内标识设备，实现数据帧的正确传输。网络层使用的是IP地址。', NULL, 1, 0, 1, 'mac地址/五层模型');
INSERT INTO `t_question` VALUES (768, '1', NULL, '当主机A（IP: 192.168.1.10）要向同一局域网内的主机B（IP: 192.168.1.20）发送数据，但不知道主机B的MAC地址时，会发生什么？', '2026-01-04 10:53:52', '在局域网通信中，主机A需要知道目标主机B的MAC地址才能发送数据帧。当A不知道B的MAC地址时，会发送ARP广播请求（目标MAC地址为FF:FF:FF:FF:FF:FF），询问\"谁的IP是192.168.1.20\"。局域网内所有主机都会收到此广播，但只有IP为192.168.1.20的主机B会单播回复ARP响应，告知自己的MAC地址。主机A收到后会将此映射关系缓存到ARP表中，后续通信就可以直接使用。', NULL, 1, 0, 2, 'ARP/mac地址/IP');
INSERT INTO `t_question` VALUES (769, '2', NULL, '关于HTTP和HTTPS协议的说法，下列哪些选项是正确的？', '2026-01-04 10:53:52', 'HTTPS是HTTP的安全版本，通过TLS/SSL协议对数据进行加密传输，能够有效防止中间人攻击和数据篡改。HTTP使用80端口，HTTPS使用443端口。HTTP和HTTPS都是应用层协议，工作在OSI七层模型的应用层（或TCP/IP五层模型的应用层），而非传输层。', NULL, 1, 0, 2, 'HTTP/HTTPS/TLS/五层模型');
INSERT INTO `t_question` VALUES (770, '2', NULL, '在TCP/IP五层网络模型中，以下关于MAC地址和ARP协议的描述，正确的有哪些？', '2026-01-04 10:53:52', 'MAC地址是48位（6字节）的物理地址，工作在数据链路层，用于在局域网内唯一标识网络设备。ARP（地址解析协议）用于将网络层的IP地址解析为数据链路层的MAC地址，它工作在网络层和数据链路层之间，而非传输层。在实际通信中，当主机需要发送数据到同一网络的另一台主机时，需要通过ARP协议获取目标主机的MAC地址。', NULL, 1, 0, 2, 'ARP/五层模型/MAC地址');
INSERT INTO `t_question` VALUES (771, '3', NULL, '在OSI七层模型中，HTTP协议工作在应用层，而TCP协议工作在传输层。', '2026-01-04 10:53:52', '该说法正确。HTTP（超文本传输协议）是应用层协议，用于Web浏览器和服务器之间的通信。TCP（传输控制协议）工作在传输层，为HTTP等上层协议提供可靠的端到端传输服务。在五层模型中，从下到上依次是：物理层、数据链路层、网络层、传输层、应用层。', NULL, 1, 0, 1, '五层模型');
INSERT INTO `t_question` VALUES (772, '3', NULL, 'ARP协议的主要功能是将IP地址解析为MAC地址，它工作在网络层和数据链路层之间。', '2026-01-04 10:53:52', '该说法正确。ARP（地址解析协议）用于将网络层的IP地址映射为数据链路层的MAC地址。当主机需要向同一局域网内的另一台主机发送数据时，需要知道目标主机的MAC地址，此时就需要使用ARP协议。ARP请求会在局域网内广播，拥有对应IP地址的主机会回复自己的MAC地址。', NULL, 1, 0, 2, 'ARP');
INSERT INTO `t_question` VALUES (773, '3', NULL, 'HTTPS协议使用TLS/SSL进行加密传输，但MAC地址信息在TLS加密过程中也会被加密保护，无法被网络中间设备读取。', '2026-01-04 10:53:52', '该说法错误。虽然HTTPS使用TLS/SSL对应用层数据进行加密，但MAC地址属于数据链路层的信息，位于以太网帧头部，不在TLS加密范围内。TLS只加密传输层及以上的数据（TCP载荷及应用层数据）。因此，同一局域网内的交换机、路由器等网络设备仍然可以读取数据帧中的源MAC地址和目标MAC地址。这也是为什么即使使用HTTPS，网络管理员仍然可以通过MAC地址进行设备识别和流量监控。', NULL, 1, 0, 3, 'HTTPS/TLS/mac地址');
INSERT INTO `t_question` VALUES (774, '4', NULL, '请详细说明HTTPS通信过程中TLS握手的主要步骤，并解释该过程如何确保数据传输的安全性。同时说明HTTPS相比HTTP在网络五层模型中哪一层增加了安全机制。', '2026-01-04 10:53:52', '本题考查HTTPS和TLS协议的核心知识点。\n\n关键要点：\n1. TLS握手是非对称加密和对称加密结合使用：握手阶段用RSA等非对称算法交换密钥，数据传输阶段用AES等对称算法加密数据，兼顾安全性和效率。\n\n2. 三个随机数的作用：Client Random、Server Random和Pre-Master Secret共同生成最终的会话密钥，增加密钥的随机性和安全性。\n\n3. 层次定位：虽然HTTPS协议名称包含HTTP（应用层），但TLS实际上是独立的安全层，位于OSI七层模型的会话层，五层模型中可视为应用层和传输层之间的安全子层。\n\n4. 与其他协议的关系：\n- HTTP在应用层\n- TLS在会话层（应用层与传输层之间）\n- TCP在传输层\n- IP在网络层\n- MAC地址在数据链路层\n- ARP协议用于IP地址到MAC地址的映射（工作在网络层和数据链路层之间）\n\n扩展知识：TLS 1.3相比TLS 1.2简化了握手流程，减少了往返次数，提高了性能和安全性。', NULL, 1, 0, 3, 'IP/HTTP/HTTPS/TLS/ARP/五层模型、mac地址');
INSERT INTO `t_question` VALUES (775, '1', NULL, '在红黑树中，从根节点到任意叶子节点的路径上，黑色节点的数量必须相同。如果一棵红黑树的根节点到叶子节点的路径上有3个黑色节点，那么该树最多可能有多少个节点？', '2026-01-04 16:08:49', '红黑树的黑高为3时，最多节点的情况是每个黑色节点都有两个红色子节点。根据红黑树性质，红色节点的子节点必须是黑色，因此可以在每两个黑色节点之间插入一层红色节点。计算方式：最短路径有3个黑色节点，最长路径可以有3个黑色节点和3个红色节点（交替出现），总共6层。按满二叉树计算：2^6 - 1 = 63个节点。这是理论最大值，实际中红黑树通过红黑节点的交替保证平衡性。', NULL, 163, 0, 3, '红黑树');
INSERT INTO `t_question` VALUES (776, '2', NULL, '关于红黑树、二叉树和图的性质，以下说法正确的是？', '2026-01-04 16:08:49', '选项A正确：红黑树通过五条性质约束（根是黑色、叶子是黑色、红色节点的子节点必须是黑色、从根到叶子的所有路径包含相同数量的黑色节点等）和旋转操作维持平衡。选项B正确：这是完全二叉树数组存储的标准索引计算方式（基于0索引）。选项C错误：有向图的邻接矩阵也可能是对称的，例如当图中每条边都有对应的反向边时。选项D正确：红黑树保证最长路径不超过最短路径的2倍，因此高度为O(log n)，操作效率稳定。', NULL, 163, 0, 2, '红黑树、二叉树、图');
INSERT INTO `t_question` VALUES (777, '3', NULL, '在红黑树中，从根节点到任意叶子节点的所有路径上，黑色节点的数量必须相同。', '2026-01-04 16:08:49', '这是红黑树的五大性质之一，称为\"黑高性质\"或\"路径黑色节点数相等性质\"。该性质保证了红黑树的平衡性，使得最长路径不会超过最短路径的两倍，从而确保查找、插入和删除操作的时间复杂度为O(log n)。红黑树的五大性质包括：1)每个节点是红色或黑色；2)根节点是黑色；3)所有叶子节点(NIL)是黑色；4)红色节点的两个子节点都是黑色(不存在连续的红色节点)；5)从任一节点到其每个叶子节点的所有路径都包含相同数目的黑色节点。', NULL, 163, 0, 2, '红黑树');
INSERT INTO `t_question` VALUES (778, '4', NULL, '请简述马克思主义的基本原理及其三个组成部分，并说明它们之间的关系。', '2026-01-04 18:30:39', '马克思主义的三个组成部分包括：\n1. 马克思主义哲学：即辩证唯物主义和历史唯物主义，是马克思主义的理论基础，为认识世界和改造世界提供了科学的世界观和方法论。\n2. 马克思主义政治经济学：揭示了资本主义社会的经济运动规律，特别是剩余价值理论，阐明了资本主义剥削的本质和无产阶级的历史使命。\n3. 科学社会主义：阐明了社会主义代替资本主义的历史必然性，指明了无产阶级解放的条件和道路。\n\n三者关系：马克思主义哲学是理论基础，政治经济学是核心内容，科学社会主义是最终目标。三者相互联系、相互渗透，构成了统一的科学理论体系。哲学为政治经济学和科学社会主义提供世界观和方法论指导；政治经济学为科学社会主义提供经济基础和理论依据；科学社会主义是哲学和政治经济学的归宿和落脚点。', 102, 1, 0, 2, '马克思主义的基本原理和组成部分');
INSERT INTO `t_question` VALUES (779, '4', NULL, '论述毛泽东思想的科学内涵、主要内容及其历史地位，并说明毛泽东思想对中国革命的指导意义。', '2026-01-04 18:30:39', '一、科学内涵：\n毛泽东思想是马克思列宁主义在中国的运用和发展，是被实践证明了的关于中国革命和建设的正确的理论原则和经验总结，是中国共产党集体智慧的结晶。\n\n二、主要内容：\n1. 新民主主义革命理论：提出了农村包围城市、武装夺取政权的革命道路。\n2. 社会主义革命和建设理论：探索了中国社会主义改造和建设的道路。\n3. 革命军队建设和军事战略理论：创立了人民军队建设的理论和人民战争的战略战术。\n4. 政策和策略理论：制定了一系列正确的政策和灵活的策略。\n5. 思想政治工作和文化工作理论：强调思想政治工作是经济工作和其他一切工作的生命线。\n6. 党的建设理论：提出着重从思想上建党的原则。\n\n三、历史地位：\n毛泽东思想是马克思主义中国化的第一次历史性飞跃的理论成果，是中国革命和建设的科学指南，是中国共产党和中国人民宝贵的精神财富。\n\n四、指导意义：\n毛泽东思想指导中国人民取得了新民主主义革命的胜利，建立了新中国；指导完成了社会主义改造，确立了社会主义基本制度；为中国特色社会主义理论体系的形成奠定了理论基础，其活的灵魂（实事求是、群众路线、独立自主）至今仍具有重要指导意义。', 102, 1, 0, 3, '毛泽东思想的科学内涵和历史地位');
INSERT INTO `t_question` VALUES (780, '1', NULL, '在循环队列中，假设队列的最大容量为n，队头指针为front，队尾指针为rear，则判断队列为满的条件是？', '2026-01-04 18:34:01', '在循环队列中，为了区分队满和队空的状态，通常会牺牲一个存储单元。当(rear + 1) % n == front时，表示队尾指针的下一个位置就是队头指针，此时队列已满。而rear == front表示队列为空。', NULL, 163, 0, 2, '队列');
INSERT INTO `t_question` VALUES (781, '1', NULL, '对于一个具有n个顶点和e条边的无向图，采用邻接矩阵存储，则该邻接矩阵中非零元素的个数为？', '2026-01-04 18:34:01', '在无向图的邻接矩阵中，如果顶点i和顶点j之间有边相连，则矩阵中(i,j)和(j,i)位置都会标记为1（或边的权值）。因此，每条边在邻接矩阵中会对应两个非零元素，所以非零元素总数为2e。如果是有向图，则非零元素个数为e。', NULL, 163, 0, 2, '图');
INSERT INTO `t_question` VALUES (782, '2', NULL, '关于队列的基本操作和特性，下列说法正确的是？', '2026-01-04 18:34:01', '队列具有先进先出的特性，A正确。在循环队列中，rear+1=front可能表示队满或队空，需要额外标志位区分，B错误。双端队列(deque)允许两端操作，C正确。优先队列按优先级出队，D正确。', NULL, 163, 0, 2, '队列');
INSERT INTO `t_question` VALUES (783, '2', NULL, '在图的存储和遍历中，下列描述正确的是？', '2026-01-04 18:34:01', '邻接矩阵空间复杂度为O(n²)，适合稠密图，A错误。有向图的邻接表中，每条边<u,v>只存储在顶点u的链表中，B正确。DFS可用递归(利用系统栈)或显式栈实现，C正确。BFS使用队列按层次遍历，D正确。', NULL, 163, 0, 2, '图');
INSERT INTO `t_question` VALUES (784, '3', NULL, '在图的广度优先遍历（BFS）算法中，必须使用队列作为辅助数据结构来存储待访问的顶点。', '2026-01-04 18:34:01', '该说法正确。广度优先遍历（BFS）是按层次顺序访问图中的顶点，需要先访问距离起始顶点近的节点，再访问距离远的节点。队列具有先进先出（FIFO）的特性，恰好符合BFS的访问顺序要求。算法流程是：将起始顶点入队，然后循环取出队首顶点访问，并将其所有未访问的邻接顶点依次入队，直到队列为空。如果使用栈（LIFO）则实现的是深度优先遍历（DFS）。因此，队列是BFS算法的必需数据结构。', NULL, 163, 0, 2, '队列、图');
INSERT INTO `t_question` VALUES (785, '4', NULL, '请简述在图的广度优先搜索（BFS）算法中，队列数据结构所起到的作用，并说明为什么不能使用栈来替代队列实现BFS遍历。', '2026-01-04 18:34:01', '本题考查队列在图遍历算法中的应用。答题要点包括：（1）队列的FIFO特性与BFS层次遍历的对应关系；（2）队列在算法中的具体作用；（3）数据结构选择对算法行为的影响。优秀答案应结合队列和栈的特性差异，说明数据结构与算法逻辑的内在联系。', NULL, 163, 0, 2, '队列、图');

-- ----------------------------
-- Table structure for t_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `discussion_id` int NOT NULL,
  `user_id` int NOT NULL,
  `parent_id` int NULL DEFAULT NULL COMMENT '父评论id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES (18, 1, 163, 12, '测试评论', '2025-04-05 09:46:47');
INSERT INTO `t_reply` VALUES (19, 1, 163, -1, '<p>看看讨论能力</p>', '2026-01-03 18:40:03');
INSERT INTO `t_reply` VALUES (20, 1, 163, -1, '<p>加粗 斜体 下划线 <span style=\"background-color: rgb(230, 0, 0); color: rgb(255, 255, 255);\">测试</span></p>', '2026-01-03 18:40:43');
INSERT INTO `t_reply` VALUES (21, 1, 164, -1, '<p>我是学生</p>', '2026-01-03 18:51:09');
INSERT INTO `t_reply` VALUES (22, 1, 164, -1, '<p>测试讨论功能</p>', '2026-01-04 18:27:58');

-- ----------------------------
-- Table structure for t_repo
-- ----------------------------
DROP TABLE IF EXISTS `t_repo`;
CREATE TABLE `t_repo`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   题库表',
  `user_id` int NOT NULL COMMENT '创建人id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '题库标题',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  `is_exercise` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_repo
-- ----------------------------
INSERT INTO `t_repo` VALUES (99, 163, '测试题库', 6, '2025-04-24 22:34:33', 0, 0);
INSERT INTO `t_repo` VALUES (100, 163, '计算机网络题库', 6, '2026-01-03 18:42:08', 0, 1);
INSERT INTO `t_repo` VALUES (101, 163, '数据结构题库', 6, '2026-01-03 18:46:52', 0, 1);
INSERT INTO `t_repo` VALUES (102, 1, '测试', 7, '2026-01-04 18:29:35', 0, 1);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID  角色表',
  `role_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, '学生', 'student');
INSERT INTO `t_role` VALUES (2, '教师', 'teacher');
INSERT INTO `t_role` VALUES (3, '管理员', 'admin');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `real_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'https://online-exam-system-backend.oss-cn-beijing.aliyuncs.com/da93c2a6-6879-46c3-b38f-a99956f70d22.jpg' COMMENT '头像地址',
  `role_id` int NULL DEFAULT 1 COMMENT '角色id',
  `grade_id` int NULL DEFAULT NULL COMMENT '班级id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间   YYYY-MM-DD hh:mm:ss',
  `status` int NULL DEFAULT 1 COMMENT '状态  1正常0禁用',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除：0代表未删除，1代表删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '管理员', '$2a$10$/ZdKFY15AWNLOeTqAp91a.uDa0JDioj1wVYGgpn.HKMYh9vq0Uh4S', 'https://online-exam-system-backend.oss-cn-beijing.aliyuncs.com/27eb3a59-4d05-4bce-90ec-4a2457452886.png', 3, 106, '2025-12-23 16:06:07', 1, 0);
INSERT INTO `t_user` VALUES (163, 'teacher', '教师1', '$2a$10$odROzQ2vFaHRomD9UG4uWO65twiqI33Y1RktzqtxWNLaVf5.luivy', 'https://online-exam-system-backend.oss-cn-beijing.aliyuncs.com/da93c2a6-6879-46c3-b38f-a99956f70d22.jpg', 2, NULL, '2025-12-22 11:38:18', 1, 0);
INSERT INTO `t_user` VALUES (164, 'student', '张三', '$2a$10$vcnsGkVJdeH0tdKiLa1.d.qbPD/.5B5Ah3qYzeN6rem5P/U8jGiMS', 'https://online-exam-system-backend.oss-cn-beijing.aliyuncs.com/da93c2a6-6879-46c3-b38f-a99956f70d22.jpg', 1, 124, '2025-12-22 11:38:36', 1, 0);

-- ----------------------------
-- Table structure for t_user_book
-- ----------------------------
DROP TABLE IF EXISTS `t_user_book`;
CREATE TABLE `t_user_book`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID   错题本',
  `exam_id` int NULL DEFAULT NULL COMMENT '考试id  唯一',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id    唯一',
  `qu_id` int NULL DEFAULT NULL COMMENT '题目id    唯一',
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间    YYYY-MM-DD hh:mm:ss',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 234 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_book
-- ----------------------------
INSERT INTO `t_user_book` VALUES (214, 120, 164, 720, '2025-04-26 14:35:36');
INSERT INTO `t_user_book` VALUES (218, 121, 164, 731, '2026-01-01 03:19:38');
INSERT INTO `t_user_book` VALUES (219, 121, 164, 732, '2026-01-01 03:19:38');
INSERT INTO `t_user_book` VALUES (220, 121, 164, 733, '2026-01-01 03:19:38');
INSERT INTO `t_user_book` VALUES (221, 121, 164, 734, '2026-01-01 03:19:38');
INSERT INTO `t_user_book` VALUES (222, 122, 164, 735, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (223, 122, 164, 738, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (224, 122, 164, 739, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (225, 122, 164, 740, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (226, 122, 164, 741, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (227, 122, 164, 743, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (228, 122, 164, 744, '2026-01-03 19:01:00');
INSERT INTO `t_user_book` VALUES (229, 125, 164, 764, '2026-01-04 14:39:20');
INSERT INTO `t_user_book` VALUES (230, 125, 164, 774, '2026-01-04 14:39:20');
INSERT INTO `t_user_book` VALUES (231, 126, 164, 731, '2026-01-04 15:01:33');
INSERT INTO `t_user_book` VALUES (232, 130, 164, 775, '2026-01-04 18:27:01');
INSERT INTO `t_user_book` VALUES (233, 130, 164, 776, '2026-01-04 18:27:01');

-- ----------------------------
-- Table structure for t_user_daily_login_duration
-- ----------------------------
DROP TABLE IF EXISTS `t_user_daily_login_duration`;
CREATE TABLE `t_user_daily_login_duration`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID，与用户表关联，确保数据一致性',
  `login_date` date NULL DEFAULT NULL COMMENT '登录日期，记录用户在哪一天的登录时长',
  `total_seconds` int NULL DEFAULT NULL COMMENT '累积在线秒数，每日登录总时长，单位为秒',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 134 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_daily_login_duration
-- ----------------------------
INSERT INTO `t_user_daily_login_duration` VALUES (126, 164, '2025-12-22', 0);
INSERT INTO `t_user_daily_login_duration` VALUES (127, 164, '2025-12-24', 564020);
INSERT INTO `t_user_daily_login_duration` VALUES (128, 164, '2025-12-25', 28830);
INSERT INTO `t_user_daily_login_duration` VALUES (129, 164, '2025-12-26', 63127);
INSERT INTO `t_user_daily_login_duration` VALUES (130, 164, '2025-12-29', 0);
INSERT INTO `t_user_daily_login_duration` VALUES (131, 164, '2026-01-01', 198362);
INSERT INTO `t_user_daily_login_duration` VALUES (132, 164, '2026-01-03', 235591);
INSERT INTO `t_user_daily_login_duration` VALUES (133, 164, '2026-01-04', 8549);

-- ----------------------------
-- Table structure for t_user_exams_score
-- ----------------------------
DROP TABLE IF EXISTS `t_user_exams_score`;
CREATE TABLE `t_user_exams_score`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id  用户考试成绩表',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id  唯一',
  `exam_id` int NULL DEFAULT NULL COMMENT '试卷id  唯一',
  `total_time` int NULL DEFAULT NULL COMMENT '总时长  YYYY-MM-DD hh:mm:ss',
  `user_time` int NULL DEFAULT NULL COMMENT '用户用时  YYYY-MM-DD hh:mm:ss',
  `user_score` int UNSIGNED NULL DEFAULT 0 COMMENT '用户得分',
  `limit_time` datetime NULL DEFAULT NULL COMMENT '交卷时间  YYYY-MM-DD hh:mm:ss',
  `count` int NULL DEFAULT 0 COMMENT '切屏次数',
  `state` int NULL DEFAULT NULL COMMENT '状态   0正在考试 1考试完成',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间  YYYY-MM-DD hh:mm:ss',
  `whether_mark` int NULL DEFAULT NULL COMMENT '是否阅卷-1无简答题、0未阅卷、1阅卷',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `exam_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 215 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_exams_score
-- ----------------------------
INSERT INTO `t_user_exams_score` VALUES (204, 164, 119, 1, 21348355, 0, '2025-12-29 16:14:05', 0, 1, '2025-04-26 14:08:10', -1);
INSERT INTO `t_user_exams_score` VALUES (205, 164, 120, 100, 19, 10, '2025-11-26 14:35:36', 0, 1, '2025-04-26 14:35:17', -1);
INSERT INTO `t_user_exams_score` VALUES (206, 164, 121, 30, 22, 0, '2026-01-01 03:19:38', 0, 1, '2026-01-01 03:19:16', -1);
INSERT INTO `t_user_exams_score` VALUES (207, 164, 122, 30, 66, 15, '2026-01-03 19:01:00', 2, 1, '2026-01-03 18:59:53', -1);
INSERT INTO `t_user_exams_score` VALUES (208, 164, 124, 60, 488, 0, '2026-01-04 09:45:43', 0, 1, '2026-01-04 09:37:35', 0);
INSERT INTO `t_user_exams_score` VALUES (209, 164, 125, 60, 30, 0, '2026-01-04 14:39:20', 4, 1, '2026-01-04 14:38:49', 0);
INSERT INTO `t_user_exams_score` VALUES (210, 164, 126, 30, 9, 5, '2026-01-04 15:01:33', 0, 1, '2026-01-04 15:01:23', -1);
INSERT INTO `t_user_exams_score` VALUES (211, 164, 127, 30, 15, 3, '2026-01-04 15:03:39', 0, 1, '2026-01-04 15:03:23', -1);
INSERT INTO `t_user_exams_score` VALUES (212, 164, 129, 30, 21, 0, '2026-01-04 15:25:36', 2, 1, '2026-01-04 15:25:15', -1);
INSERT INTO `t_user_exams_score` VALUES (213, 164, 123, 0, 4, 0, '2026-01-04 18:21:06', 0, 1, '2026-01-04 18:21:01', 0);
INSERT INTO `t_user_exams_score` VALUES (214, 164, 130, 60, 35, 2, '2026-01-04 18:27:01', 5, 1, '2026-01-04 18:26:25', -1);

-- ----------------------------
-- Table structure for t_user_exercise_record
-- ----------------------------
DROP TABLE IF EXISTS `t_user_exercise_record`;
CREATE TABLE `t_user_exercise_record`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id   用户刷题记录表',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `repo_id` int NULL DEFAULT NULL COMMENT '题库id',
  `total_count` int NULL DEFAULT NULL COMMENT '总题数',
  `exercise_count` int NULL DEFAULT NULL COMMENT '已刷题数',
  `create_time` datetime NULL DEFAULT NULL COMMENT '刷题时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_exercise_record
-- ----------------------------
INSERT INTO `t_user_exercise_record` VALUES (31, 164, 101, 5, 1, '2026-01-03 18:52:20');
INSERT INTO `t_user_exercise_record` VALUES (32, 164, 100, 0, 8, '2026-01-04 09:07:57');

-- ----------------------------
-- Table structure for t_user_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_user_grade`;
CREATE TABLE `t_user_grade`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `u_id` int NULL DEFAULT NULL COMMENT '用户id',
  `g_id` int NULL DEFAULT NULL COMMENT '教师id',
  `is_deleted` int NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `u_id`(`u_id` ASC, `g_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_grade
-- ----------------------------
INSERT INTO `t_user_grade` VALUES (10, 163, 124, 0);

SET FOREIGN_KEY_CHECKS = 1;
