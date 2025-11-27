select sysdate from dual;
select sysdate-1,sysdate,sysdate+1 from dual;

-- 날짜함수 +,-,<,> 가능
select * from board;
select bdate from board where bdate>'2025/11/01';

-- 컬럼합치기 - concat,||
select concat(btitle,bcontent) from board;
select btitle||bcontent from board;

select * from member;
select id||'-'||pw||'-'||name as tel from member;

-- 현재일 - 입사일 -> 가장 오래 근무한 사원순으로 출력하시오.
select * from employees;
select sysdate-hire_date hdate from employees order by hdate desc;

-- board 현재 게시글날짜가 얼마나 지났는지 출력하시오.
-- 소수점 2자리에서 반올림하시오.
select sysdate-bdate from board;
select round(sysdate-bdate,2)from board;
select trunc(sysdate-bdate,4)from board;

select * from member;
select * from board;
select * from stuscore order by sno desc;

-- 날짜함수
-- hh24:mi:ss - 24시 표기
-- am hh:mi:ss - 오전/오후 표기
select to_char(sdate,'yyyy-mm-dd am hh:mi:ss') from stuscore order by sno desc;

insert into stuscore values(
stuscore_seq.nextval,'이순신',80,81,88,(80+81+88),(80+81+88)/3,sysdate
);

commit;
select hire_date from employees;

-- round: 반올림 / month - 15일 이후는 1개월 추가
select hire_date,round(hire_date,'month') from employees;
-- trunc: 버림 / month - 그 달 1일로 변경
select hire_date,trunc(hire_date,'month') from employees order by hire_date;
-- day - 수요일 기준 이전 -> 일요일, 이후 -> 다음 일요일
select hire_date,round(hire_date,'day') from employees;
select bdate,round(bdate,'day') from board;

-- board 테이블에서 입력한 게시글 기준 그 달 1일을 출력하시오.
select bdate,trunc(bdate,'month') from board;
-- 가입한 회원 중 9월달 생일자를 검색해서 생일쿠폰을 제공하시오.
select * from board where to_char(bdate,'mm') = '09';
-- 2024-12-01 ~ 2025-05-31 까지 게시글을 출력하시오.
select bdate,trunc(bdate,'month'),bdate-30 from board
where bdate between '2024-12-01' and '2025-05-31'
order by bdate;

select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board;
select bdate,trunc(bdate,'month') from board;
select bdate,trunc(bdate,'yyyy') from board;
select bdate,trunc(bdate,'mm') from board;

-- hh - 30분 이상이면 1시간 추가
select name,to_char(sdate,'yyyy-mm-dd hh:mi:ss'),
to_char(trunc(sdate,'hh'),'yyyy-mm-dd hh:mi:ss') from stuscore;

-- months_between 두 컬럼의 개월 수를 확인
select sysdate,sdate,
trunc(months_between(sysdate,sdate))||'개월' from stuscore
where months_between(sysdate-1,sdate) = 9
;

-- add_months: 특정 개월수를 더한 날짜 확인
select name,sdate,add_months(sdate,6) from stuscore;

-- 문자열 함수
-- length: 문자의 길이 / lengthb: 문자의 바이트 수
select name,length(name),lengthb(name) from stuscore;

-- substr: 문자자르기(컬럼명,시작위치,개수)
select name,substr(name,0,2) from stuscore;

-- s1423,s2798 -> 숫자의 합을 구하시오.
select substr('s1423',2,4),substr('s2798',2,4) from dual;
select to_number(substr('s1423',2,4)),to_number(substr('s2798',2,4)) from dual;
select to_number(substr('s1423',2,4))+to_number(substr('s2798',2,4)) from dual;

select (kor+eng+math)/3 from stuscore;
select id||pw from member;

-- instr 함수
select name from member;
-- ni가 포함되어 있는 이름을 출력하시오.
select name from member where name like '%ni%';

-- !=, <>, ^=
select name, instr(name,'n') from member
where instr(name,'n') != 0
;

-- trim 함수: 공백제거(ltrim - 왼쪽 공백제거 ,rtrim - 오른쪽 공백제거)
select '     ab   c     ' from dual;
select ltrim('     ab   c     ') from dual;
select rtrim('     ab   c     ') from dual;
select trim('     ab   c     ') from dual;

-- replace 다른문자로 대체 - 문자 사이의 공백 제거
select replace('     ab   c     ',' ','') from dual;

select replace('rove,rive,rife','r','l') from dual;
select 'rove,rive,rifee' from dual;

select name,replace(name,'r','l') from member
where name like '%r%';

select id,pw from member;
select id,rpad(substr(pw,0,2),4,'*') as pw from member;

select sysdate-1,sysdate,sysdate+1,sysdate-hire_date from employees;

create table stu (
sno number(4),
name varchar2(100),
sdate date,
sdate2 date
);

insert into stu(sno,name,sdate) select sno,name,sdate from stuscore;
select * from stu;

-- sdate2 10년 후 날짜를 입력.
select sno,name,sdate,sdate2,add_months(sdate,120) from stu;

-- 유관순 sdate2 오늘날짜 입력하시오.
update stu set sdate2 = sysdate where name = '유관순';

update stu a set sdate2 = (
select add_months(sdate,120) from stu b
where a.sno = b.sno
);

select hire_date,trunc(hire_date,'month'),last_day(hire_date) from employees;
select sysdate,next_day(sysdate,'월요일') from dual;

select * from stuscore;
select sno,name,total,rank() over(order by total desc) from stuscore;

-- 형변환 함수 to_char(),to_number(),to_date()
-- to_char(): 천단위 표시
-- '000,000': 빈자리 0으로 채움 / '999,999': 빈자리 공백으로 채움
-- 쉼표(,): 천단위 표시 / 점(.): 소수점
select salary,salary*12,salary*12*1473 from employees;
-- 12,000,000: 쉼표 - 문자열
select salary,to_char(salary*12,'$000,999'),to_char(salary*12*1473,'L999,999,999.00') from employees;

-- to_char(): 문자열 함수 변환
-- to_char(컬럼명,'yyyy-mm-dd hh24:mi:ss day')
select sdate from stuscore;
select sdate,to_char(sdate,'yyyy-mm-dd mon hh24:mi:ss day') from stuscore;
select sdate,to_char(sdate,'yyyy/mm/dd') from stuscore;
select sdate,to_char(sdate,'mm') from stuscore;
select sdate,substr(to_char(sdate),4,2) from stuscore;

select phone,substr(phone,1,3),substr(phone,5,3),substr(phone,9,4) from member;

-- to_date(): 문자열을 날짜로 변경
-- 주로 날짜 간의 연산이 필요할 경우 문자열을 날짜타입으로 변경
select sysdate-'20251027' from dual;
select sysdate-to_date('20251027','yyyymmdd') from dual;
select add_months(to_date('20251027','yyyymmdd'),1) from dual;
select months_between(sysdate,to_date('20251027','yyyymmdd')) from dual;

-- to_number(): 문자열을 숫자로 변경
select '20,000','30,000' from dual;
select to_number('20,000','99,999'),to_number(replace('30,000',',','')) from dual;
select '30000',to_number('30000') from dual;

select to_char(salary,'99,999'),to_char(salary*12,'999,999') y_salary,to_char(salary*12*1473,'999,999,999') y_ksalary from employees;

--------------------------------------------------
-- 그룹함수 count,max,min,avg,sum
-- 그룹함수와 단일함수(일반 컬럼 조회)는 함께 사용할 수 없음
select max(kor),min(kor),avg(kor),median(kor),count(*) from stuscore;
select variance(kor),stddev(kor) from stuscore;
select count(*),sum(salary),avg(salary),max(salary),min(salary) from employees;

select department_id,salary from employees;
select sum(salary),round(avg(salary),2),max(salary),min(salary),count(salary) from employees
where department_id = 50;

select max(salary) from employees
where department_id = 50;

select emp_name from employees
where department_id = 50 and salary=(
select max(salary) from employees
where department_id = 50
);
-- select emp_name from employees where department_id = 50 and salary=(8200);

select emp_name from employees
where salary=(select max(salary) from employees);

-- 평균월급보다 높은 사원을 출력하시오.
-- 평균월급
select avg(salary) from employees;

select emp_name,salary from employees
where salary>=(select avg(salary) from employees);

-- stuscore에서 국어 점수가 평균 이상인 사람이 몇명인지 출력하시오.
select count(*) from stuscore
where kor>=(select avg(kor) from stuscore);

-- count(*)
select count(*) from employees; -- 107명
select count(emp_name) from employees; -- 107명
select count(manager_id) from employees; -- 106명 null값이 있으면 count에 포함되지 않음

select manager_id from employees
where manager_id is null;

-- stuscore 테이블 total 컬럼을 비교해서
-- 입력한 점수보다 합계점수가 높은 학생이 몇명인지 출력하시오.
select count(total) from stuscore where total>=120;

-- 520-***-1397 *** 출력하시오.
select substr(phone,1,3)||'-***-'||substr(phone,9,4) from member;

-- 11** rpad()
select pw,rpad(substr(pw,1,2),4,'*') from member;
select pw,rpad(substr(pw,0,length(pw)-2),length(pw),'*') from member;

-- 홍**, Luci**, Gregoi**
select name,rpad(substr(name,1,length(name)-2),length(name),'*') from member;

-- 제약조건: primary key, foreign key, not null, unique, check
-- primary key: null 불가, 중복 불가
-- foreign key: 다른 테이블에 primary key로 등록이 되어야 Fk로 등록 가능
-- not null: null 불가, 중복 가능
-- unique: 중복 불가, null 가능
-- check: 설정값만 입력 가능
create table mem (
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique,
phone char(13),
gender nvarchar2(2) check(gender in ('남자','여자')),
hobby varchar2(100),
mdate date
);
insert into mem values(
'aaa','1111','홍길동','010-1111-1111','남자','게임',sysdate
);
insert into mem values(
'bbb','1111',null,'010-1111-1111','남자','게임',sysdate
);
insert into mem values(
'ccc','1111',null,'010-1111-1111','여자','게임',sysdate
);
insert into mem values(
'ddd','1111',null,'010-1111-1111','여자','게임',sysdate
);
insert into mem values(
'eee','1111',null,null,'여자',null,null
);

create table board2 as select * from board;

-- foreign key 등록
alter table board2
add constraint fk_mem_board2_id foreign key(id)
references mem(id);

-- mem 테이블, board2 테이블 id컬럼이 연결
-- mem 테이블에 없는 id는 board2에 id로 등록이 불가
-- mem 테이블은 board2의 id가 삭제되지 않으면 삭제할 수 없음
