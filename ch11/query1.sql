select sum(status) from s where city='London';
call getStatus('London', @total);
select @total;

create table 계좌 (
	학생이름 char(13) primary key,
    계좌번호 char(15) not null,
    잔액 int not null default 0
);

insert into 계좌 values ('정용민','123435-333333',450000);
insert into 계좌 values ('안중근','123434-666666',100000);
select * from 계좌;
delete from 계좌;

-- 정용민 계좌에서 안중근 계좌로 50000원 송금
update 계좌 set 잔액 = 잔액 - 50000 where 학생이름='정용민';
update 계좌 set 잔액 = 잔액 + 50000 where 학생이름='안중근';
select * from 계좌;
-- 정용민 계좌에서 안중근 계좌로 500000원 송금
update 계좌 set 잔액 = 잔액 - 500000 where 학생이름='정용민';
update 계좌 set 잔액 = 잔액 + 500000 where 학생이름='안중근';
select * from 계좌;
-- 트랜잭션 수행
start transaction;
update 계좌 set 잔액 = 잔액 - 500000 where 학생이름='정용민';
update 계좌 set 잔액 = 잔액 + 500000 where 학생이름='안중근';
rollback;
-- rollback문을 수행하여 오류가 발생한 전체 트랜잭션을 취소
-- 트랜잭션 시작 이전의 상태로 값이 복원

-- 안전한 트랜잭션 수행 : wire_transfer procedure 생성
call wire_transfer('정용민','안중근',100000);
select * from 계좌;