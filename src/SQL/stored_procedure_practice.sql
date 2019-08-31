DROP PROCEDURE transfer;
Create PROCEDURE transfer(inAccount int, outAccount int, amount float)
label_pro:
begin
    DECLARE totalDepositOut Float;
    DECLARE totalDepositIn Float;
    DECLARE inAccountnum int;
    select total into totalDepositOut from Account where accountnum = outAccount;
    IF totalDepositOut is NULL THEN
        rollback;
        leave label_pro;
    END IF;

    IF totalDepositOut < amount THEN
        rollback;
        leave label_pro;
    END IF;

    select accountnum into inAccountnum from Account where accountnum = inAccount;
    IF inAccountnum is null THEN
        rollback;
        leave label_pro;
    END IF;

    update Account set total = total - amount WHERE accountnum = outaccount;
    update Account set total =total + amount where accountnum = inAccount;
    commit;
end;

call transfer(1, 2, 500);
select *
from Account;