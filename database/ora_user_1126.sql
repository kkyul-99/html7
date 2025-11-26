-- [[ 수업 정리 ]]
-- 컬럼 순서 변경
alter table student3 modify sdate invisible;
alter table student3 modify sdate visible;

-- 범위 검색(between - and)
select salary from employees where salary between 6000 and 7000;

-- 같은 경우 검색(in)
select salary from employees where salary in(6000,7000,8000);

-- like 검색(%,_)
-- %: 순서와 상관없이 어떤 문자가 들어와도 검색
-- _: 1개의 문자 순서
-- like '%a%': a가 포함되어 있는 것, '%a': 마지막 글자가 a인 것,
--      'a%': 첫글자가 a인 것, '_a%': 두번째 글자가 a인 것
select emp_name from employees where emp_name like 'Do%'; -- Do로 시작하는 사원
select emp_name from employees where emp_name like '%d%'; -- d가 들어가는 사원

select * from member where email like '%n'; -- n으로 끝나는 이메일
select * from member where email like '__n%'; -- 세번째 문자가 n인 이메일

-- _를 검색할 때 #을 붙이고 escape을 추가하면 _문자 검색 가능
select job_id from employees where job_id like '%#_M%' escape '#';

-- null 검색: is null, is not null
select manager_id from employees;
select manager_id from employees where manager_id is null;

-- null 다른 것으로 대체 nvl()
-- salary + (salary*commission_pct) 출력하시오.
select salary,salary+(salary*nvl(commission_pct,0)) real_salary,
(salary+(salary*nvl(commission_pct,0)))*1473 real_ksalary from employees;

-- null -> ceo
-- to_char: number 타입을 varchar2 타입으로 변경
select nvl(manager_id,0), nvl(to_char(manager_id),'ceo') from employees;
desc employees;

-- 숫자 함수
select 10 from dual; -- dual: 가상 테이블
-- abs: 절대값
select 10, abs(-10) abs from dual;
-- floor: 버림 / round: 반올림(소수점 첫째자리에서) / ceil: 올림
select floor(10.598),round(10.598),ceil(10.2) from dual;
-- round(값,반올림 후 소수점 자리수) / -1 -> 정수부분
select round(10.2587),round(10.2587,2),round(10.2587,3),round(35.2587,-1) from dual;
-- trunc(값,버림 후 소수점 자리수): 버림
select trunc(34.5678,2),trunc(34.5678,3),trunc(34.5678,-1) from dual;
-- mod: 나머지
select mod(27,2),mod(27,5) from dual;

-- 사원번호가 홀수인 것을 출력하시오.
select employee_id from employees where mod(employee_id,2) = 1;

-- 시퀀스 함수: 순차적으로 순번을 증가시킬 때 사용하는 함수
-- nextval: 번호생성-번호증가됨 / currval: 번호확인
create sequence member_seq -- 시퀀스 생성 이름: member_seq
increment by 1             -- 증감 1
start with 1               -- 1부터 시작
minvalue 1                 -- 최소값
maxvalue 9999              -- 최대값
nocycle;                   -- 9999 이후에는 에러
                           -- cf) cycle - 9999 이후 다시 1로
nocache                    -- 메모리에 시퀀스값 미리 할당

select member_seq.nextval from dual;
select member_seq.currval from dual;

-- 시퀀스 수정
alter sequence employee_seq increment by 2;
alter sequence employee_seq restart start with 1;

-- 시퀀스 삭제
drop sequence employee_seq;

-- [[ 수업 정리 끝 ]]
--------------------------------------------------
-- sdate 컬럼을 name 컬럼 뒤에 배치하시오.
alter table student3 modify sdate invisible;
alter table student3 modify kor invisible;
alter table student3 modify eng invisible;
alter table student3 modify math invisible;
alter table student3 modify total invisible;
alter table student3 modify avg invisible;

alter table student3 modify sdate visible;
alter table student3 modify kor visible;
alter table student3 modify eng visible;
alter table student3 modify math visible;
alter table student3 modify total visible;
alter table student3 modify avg visible;

drop table student3;

-- select,update,delete,insert
select * from student3;

insert into student3(sno,name,kor,eng,math,sdate,total,avg) values(
5,'강감찬',75,70,79,sysdate,(75+70+79),(75+70+79)/3
);

commit;

desc student3;

--------------------------------------------------
-- employees 테이블에서 6000~7000까지 사원을 검색하시오.
-- 비교연산자, between and
select salary from employees where salary >= 6000 and salary <= 7000;

-- 6000,7000,8000 사원을 검색하시오.
select salary from employees where salary = 6000 or salary = 7000 or salary = 8000;

--------------------------------------------------
select emp_name from employees where emp_name = 'Donald OConnell';
select salary from employees where salary = 6000;

select * from customers;
-- cust_city에서 ge가 들어가는 도시를 검색하시오.
select cust_city from customers where lower(cust_city) like '%g%';

-- 대소문자 구분없이 검색: upper, lower
select lower(cust_city) from customers;

select * from member;

-- 이름에 홍이 들어가 있는 회원을 검색하시오.
select * from member where name like '%홍%';
-- 이메일에서 man이 들어가 있는 회원을 검색하시오.
select * from member where email like '%man';

select * from employees;
select job_id from employees;
select job_id from employees where job_id = 'SH_CLERK';

--------------------------------------------------
-- 정렬(asc, desc)
-- order by asc: 순차정렬, 오름차순
-- order by desc: 역순정렬, 내림차순

select emp_name from employees
order by emp_name asc; -- 순차정렬(default)

select emp_name from employees
order by emp_name desc; -- 역순정렬

-- a가 들어가 있는 사원을 역순정렬로 출력하시오.
select emp_name from employees
where emp_name like '%a%'
order by emp_name desc;

select hire_date from employees
order by hire_date;

-- member 테이블에서 이름을 순차정렬하시오.
select * from member order by name;

-- employees salary 역순정렬하시오. null -> ceo.
-- 8000이상이면서 이름에 p,P 들어가는 사원만 출력하시오.
select emp_name,nvl(to_char(manager_id),'ceo'),salary from employees
where salary >= 8000 and lower(emp_name) like '%p%'
order by salary desc;

-- 이름 또는 email에 z,Z가 들어가 있는 사원을 출력하시오.
select * from employees
where lower(emp_name) like '%z%' or lower(email) like '%z%';

-- department_id로 순차정렬하고, salary로 역순정렬 하시오.
select department_id,salary from employees
order by department_id asc, salary desc;

-- 같은 부서 내에 입사일이 빠른 사원부터 출력하시오.
-- department_id, hire_date
select department_id,hire_date from employees
order by department_id asc, hire_date asc;

select salary "연봉" from employees;

-- nvl(): null 값이 있을 경우 대체함수
-- null
select commission_pct,nvl(commission_pct,0)+100 from employees;
select manager_id,nvl(manager_id,0),nvl(to_char(manager_id),'ceo') from employees;

--------------------------------------------------
-- employee_seq 생성
create sequence employee_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache;

select employee_seq.nextval from dual;
select employee_seq.currval from dual;

--------------------------------------------------
create table board(
bno number(4) primary key,
btitle varchar2(2000),
bcontent clob, -- 4Gb varchar2(4000byte) cf) blob
id varchar2(100),
bgroup number(4),
bstep number(4),
bindent number(4),
bhit number(4),
bfile varchar2(1000),
bdate date
);

insert into board values(
board_seq.nextval,'제목입니다.','내용입니다.',board_seq.currval,
0,0,0,'1.jpg',sysdate
);

insert into board values(
board_seq.nextval,'제목입니다.2','내용입니다.2',board_seq.currval,
0,0,0,'1.jpg',sysdate
);

--------------------------------------------------
insert into board values(
board_seq.nextval,'제목입니다.','내용입니다.','aaa',board_seq.currval,
0,0,0,'1.jpg',sysdate);

select * from board order by bno desc;
select board_seq.nextval from dual;

--------------------------------------------------
update stuscore set avg = total/3;
alter table stuscore modify avg number(10,7);
select * from stuscore order by kor desc, eng asc;

insert into stuscore values(
    stuscore_seq.nextval,'홍길동',100,100,99,(100+100+99),(100+100+99)/3,sysdate
);
select * from stuscore;
commit;
