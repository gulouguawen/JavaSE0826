-- 自定义函数

# 创建函数
drop function if exists java0826.getCount;
create function java0826.getCount()
    returns int
    return (select count(id)
            from java0826.product);

# 调用自定义函数
select java0826.getCount() as 'product count';

# 一般情况下函数只是执行某个功能
DROP function if exists procedure_test.transferFuc;
create function procedure_test.transferFuc(inAccount int, outAccount int, amount double)
    returns int
begin
    -- 记录当前 转出账号的 金额（余额）
    DECLARE totalDepositOut double;

    -- 记录当前 转入账号的 金额（余额）
    DECLARE totalDepositIn double;

    -- 转入的账号
    DECLARE inAccountnum int;
    select total into totalDepositOut from Account where accountnum = outAccount;

    -- 如果转出账号没有开户 则退出
    IF totalDepositOut is NULL THEN
        return -1;
    END IF;

    -- 如果转出账号的余额不足 则退出
    IF totalDepositOut < amount THEN
        return -2;
    END IF;

    # 到这里 转出账号满足 转出的要求   注意：select into赋值 查询出来的结果一定只有一条记录，多余一条，赋值失败
    select accountnum into inAccountnum from Account where accountnum = inAccount;

    -- 判断转入账号是否开户
    IF inAccountnum is null THEN
        return -3;
    END IF;

    -- 转出账号的钱开始减少
    update Account set total = total - amount WHERE accountnum = outaccount;

    -- 转入的账号的钱开始增加
    update Account set total =total + amount where accountnum = inAccount;

    -- SQL的异常处理
    return 1;
end;

select procedure_test.transferFuc(111, 222, 333);


-- 内置函数

# 【例6.1】求2，-3.3和-33的绝对值，输入语句如下：
SELECT ABS(2), ABS(-3.3), ABS(-33);

# 【例6.2】返回圆周率值，输入语句如下：
SELECT pi();

# 【例6.3】求9，40和-49的二次平方根，输入语句如下：
SELECT SQRT(9), SQRT(40), SQRT(-49);

# 【例6.4】对MOD(31,8)，MOD(234, 10)，MOD(45.5,6)进行求余运算，输入语句如下：
SELECT MOD(31, 8), MOD(234, 10), MOD(45.5, 6);

# 【例6.5】使用CEILING函数返回最小整数，输入语句如下：
SELECT CEIL(-3.35), CEILING(3.35);

# 【例6.6】使用FLOOR函数返回最大整数，输入语句如下：
SELECT FLOOR(-3.35), FLOOR(3.35);

# 【例6.7】使用RAND()函数产生随机数，输入语句如下：
SELECT RAND(), RAND(), RAND();

# 【例6.8】使用RAND(x)函数产生随机数，输入语句如下：
SELECT RAND(10), RAND(10), RAND(11);

# 【例6.9】使用ROUND(x)函数对操作数进行四舍五入操作，输入语句如下：
SELECT ROUND(-1.14), ROUND(-1.67), ROUND(1.14), ROUND(1.66);

# 【例6.10】使用ROUND(x,y)函数对操作数进行四舍五入操作，结果保留小数点后面指定y位，输入语句如下：
SELECT ROUND(1.38, 1), ROUND(1.38, 0), ROUND(232.38, -1), round(232.38, -2);

# 【例6.11】使用TRUNCATE(x,y)函数对操作数进行四舍五入操作，结果保留小数点后面指定y位，输入语句如下：
SELECT TRUNCATE(1.31, 1), TRUNCATE(1.99, 1), TRUNCATE(1.99, 0), TRUNCATE(19.99, -1);

# 【例6.12】使用SIGN函数返回参数的符号，输入语句如下：
SELECT SIGN(-21), SIGN(0), SIGN(21);

# 【例6.13】使用POW和POWER函数进行乘方运算，输入语句如下：
SELECT POW(2, 2), POWER(2, 2), POW(2, -2), POWER(2, -2);

# 【例6.14】使用EXP函数计算e的乘方，输入语句如下：
SELECT EXP(3), EXP(-3), EXP(0);

# 【例6.15】使用LOG(x)函数计算自然对数，输入语句如下：
SELECT LOG(3), LOG(-3);

# 【例6.16】使用LOG10计算以10为基数的对数，输入语句如下：
SELECT LOG10(2), LOG10(100), LOG10(-100);

# 【例6.17】使用RADIANS将角度转换为弧度，输入语句如下：
SELECT RADIANS(90), RADIANS(180);

# 【例6.18】使用DEGREES将弧度转换为角度，输入语句如下：
SELECT DEGREES(PI()), DEGREES(PI() / 2);

# 【例6.19】使用SIN函数计算正弦值，输入语句如下：
SELECT SIN(1), ROUND(SIN(PI()));

# 【例6.20】使用ASIN函数计算反正弦值，输入语句如下：
SELECT ASIN(0.8414709848078965), ASIN(3);

# 【例6.21】使用COS函数计算余弦值，输入语句如下：
SELECT COS(0), COS(PI()), COS(1);

# 【例6.22】使用ACOS函数计算反余弦值，输入语句如下：
SELECT ACOS(1), ACOS(0), ROUND(ACOS(0.5403023058681398));

# 【例6.23】使用TAN函数计算正切值，输入语句如下：
SELECT TAN(0.3), ROUND(TAN(PI() / 4));

# 【例6.24】使用ATAN函数计算反正切值，输入语句如下：
SELECT ATAN(0.30933624960962325), ATAN(1);

# 【例6.25】使用COT()函数计算余切值，输入语句如下，
SELECT COT(0.3), 1 / TAN(0.3), COT(PI() / 4);

# 【例6.26】使用CHAR_LENGTH函数计算字符串字符个数，输入语句如下：
SELECT CHAR_LENGTH('date'), CHAR_LENGTH('egg');

# 【例6.27】使用LENGTH函数计算字符串长度，输入语句如下：
SELECT LENGTH('date'), LENGTH('egg');

# 【例6.28】使用CONCAT函数连接字符串，输入语句如下：
SELECT CONCAT('My SQL', '5.6'), CONCAT('My', NULL, 'SQL');

# 【例6.29】使用CONCAT_WS函数连接带分隔符的字符串，输入语句如下：
SELECT CONCAT_WS('-', '1st', '2nd', '3rd'), CONCAT_WS('*', '1st', NULL, '3rd');

# 【例6.30】使用INSERT函数进行字符串替代操作，输入语句如下：
SELECT INSERT('Quest', 2, 4, 'What')  AS col1,
       INSERT('Quest', -1, 4, 'What') AS col2,
       INSERT('Quest', 3, 100, 'Wh')  AS col3;

# 【例6.31】使用LOWER函数或者LCASE函数将字符串中所有字母字符转换为小写，输入语句如下：
SELECT LOWER('BEAUTIFUL'), LCASE('Well');

# 【例6.32】使用UPPER函数或者UCASE函数将字符串中所有字母字符转换为大写，输入语句如下：
SELECT UPPER('black'), UCASE('BLacK');

# 【例6.33】使用LEFT函数返回字符串中左边的字符，输入语句如下：
SELECT LEFT('football', 5);

# 【例6.34】使用RIGHT函数返回字符串中右边的字符，输入语句如下：
SELECT RIGHT('football', 4);

# 【例6.35】使用LPAD函数对字符串进行填充操作，输入语句如下：
SELECT LPAD('hello', 4, '??'), LPAD('hello', 10, '??');

# 【例6.36】使用RPAD函数对字符串进行填充操作，输入语句如下：
SELECT RPAD('hello', 4, '?'), RPAD('hello', 10, '?');

# 【例6.37】使用LTRIM函数删除字符串左边的空格，输入语句如下：
SELECT '(  book  )', CONCAT('(', LTRIM('  book  '), ')');

# 【例6.38】SELECT CONCAT( '(',  RTRIM ('  book  '), ')');
SELECT '(  book  )', CONCAT('(', RTRIM('  book  '), ')');

# 【例6.39】SELECT CONCAT( '(',  TRIM('  book  ') , ')');
SELECT '(  book  )', CONCAT('(', TRIM('  book  '), ')');

# 【例6.40】使用TRIM(s1 FROM s)函数删除字符串中两端指定的字符，输入语句如下：
SELECT TRIM('xy' FROM 'xyxboxyokxxyxy');

# 【例6.41】使用REPEAT函数重复生成相同的字符串，输入语句如下：
SELECT REPEAT('MySQL', 3);

# 【例6.42】使用SPACE函数生成由空格组成的字符串，输入语句如下：
SELECT CONCAT('(', SPACE(6), ')');

# 【例6.43】使用REPLACE函数进行字符串替代操作，输入语句如下：
SELECT REPLACE('xxx.mysql.com', 'x', 'w');

# 【例6.44】使用STRCMP函数比较字符串大小，输入语句如下：
SELECT STRCMP('txt', 'txt2'), STRCMP('txt2', 'txt'), STRCMP('txt', 'txt');

# 【例6.45】使用SUBSTRING函数获取指定位置处的子字符串，输入语句如下：
SELECT SUBSTRING('breakfast', 5)    AS col1,
       SUBSTRING('breakfast', 5, 3) AS col2,
       SUBSTRING('lunch', -3)       AS col3,
       SUBSTRING('lunch', -5, 3)    AS col4;

# 【例6.46】使用MID()函数获取指定位置处的子字符串，输入语句如下：
SELECT MID('breakfast', 5)    as col1,
       MID('breakfast', 5, 3) as col2,
       MID('lunch', -3)       as col3,
       MID('lunch', -5, 3)    as col4;

# 【例6.47】使用LOCATE，POSITION，INSTR函数查找字符串中指定子字符串的开始位置，输入语句如下：
SELECT LOCATE('ball', 'football'), POSITION('ball' IN 'football'), INSTR('football', 'ball');

# 【例6.48】使用REVERSE函数反转字符串，输入语句如下：
SELECT REVERSE('abc');

# 【例6.49】使用ELT函数返回指定位置字符串，输入语句如下：
SELECT ELT(3, '1st', '2nd', '3rd'), ELT(3, 'net', 'os');

# 【例6.50】使用FIELD函数返回指定字符串第一次出现的位置，输入语句如下：
SELECT FIELD('Hi', 'hihi', 'Hey', 'Hi', 'bas') as col1,
       FIELD('Hi', 'Hey', 'Lo', 'Hilo', 'foo') as col2;

# 【例6.51】使用FIND_IN_SET()函数返回子字符串在字符串列表中的位置，输入语句如下：
SELECT FIND_IN_SET('Hi', 'hihi,Hey,Hi,bas');

# 【例6.52】使用MAKE_SET根据二进制位选取指定字符串，输入语句如下：
SELECT MAKE_SET(1, 'a', 'b', 'c')                      as col1,
       MAKE_SET(1 | 4, 'hello', 'nice', 'world')       as col2,
       MAKE_SET(1 | 4, 'hello', 'nice', NULL, 'world') as col3,
       MAKE_SET(0, 'a', 'b', 'c')                      as col4;

# 【例6.53】使用日期函数获取系统当前日期，输入语句如下：
SELECT CURDATE(), CURRENT_DATE(), CURDATE() + 0;

# 【例6.54】使用时间函数获取系统当前时间，输入语句如下：
SELECT CURTIME(), CURRENT_TIME(), CURTIME() + 0;

# 【例6.55】使用日期时间函数获取当前系统日期和时间，输入语句如下：
SELECT CURRENT_TIMESTAMP(), LOCALTIME(), NOW(), SYSDATE();

# 【例6.56】使用UNIX_TIMESTAMP函数返回UNIX格式的时间戳，输入语句如下：
SELECT UNIX_TIMESTAMP(), UNIX_TIMESTAMP(NOW()), NOW();

# 【例6.57】使用FROM_UNIXTIME函数将UNIX时间戳转换为普通格式时间，输入语句如下：
SELECT FROM_UNIXTIME('1364098609');

# 【例6.58】使用UTC_DATE()函数返回当前UTC日期值，输入语句如下：
SELECT UTC_DATE(), UTC_DATE() + 0;

# 【例6.59】使用UTC_TIME()函数返回当前UTC时间值，输入语句如下：
SELECT UTC_TIME(), UTC_TIME() + 0;

# 【例6.60】使用MONTH()函数返回指定日期中的月份，输入语句如下：
SELECT MONTH('2013-02-13');

# 【例6.61】使用MONTHNAME()函数返回指定日期中的月份的名称，输入语句如下：
SELECT MONTHNAME('2013-02-13');

# 【例6.62】使用DAYNAME()函数返回指定日期的工作日名称，输入语句如下：
SELECT DAYNAME('2013-02-13');

# 【例6.63】使用DAYOFWEEK()函数返回日期对应的周索引，输入语句如下：
SELECT DAYOFWEEK('2011-02-13');

# 【例6.64】使用WEEKDAY()函数返回日期对应的工作日索引，输入语句如下：
SELECT WEEKDAY('2011-02-13 22:23:00'), WEEKDAY('2011-07-01');

# 【例6.65】使用WEEK()函数查询指定日期是一年中的第几周，输入语句如下：
SELECT WEEK('2011-02-20'), WEEK('2011-02-20', 0), WEEK('2011-02-20', 1);

# 【例6.66】使用WEEKOFYEAR()查询指定日期是一年中的第几周，输入语句如下：
SELECT WEEK('2011-02-20', 3), WEEKOFYEAR('2011-02-20');

# 【例6.67】使用DAYOFYEAR()函数返回指定日期在一年中的位置，输入语句如下：
SELECT DAYOFYEAR('2011-02-20');

# 【例6.68】使用DAYOFYEAR()函数返回指定日期在一个月中的位置，输入语句如下：
SELECT DAYOFMONTH('2011-02-20');

# 【例6.69】使用YEAR()函数返回指定日期对应的年份，输入语句如下：
SELECT YEAR('11-02-03'), YEAR('96-02-03');

# 【例6.70】使用QUARTER()函数返回指定日期对应的季度，输入语句如下：
SELECT QUARTER('11-04-01');

# 【例6.71】使用MINUTE()函数返回指定时间的分钟值，输入语句如下：
SELECT MINUTE('11-02-03 10:10:03');

# 【例6.72】使用SECOND()函数返回指定时间的秒值，输入语句如下：
SELECT SECOND('10:05:03');

# 【例6.73】使用EXTRACT函数提取日期或者时间值，输入语句如下：
SELECT EXTRACT(YEAR FROM '2011-07-02')                AS col1,
       EXTRACT(YEAR_MONTH FROM '2011-07-12 01:02:03') AS col2,
       EXTRACT(DAY_MINUTE FROM '2011-07-12 01:02:03') AS col3;

# 【例6.74】使用TIME_TO_SEC函数将时间值转换为秒值，输入语句如下：
SELECT TIME_TO_SEC('23:23:00');

# 【例6.75】使用SEC_TO_TIME()函数将秒值转换为时间格式，输入语句如下：
SELECT SEC_TO_TIME(2345),
       SEC_TO_TIME(2345) + 0,
       TIME_TO_SEC('23:23:00'),
       SEC_TO_TIME(84180);

# 【例6.76】使用DATE_ADD()和ADDDATE()函数执行日期加操作，输入语句如下：
SELECT DATE_ADD('2010-12-31 23:59:59', INTERVAL 1 SECOND)            AS col1,
       ADDDATE('2010-12-31 23:59:59', INTERVAL 1 SECOND)             AS col2,
       DATE_ADD('2010-12-31 23:59:59', INTERVAL '1:1' MINUTE_SECOND) AS col3;

# 【例6.77】使用DATE_SUB和SUBDATE函数执行日期减操作，输入语句如下：
SELECT DATE_SUB('2011-01-02', INTERVAL 31 DAY)                        AS col1,
       SUBDATE('2011-01-02', INTERVAL 31 DAY)                         AS col2,
       DATE_SUB('2011-01-01 00:01:00', INTERVAL '0 0:1:1' DAY_SECOND) AS col3;

# 【例6.78】使用ADDTIME进行时间加操作，输入语句如下：
SELECT ADDTIME('2000-12-31 23:59:59', '1:1:1'), ADDTIME('02:02:02', '02:00:00');

# 【例6.79】使用SUBTIME()函数执行时间减操作，输入语句如下：
SELECT SUBTIME('2000-12-31 23:59:59', '1:1:1'), SUBTIME('02:02:02', '02:00:00');

# 【例6.80】使用DATEDIFF()函数计算两个日期之间的间隔天数，输入语句如下：
SELECT DATEDIFF('2010-12-31 23:59:59', '2010-12-30') AS col1,
       DATEDIFF('2010-11-30 23:59:59', '2010-12-31') AS col2;

# 【例6.81】使用DATE_FORMAT()函数格式化输出日期和时间值，输入语句如下：
SELECT DATE_FORMAT('1997-10-04 22:23:00', '%W %M %Y')             AS col1,
       DATE_FORMAT('1997-10-04 22:23:00', '%D %y %a %d %m %b %j') AS col2;

# 【例6.82】使用TIME_FORMAT()函数格式化输入时间值，输入语句如下：
SELECT TIME_FORMAT('16:00:00', '%H %k %h %I %l');

# 【例6.83】使用GET_FORMAT()函数显示不同格式化类型下的格式字符串，输入语句如下：
SELECT GET_FORMAT(DATE, 'EUR'), GET_FORMAT(DATE, 'USA');

# 【例6.84】在DATE_FORMAT()函数中，使用GET_FORMAT函数返回的显示格式字符串来显示指定的日期值，输入语句如下：
SELECT DATE_FORMAT('2000-10-05 22:23:00', GET_FORMAT(DATE, 'USA'));

# 【例6.85】使用IF()函数进行条件判断，输入语句如下：
SELECT IF(12, 2, 3),
       IF(1 < 2, 'yes ', 'no'),
       IF(STRCMP('test', 'test1'), 'no', 'yes');

# 【例6.86】使用IFNULL()函数进行条件判断，输入语句如下：
SELECT IFNULL(1, 2), IFNULL(NULL, 10), IFNULL(1 / 0, 'wrong');

# 【例6.87】使用CASE value WHEN语句执行分支操作，输入语句如下：
SELECT CASE 2 WHEN 1 THEN 'one' WHEN 2 THEN 'two' ELSE 'more' END;

# 【例6.88】使用CASE WHEN语句执行分支操作，输入语句如下：
SELECT CASE WHEN 1 < 0 THEN 'true' ELSE 'false' END;

# 【例6.89】查看当前MySQL版本号，输入语句如下：
SELECT VERSION();

# 【例6.90】查看当前用户的连接数，输入语句如下：
SELECT CONNECTION_ID();

# 【例6.91】使用SHOW PROCESSLIST命令输出当前用户的连接信息，输入语句如下：
SHOW PROCESSLIST;

# 【例6.92】查看当前使用的数据库，输入语句如下：
SELECT DATABASE(), SCHEMA();

# 【例6.93】获取当前登录用户名称，输入语句如下：
SELECT USER(), CURRENT_USER(), SYSTEM_USER();

# 【例6.94】使用CHARSET()函数返回字符串使用的字符集，输入语句如下：
SELECT CHARSET('abc'),
       CHARSET(CONVERT('abc' USING latin1)),
       CHARSET(VERSION());

# 【例6.95】使用COLLATION()函数返回字符串排列方式，输入语句如下：
SELECT COLLATION('abc'), COLLATION(CONVERT('abc' USING utf8));

# 【例6.96】使用SELECT LAST_INSERT_ID查看最后一个自动生成的列值，执行过程如下：
# 1．一次插入一条记录
# 首先创建表worker，其Id字段带有AUTO_INCREMENT约束，输入语句如下：
CREATE TABLE worker
(
    Id   INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Name VARCHAR(30)
);
# 分别单独向表worker中插入2条记录：
INSERT INTO worker
VALUES (NULL, 'jimy');

INSERT INTO worker
VALUES (NULL, 'Tom');

SELECT *
FROM worker;

# 查看已经插入的数据可以发现，最后一条插入的记录的Id字段值为2，使用LAST_INSERT_ID()查看最后自动生成的Id值：
SELECT LAST_INSERT_ID();

# 2．一次同时插入多条记录
# 接下来，向表中插入多条记录，输入语句如下：
INSERT INTO worker
VALUES (NULL, 'Kevin'),
       (NULL, 'Michal'),
       (NULL, 'Nick');

# 查询已经插入的的记录，
SELECT *
FROM worker;
SELECT LAST_INSERT_ID();

# 【例6.97】使用PASSWORD函数加密密码，输入语句如下：
SELECT PASSWORD('newpwd');

# 【例6.98】使用MD5函数加密字符串，输入语句如下：
SELECT MD5('mypwd');

# 【例6.99】使用ENCODE加密字符串，输入语句如下：
SELECT ENCODE('secret', 'cry'), LENGTH(ENCODE('secret', 'cry'));

# 【例6.100】使用DECODE函数解密被ENCODE加密的字符串，输入语句如下：
SELECT DECODE(ENCODE('secret', 'cry'), 'cry');


# 【例6.101】使用FORMAT函数格式化数字，保留小数点位数为指定值，输入语句如下：
SELECT FORMAT(12332.123456, 4), FORMAT(12332.1, 4), FORMAT(12332.2, 0);


# 【例6.102】使用CONV函数在不同进制数值之间转换，输入语句如下：
SELECT CONV('a', 16, 2),
       CONV(15, 10, 2),
       CONV(15, 10, 8),
       CONV(15, 10, 16);

# 【例6.103】使用INET_ATON函数将字符串网络点地址转换为数值网络地址，输入语句如下：
SELECT INET_ATON('209.207.224.40');

# 【例6.104】使用INET_NTOA函数将数值网络地址转换为字符串网络点地址，输入语句如下：
SELECT INET_NTOA(3520061480);

# 【例6.105】使用加锁、解锁函数，输入语句如下：
SELECT GET_LOCK('lock1', 10) AS GetLock,
       IS_USED_LOCK('lock1') AS ISUsedLock,
       IS_FREE_LOCK('lock1') AS ISFreeLock,
       RELEASE_LOCK('lock1') AS ReleaseLock;

# 【例6.106】使用BENCHMARK重复执行指定函数。
# 首先，使用PASSWORD函数加密密码，输入语句如下：
SELECT PASSWORD('newpwd');

# 可以看到，PASSWORD执行花费时间为0.00sec，下面使用BENCHMARK函数重复执行PASSWORD操作500000次：
SELECT BENCHMARK(500000, PASSWORD('newpwd'));

# 【例6.107】使用CONVERT()函数改变字符串的默认字符集，输入语句如下：
SELECT CHARSET('string'), CHARSET(CONVERT('string' USING latin1));

# 【例6.108】使用CAST和CONVERT函数进行数据类型的转换，SQL语句如下：
SELECT CAST(100 AS CHAR(2)), CONVERT('2010-10-01 12:12:12', TIME);


