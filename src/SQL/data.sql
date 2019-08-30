/*
Navicat MySQL Data Transfer

Source Server         : localhost_sy205919
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : java0826

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-08-26 10:11:43
*/

-- ----------------------------
--  Crate database java0826
-- ----------------------------
create database if not exists java0826;


SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS java0826.`address`;
CREATE TABLE java0826.`address`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT,
    `userId`   int(11)      DEFAULT NULL,
    `userName` varchar(20)  DEFAULT NULL,
    `addr`     varchar(255) DEFAULT NULL,
    `tel`      varchar(20)  DEFAULT NULL,
    `status`   int(11)      DEFAULT '0' COMMENT '0:不是默认的 1：默认的',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO java0826.`address`
VALUES ('4', '2', '王五', '安徽省合肥市科大讯飞产业基地', '13344444444', '1');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS java0826.`order`;
CREATE TABLE java0826.`order`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
    `orderNo`     varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
    `status`      int(11)                                                DEFAULT '0' COMMENT '0:初始化  2：已完成',
    `creator`     int(11)                                                DEFAULT NULL,
    `creatorName` varchar(20)                                            DEFAULT NULL,
    `addrId`      int(11)                                                DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO java0826.`order`
VALUES ('4', 'IFLYTEK201908291104253521', '0', '2', 'user1', null);
INSERT INTO java0826.`order`
VALUES ('9', 'IFLYTEK201908301151535336', '2', '2', 'user1', '4');

-- ----------------------------
-- Table structure for ordermx
-- ----------------------------
DROP TABLE IF EXISTS java0826.`ordermx`;
CREATE TABLE java0826.`ordermx`
(
    `productId` int(11) NOT NULL AUTO_INCREMENT,
    `orderId`   int(11) DEFAULT NULL,
    `num`       int(11) DEFAULT NULL,
    PRIMARY KEY (`productId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of ordermx
-- ----------------------------
INSERT INTO java0826.`ordermx`
VALUES ('2', '4', '3');
INSERT INTO java0826.`ordermx`
VALUES ('3', '9', '1');
INSERT INTO java0826.`ordermx`
VALUES ('4', '9', '1');
INSERT INTO java0826.`ordermx`
VALUES ('5', '9', '1');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS java0826.`product`;
CREATE TABLE java0826.`product`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(50)   DEFAULT NULL,
    `price`       double(10, 0) DEFAULT NULL,
    `brand`       varchar(50)   DEFAULT NULL,
    `num`         int(11)       DEFAULT NULL,
    `type`        int(11)       DEFAULT NULL,
    `creator`     int(11)       DEFAULT NULL,
    `creatorName` varchar(50)   DEFAULT NULL,
    `status`      int(11)       DEFAULT '1' COMMENT '1:正常 0：下架',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO java0826.`product`
VALUES ('1', '手机', '9000', '华为', '1000', '5', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('2', '男士寸衫', '300', '海澜之家', '47', '4', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('3', '女士寸衫', '100', 'Tommy Hilfiger', '4', '3', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('4', '女士裙子', '800', 'Tommy Hilfiger', '3', '3', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('5', '男士西服', '1000', '361', '96', '4', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('6', '联想笔记本', '3200', '联想', '29', '5', '1', 'admin', '1');
INSERT INTO java0826.`product`
VALUES ('7', 'iphone8X', '8000', '苹果', '1000', '5', '1', 'admin', '1');

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS java0826.`product_type`;
CREATE TABLE java0826.`product_type`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(50)  DEFAULT NULL,
    `creator`     int(11)      DEFAULT NULL,
    `creatorName` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO java0826.`product_type`
VALUES ('1', '女装', '1', 'admin');
INSERT INTO java0826.`product_type`
VALUES ('2', '女装', '1', 'admin');
INSERT INTO java0826.`product_type`
VALUES ('3', '女装', '1', 'admin');
INSERT INTO java0826.`product_type`
VALUES ('4', '男装', '1', 'admin');
INSERT INTO java0826.`product_type`
VALUES ('5', '数码', '1', 'admin');
INSERT INTO java0826.`product_type`
VALUES ('8', '童装', '1', 'admin');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS java0826.`test`;
CREATE TABLE java0826.`test`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO java0826.`test`
VALUES ('1', 'ewwe');
INSERT INTO java0826.`test`
VALUES ('2', 'eeee');
INSERT INTO java0826.`test`
VALUES ('3', 'rrrr');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS java0826.`user`;
CREATE TABLE java0826.`user`
(
    `id`       int(11)                                                NOT NULL AUTO_INCREMENT,
    `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `password` varchar(20) DEFAULT NULL,
    `name`     varchar(20) DEFAULT NULL,
    `email`    varchar(20) DEFAULT NULL,
    `type`     int(11)     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_uniq_key` (`username`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO java0826.`user`
VALUES ('1', 'admin', '123456', 'admin', 'admin@iflytek.com', '2');
INSERT INTO java0826.`user`
VALUES ('2', 'user1', '123456', 'user1', 'user1@iflytek.com', '1');
INSERT INTO java0826.`user`
VALUES ('3', 'user2', '123456', 'user2', 'user2@iflytek.com', '1');
