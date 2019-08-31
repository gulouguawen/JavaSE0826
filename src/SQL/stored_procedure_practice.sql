create database if not exists procedure_test;

drop table if exists procedure_test.Account;
create table procedure_test.Account
(
    id         int auto_increment primary key,
    accountnum int    not null,
    total      double not null
);

insert into procedure_test.Account (accountnum, total)
values ('111', '99999.9'),
       ('222', '99999.9'),
       ('333', '99999.9'),
       ('444', '99999.9'),
       ('555', '99999.9');

select *
from procedure_test.Account;

DROP PROCEDURE if exists procedure_test.transfer;
-- 转账
Create PROCEDURE procedure_test.transfer(inAccount int, outAccount int, amount double)
-- label_pro 标记 用来标记下位置，用途：用来进行退出   存储过程中不支持return
label_pro:
begin
    #begin
    -- 记录当前 转出账号的 金额（余额）
    DECLARE totalDepositOut double;

    -- 记录当前 转入账号的 金额（余额）
    DECLARE totalDepositIn double;

    -- 转入的账号
    DECLARE inAccountnum int;
    select total into totalDepositOut from procedure_test.Account where accountnum = outAccount;

    -- 如果转出账号没有开户 则退出
    IF totalDepositOut is NULL THEN
        rollback;
        leave label_pro;
    END IF;

    -- 如果转出账号的余额不足 则退出
    IF totalDepositOut < amount THEN
        rollback;
        leave label_pro;
    END IF;

    # 到这里 转出账号满足 转出的要求   注意：select into赋值 查询出来的结果一定只有一条记录，多余一条，赋值失败
    select accountnum into inAccountnum from procedure_test.Account where accountnum = inAccount;

    -- 判断转入账号是否开户
    IF inAccountnum is null THEN
        rollback;
        leave label_pro;
    END IF;

    -- 转出账号的钱开始减少
    update procedure_test.Account set total = total - amount WHERE accountnum = outaccount;

    -- 转入的账号的钱开始增加
    update procedure_test.Account set total =total + amount where accountnum = inAccount;
    select * from procedure_test.Account;
    commit;
end;

call procedure_test.transfer(111, 333, 6666);

select *
from procedure_test.Account;

# 新建存储过程
create procedure student.proc()
begin
    select * from student.tsinghua;
end;

# 调用存储过程
call student.proc();

# 删除存储过程
drop procedure student.proc;