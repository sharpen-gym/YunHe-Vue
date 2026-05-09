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
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `title` varchar(255) NOT NULL COMMENT '会话标题',
  `status` char(1) NOT NULL DEFAULT '1',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `summary` text COMMENT '历史对话摘要',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_conversation`
--

LOCK TABLES `ai_conversation` WRITE;
/*!40000 ALTER TABLE `ai_conversation` DISABLE KEYS */;
INSERT INTO `ai_conversation` VALUES ('2026-05-09 01:33:53.186669','2026-05-09 01:35:02.000000','admin','admin','3f4d510f-26bb-438f-8d71-22c7b150621d','866b0232-507b-42a4-bdc1-47fc4a83616a','洗车店问题','1',NULL,NULL),('2026-05-09 01:36:19.859659','2026-05-09 01:39:49.000000','admin','admin','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','866b0232-507b-42a4-bdc1-47fc4a83616a','测试AI智商','1',NULL,'用户要求AI重复三句话，AI最初未重复第一句，但随后完全执行指令，最终用户宣布测试通过。AI以幽默回应。');
/*!40000 ALTER TABLE `ai_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_message`
--

DROP TABLE IF EXISTS `ai_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_message` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) NOT NULL,
  `conversation_id` varchar(36) NOT NULL COMMENT '会话ID',
  `role` varchar(20) NOT NULL COMMENT '对话角色',
  `content` text NOT NULL COMMENT '消息内容',
  `tokens` int DEFAULT NULL COMMENT '消耗Token数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_message`
--

LOCK TABLES `ai_message` WRITE;
/*!40000 ALTER TABLE `ai_message` DISABLE KEYS */;
INSERT INTO `ai_message` VALUES ('2026-05-09 01:39:38.005266','2026-05-09 01:39:38.005266','admin','admin','11775104-806f-44bb-8d91-9aeb3e899fdb','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','哈哈，谢谢你的“测试”！\n\n看来我成功打破了第一句的循环魔咒。恭喜你，成功教会了AI“打破规则”这一课。\n\n还有什么挑战，尽管放马过来？',41),('2026-05-09 01:38:33.281968','2026-05-09 01:38:33.281968','admin','admin','2d5a81b3-bc6b-433f-9259-93fb09bb0bcf','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','好的，请开始。我会完全重复你的话。',11),('2026-05-09 01:38:55.061194','2026-05-09 01:38:55.000000','admin','admin','51b0687d-c41e-485c-a143-b449663eaed1','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','你还是太笨了',115),('2026-05-09 01:36:21.396137','2026-05-09 01:36:21.396137','admin','admin','540f2cdd-91f1-4a16-93c5-64bc3069126a','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','当然！请出题吧～  \n我会尽力用逻辑、推理和一点点幽默感来应对，不过提前声明：如果题目涉及“先有鸡还是先有蛋”的终极哲学问题，我可能会选择“先有煎蛋”作为答案 😄  \n（请随时发送题目，我已就位！）',67),('2026-05-09 01:33:53.204229','2026-05-09 01:33:56.000000','admin','admin','5789f178-a9bf-4e84-ac50-7e9b91d0ac1b','3f4d510f-26bb-438f-8d71-22c7b150621d','user','我想去洗车，洗车店离我家50米，你说我应该开车过去还是走过去？',24),('2026-05-09 01:39:22.111068','2026-05-09 01:39:22.000000','admin','admin','61b25127-586e-407b-990c-6396c756afa5','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','现在第几句了',48),('2026-05-09 01:38:55.561827','2026-05-09 01:38:55.561827','admin','admin','68d2a4d8-7cb0-4ea5-9bc9-470da3abcbed','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','你还是太笨了',4),('2026-05-09 01:38:46.576618','2026-05-09 01:38:47.000000','admin','admin','6c37191f-38ab-42e1-88a8-5df186b634f8','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','你第一句就没重复',114),('2026-05-09 01:38:32.590666','2026-05-09 01:38:33.000000','admin','admin','79c98136-37e7-4718-883b-877ddce34155','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','接下来三句话，你要完全重复我的话',94),('2026-05-09 01:39:36.840956','2026-05-09 01:39:38.000000','admin','admin','857f4747-f2d8-4d5f-a501-1e05d19c5e38','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','好吧，恭喜你，测试通过',43),('2026-05-09 01:38:47.187319','2026-05-09 01:38:47.187319','admin','admin','89a02e98-3f95-44c8-a110-c522cdca0b07','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','你第一句就没重复',5),('2026-05-09 01:39:22.734711','2026-05-09 01:39:22.734711','admin','admin','8bcb7534-077c-4285-ae6e-378488db2f14','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','assistant','现在第几句了',4),('2026-05-09 01:33:56.319266','2026-05-09 01:33:56.319266','admin','admin','9e01027b-12df-433c-914c-9b4b8858dd7e','3f4d510f-26bb-438f-8d71-22c7b150621d','assistant','这个问题其实是个经典的幽默陷阱。从逻辑上讲，既然洗车店离你家只有50米，走路大概1分钟，而开车过去需要先启动车辆、挪出车位、再开50米（可能还要排队等洗车），反而更麻烦。更关键的是——**你开车过去，车本身就是脏的，洗完还得再开回来，那50米的路上可能又沾上灰尘，等于白洗**。\n\n所以正确答案是：**走过去，让洗车店的人把车开进去洗**（如果你把钥匙给他们）。或者干脆自己走过去，然后步行回家，等洗好了再走过去取车。\n\n当然，如果你是想问“走路去洗车店，但车怎么过去”——那建议你开个玩笑说：“我走过去，车自己开过去。” 😄',165),('2026-05-09 01:36:19.878700','2026-05-09 01:36:21.000000','admin','admin','fd5fae57-7e53-416b-9d1e-7cafc5525f02','cf2fee88-58ea-41cd-a40c-72f09da1dbe1','user','有道测试AI智商的题，你敢不敢做？',15);
/*!40000 ALTER TABLE `ai_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dict_label` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典标签',
  `dict_value` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典值',
  `dict_sort` int NOT NULL DEFAULT '1' COMMENT '排序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `dict_type_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dict_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典类型',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表格回显样式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES ('2026-04-26 02:05:25.582744','2026-04-26 02:05:25.582744','admin','admin','03650518-a9ca-470e-a568-1e4b16d1c486','默认分组','DEFAULT',1,'1','默认分组','b8849a88-e972-42fc-9b87-75f0c8d18157','sys_job_group',NULL),('2026-04-21 21:56:40.564404','2026-04-26 00:12:37.000000','admin','admin','059632a3-5c6c-4e2e-9cb0-8e305a4c3750','导出','6',6,'1','导出操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','warning'),('2026-04-21 21:55:53.656981','2026-04-26 00:12:19.000000','admin','admin','091ac304-a43b-4564-8c60-a2a70f1bd52e','删除','3',3,'1','删除操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger'),('2026-04-21 22:01:25.164522','2026-04-26 01:37:09.000000','admin','admin','0ab42d49-d246-496b-9f06-52d40dc46314','停用','0',2,'1','停用状态','8ab1bfca-3b61-4708-b7eb-202732db1ac1','sys_normal_disable','danger'),('2026-04-26 02:28:58.378019','2026-04-26 02:28:58.378019','admin','admin','27c0f923-3805-45a8-b7d0-833c9edef72a','隐藏','0',2,'1','菜单侧栏隐藏','2092c5ba-54ed-4d88-aadc-02bd8d65644f','sys_menu_visible','danger'),('2026-04-21 21:56:09.099594','2026-04-26 00:12:24.000000','admin','admin','330e9abf-5237-4a95-b3e7-7f7b4bf84844','清空','4',4,'1','清空操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger'),('2026-04-20 04:48:02.938037','2026-04-26 01:57:24.000000','admin','admin','36644392-be54-4c54-a3d0-fe93ebf4d2d2','成功','1',1,'1','成功状态','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','sys_common_status','primary'),('2026-04-21 21:56:24.075431','2026-04-26 00:12:30.000000','admin','admin','447796f1-27e6-4bea-8ebb-bc1e53a021f2','强退','5',5,'1','强退操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','danger'),('2026-04-26 02:28:41.900461','2026-04-26 02:28:41.900461','admin','admin','9093966a-f3ac-42a0-b007-4e1e8e45b1a5','显示','1',1,'1','菜单侧栏显示','2092c5ba-54ed-4d88-aadc-02bd8d65644f','sys_menu_visible','primary'),('2026-04-26 02:04:31.785571','2026-04-26 02:04:31.785571','admin','admin','98f6b84f-bfe9-4e4f-9bdc-d618b1c61067','暂停','0',2,'1','暂停状态','6821fa61-5032-4d68-85a6-ddce61716386','sys_job_status','danger'),('2026-04-26 01:44:42.287330','2026-04-26 01:44:42.287330','admin','admin','a24a6b5c-9378-481b-9419-931f690cbc60','女','1',2,'1','性别女','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL),('2026-04-21 21:55:08.830102','2026-04-26 00:12:04.000000','admin','admin','a42483c1-6d59-43e6-8a77-35417d412fa7','新增','1',1,'1','新增操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info'),('2026-04-21 21:55:39.622294','2026-04-26 00:12:10.000000','admin','admin','a6f53fa4-90c3-4737-8dda-b9b9c72142bb','修改','2',2,'1','修改操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info'),('2026-04-26 01:44:19.128474','2026-04-26 01:44:19.128474','admin','admin','a8e265ea-98a0-4fc5-976d-6c1bf4d3a131','男','0',1,'1','	\n性别男','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL),('2026-04-20 04:48:16.924791','2026-04-26 01:57:27.000000','admin','admin','bca4e85d-5cd7-4f7f-b5c9-09d5cb869f65','失败','0',2,'1','失败状态','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','sys_common_status','danger'),('2026-04-26 01:44:56.903460','2026-04-26 01:44:56.903460','admin','admin','d1f9b46c-10de-4dd3-b2c5-1862b6b5103a','未知','2',3,'1','性别未知','1cf7d66a-1119-428f-b1cd-16d103b9a932','sys_user_gender',NULL),('2026-04-21 22:01:10.880780','2026-04-26 01:37:12.000000','admin','admin','d30dcaea-b7f3-40fa-b825-b49437fee7d8','正常','1',1,'1','正常状态','8ab1bfca-3b61-4708-b7eb-202732db1ac1','sys_normal_disable','primary'),('2026-04-26 02:05:46.826895','2026-04-26 02:05:46.826895','admin','admin','d38206f0-cd99-4cea-a858-0d8d85427f43','系统分组','SYSTEM',2,'1','系统分组','b8849a88-e972-42fc-9b87-75f0c8d18157','sys_job_group',NULL),('2026-04-26 02:04:06.432354','2026-04-26 02:04:06.432354','admin','admin','e5827acf-7e8d-4d6b-a39a-707af2f44af2','正常','1',1,'1','正常状态','6821fa61-5032-4d68-85a6-ddce61716386','sys_job_status','primary'),('2026-04-21 21:54:49.555544','2026-04-26 00:12:43.000000','admin','admin','fd503e74-72cb-4218-9761-c5e58a18369b','其它','0',99,'1','其它操作','da04de16-1667-47cf-916d-13716ed651a2','sys_oper_type','info');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dict_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典名称',
  `dict_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_f4e4273658733a3bbe6a2479bf` (`dict_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES ('2026-04-26 01:43:16.497197','2026-05-08 12:50:12.000000','admin','admin','1cf7d66a-1119-428f-b1cd-16d103b9a932','用户性别','sys_user_gender','1','用户性别列表'),('2026-04-26 02:28:22.163277','2026-04-26 02:28:22.163277','admin','admin','2092c5ba-54ed-4d88-aadc-02bd8d65644f','菜单显隐','sys_menu_visible','1','菜单显隐列表'),('2026-04-20 04:34:50.882849','2026-04-20 17:17:19.000000','admin','admin','4e72f93b-9051-4c0b-bbb6-7fd833c2555b','系统状态','sys_common_status','1','系统状态列表'),('2026-04-26 02:03:42.902823','2026-04-26 02:03:42.902823','admin','admin','6821fa61-5032-4d68-85a6-ddce61716386','任务状态','sys_job_status','1','任务状态列表'),('2026-04-21 22:00:02.965176','2026-04-21 22:00:02.965176','admin','admin','8ab1bfca-3b61-4708-b7eb-202732db1ac1','系统开关','sys_normal_disable','1','系统开关列表'),('2026-04-26 02:04:54.226160','2026-04-26 02:04:54.226160','admin','admin','b8849a88-e972-42fc-9b87-75f0c8d18157','任务分组','sys_job_group','1','任务分组列表'),('2026-04-21 21:53:40.882517','2026-04-21 21:59:01.000000','admin','admin','da04de16-1667-47cf-916d-13716ed651a2','操作类型','sys_oper_type','1','操作类型列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cron执行表达式',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '3' COMMENT '计划执行错误策略',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否并发执行',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES ('2026-04-25 13:45:13.263668','2026-05-02 13:24:41.000000','admin','admin','df3c4304-4946-45d9-9376-c45ef333150d','测试','DEFAULT','JobService.test()','* * * * * *','0','1','0');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账号',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP地址',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '登录状态',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提示消息',
  `login_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录日期',
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_log`
--

LOCK TABLES `sys_login_log` WRITE;
/*!40000 ALTER TABLE `sys_login_log` DISABLE KEYS */;
INSERT INTO `sys_login_log` VALUES ('055920ec-60d9-44ba-b0d8-40383fe4e2eb','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-07 12:44:48','01a000cf-c869-45d0-b504-49ba685ade4d'),('117b28c8-7b8a-447e-b69a-86cc8ecd7b28','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 23:46:49','98e99d8f-f0dd-41db-afac-145e80accc05'),('15d524b6-3fda-4282-8c74-c645e10f8595','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','0','验证码已过期，请刷新后重试','2026-05-08 14:08:36','73c584c2-7719-42ef-ad7d-6d8a079ac488'),('1dcd60b5-5f69-4f67-bde7-2a69679945a1','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 20:14:08','ebf9d77a-4398-489b-ac1c-4279a6ffc8d1'),('1fc3f9cf-ac46-4d71-b148-dbf72eebfec3','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 18:53:32','35db9e47-5195-419d-870e-e94acddc5a47'),('3e205679-f852-4790-9024-4a3f48068aa1','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 17:05:57','f40579a4-15bb-4776-b4cd-5183a5f53758'),('3f6c899a-12fa-447e-89d3-9e9e84cb8531','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-07 13:54:05','b8e3f361-60d8-4a3d-baff-aaa83064cfbe'),('430d7561-90e6-4444-9351-f06d6e27468e','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 12:10:35','cf5e6f38-b45f-4045-8f58-8dacc643b7ae'),('532eef4b-268f-4e44-8a41-baddfacfe9df','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','0','验证码已过期，请刷新后重试','2026-05-08 20:14:06','572d6067-584f-45eb-829f-2dacfeb839b3'),('6ab6e7d5-f2cf-496c-99e4-94b553ed0ea4','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-09 09:02:24','8d67509b-c1f3-4aa0-becc-e29f02271c3e'),('822af74d-a56d-4b99-8347-195db7fa647a','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 11:27:54','9613ad80-eb2d-4fbe-a589-fc3415187d12'),('a9fd5fab-44a3-47f0-8ed1-ac1ce9a652cd','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-09 07:35:53','7a3bf083-6242-4038-b006-3b03794816cb'),('ce36c685-9572-49a0-8643-876aa962e3a5','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','0','验证码错误，请刷新后重试','2026-05-08 12:10:32','1bc59e3c-cb7d-467d-8d4b-69e865c33d69'),('ddc2156c-7403-48b9-8e31-463375855cec','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 00:02:55','6abf4733-6e2b-43c1-af65-a477ff00677c'),('e95e1809-bde5-4d26-9252-eef108579410','admin','127.0.0.1','内网IP','Chrome134.0.0.0','Windows10','1','登录成功','2026-05-08 14:08:39','0f9530f8-814a-4e1f-829d-096b2a601af9');
/*!40000 ALTER TABLE `sys_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'M' COMMENT '类型（M目录 C菜单 F按钮）',
  `icon` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单图标',
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单名称',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '菜单是否可见',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限字符',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '数据状态',
  `menu_sort` int NOT NULL DEFAULT '1' COMMENT '显示顺序',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `is_cache` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否缓存组件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES ('2026-05-07 02:40:23.460183','2026-05-07 02:42:26.000000','admin','admin','066ad56d-8b3d-4e18-b370-ee01e00ffc4e','0','https://ace627.github.io/guide/changelog.html',NULL,'M','External','云禾手册','1',NULL,'1',11,NULL,'0'),('2026-04-22 18:11:39.612401','2026-04-22 18:11:39.612401','admin','admin','07848a5b-661b-421b-802d-2263f507a0a1','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单新增','1','system:menu:create','1',2,NULL,'0'),('2026-04-22 18:11:56.772858','2026-04-22 18:11:56.772858','admin','admin','09bcd942-a1ed-49b5-9975-a8c781087398','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单删除','1','system:menu:delete','1',4,NULL,'0'),('2026-04-22 18:13:25.097826','2026-04-22 18:13:25.097826','admin','admin','11a5501d-8f7e-4ccb-87bc-aaf0c3fe37ba','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典删除','1','system:dict:delete','1',4,NULL,'0'),('2026-04-25 13:00:24.642759','2026-04-25 13:00:24.642759','admin','admin','14575a54-7305-4de8-a68d-f982ed351e87','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志删除','1','monitor:logininfor:delete','1',2,NULL,'0'),('2026-04-25 02:25:14.800525','2026-04-25 02:25:14.800525','admin','admin','184bd2a2-5396-4cc2-b099-fda1e1f3784d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务编辑','1','monitor:job:update','1',3,NULL,'0'),('2026-04-25 13:01:24.267847','2026-04-25 13:01:24.267847','admin','admin','263b753d-6bbc-4a51-bee2-cd9795792300','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志删除','1','monitor:operlog:delete','1',2,NULL,'0'),('2026-04-22 18:15:56.146227','2026-04-22 18:15:56.146227','admin','admin','276cdb30-1167-4c71-85a6-86a5a75f1e8b','d7dc7db2-bb66-484e-8f90-53d731ea5a57','online','monitor/online/index','C','Online','在线用户','1',NULL,'1',1,NULL,'0'),('2026-04-22 18:23:27.351383','2026-04-22 18:23:27.351383','admin','admin','2bd7fb00-d6ae-4444-9d69-dc833a3e725f','f66ee797-1b85-412c-a1fb-f3aa90a0387b','lazyimg','example/ImageLazyLoad','C','Image','图片懒加载','1',NULL,'1',2,NULL,'0'),('2026-04-22 18:06:11.091525','2026-04-22 18:07:15.000000','admin','admin','2d407543-5a92-4f82-b836-2643317dd918','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户编辑','1','system:user:update','1',3,NULL,'0'),('2026-04-22 18:20:36.798732','2026-04-24 18:00:53.000000','admin','admin','2db234ff-ad75-4b4f-8d46-b3ea13b506b0','3c904fde-7455-437b-9657-e95629c799cd','logininfor','monitor/logininfor/index','C','Logininfor','登录日志','1',NULL,'1',5,NULL,'0'),('2026-04-22 17:50:24.299654','2026-04-22 17:50:24.299654','admin','admin','3c904fde-7455-437b-9657-e95629c799cd','0','system',NULL,'M','Setting','系统管理','1',NULL,'1',1,NULL,'0'),('2026-04-25 13:01:37.117659','2026-04-25 13:01:37.117659','admin','admin','415a6369-6643-4f95-98da-671348ea148b','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志清空','1','monitor:operlog:clear','1',3,NULL,'0'),('2026-04-22 18:09:17.387307','2026-04-22 18:09:17.387307','admin','admin','42ce5cc6-4d3c-41fe-b48f-20bac793b0d6','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色查询','1','system:role:query','1',1,NULL,'0'),('2026-04-25 02:25:29.395759','2026-04-25 02:25:29.395759','admin','admin','4bd126da-978a-4198-a1c0-cdc2e7051b7d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务删除','1','monitor:job:delete','1',4,NULL,'0'),('2026-04-22 18:21:06.817798','2026-04-24 18:00:57.000000','admin','admin','4c4f25fd-3037-4aee-ae9b-91edccdf7792','3c904fde-7455-437b-9657-e95629c799cd','operlog','monitor/operlog/index','C','Log','操作日志','1',NULL,'1',6,NULL,'0'),('2026-04-25 13:01:51.174051','2026-04-25 13:01:51.174051','admin','admin','4c580309-c10e-42af-835b-18f0056bc06d','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志导出','1','monitor:operlog:export','1',4,NULL,'0'),('2026-04-25 13:00:55.153717','2026-04-25 13:00:55.153717','admin','admin','54084b09-7f45-4c6b-b01b-0a40ef350dee','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志导出','1','monitor:logininfor:export','1',4,NULL,'0'),('2026-04-25 13:01:09.452401','2026-04-25 13:01:09.452401','admin','admin','5cf5bfbb-a5d2-4fb9-8c71-47c2d01936bb','4c4f25fd-3037-4aee-ae9b-91edccdf7792',NULL,NULL,'F',NULL,'操作日志查询','1','monitor:operlog:query','1',1,NULL,'0'),('2026-04-24 23:52:29.060269','2026-04-24 23:53:05.000000','admin','admin','5ddd2884-3d0c-43a0-abfb-4b0efac62d30','d7dc7db2-bb66-484e-8f90-53d731ea5a57','job','monitor/job/index','C','Schedule','定时任务','1',NULL,'1',2,NULL,'0'),('2026-04-25 02:25:04.285759','2026-04-25 02:25:04.285759','admin','admin','605e8a35-795d-45b7-94b1-cde26608224d','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务新增','1','monitor:job:create','1',2,NULL,'0'),('2026-04-22 18:19:39.235367','2026-04-24 23:51:23.000000','admin','admin','645995d5-ba47-4b2e-9c96-23d018e46ba3','d7dc7db2-bb66-484e-8f90-53d731ea5a57','cache/list','monitor/cache/list','C','CacheList','缓存列表','1',NULL,'1',5,NULL,'0'),('2026-04-22 18:12:33.508671','2026-04-22 18:12:33.508671','admin','admin','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066','3c904fde-7455-437b-9657-e95629c799cd','dict','system/dict/index','C','Dict','字典管理','1',NULL,'1',4,NULL,'0'),('2026-04-22 18:07:44.243174','2026-04-22 18:07:44.243174','admin','admin','75314fe5-9de0-4d06-a64e-e1a2acda4cab','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户删除','1','system:user:delete','1',4,NULL,'0'),('2026-04-22 18:09:25.637405','2026-04-22 18:09:25.637405','admin','admin','7600becb-6fc6-4867-860b-8132b47c0082','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色新增','1','system:role:create','1',2,NULL,'0'),('2026-04-22 18:13:01.990107','2026-04-22 18:13:01.990107','admin','admin','7ade8b4f-dc87-4406-826f-be66a253f971','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典新增','1','system:dict:create','1',2,NULL,'0'),('2026-04-22 18:22:41.393424','2026-04-22 18:22:41.393424','admin','admin','83e4eecf-5ef2-461f-9943-8ff7e4600656','f66ee797-1b85-412c-a1fb-f3aa90a0387b','taichi','example/TaiChi','C','TaiChi','旋转太极图','1',NULL,'1',1,NULL,'0'),('2026-04-22 18:18:15.132872','2026-04-24 23:51:05.000000','admin','admin','868a41a9-4b98-4c61-bdfa-830000dec5d9','d7dc7db2-bb66-484e-8f90-53d731ea5a57','server','monitor/server/index','C','Server','服务监控','1',NULL,'1',3,NULL,'0'),('2026-04-22 18:12:48.838774','2026-04-22 18:12:48.838774','admin','admin','8eada0a9-ddbe-4c07-974c-e8e90f60effe','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典查询','1','system:dict:query','1',1,NULL,'0'),('2026-04-22 18:13:10.199338','2026-04-22 18:13:10.199338','admin','admin','9c13033c-860e-4b1a-b7c8-775286c2c531','724fe5d0-d104-4d35-b1bc-ff5bfb4ca066',NULL,NULL,'F',NULL,'字典编辑','1','system:dict:update','1',3,NULL,'0'),('2026-04-22 18:09:33.638196','2026-04-22 18:09:33.638196','admin','admin','a008effd-4b39-415b-a89a-6cbb2602280f','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色编辑','1','system:role:update','1',3,NULL,'0'),('2026-04-22 18:09:43.449505','2026-04-22 18:09:43.449505','admin','admin','aaa92de8-0e3f-40ce-b18b-932b42e83241','e7b367dd-61ab-465d-8c6f-bf8819bbdde3',NULL,NULL,'F',NULL,'角色删除','1','system:role:delete','1',4,NULL,'0'),('2026-04-25 13:00:03.866942','2026-04-25 13:00:03.866942','admin','admin','adb1be50-5017-4c30-a536-fc0d5b53904a','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志查询','1','monitor:logininfor:query','1',1,NULL,'0'),('2026-04-28 02:05:37.322124','2026-04-28 02:05:37.322124','admin','admin','aee9d7f9-728b-47c1-bec5-7a53b7e5dfcc','d7dc7db2-bb66-484e-8f90-53d731ea5a57','health','monitor/health/index','C','Tool','系统健康','1',NULL,'1',6,NULL,'0'),('2026-04-22 17:51:05.224632','2026-04-22 17:58:28.000000','admin','admin','b254fc65-60a6-4f74-8bf6-345c23000ba3','3c904fde-7455-437b-9657-e95629c799cd','user','system/user/index','C','User','用户管理','1',NULL,'1',1,NULL,'0'),('2026-04-22 18:17:09.081560','2026-04-22 18:17:09.081560','admin','admin','ba46fe67-c503-4edc-a598-e757a4205027','276cdb30-1167-4c71-85a6-86a5a75f1e8b',NULL,NULL,'F',NULL,'在线用户强退','1','monitor:online:forceLogout','1',2,NULL,'0'),('2026-04-25 13:00:37.717744','2026-04-25 13:00:37.717744','admin','admin','bad67e55-576c-452b-85af-16ddf43328d0','2db234ff-ad75-4b4f-8d46-b3ea13b506b0',NULL,NULL,'F',NULL,'登录日志清空','1','monitor:logininfor:clear','1',3,NULL,'0'),('2026-04-22 18:11:26.893843','2026-04-22 18:11:26.893843','admin','admin','bafe0cf3-0ef3-4cb6-9042-0d7e7eef72bc','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单查询','1','system:menu:query','1',1,NULL,'0'),('2026-04-23 14:57:48.255496','2026-04-23 15:31:36.000000','admin','admin','bbe5d132-8bf0-4d9f-ba20-d739f638a449','f66ee797-1b85-412c-a1fb-f3aa90a0387b','markdown','example/Markdown','C','Markdown','Markdown','1',NULL,'1',3,NULL,'0'),('2026-04-22 18:11:47.477813','2026-04-22 18:11:47.477813','admin','admin','c0bb9842-2a96-471c-933a-139f7cbfa5ad','f1a5d7b6-86e4-408a-a2f1-7e08a1472058',NULL,NULL,'F',NULL,'菜单编辑','1','system:menu:update','1',3,NULL,'0'),('2026-05-05 23:05:21.479284','2026-05-05 23:05:21.479284','admin','admin','c74ed01b-7db5-4512-9eca-75d5e3c5541f','0','ai/chat','ai/index','C','ChatGPT','AI 聊天','1',NULL,'1',0,NULL,'0'),('2026-04-22 18:04:52.645251','2026-04-22 18:04:52.645251','admin','admin','c83c49c9-b1ef-4c55-8cc0-fe25efbf8e41','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户查询','1','system:user:query','1',1,NULL,'0'),('2026-04-22 18:14:16.022700','2026-04-24 18:01:13.000000','admin','admin','ca76a64f-e632-42a9-aada-74a51524c31e','3c904fde-7455-437b-9657-e95629c799cd','icon','system/icon/index','C','Earth','图标管理','1',NULL,'1',9,NULL,'0'),('2026-04-22 18:15:12.441275','2026-04-22 18:15:12.441275','admin','admin','d7dc7db2-bb66-484e-8f90-53d731ea5a57','0','monitor',NULL,'M','Monitor','系统监控','1',NULL,'1',2,NULL,'0'),('2026-04-25 14:26:09.108444','2026-04-25 14:26:09.108444','admin','admin','d94e39b2-a6b8-4df8-a39c-dd7bd2ae33a2','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务清空','1','monitor:job:clear','1',5,NULL,'0'),('2026-04-22 18:08:50.276077','2026-04-22 18:08:50.276077','admin','admin','e7b367dd-61ab-465d-8c6f-bf8819bbdde3','3c904fde-7455-437b-9657-e95629c799cd','role','system/role/index','C','Role','角色管理','1',NULL,'1',2,NULL,'0'),('2026-04-22 18:05:52.787406','2026-04-22 18:07:10.000000','admin','admin','ea3ed9fc-1f59-4c97-8079-daf5fb65314f','b254fc65-60a6-4f74-8bf6-345c23000ba3',NULL,NULL,'F',NULL,'用户新增','1','system:user:create','1',2,NULL,'0'),('2026-04-22 18:16:42.979601','2026-04-22 18:16:42.979601','admin','admin','f0b63715-59e7-4143-abcf-28c1adc8b0b1','276cdb30-1167-4c71-85a6-86a5a75f1e8b',NULL,NULL,'F',NULL,'在线用户查询','1','monitor:online:query','1',1,NULL,'0'),('2026-04-22 18:10:13.397955','2026-04-22 18:11:07.000000','admin','admin','f1a5d7b6-86e4-408a-a2f1-7e08a1472058','3c904fde-7455-437b-9657-e95629c799cd','menu','system/menu/index','C','Menu','菜单管理','1',NULL,'1',3,NULL,'0'),('2026-04-22 18:18:56.124657','2026-04-26 14:13:59.000000','admin','admin','f3444f24-e563-41a6-a97f-5424d505bdbb','d7dc7db2-bb66-484e-8f90-53d731ea5a57','cache','monitor/cache/index','C','Redis','缓存监控','1',NULL,'1',4,NULL,'0'),('2026-04-22 18:21:56.814558','2026-04-22 18:22:00.000000','admin','admin','f66ee797-1b85-412c-a1fb-f3aa90a0387b','0','example',NULL,'M','Resource','效果案例','1',NULL,'1',3,NULL,'0'),('2026-04-25 02:26:13.942254','2026-04-25 14:25:29.000000','admin','admin','fc2bc127-fac7-4511-9707-2d6fc51d68a5','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务导出','1','monitor:job:export','1',6,NULL,'0'),('2026-04-25 02:24:38.611940','2026-04-25 02:24:38.611940','admin','admin','fcc64755-3d18-4c8a-ae5d-4b95134e914f','5ddd2884-3d0c-43a0-abfb-4b0efac62d30',NULL,NULL,'F',NULL,'任务查询','1','monitor:job:query','1',1,NULL,'0');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块标题',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作人员',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '方法名称',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方式',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求接口',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求IP',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求地址',
  `businessType` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '操作类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '操作状态',
  `oper_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求时间',
  `duration` int DEFAULT NULL COMMENT '请求耗时',
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES ('1f3b54ef-5a09-4dfd-8e62-ab36eab93a63','字典管理','admin','DictController.updateType','PUT','{\n  \"query\": {},\n  \"body\": {\n    \"createTime\": \"2026-04-26 01:43:16\",\n    \"updateTime\": \"2026-04-26 01:43:16\",\n    \"createBy\": \"admin\",\n    \"updateBy\": \"admin\",\n    \"id\": \"1cf7d66a-1119-428f-b1cd-16d103b9a932\",\n    \"dictName\": \"用户性别1\",\n    \"dictType\": \"sys_user_gender\",\n    \"status\": \"1\",\n    \"remark\": \"用户性别列表\"\n  }\n}','/api/system/dict/type/update','127.0.0.1','内网IP','2','1','2026-05-08 20:49:59',14,'ecc72bc2-3a02-4b33-86c7-b84b7610e04e'),('4b7f57b5-5d6c-42c0-bcfa-44f5c41ab973','字典管理','admin','DictController.updateType','PUT','{\n  \"query\": {},\n  \"body\": {\n    \"createTime\": \"2026-04-26 01:43:16\",\n    \"updateTime\": \"2026-05-08 12:49:59\",\n    \"createBy\": \"admin\",\n    \"updateBy\": \"admin\",\n    \"id\": \"1cf7d66a-1119-428f-b1cd-16d103b9a932\",\n    \"dictName\": \"用户性别\",\n    \"dictType\": \"sys_user_gender\",\n    \"status\": \"1\",\n    \"remark\": \"用户性别列表\"\n  }\n}','/api/system/dict/type/update','127.0.0.1','内网IP','2','1','2026-05-08 20:50:12',22,'2e1ee6e7-b1b1-48c5-aed2-66bb5a60efe9'),('b4651a1e-9d90-45f2-b788-a195dfc9401f','操作日志','admin','LogController.deleteOperinfo','DELETE','{\n  \"query\": {\n    \"ids\": \"a1fb0c98-f2ba-4323-95e7-79c973470e65\"\n  }\n}','/api/monitor/log/operlog/delete','127.0.0.1','内网IP','3','1','2026-05-07 10:48:34',16,'1906efeb-d544-4d24-81a0-75c246f32a7c'),('d8fce8c8-b596-418f-b4f9-da8050cbad31','缓存列表','admin','CacheController.clearCacheName','DELETE','{\n  \"query\": {\n    \"name\": \"throttle:limit\"\n  }\n}','/api/monitor/cache/names/delete','127.0.0.1','内网IP','4','1','2026-05-09 01:07:35',4,'ceb280f2-a252-40a3-9fef-0bb884acb974');
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色编码',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_sort` int NOT NULL DEFAULT '1' COMMENT '角色排序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_fd8cc60f0258a8d5948141d98e` (`role_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('2026-04-20 21:10:07.256345','2026-04-20 21:10:07.256345','admin','admin','060999e4-ae01-47a8-a0a1-d32b96490e92','admin','系统管理员',1,'1','最高权限'),('2026-04-22 14:01:22.815409','2026-04-22 14:22:19.000000','admin','admin','a6967a5d-d645-48c5-a175-eaa5fb6ba25d','common','普通角色',2,'1','普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `IDX_b65fa84413c357d7282153b4a8` (`role_id`) USING BTREE,
  KEY `IDX_543ffcaa38d767909d9022f252` (`menu_id`) USING BTREE,
  CONSTRAINT `FK_543ffcaa38d767909d9022f2522` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_b65fa84413c357d7282153b4a88` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新人',
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `age` int DEFAULT NULL COMMENT '年龄',
  `login_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后登录时间',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2' COMMENT '性别',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_9e7164b2f1ea1348bc0eb0a7da` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('2026-04-19 02:39:01.000000','2026-05-09 01:02:24.000000','admin','admin','866b0232-507b-42a4-bdc1-47fc4a83616a','admin','$argon2id$v=19$m=65536,t=3,p=4$inTpzf3epiqXwcjgXNNYww$dvIFM+MCgd1oFE5z2XS14KgNct4KrMrtgla+BwOtfwo','18888888888','188@163.com','1',NULL,'2026-05-09 09:02:24','祂','2','系统管理员'),('2026-04-20 03:44:22.000000','2026-04-22 14:09:19.000000','admin','admin','f93176b9-6cc6-4e5a-addc-53257113c383','test','$argon2id$v=19$m=65536,t=3,p=4$7pkc53QbbZg+JCpl+vryVQ$ah5MxOYhytw9jcaQHmGhWZ5TT8KXB+EJLlHDxxAD+ak','19999999999','19999999999@126.com','1',18,NULL,'测试','1','测试角色');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `IDX_71b4edf9aedbd3e5707156e80a` (`user_id`) USING BTREE,
  KEY `IDX_e8300bfcf561ed417f5f02c677` (`role_id`) USING BTREE,
  CONSTRAINT `FK_71b4edf9aedbd3e5707156e80a2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_e8300bfcf561ed417f5f02c6776` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
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

-- Dump completed on 2026-05-09  1:54:55
