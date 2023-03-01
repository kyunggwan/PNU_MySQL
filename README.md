<!--
# MySQL
### 1장 . UBUNTU MySQL 설치
+ VirtualBox 가상 머신 설치
+ 우분투 MySQL설치  

### 2장. MySQL Workbench
+ 테이블 생성, 삭제
+ 테이블 입력
+ Trigger
+ SQL 데이터 입력, 수정, 삭제
+ 데이터 검색 및 원하는 정보 출력

### 3장. 데이터베이스 개념
+ 데이터베이스 정의
+ 데이터베이스 개념적 구성
+ 관계형 데이터 모델
+ 데이터베이스 모델링

### 4장. MySQL WorkBench ER 모델링

### 5장. DataBase System Architecture
- 3단계 데이터시스템 구조
- External Level의 extenal schema
- Conceptual Level의 conceptual view
- Internal Level의 internal schema
- 3단계 스키마 간의 Mapping
- DBA의 역할
- DBMS
- 분산 데이터베이스 처리

### 6장. Relational 데이터베이스
- Relational Systems
-Relational 데이터 모델
- Relational expression에 의한 최적화
- 스키마 테이블
- Base relations과 Views
- Transactions 처리

### 7장. Relational algebra
- SQL의 relational algebra 요소
- Relational closure 성질
- Relational algebra의 확장된 연산자들
- Relational algebra를 사용한 표현 예제
- Query 처리 실습

### 11장. Stored Procedure 프로그래밍
- Stored procedure
- procedual 구문
- 예외처리
- 동적 SQL
- stored function
- cursor
- Trigger

### 12장. 함수 종속성과 Normal Form
- 함수 종속성 정의
- 함수 종속성의 Closure
- Nomalization: 1NF, 2NF, 3NF, BCNF
- Nonloss decomposition과 함수 종속성
- Update Anomaly
- 2NF와 3NF
- 올바른 decomposition 방법
- Boyce/Codd Normal Form

### 15장. DB 연동 프로그래밍

--- 
-->
## 명령어, 쿼리문 모음
```
  • 테이블(Table) : 서로 연관된 레코드의 집합.
  • 레코드(Record) : 하나의 단위로 취급되는 자료의 집합. =열(column) = 속성(attribute)
  • 필드(Field) : 가장 작은 단위의 데이터를 의미. = 행(row) = 튜플(tuple)
```
  ![row, colum 구분](https://user-images.githubusercontent.com/51871037/201661348-893fd445-ffdb-4526-b3e9-477ccfe0bca4.PNG)
---

### 1. MySql 접속
```
  1) 터미널: mysql -h localhost -u root -p
  2) 워크벤치: mysql 실행
```

### 2. Database
```
  1) DB생성
     • create database <DB명> character set utf9 collate utf8_general_ci;

  2) DB조회
     • show databases;

  3) DB사용
     • use <DB명>;

  4) DB삭제
     • drop databases <DB명>;
```

### 3. Table
```
  1) table 생성
     • create table <테이블이름> (컬럼명1 data_type, 컬럼명2 data_type ...);

  2) 자주쓰는 data_type
     (2-1) Text: CHAR(size), VARCHAR(size)
     (2-2) Num: INT(size), DECIMAL(size, d)
     (2-3) Date: DATE, DATETIME, TIMESTAMP

  3) table보기
     • show tables;

  4) table 구조파악
     • desc <테이블명>;
```

### 4. CRUD 명령어

   **1) Create**
```
      • insert into <테이블명>(컬럼명1, 컬럼명2) values (컬럼1의값, 컬럼2의 값);
```
   **2) Read**
```
  (1) 기본
      • select * from <테이블명?;

      • select <컬럼명1, 컬럼명2> from <테이블명> where (not) <조건>;

      • select <컬럼명1, 컬럼명2> from <테이블명> where <조건> limit <조회할 row 수>;

      •  select * from <테이블명> where <필드명> (not) between A and B;

      • select * from <테이블명> where <필드명> (not) in (A,B);
         => select * from <테이블명> where <필드명> = A or <필드명> = B;

      • select * from <테이블명> where <필드명> (not) like '%문자열%';

      • select * from <테이블명> where <필드명> is (not) null;

      • select count(*) from <테이블명> where <조건>;

  (2) group by 
      • select * from <테이블명> group by <기준 필드명>;

      • select * from <테이블명> group by <기준 필드명> having <조건>;
         ex) select deptno, avg(sal) from emp group by deptno having avg(sal) >=2000;
         ** avg, sum, count

  (3) order by 
      • select * from <테이블명> order by <기준 필드명> <asc or desc>;       // asc: 오름차순, desc: 내림차순

      • select <필드명1, 필드명2> from <테이블명> order by <필드명1> desc, <필드명2> asc;
```
  **3) Update**
```
      • update <테이블명> set <기존컬럼명> = "업데이트컬럼명" where <조건>;

      • on duplicate key update  <컬럼명1> = 값1, <컬럼명2> = 값2
         ex) inset into 'test' (name, place) values ('김삼돌, '올레플라자') on duplicate key update name = '김삼돌', place = '종로5가';
         
      • alter table <테이블명> add <컬럼명> data_type(자료형길이) 제약조건;
```
  **4) Delete**
```
      • delete from <테이블명> where <조건>;
      
      • truncate <테이블명>;
      
      • drop procedure IF EXIST <procedure명>;       //drop은 view, table 등에도 사용가능
```
![삭제명령어 비교](https://user-images.githubusercontent.com/51871037/204079747-ef9b996b-1540-4388-996c-83bd20fe68cf.PNG)

### 5. Join
```
  1) inner Join
     • select * from A 별칭a (inner) join B 별칭b on a.key = b.key;
       => select <A컬럼명1, B컬럼명2> from A 별칭a , B 별칭b where a.A컬럼명 = b.B컬럼명; (where이하 join조건)

  2) left Join
     • select * from A left join B on A.key = B.key;

  3) left anti Join
     • select * from A left join B on A.key = B.key where B.key is null;
     
  4) right join
     • select * from A right join B on A.key = B.key;

  5) right anti join
     • select * from A right join B on A.key = B.key where A.key is null;

  6) full outer join(합집합)
     • select * from A full outer join B on A.key = B.key;

  7) full outer join (차집합)
     • select * from A full outer join on A.key = B.key where A.key is null of B.key is null;
```

### 6. 서브쿼리
```
  1) select <컬럼명> from <테이블명> where <조건컬럼명> = (select <컬럼명*> from <테이블명*> where <조건*>);
      ex) select dname from dept where deptno = (select deptno from emp where ename = 'JONES');
          : emp에서 ename이 'jones'라는 사람이 속한 deptno 의 dname 을 dept에서 찾기. 

  2) select <컬럼명1, 컬럼명2, 컬럼명3> from emp where <조건럼명> > (select 조건컬럼명 from <테이블명>) order by <컬럼명> desc;
      ex) select empno, ename, sal from emp where sal > (select avg(sal) from emp) order by sal desc;
          : emp에서 평균sal보다 sal이 큰 사람들의 empno, ename, sal을 내림차순으로 정렬.

  3) select <컬럼명1, 컬럼명2> from <테이블명> where <조건컬럼명1> = (select max<조건컬럼명1> from <테이블명> where <조건>);
      ex) select empno, ename from emp where sal = (select max(sal) from emp where deptno = 10);
          : deptno가 10인 사원 중 sal이 가장 큰 사람과 같은 sal을 받는 사람의 empno와 ename 조회.
```

