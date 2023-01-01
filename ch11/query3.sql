-- 상품 테이블 작성
CREATE TABLE 상품 (상품코드 VARCHAR(6) NOT NULL PRIMARY KEY, 상품명 VARCHAR(30)  NOT NULL, 제조사 VARCHAR(30) NOT NULL, 소비자가격  INT, 재고수량  INT DEFAULT 0);

-- 입고 테이블 작성
CREATE TABLE 입고 (입고번호 INT PRIMARY KEY, 상품코드 VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 입고일자 DATE,입고수량 INT,입고단가 INT);

-- 판매 테이블 작성
CREATE TABLE 판매 (판매번호 INT  PRIMARY KEY,상품코드  VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 판매일자 DATE,판매수량 INT,판매단가 INT);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;

-- [입고] 테﻿이블에 자료가 추가 되는 경우 [상품] 테이블의 재고수량이 되도록 트리거를 작성한다.
-- UPDATE 상품 SET 재고수량 = 재고수량 + NEW.입고수량 WHERE 상품코드 = NEW.상품코드;
-- 문제2) 입고 테이블에 UPDATE 트리거를 작성 한다.
-- [입고] 테이블의 자료가 변경 되는 경우 [상품] 테﻿이블의 재고수량이 변경 되도록 트리거를 작성한다.
-- update 상품 set 재고수량 = 재고수량 - OLD.입고수량 + NEW.입고수량 where 상품코드 = NEW.상품코드;
-- 문제3) 입고 테이블에 DELETE 트리거를 작성 한다.
--  [입고] 테이블의 자료가 삭제되는 경우 [상품] 테이블의 재고수량이 변경 되도록 트리거를 작성한다.
-- update 상품  set 재고수량 = 재고수량 - OLD.입고수량 where 상품코드 = OLD.상품코드;

-- 상품 테이블에 자료 추가 테스트

INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);
COMMIT;
SELECT * FROM 상품;
select * from 입고;

-- AAA라는 상품에 대한 입고수량이 10->8로 변경한다면, 재고수량은 현재값 -10 + 8 연산 필요. 현재값 - 옛날입고수량 + 새로운 입고 수량.

-- UPDATE 테스트
UPDATE 입고 SET 입고수량 = 30 WHERE 입고번호 = 5;
COMMIT;

-- DELETE 테스트
DELETE from 입고 WHERE 입고번호 = 5;
COMMIT;

-- [판매]테이블에 자료가 추가 되는 경우 [상품]테이블의 [재고수량]이 변경 되도록 트리거 작성
-- declare vqty integer;
-- select 재고수량 into vqty from 상품 where 상품코드 = NEW.상품코드;    
-- if vqty>= NEW.판매수량 then		
-- 	update 상품 set 재고수량 = 재고수량 - NEW.판매수량 where 상품코드 = NEW.상품코드;   
-- else
-- 	signal sqlstate '45000' set message_text = '재고수량 부족으로 판매 불가';     
-- end if;

-- 문제4 테스트
INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES
               (1, 'AAAAAA', '2004-11-10', 10, 1000000);
INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES
               (1, 'AAAAAA', '2004-11-10', 20, 1000000);
COMMIT;

-- savepoint / truncate 실습
select @@autocommit;
set autocommit=0; 
drop table new학과;
create table new학과 (select * from 학과);
savepoint t1;
delete from new학과 where 학과번호=01;
savepoint t2;
delete from new학과 where 학과번호=02;
savepoint t3;
delete from new학과 where 학과번호=03;
rollback to t2;
set autocommit=1;
select * from new학과;