/*
Navicat MySQL Data Transfer

Source Server         : localhost_123456
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : java0826

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-08-27 17:09:40
*/

create database if not exists java0826;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS java0826.`product`;
CREATE TABLE java0826.`product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `creatorName` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '1:正常 0：下架',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO java0826.`product` VALUES ('1', '手机', '9000', '华为', '1000', '5', '1', 'admin', '1');

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS java0826.`product_type`;
CREATE TABLE java0826.`product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `creatorName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO java0826.`product_type` VALUES ('1', '女装', '1', 'admin');
INSERT INTO java0826.`product_type` VALUES ('2', '女装', '1', 'admin');
INSERT INTO java0826.`product_type` VALUES ('3', '女装', '1', 'admin');
INSERT INTO java0826.`product_type` VALUES ('4', '男装', '1', 'admin');
INSERT INTO java0826.`product_type` VALUES ('5', '数码', '1', 'admin');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS java0826.`test`;
CREATE TABLE java0826.`test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO java0826.`test` VALUES ('1', 'ewwe');
INSERT INTO java0826.`test` VALUES ('2', 'eeee');
INSERT INTO java0826.`test` VALUES ('3', 'rrrr');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS java0826.`user`;
CREATE TABLE java0826.`user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_uniq_key` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO java0826.`user` VALUES ('1', 'admin', '123456', 'admin', 'admin@iflytek.com', '2');
INSERT INTO java0826.`user` VALUES ('2', 'user1', '123456', 'user1', 'user1@iflytek.com', '1');
INSERT INTO java0826.`user` VALUES ('3', 'user2', '123456', 'user2', 'user2@iflytek.com', '1');
