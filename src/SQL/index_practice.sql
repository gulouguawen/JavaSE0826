# --创建测试表
CREATE TABLE test_table1
(
    id          INT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        CHAR(100) NOT NULL,
    address     CHAR(100) NOT NULL,
    description CHAR(100) NOT NULL,
    UNIQUE INDEX UniqIdx (id),
    INDEX MultiColIdx (name(20), address(30)),
    INDEX ComIdx (description(30))
);

# test_table1表中成功创建了3个索引，分别是：在id字段上名称为UniqIdx的唯一索引；
# 在name和address字段上的组合索引，两个索引列的长度分别为20个字符和30个字符；
# 在description字段上的长度为30的普通索引。
#
# 创建表test_table2，存储引擎为MyISAM
CREATE TABLE test_table2
(
    id         INT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    firstname  CHAR(100) NOT NULL,
    middlename CHAR(100) NOT NULL,
    lastname   CHAR(100) NOT NULL,
    birth      DATE      NOT NULL,
    title      CHAR(100) NULL
) ENGINE = MyISAM;

# 使用ALTER TABLE语句在表test_table2的birth字段上，建立名称为ComDateIdx的普通索引。
ALTER TABLE test_table2
    ADD INDEX ComDateIdx (birth);

# 使用ALTER TABLE语句在表test_table2的id字段上，添加名称为UniqIdx2的唯一索引，并以降序排列。
ALTER TABLE test_table2
    ADD UNIQUE INDEX UniqIdx2 (id DESC);

# 使用CREATE INDEX在firstname、middlename和lastname3个字段上建立名称为MultiColIdx2的组合索引。
CREATE INDEX MultiColIdx2 ON test_table2 (firstname, middlename, lastname);

# 使用CREATE INDEX在title字段上建立名称为FTIdx的全文索引。
CREATE FULLTEXT INDEX FTIdx ON test_table2 (title);

# 使用ALTER TABLE语句删除表test_table1中名称为UniqIdx的唯一索引。
ALTER TABLE test_table1
    DROP INDEX UniqIdx;

# 使用DROP INDEX语句删除表test_table2中名称为MultiColIdx2的组合索引。
DROP INDEX MultiColIdx2 ON test_table2;
