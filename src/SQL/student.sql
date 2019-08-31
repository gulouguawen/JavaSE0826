create database if not exists student;
# 步骤1：创建学生表stu，插入3条记录。
DROP TABLE IF EXISTS student.stu;
CREATE TABLE student.stu
(
    s_id   INT PRIMARY KEY,
    s_name VARCHAR(20),
    addr   VARCHAR(50),
    tel    VARCHAR(50)
);
INSERT INTO student.stu
VALUES (1, 'XiaoWang', 'Henan', '0371-12345678'),
       (2, 'XiaoLi', 'Hebei', '13889072345'),
       (3, 'XiaoTian', 'Henan', '0371-12345670');


# 步骤2：创建报名表sign，插入3条记录。
drop table if exists student.sign;
CREATE TABLE student.sign
(
    s_id       INT PRIMARY KEY,
    s_name     VARCHAR(20),
    s_sch      VARCHAR(50),
    s_sign_sch VARCHAR(50)
);

INSERT INTO student.sign
VALUES (1, 'XiaoWang', 'Middle School1', 'Peking University'),
       (2, 'XiaoLi', 'Middle School2', 'Tsinghua University'),
       (3, 'XiaoTian', 'Middle School3', 'Tsinghua University');


# 步骤3：创建成绩表stu_mark，插入3条记录。
drop TABLE if exists student.stu_mark;
CREATE TABLE student.stu_mark
(
    s_id   INT PRIMARY KEY,
    s_name VARCHAR(20),
    mark   int
);
INSERT INTO student.stu_mark
VALUES (1, 'XiaoWang', 80),
       (2, 'XiaoLi', 71),
       (3, 'XiaoTian', 70);


# 步骤4：创建考上Peking University的学生的视图
drop view if exists student.Peking;
CREATE VIEW student.Peking (id, name, mark, sch)
AS
SELECT student.stu_mark.s_id, student.stu_mark.s_name, student.stu_mark.mark, student.sign.s_sign_sch
FROM student.stu_mark,
     student.sign
WHERE student.stu_mark.s_id = sign.s_id
  AND student.stu_mark.mark >= 41
  AND student.sign.s_sign_sch = 'Peking University';


# 步骤5：创建考上Tsinghua University的学生的视图
drop view if exists student.Tsinghua;
CREATE VIEW student.Tsinghua (id, name, mark, sch)
AS
SELECT student.stu_mark.s_id, student.stu_mark.s_name, student.stu_mark.mark, sign.s_sign_sch
FROM student.stu_mark,
     student.sign
WHERE student.stu_mark.s_id = sign.s_id
  AND student.stu_mark.mark >= 40
  AND student.sign.s_sign_sch = 'Tsinghua University';


# 步骤6：XiaoTian的成绩在录入的时候录入错误多录了50分，对其录入成绩进行更正。
UPDATE student.stu_mark
SET mark = mark - 50
WHERE student.stu_mark.s_name = 'XiaoTian';


# 步骤7：查看更新过后视图和表的情况。
SELECT *
FROM student.stu_mark;
SELECT *
FROM student.Tsinghua;
SELECT *
FROM student.Peking;

# 步骤8：查看视图的创建信息。
SELECT *
FROM information_schema.views;


#     步骤9：删除创建的视图。
DROP VIEW student.Peking;
DROP VIEW student.Tsinghua;