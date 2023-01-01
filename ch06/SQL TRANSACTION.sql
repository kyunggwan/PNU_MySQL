create database money;
USE money;

CREATE TABLE 계좌 (
학생이름 CHAR(13) PRIMARY KEY,
계좌번호 CHAR(15) NOT NULL,
잔액 INT NOT NULL DEFAULT 0
);

SELECT * FROM 계좌;
DELETE FROM 계좌;

INSERT INTO 계좌 VALUES ('정용민', '123435-333333', 450000);
INSERT INTO 계좌 VALUES ('안중근', '123434-666666', 100000);

-- 계좌에서 50000송금
update 계좌 set 잔액 = 잔액 - 50000 where 학생이름 = '정용민';
update 계좌 set 잔액 = 잔액 + 50000 where 학생이름 = '안중근';

-- TRANSACTION, ROLLBACK
-- 잘못 송금될 경우 ROLLBACK하여 전체 TRANSACTION을 취소한다
START TRANSACTION;
update 계좌 set 잔액 = 잔액 - 50000 where 학생이름 = '정용민';
update 계좌 set 잔액 = 잔액 + 50000 where 학생이름 = '안중근';
ROLLBACK;

update 계좌 set 잔액 = 잔액 - 500000 where 학생이름 = '정용민';
update 계좌 set 잔액 = 잔액 + 500000 where 학생이름 = '안중근';

-- 안전한 TRANSACTION실행, WIRE_TRANSFER라는 Stored Procedures사용
CALL WIRE_TRANSFER('정용민', '안중근', 500000);

-- CREATE DEFINER=`musthave`@`%` PROCEDURE `WIRE_TRANSFER`(
-- IN sender CHAR(13),
-- IN recipient CHAR(13),
-- IN amount INT )
-- BEGIN
-- 	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
--     START TRANSACTION;
-- 		UPDATE 계좌 SET 잔액 = 잔액 - amount WHERE 학생이름 = sender;
--      UPDATE 계좌 SET 잔액 = 잔액 + amount WHERE 학생이름 = recipient;
-- 	COMMIT;
-- END