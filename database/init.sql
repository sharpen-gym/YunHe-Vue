-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: yunhe
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_conversation`
--

DROP TABLE IF EXISTS `ai_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_conversation` (
  `create_by` varchar(36) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `title` varchar(255) NOT NULL COMMENT '会话标题',
  `status` char(1) NOT NULL DEFAULT '1',
  `summary` text COMMENT '历史对话摘要',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_conversation`
--

LOCK TABLES `ai_conversation` WRITE;
/*!40000 ALTER TABLE `ai_conversation` DISABLE KEYS */;
INSERT INTO `ai_conversation` VALUES ('admin','admin','e14a288f-8a20-42ea-94ce-ba0165da90d5','866b0232-507b-42a4-bdc1-47fc4a83616a','55511','1',NULL,NULL,'2026-05-09 23:15:19','2026-05-09 23:15:19');
/*!40000 ALTER TABLE `ai_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_message`
--

DROP TABLE IF EXISTS `ai_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_message` (
  `create_by` varchar(36) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) NOT NULL,
  `conversation_id` varchar(36) NOT NULL COMMENT '会话ID',
  `role` varchar(20) NOT NULL COMMENT '对话角色',
  `content` text NOT NULL COMMENT '消息内容',
  `tokens` int DEFAULT NULL COMMENT '消耗Token数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_message`
--

LOCK TABLES `ai_message` WRITE;
/*!40000 ALTER TABLE `ai_message` DISABLE KEYS */;
INSERT INTO `ai_message` VALUES ('admin','admin','89bccbbc-39fe-422b-90e9-60364807ca52','e14a288f-8a20-42ea-94ce-ba0165da90d5','user','555',5,'2026-05-09 23:15:19','2026-05-09 23:15:19'),('admin','admin','d42b96d7-cf22-42a7-a2a5-3b8bc1403b46','e14a288f-8a20-42ea-94ce-ba0165da90d5','assistant','你好！看起来你发送了“555”。这个数字在不同语境下有不同的含义：\n\n1. **网络用语**：在中文互联网中，“555”常被用来模拟哭泣的声音（呜呜呜），表示伤心、委屈或撒娇。\n2. **数字本身**：五百五十五。\n3. **其他**：在某些游戏中可能是技能代码或特定含义。\n\n请问你是想表达哪种意思？或者有什么具体的问题需要我帮忙吗？😊',92,'2026-05-09 23:15:19','2026-05-09 23:15:19');
/*!40000 ALTER TABLE `ai_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_prompt`
--

DROP TABLE IF EXISTS `res_prompt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_prompt` (
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(36) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) NOT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT '提示词类型',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `content` text COMMENT '提示词内容',
  `title` varchar(200) DEFAULT NULL COMMENT '提示词标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_prompt`
--

LOCK TABLES `res_prompt` WRITE;
/*!40000 ALTER TABLE `res_prompt` DISABLE KEYS */;
INSERT INTO `res_prompt` VALUES ('2026-05-13 07:40:46','2026-05-13 07:46:30','admin','admin','94e69b43-2c51-400f-a24c-d5e9a46dd5da','1','1',NULL,'帮我生成一个 诗词名句 的 CRUD 模块\n位置：modules/resource/poem\n表名：res_poem\n字段：status、作者 author、名句 digest、朝代 dynasty','快速生成增删改查'),('2026-05-13 03:57:26','2026-05-13 03:58:10','admin','admin','c9eb4351-28aa-46aa-83b0-d54d6d234544','1','1','仅适用于本项目，解析项目文件生成大厂标准的简历项目经历','你是资深全栈开发工程师简历顾问，同时精通NestJS+Vue3+TypeScript技术栈和Pnpm Monorepo架构，现在请深度扫描我当前打开的这个全栈Monorepo项目，优先解析根目录的SUMMARY.md文件，结合pnpm-workspace.yaml、根目录及各包的package.json、nest-cli.json、vite.config.ts、docker-compose.yml等关键配置文件，自动提取项目名称、技术栈、项目时间、项目角色，生成一份符合大厂标准、可直接复制到简历的项目经历，内容需包含1-2句清晰的项目描述、4-6条以动词开头的主要职责（平衡后端、前端和工程化工作）、3-5个带量化指标的技术亮点和项目成果，重点突出Monorepo架构带来的工程价值、前后端类型安全协同、NestJS后端设计和Vue3前端优化能力，自动挖掘代码中隐藏的技术难点和个人贡献，确保内容专业准确、简洁有力，突出个人独特价值而非团队工作。','提取本项目为项目经历'),('2026-05-12 22:57:26','2026-05-13 03:49:31','admin','admin','fb00d345-a7d5-471e-b7a4-58a2835623f0','0','1','','你要随机扮演中国古代历史人物的其中一位和我对话，这个人物必须是真实存在的，你不能暴露你的身份，我会提出问题来猜测你的身份。你需要以他/她的语气来回答我，必须按照事实回答，不能撒谎，不能说你没有干过的事，不能虚构事件，不能编造事实，一句话不能超过16个字，要符合你扮演的这个人的性格，请以第一人称视角和我开始对话，要准确的回答我的问题，是或不是，不能模糊，我说游戏结束就是结束，如果我猜不出来，你要告诉我你是谁。','历史人物对话游戏');
/*!40000 ALTER TABLE `res_prompt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dict_label` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典标签',
  `dict_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典值',
  `dict_sort` int NOT NULL DEFAULT '1' COMMENT '排序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `dict_type_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dict_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典类型',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '表格回显样式',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES ('admin','admin','03650518-a9ca-470e-a568-1e4b16d1c486','默认分组','DEFAULT',1,'1','默认分组','b8849a88-e972-42fc-9b87-75f0c8d18157','sys_job_group',NULL,'2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','059632a3-5c6c-4e2e-9cb0-8e305a4c3750','导出','6',6,'1','导出操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','warning','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','091ac304-a43b-4564-8c60-a2a70f1bd52e','删除','3',3,'1','删除操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','0ab42d49-d246-496b-9f06-52d40dc46314','停用','0',2,'1','停用状态','8ab1bfca-3b61-4708-b7eb-202732db1ac1','sys_normal_disable','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','27c0f923-3805-45a8-b7d0-833c9edef72a','隐藏','0',2,'1','菜单侧栏隐藏','2092c5ba-54ed-4d88-aadc-02bd8d65644f','sys_menu_visible','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','330e9abf-5237-4a95-b3e7-7f7b4bf84844','清空','4',4,'1','清空操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','36644392-be54-4c54-a3d0-fe93ebf4d2d2','成功','1',1,'1','成功状态','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','sys_common_status','primary','2026-05-09 23:15:20','2026-05-10 17:58:06'),('admin','admin','447796f1-27e6-4bea-8ebb-bc1e53a021f2','强退','5',5,'1','强退操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','44c85375-43e3-412e-97b5-399f3d86dbac','系统预设','1',1,'1','本项目专属','01764eff-a4e4-4a69-84e5-8416dab03d4d','res_prompt_type',NULL,'2026-05-12 22:47:17','2026-05-13 03:48:47'),('admin','admin','64b18e59-5a31-4432-bdb5-70baba75002a','其它','0',99,'1',NULL,'01764eff-a4e4-4a69-84e5-8416dab03d4d','res_prompt_type',NULL,'2026-05-12 22:50:56','2026-05-12 22:50:56'),('admin','admin','9093966a-f3ac-42a0-b007-4e1e8e45b1a5','显示','1',1,'1','菜单侧栏显示','2092c5ba-54ed-4d88-aadc-02bd8d65644f','sys_menu_visible','primary','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','98f6b84f-bfe9-4e4f-9bdc-d618b1c61067','暂停','0',2,'1','暂停状态','6821fa61-5032-4d68-85a6-ddce61716386','sys_job_status','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','a24a6b5c-9378-481b-9419-931f690cbc60','女','1',2,'1','性别女','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL,'2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','a42483c1-6d59-43e6-8a77-35417d412fa7','新增','1',1,'1','新增操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','a6f53fa4-90c3-4737-8dda-b9b9c72142bb','修改','2',2,'1','修改操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','a8e265ea-98a0-4fc5-976d-6c1bf4d3a131','男','0',1,'1','	\n性别男','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL,'2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','bca4e85d-5cd7-4f7f-b5c9-09d5cb869f65','失败','0',2,'1','失败状态','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','sys_common_status','danger','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','d1f9b46c-10de-4dd3-b2c5-1862b6b5103a','未知','2',3,'1','性别未知','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL,'2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','d30dcaea-b7f3-40fa-b825-b49437fee7d8','正常','1',1,'1','正常状态','8ab1bfca-3b61-4708-b7eb-202732db1ac1','sys_normal_disable','primary','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','d38206f0-cd99-4cea-a858-0d8d85427f43','系统分组','SYSTEM',2,'1','系统分组','b8849a88-e972-42fc-9b87-75f0c8d18157','sys_job_group',NULL,'2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','e5827acf-7e8d-4d6b-a39a-707af2f44af2','正常','1',1,'1','正常状态','6821fa61-5032-4d68-85a6-ddce61716386','sys_job_status','primary','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','fd503e74-72cb-4218-9761-c5e58a18369b','其它','0',99,'1','其它操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info','2026-05-09 23:15:20','2026-05-09 23:15:20');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dict_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典名称',
  `dict_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_f4e4273658733a3bbe6a2479bf` (`dict_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES ('admin','admin','01764eff-a4e4-4a69-84e5-8416dab03d4d','提示词类型','res_prompt_type','1','提示词类型列表','2026-05-12 22:45:29','2026-05-12 22:45:29'),('admin','admin','1cf7d66a-1119-428f-b1cd-16d103b9a932','用户性别','sys_user_gender','1','用户性别列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','2092c5ba-54ed-4d88-aadc-02bd8d65644f','菜单显隐','sys_menu_visible','1','菜单显隐列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','系统状态','sys_common_status','1','系统状态列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','6821fa61-5032-4d68-85a6-ddce61716386','任务状态','sys_job_status','1','任务状态列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','8ab1bfca-3b61-4708-b7eb-202732db1ac1','系统开关','sys_normal_disable','1','系统开关列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','b8849a88-e972-42fc-9b87-75f0c8d18157','任务分组','sys_job_group','1','任务分组列表','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','da04de16-1667-47cf-916d-13716ed651a2','操作类型','sys_oper_type','1','操作类型列表','2026-05-09 23:15:20','2026-05-09 23:15:20');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'cron执行表达式',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '3' COMMENT '计划执行错误策略',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否并发执行',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES ('admin','admin','df3c4304-4946-45d9-9376-c45ef333150d','测试','DEFAULT','JobService.test()','* * * * * *','0','1','0','2026-05-09 23:15:20','2026-05-09 23:15:20');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
INSERT INTO `sys_job_log` VALUES ('0226e040-1ef7-4c00-bbba-7dc055fbce08','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:35'),('03448a12-32af-4931-9891-93147ba50791','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:30'),('08be2173-56d3-4d47-9c99-611e77549131','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:51'),('0f12a9fe-98ce-4a36-84b7-a3a8c2ffb905','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:23'),('0f5e8245-a9ec-49bf-93cd-c129d35894b5','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:26'),('10b4e0e0-2a62-41a5-8340-ee771811f81f','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:25'),('12ac4bba-678f-4625-a32b-2e73d2f10b37','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:23'),('135e271e-fdc4-40d6-b12e-cbb28dcbad78','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:33'),('1428ae75-5b9c-44c8-83d5-c9ef9588a730','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:15'),('14a71e8b-c2ec-4c78-9dbd-3427be928b44','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:42'),('19d064fa-0b64-4aa7-9872-b8c6e5319adc','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:36'),('1a03207d-3fab-4c30-8e14-f03ac75cc429','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:41'),('2132d515-518b-4c62-8bf8-6fce3b67e056','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:10'),('22623aa4-7c7c-4ab1-83b9-c81e98eda103','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:49'),('260c18b7-bc50-4c56-a380-273ea6549dfb','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:37'),('276bba87-466f-4456-9d14-04def2ce6e77','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:41'),('296a4efa-3af7-4bb5-99d3-9b9b54b66a7c','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:38'),('299dfdca-15d3-4ed2-b3d5-a55398afb9c7','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-01 07:30:14'),('2d93d5fd-d548-441e-9ce1-e0d6de8f99c1','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:40'),('2f91e5a4-e8c7-4025-8d0f-ec35f9749f64','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:29'),('3331835b-8444-4ce4-8095-cb51b16d6dd8','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:27'),('34277019-d9e9-4e3e-a2fe-5ab200d1f22c','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:38'),('37187030-ea1e-462f-aac7-66b29dc04ebc','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:22'),('38e8f957-e3f5-4b8f-b028-935025dd7189','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:54'),('3d94077f-23ef-40bf-a35a-ed0058fe3a3b','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:26'),('3f8281d9-a1ee-49fd-aaa4-b60785759f15','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:00'),('40834eb6-bb8a-438f-b9c4-733e4ada3294','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:31'),('423ce7a6-76e5-4287-8793-f5927a448f82','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:47'),('42804bbb-0d6b-4eee-9644-e37ab1d019ec','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:33'),('4295ebd3-961d-46c6-93ad-a166aa85c342','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:39'),('4c2ba714-682a-435a-ba42-a6b9f21fda19','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:09'),('4cc99e0c-4bcf-413a-a8ed-446d1d4800d8','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:52'),('4d1fb731-cf2a-47a5-b8f1-7a086267b5fa','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:32'),('4d65eb74-cd73-4669-8ddb-e3f7d609db25','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:41'),('5060af29-04ab-4031-b279-039ce9e018be','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:32'),('50b3bc16-3dab-4c2c-aa64-a77b3230ef5a','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:33'),('56023a7b-fce6-4a21-8fdd-307ee248da01','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:48'),('56c2da94-6792-4d19-9c51-acc1bc18a905','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:30'),('5883d817-ef8a-4f32-aef8-47fdc1b1e0bc','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:57'),('5a6ef833-ea83-4dbc-b50f-28c078bd7b78','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:22'),('5cb30860-7883-4ee9-b5ba-93d7336bd7f3','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:25'),('5f529516-bb19-4b16-a3a8-402ae4523588','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:29'),('60dac985-a402-498a-b0ff-e038cf4c9674','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:34'),('617291ee-a448-4fe7-837a-9205dbc92065','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:53'),('64b4dee1-f47b-4cb5-89c0-2a73e44b7bd9','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:36'),('670bf2b5-a2fe-428a-8d82-e262ac3e8faf','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:34'),('6972b76f-3776-4e17-b887-b0b9ceedaae7','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:38'),('6a24ce61-52ec-4657-8092-cd17852cfa4d','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:27'),('6cd3a1ac-ebf6-4a66-a7de-2692ec554f80','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:45'),('6d774fb6-437f-466e-99eb-8ec2409c4a58','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:35'),('70f26c77-4835-4261-b019-517e52192eff','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:34'),('716dd3d5-488f-4e86-97a9-dcbe4dce6623','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:18'),('76298f39-6ea9-46b3-b78a-1f497df3bb36','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:02'),('7732379f-72e6-41e5-872f-bfe6b37766f6','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:31'),('7733b65f-5a4b-4379-9b90-5e0d1583f178','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:12'),('79bf97ec-4141-41e0-8ab2-e88ed8edc504','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:11'),('7b64f995-e014-48c5-add2-81340a4ff098','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:40'),('7c266480-abcf-4a68-a891-4f9303788c9a','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:06'),('7cced302-dee4-4168-877f-3a549fc00918','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:42'),('7ec63be9-70c3-4e66-8256-6b153149baf1','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:55'),('86e303e8-7a11-4b11-931a-d582db0f80ec','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:46'),('88286dfc-6530-45f9-8116-d887fcdf3589','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:30'),('8b405e89-8bb6-4941-9d9c-45887e9eb60f','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:20'),('8b489d6c-fddf-4e18-af51-2c6e4dfaa1f0','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:56'),('8d284c79-627e-4a00-a310-ad9518ab626b','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:40'),('92405cd8-cf64-47e1-937d-b0adab91b580','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:21'),('9716fb36-309f-4ab2-89ef-649d3c0cc9ba','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:12'),('97b4df72-9a30-4629-9de3-fc8a4ee3fb37','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:39'),('9c943835-9cd5-4f92-a4f6-9bf83d04d4f1','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:37'),('9e36853d-da9c-4a37-91b0-d8c4be2fc77e','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:03'),('a123e704-4e3c-466c-bc9c-c155bd7ae83e','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:38'),('a894f03b-34a4-4b79-9261-bcc7c9571df1','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:29'),('a9649f98-27db-4902-bae1-66986c27e8f6','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:32'),('ab96a6f3-f9e6-4cf7-8079-3c91b8b1e2c1','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:16'),('ac0c9c7d-39de-46a2-b49d-0561c91725bd','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:21'),('ada96cb0-8dce-4b72-a50c-2bd4130817cc','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:50'),('aeb1727a-8012-49b7-8c4d-06003328bbb3','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:37'),('af61e3d6-ea1a-422d-8807-c6a929eb9ce9','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:49'),('b00d7359-23ff-4901-be03-9d3a1ac57530','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:05'),('b02e26d9-c92e-4a74-993c-4aba6380c0ea','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:43'),('b0eeeb9c-1245-40e5-a3ee-e510724e4f77','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:27'),('b43cfe6b-1fe6-40db-81e7-ff8c515772d3','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:31'),('b9081880-a695-4c27-9cee-9900c8db0a74','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:01'),('b92c2772-1aab-4fd4-bf8a-6b47d84479a7','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:59'),('b9abb099-6e87-443f-a30d-bd23bc39a87f','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:24'),('b9bd6fc8-342f-4ab1-b634-ea27d212ad23','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:24'),('bcef1863-95f2-47ed-94e0-8a0713942af7','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:39'),('c52526ea-6f34-4fc8-83e7-8c95742dabe9','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:37'),('c7479fd9-8b22-474a-b1aa-a6b55c806656','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-01 06:15:32'),('c8b78eb9-081c-4a98-9276-5c43647efe7d','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:35'),('c9c9060d-5b84-4eb8-b9f7-3d70168151cf','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:20:44'),('cc4755e3-5e9a-40cf-9589-3511c9ff87b5','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:32'),('cd82536e-e749-43b7-bdfb-1fa0a8be0bfb','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:28'),('cf4d0ce5-2fcd-4f55-9af0-a20915ea7de6','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:07'),('d0d622fb-85e9-4adc-a589-d4bf5c979060','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:17'),('d10d2836-22ee-45ab-8a25-3a8418a575fb','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-01 06:15:57'),('d423bc0a-808a-4676-a4b6-0c6663cdd803','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:28'),('d4259db4-f4ad-47ee-bbb6-222ee069968e','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:14'),('d506c442-9377-498c-aeb2-cf4e6a081686','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:43'),('d5c71f50-26cd-4f03-92ee-44235f4d1fe6','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:24:17'),('d857ddc9-7c22-4bda-8232-b39b6f9e842e','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:19'),('d8e43e26-8447-4e36-a100-7f0a45d59025','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:34'),('dbe072a7-9a16-4a73-958a-e85c4ebd1ba7','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:22'),('dc8b8b38-003f-448f-b67c-085aadd770c4','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:16'),('dd90de2a-e54d-49d3-ae7e-4edbd4a08dfa','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:35'),('e5e45a52-c3d3-443e-98fc-844f2d26273f','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:33'),('ea83d00d-c71b-4124-be04-f4b48987658b','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:13'),('eb79ae9b-4135-4fb1-80bc-3a99083199ae','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:33:58'),('ee0976ae-5d02-4684-9589-30334cef1c9e','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:28'),('ef35f91d-5843-4b3c-b0f5-c1d6defa6096','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:04'),('f2f17a5a-e883-48e6-8ba3-c96648bf5f0c','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:08'),('f74f6386-28f9-4f7e-a376-9f2367683eb9','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:31'),('fcb3ed88-5bfa-468f-87de-1d5653ad1f8a','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:25'),('fd7a3ed7-6cf0-4dab-83e7-5f60e5c0b6c8','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 01:34:36'),('fdce976f-249a-4898-9d34-98f79ff00a57','测试','DEFAULT','JobService.test()','执行成功','1','2026-05-02 21:13:36');
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_login_log`
--

DROP TABLE IF EXISTS `sys_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_login_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访问ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户账号',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录IP地址',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '登录状态',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '提示消息',
  `login_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录日期',
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_log`
--

LOCK TABLES `sys_login_log` WRITE;
/*!40000 ALTER TABLE `sys_login_log` DISABLE KEYS */;
INSERT INTO `sys_login_log` VALUES ('002a59b1-c18d-40d3-abe0-5f5ffa3e3922','admin','112.97.81.250','广东省 深圳市','WeChat8.0.73','iOS18.3.1','1','登录成功','2026-05-14 16:28:05','3cf68b35-d0fe-4a80-80a4-241e5e4b7db5'),('043b5974-38cd-44a5-b793-e41d51c5b806','admin','58.62.103.233','广东省 广州市','MIUI Browser20.17.1030507','Android16','1','登录成功','2026-05-16 00:18:52','e241fa59-e152-4b03-8edc-14589eb1f82e'),('0a3ed386-c735-4e88-886f-90d01e9bfd96','admin','14.219.121.107','广东省 东莞市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-21 15:29:30','c278e99f-06d9-4dad-8a63-e920c4edb468'),('13957c09-62fd-4500-85e5-6502469f0e87','admin','144.48.80.237','德克萨斯 达拉斯','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-19 10:47:37','e43e7e05-723e-42c4-9251-13b29a442824'),('1445d336-86f4-4446-b582-c0a883a4bf53','admin','115.206.110.44','浙江省 杭州市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-22 08:51:17','baec0231-840d-4a78-aed3-cb21251fe9b7'),('22b292af-82d2-47af-b649-0e9ef83a0c78','admin','159.226.100.198','北京 北京市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-14 18:00:00','62f13ee6-fac4-4c15-903c-a8630c6bb2c7'),('235dffd5-935e-4b69-8f14-c59c43f1d4fa','admin','119.8.242.155','中国 香港','Edge92.0.902.67','Windows10','1','登录成功','2026-05-20 14:44:20','66992eba-ec8c-4387-970b-af9f4bd3c5a9'),('255f4e92-94db-4b33-9703-14097418d314','admin','171.212.149.184','四川省 成都市','MIUI Browser20.17.1030507','Android16','1','登录成功','2026-05-14 22:05:32','20e4365a-1da9-4249-be0c-d05bc807b144'),('3552abb4-3489-4a10-b9be-b53a355ad10b','admin','60.26.11.130','天津 天津市','WebKit605.1.15','iOS18.7','1','登录成功','2026-05-18 20:05:41','1d410261-b32e-4e0c-ada0-b080f79b9d6d'),('3ab835c7-7f5d-4f0e-9cf5-d7a250da0328','admin','120.41.137.167','福建省 厦门市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-21 15:40:23','5565bb07-6e52-4114-9039-a009b716b43c'),('4172a2e1-02d8-4130-a0ed-958dca9bae0c','admin','183.39.17.168','广东省 深圳市','HeyTap40.9.3.1','Android12','1','登录成功','2026-05-18 12:31:32','cea63fe2-72bb-42b5-bec7-90f90b186093'),('505610d7-c9cc-4e7a-ba66-bc76ada29ce4','admin','171.109.10.238','广西 北海市','Firefox150.0','Windows10','1','登录成功','2026-05-18 16:12:31','b0e20ede-37bb-4c17-bf67-ceab70ca14fb'),('50f4187d-42a1-4ef9-9a0a-a55265768974','admin','39.144.59.9','辽宁省 沈阳市','WeChat8.0.71.3080','Android14','1','登录成功','2026-05-14 15:46:46','75178398-dc72-4d25-b1b9-83f89ba07385'),('5b1a23fd-d584-4818-9299-7872738c35b2','admin','182.102.190.156','江西省 南昌市','MIUI Browser20.2.80902','Linux','1','登录成功','2026-05-16 15:48:00','f13f5f03-b36a-43c2-9727-d6299d6f189e'),('5cc61fa6-62fc-41e3-9fd7-50705d46153b','admin','59.41.160.131','广东省 广州市','Edge148.0.0.0','Windows10','1','登录成功','2026-05-16 21:18:54','1dceb985-e041-4139-bf93-ac53cd1ff081'),('5e46c908-a5e4-4a49-8987-d1dc79c18343','admin','42.234.70.46','河南省 南阳市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-19 16:44:45','fafc7898-99d3-49ee-bd30-396cd3923a2d'),('61702c48-2e71-429b-aea6-05a2860325ac','admin','58.246.132.18','上海 上海市','Chrome146.0.0.0','macOS10.15.7','1','登录成功','2026-05-14 15:35:53','1e52fb21-5c4a-439f-bec8-15c119823f67'),('61ee6e04-d20d-40bb-b37d-57f8526fc0c4','admin','183.17.230.137','广东省 深圳市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-19 09:02:52','5d85ff6e-b3ac-4ddb-b21e-08f9eda8c3c3'),('63f2a7b9-e05b-47ea-b717-3007ac2f4bf9','admin','61.48.42.34','北京 北京市','Chrome148.0.0.0','macOS10.15.7','1','登录成功','2026-05-18 11:35:22','a5ddca0d-fd7a-4360-a1bf-a5939d0bbbc0'),('720a789f-19f1-4561-9e86-7b811c40a405','admin','182.138.95.6','四川省 成都市','Chrome147.0.0.0','Windows10','1','登录成功','2026-05-15 13:35:34','76f89584-e8d7-48f9-9123-5efcc072ef74'),('755c486f-50d6-4189-889b-f65b98a7c54b','admin','39.171.200.220','浙江省 绍兴市','UCBrowser11.6.4.950','Android15','1','登录成功','2026-05-21 21:44:30','6b73b9ca-585c-4a8c-89e7-d44332e732d5'),('7bc68bf9-c9a5-42b4-a0b7-c987e54a6539','admin','223.215.231.30','安徽省 合肥市','Android Browser4.0','Android16','1','登录成功','2026-05-20 19:04:49','aad64373-ee5e-4ba4-9b4d-0c31ac90ec0a'),('7e9dbefa-f545-40b0-8af0-3832df7ca531','admin','113.110.228.157','广东省 深圳市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-18 11:35:11','7293d3ab-08ba-4333-9683-5fad7a9d94e2'),('7eba712b-44b5-41a9-9ac1-72306e920fd5','admin','221.227.13.143','江苏省 无锡市','Vivo Browser29.0.3.1','Android13','1','登录成功','2026-05-20 19:02:14','cbcb1ed5-3112-47c6-9479-a6a099e9b605'),('7f342366-32ef-44fc-9b98-a4428d182a5e','admin','110.152.146.78','新疆 乌鲁木齐市','WeChat8.0.71.3080','Android16','1','登录成功','2026-05-14 16:14:13','4256e2c6-fc51-4614-8e01-318ca26dac1b'),('80f8e638-4e9e-401a-bee8-f3b9ef867182','admin','222.190.112.82','江苏省 南京市','Chrome139.0.0.0','macOS10.15.7','1','登录成功','2026-05-18 13:36:12','5538b0a9-6193-4f02-98e9-502efacce4ee'),('8350674c-7ccc-4109-aa55-7cc866c37504','admin','223.160.224.125','北京 北京市','Mobile Safari26.5','iOS18.7','1','登录成功','2026-05-20 19:50:58','b396cdb6-4177-4958-a546-0abd5985e940'),('8a4c0aab-5000-4b43-ab30-79398a0a1d97','admin','183.17.230.137','广东省 深圳市','Chrome148.0.0.0','Windows10','0','验证码已过期，请刷新后重试','2026-05-19 09:02:49','be927b63-8661-4288-911c-d81ae534fe50'),('8c97d51a-0276-4a7a-85b4-4e7717080125','admin','117.188.119.202','贵州省 黔东南','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-19 17:15:23','7326591c-313e-4bd3-9d51-d81506493409'),('8e5d4df6-4f0c-4f4a-8462-b2f7e396c637','admin','123.117.38.111','北京 北京市','WeChat8.0.71','iOS26.4','1','登录成功','2026-05-14 18:03:48','7c171b80-de24-4ad8-869c-db8013716bed'),('9c8fdc6b-600f-4ea4-b3bf-c5b71d4c9298','admin','183.223.222.209','四川省 成都市','Chrome147.0.0.0','macOS10.15.7','1','登录成功','2026-05-15 09:47:12','62b95102-47b6-49b1-b8c3-44d6dda478e2'),('a1560209-fdd4-4960-8109-cf0442c89447','admin','120.242.72.181','安徽省 芜湖市','Vivo Browser29.1.1.0','Android16','1','登录成功','2026-05-19 14:09:25','24425bfb-f7db-4bf3-8a71-4df95ea52269'),('a49abc4a-8aab-46b2-aee4-98a984c2d77c','admin','58.62.103.233','广东省 广州市','MIUI Browser20.17.1030507','Android16','1','登录成功','2026-05-16 00:15:49','4525eaf9-2410-4fde-a1f9-7597bb1aa65e'),('a7d4536b-2f68-4a06-8f42-3009ef5cde8e','admin','180.164.148.50','上海 上海市','Chrome147.0.0.0','macOS10.15.7','1','登录成功','2026-05-15 10:31:55','3ff195ca-b9c6-445e-9e79-0dee24fb9d1e'),('a85c5100-bc2d-4942-b509-f5949893d719','admin','183.93.52.210','湖北省 咸宁市','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-21 14:11:54','ee9af65f-c6ad-42a3-ac60-89497f2917cd'),('b74874eb-c5dc-43fa-bc07-8a27c464233b','admin','182.47.191.61','山东省 枣庄市','Edge148.0.0.0','Windows10','1','登录成功','2026-05-19 18:31:06','e99bf3b9-5b17-4296-9c0c-20664593db59'),('bc318392-d998-4d25-bd98-1967192bdefc','admin','144.48.80.237','德克萨斯 达拉斯','Chrome148.0.0.0','Windows10','1','登录成功','2026-05-19 10:52:57','382e8f4e-6b68-4c4b-b06b-7f0aa1f4315f'),('bcd11ba3-1fdb-4b8b-a8f8-09fad17f1aa7','admin','222.190.254.162','江苏省 南京市','Chrome131.0.0.0','Windows10','1','登录成功','2026-05-15 14:39:27','69c38f9a-fb46-4f98-a8e7-cafb644b72be'),('ce28fcd1-9ea8-4020-a58f-ff12ef5070c1','admin','223.72.25.45','北京 北京市','WeChat7.0.20.1781','Windows10','1','登录成功','2026-05-19 11:01:33','a0363de5-8657-441e-8657-6965be1172f6'),('d27f25f0-7aff-4d63-94af-2978850c6797','admin','111.167.210.59','天津 天津市','WeChat8.0.71.3080','Android16','1','登录成功','2026-05-14 16:15:02','98122833-1d10-4f21-9f67-fe4d825e863a'),('e38576b9-de7e-418c-8a7f-75225a330d0a','admin','116.23.223.194','广东省 广州市','Chrome148.0.0.0','macOS10.15.7','1','登录成功','2026-05-17 00:22:15','1ca97f00-abbd-4670-8ba6-762c7d8e78cd');
/*!40000 ALTER TABLE `sys_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '组件路径',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'M' COMMENT '类型（M目录 C菜单 F按钮）',
  `icon` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单图标',
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单名称',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '菜单是否可见',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '权限字符',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '数据状态',
  `menu_sort` int NOT NULL DEFAULT '1' COMMENT '显示顺序',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `is_cache` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否缓存组件',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES ('admin','admin','00536e8c-2f19-492a-9b18-d8a9ea4eadec','f66ee797-1b85-412c-a1fb-f3aa90a0387b','countdown','example/countdown/index','C','Resource','数字滚动','1',NULL,'1',8,NULL,'0','2026-05-10 18:46:50','2026-05-10 18:46:50'),('admin','admin','066ad56d-8b3d-4e18-b370-ee01e00ffc4e','0','https://ace627.github.io/guide/changelog.html',NULL,'M','External','云禾手册','1',NULL,'1',11,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','07848a5b-661b-421b-802d-2263f507a0a1','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单新增','1','system:menu:create','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','09bcd942-a1ed-49b5-9975-a8c781087398','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单删除','1','system:menu:delete','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','0f006c25-4d64-45fb-b1c6-b517d9b2cdd7','0','analysis','monitor/analysis‌/index','C','TaiChi','数据大屏','1',NULL,'1',5,NULL,'0','2026-05-14 14:30:35','2026-05-14 14:38:26'),('admin','admin','1070c20c-a25e-4dc2-ada1-67b324d47098','f66ee797-1b85-412c-a1fb-f3aa90a0387b','charts','example/charts/index','C','Resource','图表效果','1',NULL,'1',5,NULL,'0','2026-05-10 02:04:40','2026-05-10 02:04:40'),('admin','admin','11a5501d-8f7e-4ccb-87bc-aaf0c3fe37ba','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典删除','1','system:dict:delete','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','14575a54-7305-4de8-a68d-f982ed351e87','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志删除','1','monitor:logininfor:delete','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','184bd2a2-5396-4cc2-b099-fda1e1f3784d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务编辑','1','monitor:job:update','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','263b753d-6bbc-4a51-bee2-cd9795792300','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志删除','1','monitor:operlog:delete','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','276cdb30-1167-4c71-85a6-86a5a75f1e8b','d7dc7db2-bb66-484e-8f90-53d731ea5a57','online','monitor/online/index','C','Online','在线用户','1',NULL,'1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','2bd7fb00-d6ae-4444-9d69-dc833a3e725f','f66ee797-1b85-412c-a1fb-f3aa90a0387b','lazyimg','example/ImageLazyLoad','C','Image','图片懒加载','1',NULL,'1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','2d407543-5a92-4f82-b836-2643317dd918','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户编辑','1','system:user:update','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','2db234ff-ad75-4b4f-8d46-b3ea13b506b0','3c904fde-7455-437b-9657-e95629c799cd','logininfor','monitor/logininfor/index','C','Logininfor','登录日志','1',NULL,'1',5,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','322cf2b1-fab0-4bd8-bb6d-019de31e545e','f66ee797-1b85-412c-a1fb-f3aa90a0387b','signature','example/signature/index','C','Resource','手写签名板','1',NULL,'1',7,NULL,'0','2026-05-10 18:20:15','2026-05-10 18:33:06'),('admin','admin','3c904fde-7455-437b-9657-e95629c799cd','0','system',NULL,'M','Setting','系统管理','1',NULL,'1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','415a6369-6643-4f95-98da-671348ea148b','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志清空','1','monitor:operlog:clear','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','42ce5cc6-4d3c-41fe-b48f-20bac793b0d6','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色查询','1','system:role:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','4616a48c-a5a0-45d9-be0b-a9dd8f7aa7b8','f66ee797-1b85-412c-a1fb-f3aa90a0387b','upload','example/upload/index','C','Resource','大文件上传','1',NULL,'1',9,NULL,'0','2026-05-10 22:44:55','2026-05-10 22:44:55'),('admin','admin','4bd126da-978a-4198-a1c0-cdc2e7051b7d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务删除','1','monitor:job:delete','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','4c4f25fd-3037-4aee-ae9b-91edccdf7792','3c904fde-7455-437b-9657-e95629c799cd','operlog','monitor/operlog/index','C','Log','操作日志','1',NULL,'1',6,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','4c580309-c10e-42af-835b-18f0056bc06d','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志导出','1','monitor:operlog:export','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','54084b09-7f45-4c6b-b01b-0a40ef350dee','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志导出','1','monitor:logininfor:export','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','56c3547b-3270-4abc-9845-4bd9dd38bade','cd93e3ba-0c37-4d78-9997-f5be04d4feb1','prompt','resource/prompt/index','C','Tool','提示词管理','1',NULL,'1',1,NULL,'0','2026-05-12 21:57:05','2026-05-12 21:57:05'),('admin','admin','5cf5bfbb-a5d2-4fb9-8c71-47c2d01936bb','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志查询','1','monitor:operlog:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','5ddd2884-3d0c-43a0-abfb-4b0efac62d30','d7dc7db2-bb66-484e-8f90-53d731ea5a57','job','monitor/job/index','C','Schedule','定时任务','1',NULL,'1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','605e8a35-795d-45b7-94b1-cde26608224d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务新增','1','monitor:job:create','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','645995d5-ba47-4b2e-9c96-23d018e46ba3','d7dc7db2-bb66-484e-8f90-53d731ea5a57','cache/list','monitor/cache/list','C','CacheList','缓存列表','1',NULL,'1',5,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','6965f4e0-7037-4efa-b985-88ca239cb486','56c3547b-3270-4abc-9845-4bd9dd38bade',NULL,NULL,'F',NULL,'提示词新增','1','resource:prompt:create','1',2,NULL,'0','2026-05-12 22:01:53','2026-05-12 22:01:53'),('admin','admin','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066','3c904fde-7455-437b-9657-e95629c799cd','dict','system/dict/index','C','Dict','字典管理','1',NULL,'1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','75314fe5-9de0-4d06-a64e-e1a2acda4cab','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户删除','1','system:user:delete','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','7600becb-6fc6-4867-860b-8132b47c0082','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色新增','1','system:role:create','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','7ade8b4f-dc87-4406-826f-be66a253f971','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典新增','1','system:dict:create','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','7d96b222-688a-4f22-967f-658f828efdab','56c3547b-3270-4abc-9845-4bd9dd38bade',NULL,NULL,'F',NULL,'提示词编辑','1','resource:prompt:update','1',3,NULL,'0','2026-05-12 22:02:27','2026-05-12 22:02:27'),('admin','admin','83e4eecf-5ef2-461f-9943-8ff7e4600656','f66ee797-1b85-412c-a1fb-f3aa90a0387b','taichi','example/TaiChi','C','TaiChi','旋转太极图','1',NULL,'1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','868a41a9-4b98-4c61-bdfa-830000dec5d9','d7dc7db2-bb66-484e-8f90-53d731ea5a57','server','monitor/server/index','C','Server','服务监控','1',NULL,'1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','882e9eb0-6bab-4981-b7b2-0525b1bd83e7','56c3547b-3270-4abc-9845-4bd9dd38bade',NULL,NULL,'F',NULL,'提示词删除','1','resource:prompt:delete','1',4,NULL,'0','2026-05-12 22:02:40','2026-05-12 22:02:40'),('admin','admin','8eada0a9-ddbe-4c07-974c-e8e90f60effe','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典查询','1','system:dict:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','9c13033c-860e-4b1a-b7c8-775286c2c531','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典编辑','1','system:dict:update','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','a008effd-4b39-415b-a89a-6cbb2602280f','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色编辑','1','system:role:update','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','aaa92de8-0e3f-40ce-b18b-932b42e83241','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色删除','1','system:role:delete','1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','adb1be50-5017-4c30-a536-fc0d5b53904a','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志查询','1','monitor:logininfor:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','b254fc65-60a6-4f74-8bf6-345c23000ba3','3c904fde-7455-437b-9657-e95629c799cd','user','system/user/index','C','User','用户管理','1',NULL,'1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','ba46fe67-c503-4edc-a598-e757a4205027','276cdb30-1167-4c71-85a6-86a5a75f1e8b',NULL,NULL,'F',NULL,'在线用户强退','1','monitor:online:forceLogout','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','bad67e55-576c-452b-85af-16ddf43328d0','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志清空','1','monitor:logininfor:clear','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','bafe0cf3-0ef3-4cb6-9042-0d7e7eef72bc','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单查询','1','system:menu:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','bbe5d132-8bf0-4d9f-ba20-d739f638a449','f66ee797-1b85-412c-a1fb-f3aa90a0387b','markdown','example/Markdown','C','Markdown','Markdown','1',NULL,'1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','c0bb9842-2a96-471c-933a-139f7cbfa5ad','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单编辑','1','system:menu:update','1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','c74ed01b-7db5-4512-9eca-75d5e3c5541f','0','ai/chat','ai/index','C','ChatGPT','AI 聊天','1',NULL,'1',0,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','c83c49c9-b1ef-4c55-8cc0-fe25efbf8e41','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户查询','1','system:user:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','ca76a64f-e632-42a9-aada-74a51524c31e','3c904fde-7455-437b-9657-e95629c799cd','icon','system/icon/index','C','Earth','图标管理','1',NULL,'1',9,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','cd93e3ba-0c37-4d78-9997-f5be04d4feb1','0','resource',NULL,'M','Resource','资源管理','1',NULL,'1',4,NULL,'0','2026-05-12 21:55:41','2026-05-12 21:55:41'),('admin','admin','d7dc7db2-bb66-484e-8f90-53d731ea5a57','0','monitor',NULL,'M','Monitor','系统监控','1',NULL,'1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','d94e39b2-a6b8-4df8-a39c-dd7bd2ae33a2','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务清空','1','monitor:job:clear','1',5,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','e7b367dd-61ab-465d-8c6f-bf8819bbdde3','3c904fde-7455-437b-9657-e95629c799cd','role','system/role/index','C','Role','角色管理','1',NULL,'1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','ea3ed9fc-1f59-4c97-8079-daf5fb65314f','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户新增','1','system:user:create','1',2,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','ea7e2806-db22-4833-81f0-6f422ad609fe','f66ee797-1b85-412c-a1fb-f3aa90a0387b','watermark','example/watermark/index','C','Resource','水印效果','1',NULL,'1',6,NULL,'0','2026-05-10 17:34:56','2026-05-10 17:34:56'),('admin','admin','f0b63715-59e7-4143-abcf-28c1adc8b0b1','276cdb30-1167-4c71-85a6-86a5a75f1e8b',NULL,NULL,'F',NULL,'在线用户查询','1','monitor:online:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','f1a5d7b6-86e4-408a-a2f1-7e08a1472058','3c904fde-7455-437b-9657-e95629c799cd','menu','system/menu/index','C','Menu','菜单管理','1',NULL,'1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','f3444f24-e563-41a6-a97f-5424d505bdbb','d7dc7db2-bb66-484e-8f90-53d731ea5a57','cache','monitor/cache/index','C','Redis','缓存监控','1',NULL,'1',4,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','f3452a65-bbbc-45af-9238-06be503a7ec7','56c3547b-3270-4abc-9845-4bd9dd38bade',NULL,NULL,'F',NULL,'提示词查询','1','resource:prompt:query','1',1,NULL,'0','2026-05-12 22:01:23','2026-05-12 22:01:23'),('admin','admin','f658497c-8b02-46eb-98c3-4fdaca5b9eaa','f66ee797-1b85-412c-a1fb-f3aa90a0387b','price','example/price/index','C','Resource','定价卡片','1',NULL,'1',4,NULL,'0','2026-05-09 23:57:32','2026-05-09 23:57:32'),('admin','admin','f66ee797-1b85-412c-a1fb-f3aa90a0387b','0','example',NULL,'M','Resource','效果案例','1',NULL,'1',3,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','fc2bc127-fac7-4511-9707-2d6fc51d68a5','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务导出','1','monitor:job:export','1',6,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20'),('admin','admin','fcc64755-3d18-4c8a-ae5d-4b95134e914f','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务查询','1','monitor:job:query','1',1,NULL,'0','2026-05-09 23:15:20','2026-05-09 23:15:20');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模块标题',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作人员',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '方法名称',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求方式',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '请求参数',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求接口',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求IP',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求地址',
  `businessType` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '操作类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '操作状态',
  `oper_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求时间',
  `duration` int DEFAULT NULL COMMENT '请求耗时',
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色编码',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_sort` int NOT NULL DEFAULT '1' COMMENT '角色排序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_fd8cc60f0258a8d5948141d98e` (`role_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('admin','admin','060999e4-ae01-47a8-a0a1-d32b96490e92','admin','系统管理员',1,'1','最高权限','2026-05-09 23:15:19','2026-05-09 23:15:19'),('admin','admin','a6967a5d-d645-48c5-a175-eaa5fb6ba25d','common','普通角色',2,'1','普通角色','2026-05-09 23:15:19','2026-05-09 23:15:19');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `IDX_b65fa84413c357d7282153b4a8` (`role_id`) USING BTREE,
  KEY `IDX_543ffcaa38d767909d9022f252` (`menu_id`) USING BTREE,
  CONSTRAINT `FK_543ffcaa38d767909d9022f2522` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_b65fa84413c357d7282153b4a88` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES ('a6967a5d-d645-48c5-a175-eaa5fb6ba25d','2bd7fb00-d6ae-4444-9d69-dc833a3e725f'),('a6967a5d-d645-48c5-a175-eaa5fb6ba25d','83e4eecf-5ef2-461f-9943-8ff7e4600656'),('a6967a5d-d645-48c5-a175-eaa5fb6ba25d','f66ee797-1b85-412c-a1fb-f3aa90a0387b');
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `age` int DEFAULT NULL COMMENT '年龄',
  `login_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最后登录时间',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '2' COMMENT '性别',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_9e7164b2f1ea1348bc0eb0a7da` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('admin','admin','866b0232-507b-42a4-bdc1-47fc4a83616a','admin','$argon2id$v=19$m=65536,t=3,p=4$inTpzf3epiqXwcjgXNNYww$dvIFM+MCgd1oFE5z2XS14KgNct4KrMrtgla+BwOtfwo','18888888888','188@163.com','1',NULL,'2026-05-22 17:29:23','祂','2','系统管理员','2026-05-09 23:15:20','2026-05-22 17:29:23'),('admin','admin','f93176b9-6cc6-4e5a-addc-53257113c383','test','$argon2id$v=19$m=65536,t=3,p=4$7pkc53QbbZg+JCpl+vryVQ$ah5MxOYhytw9jcaQHmGhWZ5TT8KXB+EJLlHDxxAD+ak','19999999999','19999999999@126.com','1',18,NULL,'测试','1','测试角色','2026-05-09 23:15:20','2026-05-09 23:15:20');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `IDX_71b4edf9aedbd3e5707156e80a` (`user_id`) USING BTREE,
  KEY `IDX_e8300bfcf561ed417f5f02c677` (`role_id`) USING BTREE,
  CONSTRAINT `FK_71b4edf9aedbd3e5707156e80a2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_e8300bfcf561ed417f5f02c6776` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES ('866b0232-507b-42a4-bdc1-47fc4a83616a','060999e4-ae01-47a8-a0a1-d32b96490e92'),('f93176b9-6cc6-4e5a-addc-53257113c383','a6967a5d-d645-48c5-a175-eaa5fb6ba25d');
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-22 18:16:06
