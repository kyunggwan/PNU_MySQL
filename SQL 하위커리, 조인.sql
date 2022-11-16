-- 하위 커리 이용
select 학과, 이름, 학년
from 학생
where 학번 in(select 학번
	from 수강신청
	where 수강신청번호 in (select 수강신청번호
						from 수강신청내역
						where 과목번호 = 'k20002'));
                        
-- 정보 출력
select * from 교수;

-- 이너 조인
SELECT 교수.사번, 교수.이름, 과목.과목명
FROM 교수 INNER JOIN 과목
ON 교수.사번 = 과목.담당교수;

-- 아우터 조인, 강의 안하는 교수 정보 출력
SELECT 교수.사번, 교수.이름, 과목.과목명
FROM 교수 LEFT OUTER JOIN 과목
ON 교수.사번 = 과목.담당교수;

SELECT 교수.사번, 교수.이름, 과목.과목명
FROM 과목 RIGHT OUTER JOIN 교수
ON 교수.사번 = 과목.담당교수;

-- 강의 안하는 교수의 정보 조회
select 교수.사번, 교수.이름 
from 교수
left outer join 과목 on 교수.사번 = 과목.담당교수
where 과목.과목명 is null;

-- 조인에서 집계 함수 사용
SELECT 교수.사번, 교수.이름, COUNT(과목.과목번호) AS 담당과목수
FROM 교수 INNER JOIN 과목
ON 교수.사번 = 과목.담당교수
GROUP BY 교수.사번;

SELECT 교수.사번, 교수.이름, COUNT(과목.과목번호) AS 담당과목수
FROM 교수 LEFT OUTER JOIN 과목
ON 교수.사번 = 과목.담당교수
GROUP BY 교수.사번;