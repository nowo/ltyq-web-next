/*
 Navicat Premium Data Transfer

 Source Server         : 本地连接
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : ltyq-web

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 16/07/2024 20:26:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for _linktoupload
-- ----------------------------
DROP TABLE IF EXISTS `_linktoupload`;
CREATE TABLE `_linktoupload`  (
  `A` int(11) NOT NULL,
  `B` int(11) NOT NULL,
  UNIQUE INDEX `_LinkToUpload_AB_unique`(`A`, `B`) USING BTREE,
  INDEX `_LinkToUpload_B_index`(`B`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of _linktoupload
-- ----------------------------

-- ----------------------------
-- Table structure for _newstoupload
-- ----------------------------
DROP TABLE IF EXISTS `_newstoupload`;
CREATE TABLE `_newstoupload`  (
  `A` int(11) NOT NULL,
  `B` int(11) NOT NULL,
  UNIQUE INDEX `_NewsToUpload_AB_unique`(`A`, `B`) USING BTREE,
  INDEX `_NewsToUpload_B_index`(`B`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of _newstoupload
-- ----------------------------

-- ----------------------------
-- Table structure for _othertoupload
-- ----------------------------
DROP TABLE IF EXISTS `_othertoupload`;
CREATE TABLE `_othertoupload`  (
  `A` int(11) NOT NULL,
  `B` int(11) NOT NULL,
  UNIQUE INDEX `_OtherToUpload_AB_unique`(`A`, `B`) USING BTREE,
  INDEX `_OtherToUpload_B_index`(`B`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of _othertoupload
-- ----------------------------

-- ----------------------------
-- Table structure for _producttoupload
-- ----------------------------
DROP TABLE IF EXISTS `_producttoupload`;
CREATE TABLE `_producttoupload`  (
  `A` int(11) NOT NULL,
  `B` int(11) NOT NULL,
  UNIQUE INDEX `_ProductToUpload_AB_unique`(`A`, `B`) USING BTREE,
  INDEX `_ProductToUpload_B_index`(`B`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of _producttoupload
-- ----------------------------

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT 1,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `permission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `role` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Admin_account_key`(`account`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '管理员', '2418b72fbeb88a716b9c0795ae1a91a5', NULL, 1, '2024-05-17 16:20:53.516', '2024-06-17 07:48:16.803', '[{\"name\":\"admin-user\",\"permission\":[\"add\",\"edit\"]}]', 1);
INSERT INTO `admin` VALUES (2, 'test', 'tst', '2418b72fbeb88a716b9c0795ae1a91a5', NULL, 1, '2024-06-17 07:37:08.865', '2024-06-17 07:37:08.865', '[]', 2);

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NULL DEFAULT 0,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `status` int(11) NULL DEFAULT 1,
  `type` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `classify_p_id_fkey`(`p_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES (1, 0, '高低压核相相序系列', '10', '2024-03-08 06:32:20.120', '2024-03-09 06:17:28.915', 0, 1, 1);
INSERT INTO `classify` VALUES (2, 0, '电缆识别路径仪系列', NULL, '2024-03-08 06:32:20.120', '2024-03-08 06:32:20.120', 1, 1, 1);
INSERT INTO `classify` VALUES (3, 0, '绝缘电阻测试仪系列', NULL, '2024-03-08 06:32:20.120', '2024-03-08 06:32:20.120', 2, 1, 1);
INSERT INTO `classify` VALUES (4, 0, '接地电阻测试仪系列', NULL, '2024-03-08 06:32:20.120', '2024-03-08 06:32:20.120', 3, 1, 1);
INSERT INTO `classify` VALUES (5, 0, '智能相位伏安表系列', NULL, '2024-03-08 06:32:20.120', '2024-03-08 06:32:20.120', 4, 1, 1);
INSERT INTO `classify` VALUES (6, 0, '电能质量分析仪系列', NULL, '2024-03-08 06:32:20.120', '2024-03-08 06:32:20.120', 5, 1, 1);
INSERT INTO `classify` VALUES (7, 1, '高低压变比测试仪', '', '2024-03-08 06:32:20.120', '2024-07-15 01:24:22.778', 6, 1, 1);
INSERT INTO `classify` VALUES (8, 1, '高压电流电压表', '', '2024-03-08 06:32:20.120', '2024-07-15 01:24:33.844', 7, 1, 1);
INSERT INTO `classify` VALUES (9, 1, '钳形电流功率表T00', '', '2024-03-08 06:32:20.120', '2024-07-15 01:24:51.423', 8, 1, 1);
INSERT INTO `classify` VALUES (10, 2, '电缆检测仪', '', '2024-03-08 06:32:20.120', '2024-07-15 01:25:15.367', 9, 1, 1);

-- ----------------------------
-- Table structure for link
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `href` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `type` int(11) NULL DEFAULT 1,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `productId` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Link_productId_fkey`(`productId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of link
-- ----------------------------
INSERT INTO `link` VALUES (1, '', NULL, '', 0, 2, '2024-07-15 09:15:29.129', '2024-07-16 11:46:38.678', 1, '', '/upload/1693305458128m6ala5.png', 1, NULL);
INSERT INTO `link` VALUES (2, '', NULL, '', 0, 2, '2024-07-15 10:41:44.186', '2024-07-16 11:46:38.680', 1, '', '/upload/1693465126951cbycq5.png', 1, NULL);
INSERT INTO `link` VALUES (3, '湿嘻嘻嘻', '', '/upload/nitro.json', 0, 4, '2024-07-15 12:06:17.361', '2024-07-15 12:06:17.361', NULL, '', '', 1, '');
INSERT INTO `link` VALUES (4, '中国航天', '', '', 0, 8, '2024-07-16 02:17:51.774', '2024-07-16 02:17:51.774', NULL, '', 'http://www.eaglotest.com.cn/public/upload/ad/2021/11-22/5.jpg', 1, '');
INSERT INTO `link` VALUES (5, 'banner', '', '/about', 0, 1, '2024-07-16 02:36:28.255', '2024-07-16 02:43:12.138', NULL, '', '/upload/1709950348001sp13bc.jpg', 1, '');
INSERT INTO `link` VALUES (6, '京东店铺', '', 'http://www.jd.com', 0, 7, '2024-07-16 02:44:28.211', '2024-07-16 02:44:28.211', NULL, '', 'https://files.codelife.cc/website/tmall.svg', 1, '');
INSERT INTO `link` VALUES (7, '....', '', '', 0, 9, '2024-07-16 09:15:23.358', '2024-07-16 09:15:23.358', NULL, '', '/upload/170297285859156yibi.jpg', 1, '');
INSERT INTO `link` VALUES (8, 'hello', '', '', 0, 9, '2024-07-16 09:15:23.358', '2024-07-16 09:15:23.358', NULL, '', 'http://www.ke-tan.com/upload/3/28/2024/1711610891557sef0ku.jpg', 1, '');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NULL DEFAULT 0,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `href` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT 1,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_goods` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Menu_p_id_fkey`(`p_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, NULL, 0, '首页', 'Home', '2023-08-30 09:25:44.210', '2023-08-30 07:25:06.925', '/', 1, NULL, 0);
INSERT INTO `menu` VALUES (2, 0, '', 0, '关于我们', 'About us', '2023-08-30 09:25:44.210', '2024-07-15 05:37:44.759', '/about', 1, '/upload/1710126218957z8guah.jpg', 0);
INSERT INTO `menu` VALUES (3, 0, NULL, 0, '产品中心', 'Production', '2023-08-30 07:20:31.385', '2023-08-30 07:20:31.385', '/product', 1, 'http://localhost:7001/upload/2024/3/11/1710126486656ore0ie.jpg', 1);
INSERT INTO `menu` VALUES (4, 0, '', 3, '新闻中心', 'News', '2023-08-30 07:24:25.708', '2024-07-15 01:12:16.037', '/news', 1, '/upload/1710126218957z8guah.jpg', 0);
INSERT INTO `menu` VALUES (5, 0, NULL, 5, '服务与支持', 'Service and Support', '2023-08-30 07:26:48.686', '2023-08-30 07:26:48.686', '/service', 1, 'http://www.eaglotest.com.cn/public/upload/product-image/2021/04-30/服务与支持2.jpg', 0);
INSERT INTO `menu` VALUES (6, 5, NULL, 0, '资料下载', 'Data download', '2023-08-30 07:27:03.450', '2024-03-11 02:13:52.468', '/service', 1, '', 0);
INSERT INTO `menu` VALUES (7, 0, NULL, 5, '人才招聘', 'Talent recruitment', '2023-08-30 07:28:21.523', '2024-03-11 02:13:39.479', '/recruit', 1, '/upload/1710126218957z8guah.jpg', 0);
INSERT INTO `menu` VALUES (8, 0, NULL, 6, '联系我们', 'Contact us', '2023-08-30 07:28:55.448', '2024-02-18 08:18:49.911', '/contact', 1, '/upload/1710126218957z8guah.jpg', 0);
INSERT INTO `menu` VALUES (9, 2, NULL, 0, '关于我们', 'About us', '2023-08-30 07:45:53.157', '2024-03-11 02:14:45.916', '/about', 1, NULL, 0);
INSERT INTO `menu` VALUES (10, 2, NULL, 0, '企业文化', 'Corporate culture', '2023-08-30 07:46:32.948', '2024-03-11 02:15:16.164', '/about/culture', 1, NULL, 0);
INSERT INTO `menu` VALUES (11, 2, '', 0, '企业架构', 'Enterprise architecture', '2023-08-30 07:47:17.249', '2024-07-16 10:42:08.516', '/about/organization', 1, '', 0);
INSERT INTO `menu` VALUES (12, 2, NULL, 0, '荣誉资质', 'Honorary qualifications', '2024-03-11 02:30:22.748', '2024-03-11 02:30:22.748', '/about/honor', 1, NULL, 0);
INSERT INTO `menu` VALUES (13, 4, NULL, 0, '公司新闻', 'Company News', '2024-03-11 02:31:06.013', '2024-03-11 02:31:06.013', '/news', 1, NULL, 0);
INSERT INTO `menu` VALUES (14, 4, NULL, 0, '行业新闻', 'Industry News', '2024-03-11 02:31:34.387', '2024-03-11 02:31:34.387', '/news/industry', 1, NULL, 0);
INSERT INTO `menu` VALUES (15, 5, NULL, 0, '服务与维修', 'Service and Maintenance', '2024-03-12 14:53:15.000', '2024-03-12 14:53:30.000', '/service/mend', 1, NULL, 0);
INSERT INTO `menu` VALUES (16, 7, NULL, 0, '人才招聘', 'Talent recruitment', '2024-03-12 14:56:54.000', '2024-03-12 14:56:58.000', '/recruit', 1, NULL, 0);
INSERT INTO `menu` VALUES (17, 7, NULL, 0, '招聘须知', 'Recruitment Notice', '2024-03-14 14:21:15.000', '2024-03-14 14:21:19.000', '/recruit/notice', 1, NULL, 0);
INSERT INTO `menu` VALUES (18, 7, NULL, 0, '人才培养', 'Personnel training', '2024-03-14 14:24:13.000', '2024-03-14 14:24:17.000', '/recruit/cultivate', 1, NULL, 0);
INSERT INTO `menu` VALUES (19, 8, NULL, 0, '联系我们', 'Contact us', '2024-03-14 15:16:37.000', '2024-03-14 15:16:40.000', '/contact', 1, NULL, 0);
INSERT INTO `menu` VALUES (20, 8, NULL, 0, '客户留言', 'Customer message', '2024-03-14 15:17:24.000', '2024-03-14 15:17:42.000', '/contact/message', 1, NULL, 0);
INSERT INTO `menu` VALUES (21, 0, '', 2, '产品二', 'Product', '2024-03-28 01:29:34.521', '2024-07-15 01:11:59.199', '/product2', 0, 'http://www.ke-tan.com/upload/2024/3/28/1711589343225n17gq6.jpg', 1);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` int(11) NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, '张三', '18080080080', '1@1.com', '深圳光明', 'hello000000', 0, '2024-07-16 03:16:50.822', '2024-07-16 03:21:17.190');
INSERT INTO `message` VALUES (2, '1010', '101', '101', '101', '101', 0, '2024-07-16 08:57:01.294', '2024-07-16 08:57:01.294');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort` int(11) NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `read` int(11) NULL DEFAULT 0,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 0,
  `isIndex` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '2024端午节放假安排', '', '管理员', '<p>2024端午节放假安排通知</p>', '', '<div class=\"dpu8C _2kCxD \">\n<p>据国家统计局消息，上半年，在以习近平同志为核心的党中央坚强领导下，各地区各部门认真贯彻落实党中央、国务院决策部署，坚持稳中求进、以进促稳、先立后破，有效落实各项宏观政策，国民经济运行总体平稳，稳中有进，生产稳定增长，需求持续恢复，就业物价总体稳定，居民收入继续增加，新动能加快成长，高质量发展取得新进展。</p>\n</div>\n<div class=\"dpu8C _2kCxD \">\n<p>初步核算，上半年国内生产总值616836亿元，按不变价格计算，同比增长5.0%。分产业看，第一产业增加值30660亿元，同比增长3.5%；第二产业增加值236530亿元，增长5.8%；第三产业增加值349646亿元，增长4.6%。分季度看，一季度国内生产总值同比增长5.3%，二季度增长4.7%。从环比看，二季度国内生产总值增长0.7%。</p>\n</div>\n<div class=\"dpu8C _2kCxD \">\n<p>一、夏粮再获丰收，畜牧业总体平稳</p>\n</div>\n<div class=\"dpu8C _2kCxD \">\n<p>上半年，农业（种植业）增加值同比增长4.0%。夏粮生产再获丰收。全国夏粮总产量14978万吨，比上年增加363万吨，增长2.5%。上半年，猪牛羊禽肉产量4712万吨，同比增长0.6%，其中，牛肉、禽肉产量分别增长3.9%、6.3%，猪肉、羊肉产量分别下降1.7%、0.9%；牛奶产量增长3.4%，禽蛋产量增长2.7%。二季度末，生猪存栏41533万头，同比下降4.6%；上半年，生猪出栏36395万头，下降3.1%。</p>\n</div>\n<div class=\"dpu8C _2kCxD \">\n<p>二、工业生产较快增长，装备制造业支撑作用明显</p>\n</div>', '', 1, 1, '2024-07-15 02:02:56.782', '2024-07-15 03:29:16.369', 4, '/upload/11.jpg', 1, 0);
INSERT INTO `news` VALUES (2, '2024端午节放假安排', '', '管理员', '<p>地下管线探测仪</p>', '', '<div class=\"reuse_module\" data-v-90f61db3=\"\">\n<p class=\"reuse_title\" data-v-90f61db3=\"\">新闻资讯</p>\n<div class=\"news_txt flex\" data-v-90f61db3=\"\">\n<div class=\"news_title\" data-v-90f61db3=\"\">\n<h2 class=\"font-bold\" data-v-90f61db3=\"\"><a class=\"news_left\" href=\"http://ke-tan.com/news/7\" data-v-90f61db3=\"\">地下管线探测仪</a></h2>\n<p data-v-90f61db3=\"\"><a class=\"news_left\" href=\"http://ke-tan.com/news/7\" data-v-90f61db3=\"\">科探电子2024款地下管线仪上线，在老款基础上不断优化改进，外观全面升级功能更完善，实际探测深度更深可达20米，稳定型更强。</a></p>\n</div>\n<div class=\"news_date\" data-v-90f61db3=\"\"><a class=\"news_left\" href=\"http://ke-tan.com/news/7\" data-v-90f61db3=\"\"><strong data-v-90f61db3=\"\">28</strong><span data-v-90f61db3=\"\">2024-03</span></a></div>\n</div>\n<p>&nbsp;</p>\n</div>', '', 1, 1, '2024-07-15 02:02:56.782', '2024-07-15 03:29:11.169', 1, '/upload/11.jpg', 1, 0);

-- ----------------------------
-- Table structure for other
-- ----------------------------
DROP TABLE IF EXISTS `other`;
CREATE TABLE `other`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `subtitle_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Other_key_key`(`key`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of other
-- ----------------------------
INSERT INTO `other` VALUES (1, '客户留言', '', '<p style=\"text-indent: 2em; text-align: start;\"><span style=\"color: rgb(38, 38, 38);\"><strong>东莞市捷布鲁科技有限公司(捷布鲁JETBLUE)是一家专业从事汽车零部件清洁度检测仪器，自动清洁度分析系统,清洁度检测自动清洗萃取设备等清洁度检测配套分析测试仪器及其软件研发、制造、销售为一体的科技型企业。</strong></span></p><p style=\"text-align: start;\"><strong> &nbsp; &nbsp; &nbsp;经过多年的不断耕耘，公司自主研发生产的JYBLU-100ZD自动清洁度检测分析系统,JYBLU-767清洁度检测自动清洗萃取设备等多款产品已经形成产品系列化,规格多元化且广泛应用于燃油汽车及其部件制造、新能源汽车及其部件制造、航空航天器材及其部件制造、5G终端产品制造等众多精密加工制造领域。</strong></p><p style=\"text-align: start;\"><strong> &nbsp; &nbsp; &nbsp;公司在深圳设有研发中心:深圳洁布鲁科技，先后在浙江、重庆、上海、江苏设立直属分支机构，构建了覆盖主要市场的行销网络。</strong></p><p style=\"text-align: start;\"><strong> &nbsp; &nbsp; &nbsp;捷布鲁宗旨：不止于质量</strong></p><p style=\"text-align: start;\"><strong> &nbsp; &nbsp; &nbsp;捷布鲁愿景：做行业技术创新者！</strong></p>', '<p>eng</p>', '2023-08-31 05:45:27.187', '2024-03-19 02:37:57.838', 'http://localhost:7001/upload/2023/9/8/169413632560359vj4b.jpg', 'message', '', '');
INSERT INTO `other` VALUES (2, '企业架构图', '', '', '', '2023-08-31 05:51:56.641', '2023-08-31 05:51:56.641', 'http://www.eaglotest.com.cn/public/upload/ad/2021/05-07/公司架构图（hei）.jpg', 'organization', NULL, NULL);
INSERT INTO `other` VALUES (7, '人才培养', '', '<p style=\"text-align: start; line-height: 2;\"> &nbsp; &nbsp; &nbsp; &nbsp;鹰测技术是一个富有理想和激情的团队，公司秉承科技为先、以人为本的管理理念，为每一位员工提供施展才华、发挥潜能和实现自身价值的最好舞台！ 鹰测技术新的辉煌需要我们共同去创造，新的形象需要我们共同去塑造；公司美好的明天，也是每位员工美好生活的希望，让我们以百倍的信心，努力构建适应未来发展的管理模式，创建有鲜明特色的企业文化，早日实现公司愿景目标，成为具有国际竞争力的一流企业。</p>', '<p><br></p>', '2024-03-13 07:53:59.440', '2024-03-14 06:35:55.258', '', 'recruit-cultivate', '', '');
INSERT INTO `other` VALUES (6, '招聘须知', '', '<p><span style=\"color: rgb(31, 31, 31); background-color: rgb(255, 255, 255); font-size: 12px;\">求职注意问题：</span></p><p><span style=\"color: rgb(31, 31, 31); background-color: rgb(255, 255, 255); font-size: 12px;\">1....</span></p>', '', '2024-03-13 07:52:46.106', '2024-03-13 07:52:46.106', 'http://www.eaglotest.com.cn/public/upload/recruit/2023/10-09/集体1-2.jpg', 'recruit-notice', NULL, NULL);
INSERT INTO `other` VALUES (3, '我们是谁...', '', '<p style=\"text-indent: 2em; text-align: left;\">广东鹰测技术有限公司是一家专业从事遥感、遥测、遥控的智能化、数字化、高端检测仪器仪表及在线监测系统研发、制造、销售及应用服务于一体的高科技型企业，公司简称“鹰测”、“鹰测技术”、“鹰测科技”。 </p><p style=\"text-indent: 2em; text-align: left;\">公司拥有卓越的研发团队、管理团队，拥有高精密的试验检测设备，积极遵照国际电工委员会IEC1010标准及相关国家标准，致力于为全球用户提供智能新颖、优质安全、精准耐用的高科技产品，确保公司产品在同行业中的领先地位，从而更好地服务于电力、通讯、气象、石化、铁路、航空、教育、企业等领域。 </p><p style=\"text-indent: 32px; text-align: left;\">鹰测技术在国内较早研发出了“一次识别10条电缆的带电电缆识别仪（识别电缆时不用来回跑，省时）”、“无线高压钩式大电流表”、“远程网络基站定相核相仪”、“非接触式接地电阻在线检测仪及系统”、“无线高压钳形漏电流表”、“非接触式检相器”、“防水型微安级漏电流及接地电阻在线监测传感器”、“钳形接地电阻测试仪”、“微安级钳形漏电流表”等产品，为中国电力行业研发生产了许多经久耐用的高端智能检测仪表，赢得市场一致好评。<br></p><p style=\"text-indent: 32px; text-align: left;\">2021年，鹰测技术迁址升级，再上新台阶，在创始人符美安总工程师的带领下，誓要把鹰测技术打造成一家拥有核心技术、具有自主知识产权，与优秀同行一起引领行业发展的标杆企业。</p>', '<p><br></p>', '2024-03-13 07:00:47.097', '2024-07-16 02:23:22.030', 'http://www.eaglotest.com.cn/public/upload/about-us/2021/04-20/厂房效果图.jpg', 'about', '', '');
INSERT INTO `other` VALUES (4, '企业文化', '', '<p style=\"line-height: 2;\"><br></p><h2 style=\"line-height: 2;\"><span style=\"color: rgb(255, 122, 69); font-size: 24px;\"><strong>鹰测优势</strong></span></h2><ul><li style=\"line-height: 2;\">鹰测技术核心研发团队由符美安总工程师带领, 拥有近二十年研发经验, 并能根据客户需求研发定制;</li><li style=\"line-height: 2;\">国内较早研发钳形接地电阻测试仪, 高压钳形电流表, 非接触相序表, 电能质量分析仪等, 其专利技术被同行企业广泛应用;</li><li style=\"line-height: 2;\">发明性应用双层柔性线圈测量高压大电流，将柔性线圈内置于高压钩表内，量程达到20000A, 可测线径Φ168*245mm;</li></ul><p style=\"line-height: 2;\"><br></p><h2 style=\"line-height: 2;\"><span style=\"color: rgb(255, 122, 69); font-size: 24px;\"><strong>企业口号</strong></span></h2><ul><li style=\"line-height: 2;\">精准检测有鹰测</li></ul><p style=\"line-height: 2;\"><br></p><p style=\"line-height: 2;\"><br></p><h2 style=\"line-height: 2;\"><span style=\"color: rgb(255, 122, 69); font-size: 24px;\"><strong>服务、市场拓展和未来展望</strong></span></h2><ul><li style=\"line-height: 2;\">鹰测技术稳步发展, 公司服务的市场遍布全球, 主要市场有美国, 巴西, 哥伦比亚, 智利, 英国, 法国, 泰国, 菲律宾以及国内共计上千家优质客户;</li><li style=\"line-height: 2;\">鹰测技术不断拓展市场, 通过定期参加世界各地行业展会, 了解客户需求和市场动向, 更好的建立鹰测全球化品牌网络;</li></ul><p style=\"line-height: 2;\"><br></p>', '<p><br></p>', '2024-03-13 07:07:58.647', '2024-03-14 03:24:23.537', 'http://www.eaglotest.com.cn/public/upload/recruit/2023/10-09/集体1-2.jpg', 'culture', '', '');
INSERT INTO `other` VALUES (5, '海纳百川，唯才是用', 'All rivers run into sea, is the use', '<p style=\"text-indent: 2.1875rem; text-align: start; line-height: 2;\">我们诚挚邀请您能加入鹰测技术的大家庭！</p><p style=\"text-indent: 2.1875rem; text-align: start; line-height: 2;\">广东鹰测技术有限公司自成立以来，经过全体员工多年的拼搏与奋斗，已逐步发展成为一家以“求实求真，大气大为，技术创新”为企业精神，集研发、生产、销售、服务为一体的遥感、遥测、遥控、高端检测仪器仪表及在线监测系统领域内的国内知名技术企业，目前公司已步入快速发展之路，对此我们都感到无比的光荣与自豪！</p><p style=\"text-indent: 2.1875rem; text-align: start; line-height: 2;\">我们期待着您的加入，与您一起肩负起“服务社会，引领仪器新时代”的神圣使命，一同感受着企业与个人共成长的历程！</p>', '<p><br></p>', '2024-03-13 07:52:03.856', '2024-03-13 07:52:03.856', 'http://www.eaglotest.com.cn/public/upload/recruit/2023/10-09/集体1-2.jpg', 'recruit-person', NULL, NULL);
INSERT INTO `other` VALUES (8, '技术服务与支持专线：020-31529616', '', '<p style=\"text-align: start;\"><br></p><ul><li style=\"text-align: start;\"><span style=\"font-size: 16px;\"><strong>常见问题解答</strong></span></li></ul><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 您们的售后信息是?</p><p style=\"text-align: start;\">A：售后 收件人信息姓名: 雷先生</p><p style=\"text-align: start;\"> &nbsp; &nbsp;电话: 020-31529626</p><p style=\"text-align: start;\"> &nbsp; &nbsp;地址: 广州白云区科园路18号鹰测大楼</p><p style=\"text-align: start;\"> &nbsp; &nbsp;邮寄时麻烦附一张A4纸把公司全称，联系人，联系电话 ，回邮地址，设备存在的问题写上。快递请选择：顺丰快递，德邦快递。</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 您们是工厂还是贸易公司</p><p style=\"text-align: start;\">A: 我们是拥有20年电力仪器研发设计经验的制造工厂</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 您们的产品领域主要是什么</p><p style=\"text-align: start;\">A: 产品主要应用于电力，通讯，气象，化工，轨道交通，航空，教育等领域</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 我们怎样能确认产品规格参数？</p><p style=\"text-align: start;\">A: 我们有20多年的资深工程师经验非常丰富，我们会提供详细的产品技术资料，包括产品视频供客户学习参考</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 我们质保多久？</p><p style=\"text-align: start;\">A: 1年质保</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 您们的工厂检验测试怎样？</p><p style=\"text-align: start;\">A: 每一台设备出厂前都要检测，100%合格后才发货</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q: 付款方式 是怎样的？</p><p style=\"text-align: start;\">A: 全款电汇</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q:产品交期多久？</p><p style=\"text-align: start;\">A:通常款到1-3天发货，或根据订单数量另计</p><p style=\"text-align: start;\"><br></p><p style=\"text-align: start;\">Q：我们可以成为分销代理商吗？</p><p style=\"text-align: start;\">A: 可以，欢迎广大客户加入我们，更多代理商细节需要一起讨论</p>', '', '2024-03-13 08:14:49.782', '2024-03-13 08:14:49.782', '', 'service-mend', '售后及维修服务专线：17328333745', '');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `describe_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort` int(11) NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `read` int(11) NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `annex` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `annex_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `contrast` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `contrast_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `isHot` tinyint(1) NULL DEFAULT 0,
  `status` tinyint(1) NULL DEFAULT 0,
  `classifyId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `Product_classifyId_fkey`(`classifyId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '2131', '', '', '<p><strong>KT-150 变压器铁芯接地电流测试仪是专为现场在线测试电力系统中变压器铁芯接地电流、漏电流、频率、波形而精心设计制造的，由主机、电流钳、数据软件、通讯线等组成。电力变压器是电力系统中最重要的电气设备，运行中一旦出现故障，将会对电力系统造成严重的后果。正常运行的变压器铁芯是单点接地的，如有两点或两点以上同时接地，则铁芯与大地之间将形成电流回路，最大电流可达几十安培，将会造成铁芯局部过热甚至烧毁。本仪表能尽快发现变压器潜伏性的故障，是保证变压器安全运行和正常维护的主要工具。主要适用于变电站、发电厂作为变压器、电抗器等电气设备的铁芯与夹件的泄漏电流测试。也可用于电力、通信、气象、铁路、油田、建筑、计量、科研教学单位、工矿企业等领域线路或设备的电流、漏电流测试。</strong></p>\n<p>&nbsp;</p>', '', '<p><strong>1．基准条件和工作条件</strong></p>\n<table width=\"1167\">\n<tbody>\n<tr class=\"firstRow\">\n<td valign=\"center\" width=\"357\">\n<p><strong>影响量</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p><strong>基准条件</strong></p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p><strong>工作条件</strong></p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p><strong>备注</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>环境温度</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>23℃&plusmn;1℃</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>-10℃～40℃</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>环境湿渡</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>40%～60%</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>＜80%</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>信号频率</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>50Hz&plusmn;1Hz</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>10Hz～1000Hz</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>仪表工作电压</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>7.4V&plusmn;0.5V</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>7.4V&plusmn;1V</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>测波形电流幅值</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>/</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>10mA～400A</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>外电场、磁场</strong></p>\n</td>\n<td colspan=\"3\" valign=\"center\">\n<p>应避免</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"undefined\">\n<p><strong>被测导线位置</strong></p>\n</td>\n<td colspan=\"3\" valign=\"center\">\n<p>被测导线处于钳口的近似几何中心位置</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><strong>&nbsp;</strong></p>\n<p><strong>2．一般规格</strong></p>\n<table width=\"1167\">\n<tbody>\n<tr class=\"firstRow\">\n<td valign=\"center\" width=\"174\">\n<p><strong>功能</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>变压器铁芯接地电流测试；交流漏电流、电流、频率、波形在线分析测试</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>电源</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>DC 7.4V大容量可充锂电池，USB充电接口，充满电连续工作约8小时</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>额定电流</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>约180mA max</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>显示模式</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>3.5寸真彩液晶屏显示</p>\n</td>\n</tr>\n<tr>\n<td rowspan=\"2\" valign=\"center\" width=\"174\">\n<p><strong>仪表尺寸</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>主机：长宽厚207mm&times;101mm&times;45mm</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"992\">\n<p>电流钳：长宽厚153mmX290mmX41</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>钳口尺寸</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>88mm&times;88mm</p>\n</td>\n</tr>\n<tr>\n<td rowspan=\"2\" valign=\"center\" width=\"174\">\n<p><strong>量&nbsp;&nbsp;&nbsp;&nbsp;程</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>电流：0.0mA～400.0A(50Hz/60Hz)</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"992\">\n<p>频率：10Hz～1000Hz</p>\n</td>\n</tr>\n</tbody>\n</table>', '', 0, 0, 0, '2024-07-15 08:13:47.508', '2024-07-16 11:46:38.682', '<p>1324465546</p>', '', '<table>\n<tbody>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">主机</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1台</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">仪表箱</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">电流钳</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">8.4V 1A充电器</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">锂电池</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1组(仪表内)</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">说明书、保修卡、合格证</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1份</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>', '', '', 1, 1, 7);
INSERT INTO `product` VALUES (2, '2131', '', '', '<p><strong>KT-150 变压器铁芯接地电流测试仪是专为现场在线测试电力系统中变压器铁芯接地电流、漏电流、频率、波形而精心设计制造的，由主机、电流钳、数据软件、通讯线等组成。电力变压器是电力系统中最重要的电气设备，运行中一旦出现故障，将会对电力系统造成严重的后果。正常运行的变压器铁芯是单点接地的，如有两点或两点以上同时接地，则铁芯与大地之间将形成电流回路，最大电流可达几十安培，将会造成铁芯局部过热甚至烧毁。本仪表能尽快发现变压器潜伏性的故障，是保证变压器安全运行和正常维护的主要工具。主要适用于变电站、发电厂作为变压器、电抗器等电气设备的铁芯与夹件的泄漏电流测试。也可用于电力、通信、气象、铁路、油田、建筑、计量、科研教学单位、工矿企业等领域线路或设备的电流、漏电流测试。</strong></p>\n<p>&nbsp;</p>', '', '<p><strong>1．基准条件和工作条件</strong></p>\n<table width=\"1167\">\n<tbody>\n<tr class=\"firstRow\">\n<td valign=\"center\" width=\"357\">\n<p><strong>影响量</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p><strong>基准条件</strong></p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p><strong>工作条件</strong></p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p><strong>备注</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>环境温度</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>23℃&plusmn;1℃</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>-10℃～40℃</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>环境湿渡</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>40%～60%</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>＜80%</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>信号频率</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>50Hz&plusmn;1Hz</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>10Hz～1000Hz</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>仪表工作电压</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>7.4V&plusmn;0.5V</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>7.4V&plusmn;1V</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>测波形电流幅值</strong></p>\n</td>\n<td valign=\"center\" width=\"287\">\n<p>/</p>\n</td>\n<td valign=\"center\" width=\"380\">\n<p>10mA～400A</p>\n</td>\n<td valign=\"center\" width=\"142\">\n<p>/</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"357\">\n<p><strong>外电场、磁场</strong></p>\n</td>\n<td colspan=\"3\" valign=\"center\">\n<p>应避免</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"undefined\">\n<p><strong>被测导线位置</strong></p>\n</td>\n<td colspan=\"3\" valign=\"center\">\n<p>被测导线处于钳口的近似几何中心位置</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><strong>&nbsp;</strong></p>\n<p><strong>2．一般规格</strong></p>\n<table width=\"1167\">\n<tbody>\n<tr class=\"firstRow\">\n<td valign=\"center\" width=\"174\">\n<p><strong>功能</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>变压器铁芯接地电流测试；交流漏电流、电流、频率、波形在线分析测试</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>电源</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>DC 7.4V大容量可充锂电池，USB充电接口，充满电连续工作约8小时</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>额定电流</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>约180mA max</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>显示模式</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>3.5寸真彩液晶屏显示</p>\n</td>\n</tr>\n<tr>\n<td rowspan=\"2\" valign=\"center\" width=\"174\">\n<p><strong>仪表尺寸</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>主机：长宽厚207mm&times;101mm&times;45mm</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"992\">\n<p>电流钳：长宽厚153mmX290mmX41</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"174\">\n<p><strong>钳口尺寸</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>88mm&times;88mm</p>\n</td>\n</tr>\n<tr>\n<td rowspan=\"2\" valign=\"center\" width=\"174\">\n<p><strong>量&nbsp;&nbsp;&nbsp;&nbsp;程</strong></p>\n</td>\n<td valign=\"center\" width=\"992\">\n<p>电流：0.0mA～400.0A(50Hz/60Hz)</p>\n</td>\n</tr>\n<tr>\n<td valign=\"center\" width=\"992\">\n<p>频率：10Hz～1000Hz</p>\n</td>\n</tr>\n</tbody>\n</table>', '', 0, 0, 0, '2024-07-15 08:13:47.508', '2024-07-16 11:46:42.010', '<p>1324465546</p>', '', '<table>\n<tbody>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">主机</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1台</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">仪表箱</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">电流钳</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">8.4V 1A充电器</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1个</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">锂电池</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1组(仪表内)</td>\n</tr>\n<tr>\n<td colspan=\"1\" rowspan=\"1\" width=\"737\">说明书、保修卡、合格证</td>\n<td colspan=\"1\" rowspan=\"1\" width=\"429\">1份</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>', '', '', 1, 1, 7);

-- ----------------------------
-- Table structure for recruit
-- ----------------------------
DROP TABLE IF EXISTS `recruit`;
CREATE TABLE `recruit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `people` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `describe_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort` int(11) NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recruit
-- ----------------------------
INSERT INTO `recruit` VALUES (1, '电子工程师 （研发）', '', '多名', '广州白云', '', '<p>岗位职责： &nbsp; &nbsp; &nbsp; &nbsp; </p><p>1、负责产品电子系统总成项目的技术支持与协调，并参与项目管理以及产品开发设计；<br>2、现场支持系统总装和评估，负责解决系统级工程问题；<br>3、配合项目管理组，完成新产品开发工作流程；</p>', '', '<p>职位要求： &nbsp; &nbsp; &nbsp; </p><p>1、精通数字、模拟、高频电路。<br>2、具有扎实的硬件电路设计经验。<br>3、精通电路原理图、PCB 设计。<br>4、精通大规模集成电路硬件焊接、拆卸、维修、测试。<br>5、三年及以上工作经验。<br>6、本科及以上学历，40 岁以下。、<br>7、面试必备：个人简历、学历证书、身份证（原件+复印件）。<br>8、待遇：面议</p>', '', 0, '2024-03-13 08:42:11.746', '2024-03-13 09:27:37.109', 1);
INSERT INTO `recruit` VALUES (2, '单片机工程师（研发）', '', '多名', '广州白云', '', '<p><br></p><li>岗位职责：</li>', '', '<p>职位要求： &nbsp; &nbsp;</p><ul><li>1、精通单片机软件设计。</li><li>2、有 MCU 的应用经验，具有良好的编程习惯。 </li><li>3、精通 USB/RS232/485/WIFI/蓝牙/433MHz/4G 等各种通讯。</li><li>4、熟悉数字、模拟、高频电路。</li><li>5、熟悉电路原理图、PCB 设计。</li><li>6、两年及以上嵌入式系统软件设计开发经验。 </li><li>7、DSP 开发应用优先。 </li><li>8、本科及以上学历，36 岁以下。</li><li>9、面试必备：个人简历、学历证书、身份证（原件+复印件）。</li><li>10、待遇：面议</li></ul><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p>', '', 0, '2024-03-13 08:42:11.746', '2024-03-13 09:28:40.576', 1);
INSERT INTO `recruit` VALUES (3, '项目工程师（研发）', '', '多名', '广州市白云区', NULL, '\n            <li>岗位职责：</li>\n            <li></li>\n        ', NULL, '\n            <li>职位要求：</li>\n            <li>1、精通单片机软件设计。<br>2、精通嵌入式系统软件设计。 <br>3、精通数字、模拟、高频电路。<br>4、精通电路原理图、PCB 设计。<br>5、精通软硬件联调。 <br>6、精通大规模集成电路的焊接、拆卸。<br>7、三年及以上项目研发经验。 <br>8、具有独立的项目研发能力、领导能力。 <br>9、本科及以上学历，40 岁以下。<br>10、 面试必备：个人简历、学历证书、身份证（原件+复印件）。<br>11、 待遇：面议</li>\n        ', NULL, 0, '2024-03-13 08:42:11.746', '2024-03-13 08:42:11.746', 1);
INSERT INTO `recruit` VALUES (4, '区域业务经理', '', '多名', '不限', NULL, '\n            <li>岗位职责：</li>\n            <li>区域内销售业务<br></li>\n        ', NULL, '\n            <li>职位要求：</li>\n            <li>1、为人谦逊、勤学好问、服从安排。<br>2、一年以上销售工作经验。<br>3、具备良好的沟通能力、团队能力、身体能力。<br>4、能驻外、能常出差。<br>5、电子、电气、通讯等相关专业优先。<br>6、大专及以上学历，36 岁以下。 <br>7、面试必备：个人简历、学历证书、身份证（原件+复印件）。<br>8、待遇：面议</li>\n        ', NULL, 0, '2024-03-13 08:42:11.746', '2024-03-13 08:42:11.746', 1);
INSERT INTO `recruit` VALUES (5, '外贸业务经理', '', '多名', '广州', NULL, '\n            <li>岗位职责：</li>\n            <li>负责公司外贸业务</li>\n        ', NULL, '\n            <li>职位要求：</li>\n            <li>1、为人谦逊、勤学好问、服从安排。<br>2、一年以上销售工作经验。<br>3、流利的英语口语能力，沟通能力、团队能力、身体能力。<br>4、商务英语、电子商务、电子、电气、通讯等相关专业优先。<br>5、大专及以上学历，36 岁以下。 <br>6、面试必备：个人简历、学历证书、身份证（原件+复印件）。<br>7、待遇：面议</li>\n        ', NULL, 0, '2024-03-13 08:42:11.746', '2024-03-13 08:42:11.746', 1);
INSERT INTO `recruit` VALUES (6, '普工', '', '10', '广州白云区', NULL, '\n            <li>岗位职责：</li>\n            <li>线路板元器件焊接、仪表组装等</li>\n        ', NULL, '\n            <li>职位要求：</li>\n            <li>年龄18-35岁，高中或高中以上文凭，能长期稳定工作；男女不限，熟手优先</li>\n        ', NULL, 0, '2024-03-13 08:42:11.746', '2024-03-13 08:42:11.746', 1);

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logo2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `filing` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_en` bit(1) NULL DEFAULT NULL,
  `wx_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `welcome` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `public_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system
-- ----------------------------
INSERT INTO `system` VALUES (1, '深圳XX有限公司', '广东省深圳市光明区新湖街道楼村深澜一号1栋3楼', '/upload/v2_rzj9j3.png', '/upload/v2_rzj9j3.png', '400-10086', '100@163.com', '', '', '<p>深圳科探电子科技有限公司&copy;版权所有 粤ICP备18104836号-2</p>', '2024-05-20 10:46:37.330', '2024-07-16 10:55:14.349', '', '深圳XX有限公司', b'1', '/upload/pic.jpg', '欢迎访问深圳科探官方网站！', '/upload/pic.jpg', '18880005003');
INSERT INTO `system` VALUES (2, '深圳XX有限公司', '', NULL, '', NULL, NULL, NULL, NULL, '', '2024-05-20 10:47:39.373', '2024-07-16 10:55:14.349', NULL, '', NULL, NULL, '', NULL, NULL);

-- ----------------------------
-- Table structure for upload
-- ----------------------------
DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of upload
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
