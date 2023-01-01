
drop procedure if exists 새수강신청;
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `새수강신청`(in 학번 char(7), out 수강신청_번호 int)
-- BEGIN
-- 	select max(수강신청번호) into 수강신청_번호 from 수강신청;
--     set 수강신청_번호 = 수강신청_번호 + 1;
--     insert into 수강신청(수강신청번호, 학번, 날짜 ,연도, 학기)
--     values(수강신청_번호, 학번, curdate(), '2020', '2');
-- END
call 새수강신청('1804004',@수강신청_번호);
select @수강신청_번호;

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `새학과`(
-- 	in 학과_번호 char(2), in 학과_명 char(20), in 전화_번호 char(20)
-- )
-- BEGIN
--     insert into 학과(학과번호, 학과명, 전화번호)
--     values(학과_번호, 학과_명, 전화_번호);
--     select * from 학과 where 학과번호 = 학과_번호;
-- END
call 새학과('08','컴퓨터보안학과','022-200-7000');

call 통계(@a,@b,@c);
select @a as 학생수, @b as 교수수, @c as 과목수;

delimiter $$
create function userFunc(value1 int, value2 int)
	returns integer
begin 
	return value1 + value2;
end $$
delimiter ; 
select userFunc(100,200);

delimiter $$
create function pass(value int) returns varchar(5)
begin
	return if(value > 0, '취득', '미취득');
end $$
delimiter ;

select 수강신청번호, 과목번호, 평점, pass(평점)
	as '취득여부' from 수강신청내역 where 평점 >= 0;
    
create view 교수정보 as
	select a.사번, a.이름, a.학과, b.학과명 
    from 교수 a, 학과 b 
    where a.학과 = b.학과번호;   
select * from 교수정보 where 학과 = '01';    

drop view if exists 담당교과;
create view 담당교과 as
	select a.사번, a.이름, b.학과명, c.과목명, c.학점
    from 교수 a, 학과 b, 과목 c
    where a.학과 = b.학과번호 and a.사번 = c.담당교수;
select * from 담당교과 where 사번 = '1000001';

drop view if exists 교수별담당과목;
create view 교수별담당과목 as
	select a.사번, a.이름, b.학과명, count(c.담당교수) as 과목수, sum(c.학점) as 학점수
    from 교수 a, 학과 b, 과목 c
    where a.학과 = b.학과번호 and a.사번 = c.담당교수
    group by a.사번;
select * from 교수별담당과목 where 사번 = '1000001';