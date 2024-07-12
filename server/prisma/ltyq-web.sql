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

 Date: 12/07/2024 20:26:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for _classifytoproduct
-- ----------------------------
DROP TABLE IF EXISTS `_classifytoproduct`;
CREATE TABLE `_classifytoproduct`  (
  `A` int(11) NOT NULL,
  `B` int(11) NOT NULL,
  UNIQUE INDEX `_ClassifyToProduct_AB_unique`(`A`, `B`) USING BTREE,
  INDEX `_ClassifyToProduct_B_index`(`B`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of _classifytoproduct
-- ----------------------------

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
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classify
-- ----------------------------

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
  `isHide` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of link
-- ----------------------------

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
INSERT INTO `menu` VALUES (2, 0, NULL, 0, '关于我们', 'About us', '2023-08-30 09:25:44.210', '2024-03-11 03:08:11.014', '/about', 1, 'http://localhost:7001/upload/2024/3/11/1710126486656ore0ie.jpg', 0);
INSERT INTO `menu` VALUES (3, 0, NULL, 0, '产品中心', 'Production', '2023-08-30 07:20:31.385', '2023-08-30 07:20:31.385', '/product', 1, 'http://localhost:7001/upload/2024/3/11/1710126486656ore0ie.jpg', 1);
INSERT INTO `menu` VALUES (4, 0, NULL, 3, '新闻中心', 'News', '2023-08-30 07:24:25.708', '2024-03-11 02:09:49.313', '/news', 0, NULL, 0);
INSERT INTO `menu` VALUES (5, 0, NULL, 5, '服务与支持', 'Service and Support', '2023-08-30 07:26:48.686', '2023-08-30 07:26:48.686', '/service', 1, 'http://www.eaglotest.com.cn/public/upload/product-image/2021/04-30/服务与支持2.jpg', 0);
INSERT INTO `menu` VALUES (6, 5, NULL, 0, '资料下载', 'Data download', '2023-08-30 07:27:03.450', '2024-03-11 02:13:52.468', '/service', 1, '', 0);
INSERT INTO `menu` VALUES (7, 0, NULL, 5, '人才招聘', 'Talent recruitment', '2023-08-30 07:28:21.523', '2024-03-11 02:13:39.479', '/recruit', 1, NULL, 0);
INSERT INTO `menu` VALUES (8, 0, NULL, 6, '联系我们', 'Contact us', '2023-08-30 07:28:55.448', '2024-02-18 08:18:49.911', '/contact', 1, NULL, 0);
INSERT INTO `menu` VALUES (9, 2, NULL, 0, '关于我们', 'About us', '2023-08-30 07:45:53.157', '2024-03-11 02:14:45.916', '/about', 1, NULL, 0);
INSERT INTO `menu` VALUES (10, 2, NULL, 0, '企业文化', 'Corporate culture', '2023-08-30 07:46:32.948', '2024-03-11 02:15:16.164', '/about/culture', 1, NULL, 0);
INSERT INTO `menu` VALUES (11, 2, NULL, 0, '企业架构', 'Enterprise architecture', '2023-08-30 07:47:17.249', '2024-03-11 02:15:45.804', '/about/organization', 0, NULL, 0);
INSERT INTO `menu` VALUES (12, 2, NULL, 0, '荣誉资质', 'Honorary qualifications', '2024-03-11 02:30:22.748', '2024-03-11 02:30:22.748', '/about/honor', 1, NULL, 0);
INSERT INTO `menu` VALUES (13, 4, NULL, 0, '公司新闻', 'Company News', '2024-03-11 02:31:06.013', '2024-03-11 02:31:06.013', '/news', 1, NULL, 0);
INSERT INTO `menu` VALUES (14, 4, NULL, 0, '行业新闻', 'Industry News', '2024-03-11 02:31:34.387', '2024-03-11 02:31:34.387', '/news/industry', 1, NULL, 0);
INSERT INTO `menu` VALUES (15, 5, NULL, 0, '服务与维修', 'Service and Maintenance', '2024-03-12 14:53:15.000', '2024-03-12 14:53:30.000', '/service/mend', 1, NULL, 0);
INSERT INTO `menu` VALUES (16, 7, NULL, 0, '人才招聘', 'Talent recruitment', '2024-03-12 14:56:54.000', '2024-03-12 14:56:58.000', '/recruit', 1, NULL, 0);
INSERT INTO `menu` VALUES (17, 7, NULL, 0, '招聘须知', 'Recruitment Notice', '2024-03-14 14:21:15.000', '2024-03-14 14:21:19.000', '/recruit/notice', 1, NULL, 0);
INSERT INTO `menu` VALUES (18, 7, NULL, 0, '人才培养', 'Personnel training', '2024-03-14 14:24:13.000', '2024-03-14 14:24:17.000', '/recruit/cultivate', 1, NULL, 0);
INSERT INTO `menu` VALUES (19, 8, NULL, 0, '联系我们', 'Contact us', '2024-03-14 15:16:37.000', '2024-03-14 15:16:40.000', '/contact', 1, NULL, 0);
INSERT INTO `menu` VALUES (20, 8, NULL, 0, '客户留言', 'Customer message', '2024-03-14 15:17:24.000', '2024-03-14 15:17:42.000', '/contact/message', 1, NULL, 0);
INSERT INTO `menu` VALUES (21, 0, NULL, 2, '产品二', 'Product', '2024-03-28 01:29:34.521', '2024-03-28 03:31:11.531', '/product2', 1, 'http://www.ke-tan.com/upload/2024/3/28/1711589343225n17gq6.jpg', 1);

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
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------

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
  `isHide` tinyint(1) NULL DEFAULT 0,
  `read` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------

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
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `Other_type_key`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of other
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `describe_en` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content_en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort` int(11) NULL DEFAULT 0,
  `isHide` tinyint(1) NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `read` int(11) NULL DEFAULT 0,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------

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
  `is_open` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruit
-- ----------------------------

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system
-- ----------------------------
INSERT INTO `system` VALUES (1, '深圳XX有限公司', 'hello', '', NULL, '', '', '', '', '', '2024-05-20 10:46:37.330', '2024-05-20 11:30:15.921', '', '深圳XX有限公司', b'0', '');
INSERT INTO `system` VALUES (2, '深圳XX有限公司', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '2024-05-20 10:47:39.373', '2024-05-20 11:30:15.921', NULL, '', NULL, NULL);

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
