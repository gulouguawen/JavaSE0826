# MySQL数据库的注释  # --
# 数据库的存储与检索
# 数据库的设计 --> 索引语法与视图

create database if not exists staff;

# 创建数据表 dept
CREATE TABLE staff.dept
(
    d_no       INT NOT NULL PRIMARY KEY AUTO_INCREMENT comment 'id',
    d_name     VARCHAR(50) comment '部门名称',
    d_location VARCHAR(100) comment '部门所在地'
);

# 由于employee表dept_no依赖于父表dept的主键d_no，因此需要先创建dept表，然后创建employee表。
CREATE TABLE staff.employee
(
    e_no     INT          NOT NULL PRIMARY KEY,
    e_name   VARCHAR(100) NOT NULL,
    e_gender CHAR(2)      NOT NULL,
    dept_no  INT          NOT NULL,
    e_job    VARCHAR(100) NOT NULL,
    e_salary SMALLINT     NOT NULL,
    hireDate DATE,
    CONSTRAINT dno_fk FOREIGN KEY (dept_no)
        REFERENCES staff.dept (d_no)
);

# 将指定记录分别插入两个表中。
# 向dept表中插入数据，SQL语句如下：
INSERT INTO staff.dept
VALUES (10, 'ACCOUNTING', 'ShangHai'),
       (20, 'RESEARCH ', 'BeiJing '),
       (30, 'SALES ', 'ShenZhen '),
       (40, 'OPERATIONS ', 'FuJian ');
# 向employee表中插入数据，SQL语句如下：
INSERT INTO staff.employee
VALUES (1001, 'SMITH', 'm', 20, 'CLERK', 925, '2007-10-12'),
       (1002, 'ALLEN', 'f', 30, 'SALESMAN', 2100, '2004-05-18'),
       (1003, 'WARD', 'f', 30, 'SALESMAN', 1250, '2003-05-12'),
       (1004, 'JONES', 'm', 20, 'MANAGER', 2975, '1998-05-18'),
       (1005, 'MARTIN', 'm', 30, 'SALESMAN', 2250, '2003-06-02'),
       (1006, 'BLAKE', 'f', 30, 'MANAGER', 2650, '1995-02-15'),
       (1007, 'CLARK', 'm', 10, 'MANAGER', 2450, '2002-09-20'),
       (1008, 'SCOTT', 'm', 20, 'ANALYST', 2000, '2003-05-17'),
       (1009, 'KING', 'f', 10, 'PRESIDENT', 5100, '1995-01-11'),
       (1010, 'TURNER', 'f', 30, 'SALESMAN', 1500, '1994-10-16'),
       (1011, 'ADAMS', 'm', 20, 'CLERK', 1100, '1999-10-05'),
       (1012, 'JAMES', 'm', 30, 'CLERK', 1950, '2008-06-15');
#   在employee表中，查询所有记录的e_no、e_name和e_salary字段值。

SELECT e_no, e_name, e_salary
FROM staff.employee;

#   在employee表中，查询dept_no等于10和20的所有记录。
SELECT *
FROM staff.employee
WHERE dept_no IN (10, 20);

#   在employee表中，查询工资范围在1000~3000之间的员工信息。
SELECT *
FROM staff.employee
WHERE e_salary BETWEEN 1000 AND 3000;

#   在employee表中，查询部门编号为20的部门中的员工信息。
SELECT *
FROM staff.employee
WHERE dept_no = 20;

#   在employee表中，查询每个部门最高工资的员工信息。
select ee.*
from staff.employee ee
where exists
          (select e.dept_no, max(e_salary)
           from staff.employee e
           where e.dept_no = ee.dept_no
           group by e.dept_no
           having max(e_salary) = ee.e_salary);

#   查询员工BLAKE所在部门和部门所在地。
SELECT d_no, d_location
FROM staff.dept
WHERE d_no =
      (SELECT dept_no FROM staff.employee WHERE e_name = 'BLAKE');

#   使用连接查询，查询所有员工的部门信息。
select e_no, e_name, d_no, d_location, d_name
from staff.employee
         left outer join staff.dept
                         on employee.dept_no = dept.d_no;

#   在employee表中，计算每个部门各有多少名员工。
SELECT dept_no, COUNT(*)
FROM staff.employee
GROUP BY dept_no;

#   在employee表中，计算不同类型职工的总工资数。
SELECT e_job, SUM(e_salary)
FROM staff.employee
GROUP BY e_job;

#   在employee表中，计算不同部门的平均工资。
SELECT dept_no, AVG(e_salary)
FROM staff.employee
GROUP BY dept_no;

#   在employee表中，查询工资低于1500的员工信息。
SELECT *
FROM staff.employee
WHERE e_salary < 1500;

#   在employee表中，将查询记录先按部门编号由高到低排列，再按员工工资由高到低排列。
SELECT e_name, dept_no, e_salary
FROM staff.employee
ORDER BY dept_no DESC, e_salary DESC;

#   在employee表中，查询员工姓名以字母’A’或’S’开头的员工的信息。
SELECT *
FROM staff.employee
WHERE e_name REGEXP '^[as]';

#   在employee表中，查询到目前为止，工龄大于等于18年的员工信息。
SELECT *
FROM staff.employee
where YEAR(CURDATE()) - YEAR(hireDate) >= 18;
