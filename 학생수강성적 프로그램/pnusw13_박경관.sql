-- 강좌, 학부, 학생 테이블을 생성하고, 데이터 채우기
create table 강좌 (
	강좌이름 varchar(10) not null,
    강의실 varchar(15) not null,   
	primary key(강좌이름)
);
insert into 강좌 values( '데이터베이스', '공학관110');
insert into 강좌 values( '스포츠경영학', '체육관103');
insert into 강좌 values( '자료구조', '공학관101');

create table 학부 (
    학과 varchar(10) not null,
    학과사무실 varchar(10) not null,
	primary key(학과)
);
insert into 학부 values( '컴퓨터공학과', '공학관101');
insert into 학부 values( '체육학과', '체육관101');
insert into 학부 values( '로봇학과', '과학관101');

create table 학생 (
    학생번호 int not null,
	학생이름 varchar(10) not null,
	주소 varchar(20) not null,
    학과 varchar(10) not null,
	primary key(학생번호)
);
insert into 학생 values( 501, '박지성', '영국 맨체스터', '컴퓨터공학과');
insert into 학생 values( 401, '김연아', '대한민국 서울', '체육학과');
insert into 학생 values( 402, '장미란', '대한민국 강원도', '체육학과');
insert into 학생 values( 502, '추신수', '미국 텍사스', '체육학과');
insert into 학생 values( 403, '손흥민', '영국 토트넘', '로봇학과');

insert into 성적 values('501','데이터베이스','3.5');
insert into 성적 values('401','데이터베이스','4.0');
insert into 성적 values('402','스포츠경영학','3.5');
insert into 성적 values('502','자료구조','4.0');
insert into 성적 values('501','자료구조','3.5');
insert into 성적 values('403','데이터베이스','4.0');
insert into 성적 values('403','자료구조','4.0');
insert into 성적 values('403','스포츠경영학','4.0');
