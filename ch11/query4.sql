create user 'std01'@'localhost' identified by '1234';
create user 'std02'@'localhost' identified by '1234';
commit;

grant all privileges on *.* to 'std01'@'localhost';
grant all privileges on *.* to 'std02'@'localhost';
commit;

flush privileges;

select @@autocommit;
set autocommit=0;
lock table 계좌 write;
lock table 고객 read;
commit;