-- [DDL]
-- 테이블 생성: create
create table student (
sno number(4) primary key, -- 중복 불가, null 불가
name varchar2(100), -- 한글 3byte
kor number(3), -- (4,1) -> 정수 3자리, 소수 1자리
eng number(3),
math number(3),
total number(3),
avg number(5,2)
);

-- 테이블 삭제: drop
drop table member;

-- 테이블 변경: alter
-- 컬럼 추가, 수정, 삭제
-- 컬럼 추가: alter add
alter table student add sdate date;
-- 컬럼 삭제: alter drop
alter table student drop column sdate;
-- 컬럼 수정: alter modify
alter table student modify name varchar2(1000);
alter table student modify name varchar2(90);
alter table student modify name varchar2(5); -- 입력된 데이터 크기 아래로 변경 불가

-- [ 테이블을 생성하면서 데이터 가져오기 ]
-- 테이블 복사(데이터까지 복사)
create table student2 as select * from student;
-- 테이블 복사(테이블 구조만 복사)
create table student3 as select * from student where 1=2;
-- [ 테이블이 있으면서 데이터 가져오기 ]
-- student2, student 컬럼이 동일한 경우 데이터 가져오기
insert into student2 select * from student;
-- student3, student 컬럼 개수가 다른 경우
insert into student3(sno,name,kor,eng,math,sdate) select sno,name,kor,eng,math,sdate from student;

--------------------------------------------------

-- [DML]
-- select(검색),insert(추가),update(수정),delete(삭제) -> commit,rollback 필요
-- insert into 테이블명 (모든 column) values (값);
-- insert into 테이블명 values (모든 값);
insert into student (sno,name,kor,eng,math,total,avg)
values (
1,'홍길동',100,100,100,300,100
);
insert into student values(
2,'유관순',90,90,90,270,90
);
insert into student values(
3,'이순신',80,80,80,240,80
);

-- select column명 from 테이블명;
select sno,name,kor,eng,math,total,avg from student;
select sno,name,total from student;
select * from student;

-- update 테이블명 set 수정할 column=값 where column=값;
update student set name='홍길영' where sno=1;
update student set name='홍길동' where sno=1;

-- delete 테이블명 where column=값;
delete student where sno=3;
delete student;

--------------------------------------------------

select employee_id,emp_name from employees;
select * from employees where employee_id>200;

-- 현재 존재하는 테이블 확인
select * from tab;
-- 테이블 안 항목 컬럼의 타입
desc student;

--------------------------------------------------

select * from student;

-- sysdate: 현재날짜, 시간을 입력 / cf) mysql - now()
update student set sdate = '2025-01-01';
update student set sdate = sysdate;

commit;
rollback;

select * from employees;
select manager_id from employees;
select distinct manager_id from employees;
select distinct manager_id from employees order by manager_id;

-- employees 테이블에서 사원번호,사원이름,부서번호를 출력하시오.
select employee_id,emp_name,department_id from employees;

-- student
select * from student;

-- 홍길동 -> 홍길순
update student set name='홍길순' where sno=1;
-- 날짜를 모두 2025-10-10 변경
update student set sdate='2025-10-10';
-- 3번 학생 삭제
delete student where sno=3;
-- 4,김구,70,70,70,210,70 현재날짜 입력
insert into student values(
4,'김구',70,70,70,210,70,sysdate
);

commit;

--------------------------------------------------

-- 타입: number타입
-- 연산자: 산술연산자 +,-,*,/
select sdate,sdate+100 from student;

select * from student;
update student set kor=90 where sno=1;
update student set total=kor+eng+math, avg=(kor+eng+math)/3 where sno=1;

commit;
rollback;

select * from employees;
-- 월급(달러) * 1,474
-- 별칭: 기존컬럼명 (as) 변경컬럼명
select emp_name,salary, salary*1474 as k_salary, salary*1474*12 year_k_salary from employees;

delete student2;
commit;

alter table student3 drop column total;
alter table student3 drop column avg;

select * from student2;
select * from student3;

desc student3;
alter table student3 add total number(3);
alter table student3 add avg number(5,2);

-- total, avg 데이터 수정
update student3 set total=kor+eng+math, avg=(kor+eng+math)/3;

--------------------------------------------------

select * from employees;
-- null값에 +,-,*,/ -> null값으로 변경됨
-- null값 대체: nvl(컬럼명,대체할 값)
select emp_name,salary,nvl(commission_pct,0),salary+(salary*nvl(commission_pct,0)) as real_salary from employees;

-- 실제 연봉을 출력하시오.
select (salary+(salary*nvl(commission_pct,0))) * 12 from employees;

-- 부서번호 department_id 출력
select distinct department_id from employees;

-- job_id 직급 중복제거해서 출력하시오.
select distinct job_id from employees;

select * from jobs;

--------------------------------------------------

-- mem 테이블 - 날짜 포함: varchar2, number, date
create table zmember(
name varchar2(100),
id varchar2(100),
pw varchar2(100),
email varchar2(50),
email_check number(1),
zonecode number(5),
address varchar2(100),
phone char(13),
phone_check number(1),
tel char(13),
birth date,
birth_check number(1),
business number(1)
);

-- 001 -> 1
alter table zmember modify zonecode char(5);
desc zmember;

insert into zmember values(
'홍길동','aaa','1111','aaa@naver.com',0,'00000','서울 강남구','010-1111-1111',0,'02-1111-1111','2000-01-01',1,0
);
select * from zmember;
commit;

-- seoul_stu
-- 학생정보 테이블 작성하시오. 학생 테이블 1개(고등학생 가정)
-- 학생고유번호, 이름, 학년, 반, 번호, 전화, 주소, 입학일
create table seoul_stu(
stuno char(5), -- s0001
name varchar2(50),
birth date,
phone char(13),
address varchar2(100),
enroll_date date,
write_date date
);

insert into seoul_stu values(
's0001','홍길동','2000-01-01','010-1111-1111','서울',sysdate,sysdate
);

update seoul_stu set grade='2',grade_no='2',class_no='2' where stuno='s0001';

create table seoul_grade(
stuno char(5),
grade number(1), -- 학년
grade_no number(2), -- 반
class_no number(3) -- 번호
);

insert into seoul_grade values(
's0001',1,1,1
);
insert into seoul_grade values(
's0001',2,2,2
);
insert into seoul_grade values(
's0001',3,3,3
);

select * from seoul_grade;
select * from seoul_stu;

select seoul_stu.stuno,name,birth,phone,address,enroll_date,write_date,
grade,grade_no,class_no
from seoul_stu,seoul_grade
where seoul_stu.stuno=seoul_grade.stuno;

--------------------------------------------------

-- where절: 조건절 =, !=, <>, ^=, >=, <=, >, <, and, or
-- where 컬럼 연산자 비교값
select * from employees where department_id = 30 or department_id = 50;
select * from employees where department_id in (30, 50); -- or와 같음
select * from employees where department_id = 30 and manager_id = 100;
select * from employees where department_id <> 30;
select * from employees where department_id > 30;
select * from employees where department_id < 30;

-- 월급이 5000 이상인 사원을 출력하시오.
select * from employees where salary >= 5000;
-- 5000,6000,7000
select * from employees where salary = 5000 or salary = 6000 or salary = 7000;
select * from employees where salary in (5000,6000,7000);
select * from employees where salary != 5000 or salary != 6000 or salary != 7000;
select * from employees where salary not in (5000,6000,7000);

select emp_name,salary,salary*12 from employees
where salary*12 >= 150000;

-- (10+5)*10/3
-- 10+5*10/3
-- (10+3)>(5-2) or ((10*2)/3)+1-3

select employee_id,emp_name,salary from employees where salary <= 4000;

-- 입사일 날짜 >, <, <=, >=, =, !=
select hire_date from employees;
select hire_date from employees where hire_date+100 >= '2005/01/01';
select hire_date,hire_date+100 from employees;
select email,hire_date from employees where hire_date >= '2007-06-01';

-- between and: >= and <=
select salary from employees where salary >= 7000 and salary <= 7500;
select salary from employees where salary between 7000 and 7500; -- 위와 같음

-- not between and: < or >
select salary from employees where salary < 7000 or salary > 7500;
select salary from employees where salary not between 7000 and 7500;

select hire_date from employees;

-- 2005/01/01 ~ 2007/12/31 사이
-- 입사한 사원의 사원번호,사원이름,부서번호,입사일을 출력하시오.

select employee_id,emp_name,department_id,hire_date from employees
where hire_date between '2005/01/01' and '2007/12/31';

select employee_id,emp_name,department_id,hire_date from employees
where hire_date >= '2005/01/01' and hire_date <= '2007/12/31';

--------------------------------------------------

create table uni_stu(
stuno char(5),
name varchar2(100),
major_code varchar2(100),
major_name varchar2(100),
major_date date,
college varchar2(100)
);

insert into uni_stu values(
's0001','홍길동','COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0002','유관순','COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0003','이순신','COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0004','강감찬','COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0005','김구','COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into uni_stu values(
's0006','김유신','MATH','수학과','2002-02-02','인문대학'
);
select * from uni_stu;

create table major_collect(
major_code varchar2(100), -- primary key
major_name varchar2(100),
major_date date,
college varchar2(100)
);

insert into major_collect values(
'COM','컴퓨터공학과','2000-01-01','공과대학'
);
insert into major_collect values(
'MATH','수학과','2002-02-02','인문대학'
);
commit;

select * from major_collect;
select * from uni_stu;

-- Join
select stuno,name,uni_stu.major_code,major_name,major_date,college
from uni_stu,major_collect
where uni_stu.major_code=major_collect.major_code;

alter table uni_stu drop column major_name;
alter table uni_stu drop column major_date;
alter table uni_stu drop column college;
