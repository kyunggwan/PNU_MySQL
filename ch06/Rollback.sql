-- 학과명이 update되는데 rollback 하면 원래대로 돌아감
select * from 학과;
update 학과 set 학과명 = '고분자공학과' where 학과번호 ='01';
rollback;

-- commit은 rollback해도 안바뀜
select * from 학과;
update 학과 set 학과명 = '컴퓨터공학과' where 학과번호 ='01';
-- commit 을 해버리면 rollback해도 update내용이 되돌아가지 않는다.
commit;
rollback;

-- 보통 commit 기본 값이 1이라 0으로 바꿔줌
select @@autocommit;
set autocommit =0;

-- 테이블 복사
create table new학과 (select * from 학과);
select * from new학과;
drop table new학과;

savepoint t1;
delete from new학과 where 학과번호 =01;

savepoint t2;
delete from new학과 where 학과번호 =02;

savepoint t3;
delete from new학과 where 학과번호 =03;

rollback to t2;

-- 인덱스 사용 확인
-- 돋보기 누르면 visual explan기능 사용 가능
select 과목.과목번호, 과목.과목명, 과목.이수구분, 교수.이름
from 과목 inner join 교수
on 과목.담당교수 = 교수.사번
where 과목.영문명 like 'com%'
order by 교수.이름;