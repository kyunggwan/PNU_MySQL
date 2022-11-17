-- 뷰 실습 1
CREATE VIEW 교수정보 AS
SELECT 교수.사번, 교수.이름, 학과.학과번호, 학과.학과명
FROM 교수, 학과
WHERE 교수.학과 = 학과.학과번호;

SELECT * FROM 교수정보 WHERE 학과번호 = '01';
-- 뷰 실습 2
create view 담당교과 as
select 교수.사번, 교수.이름, 학과.학과명, 과목.과목명, 과목.학점
from 교수, 학과, 과목
where 교수.학과 = 학과.학과번호;

select * from 담당교과 where 사번 = '1000001'; 
drop view 담당교과;

-- 뷰 실습 3
create view 교수별담당과목 as
select 교수.사번, 교수.이름, 학과.학과명, count(과목명) as '과목수', sum(과목.학점) as '학점수'
from 교수, 학과, 과목
where 교수.학과 = 학과.학과번호 and 과목.담당교수 = 교수.사번
group by 과목.담당교수;

drop view 교수별담당과목;
select * from 교수별담당과목 where 사번 = '1000001'; 