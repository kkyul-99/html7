-- 신규 user 등록
-- create user c##user1 identified by 1111;

-- ctrl + enter: 1줄 실행
-- user 권한 설정
-- grant connect,resource,dba to c##user1;

-- c## 명령어 생략 가능
alter session set "_ORACLE_SCRIPT"=true;

create user ora_user identified by 1111;

grant connect,resource,dba to ora_user;
