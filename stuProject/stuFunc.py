import datetime
from stuConnect import *
conn = getConnection()

title = ['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']

# 1. 성적입력
def stuInput():
    name = input("학생 이름을 입력하세요.>> ")
    kor = int(input("국어 성적을 입력하세요.>> "))
    eng = int(input("영어 성적을 입력하세요.>> "))
    math = int(input("수학 성적을 입력하세요.>> "))
    total = kor+eng+math
    avg = total/3
    
    conn = getConnection()
    cursor = conn.cursor()
    query = f"insert into stuscore3 values(\
        stuscore3_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},sysdate,0,' ')"
    cursor.execute(query)
    
    print("학생 성적이 입력되었습니다.")
    
    print()
    conn.commit()
    conn.close()

# 2. 성적출력

def stuOutput():
    conn = getConnection()
    cursor = conn.cursor()
    query = "select * from stuscore3 order by sno"
    cursor.execute(query)
    rows = cursor.fetchall()
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    for r in rows:
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
       
    print()
    conn.commit()
    conn.close()

# 3. 성적수정
def stuUpdate():
    # 학생검색
    name = input("수정하려는 학생의 이름을 입력하세요.>> ")
    # db 연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore3 where name like '%{name}%'"
    cursor.execute(query)
    rows = cursor.fetchall()

    # 출력부분
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    if len(rows)>0:
        for r in rows:
            print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        choice = input("수정하려는 학생의 번호를 입력하세요.>> ")
        query = f"select * from stuscore3 where sno = {choice}"
        cursor.execute(query)
        row = cursor.fetchone()
        if row:
            kor = int(input("수정할 국어 점수를 입력하세요.>> "))
            eng = int(input("수정할 영어 점수를 입력하세요.>> "))
            math = int(input("수정할 수학 점수를 입력하세요.>> "))
            total = kor+eng+math
            avg = total/3
            
            query = f"update stuscore3 set kor={kor}, eng={eng}, math={math}, total={total}, avg={avg}"
            cursor.execute(query)
            conn.commit()
            
            print("성적 수정이 완료되었습니다.")
            
        else:
            print("번호를 잘못 입력하셨습니다. 다시 시작해주세요.")

    else:
        print("수정하려는 학생이 없습니다. 다시 검색하세요.")
    
    print()
    conn.close()

# 4. 성적삭제
def stuDelete():
    name = input("삭제할 학생의 이름을 입력하세요.>> ")
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore3 where name = '{name}'"
    cursor.execute(query)
    r = cursor.fetchone()
    if r:
        print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
        print("-"*85)
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        choice = input(f"정말 '{name}' 학생의 성적을 삭제하시겠습니까?(1.삭제 0.취소) ")
        if choice == "1":
            query = f"delete stuscore3 where name = '{name}'"
            cursor.execute(query)
            conn.commit()
            print(f"'{name}' 학생의 성적이 삭제되었습니다.")
        else:
            print(f"'{name}' 학생의 성적 삭제가 취소되었습니다.")
    else:
        print(f"삭제하려는 '{name}' 학생의 성적이 존재하지 않습니다.")
            
    print()
    conn.close()

# 5. 학생검색
def stuSearch():
    # 학생검색
    name = input("검색하려는 학생의 이름을 입력하세요.>> ")
    # db 연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore3 where name like '%{name}%'"
    cursor.execute(query)
    rows = cursor.fetchall()

    # 출력부분
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    if len(rows)>0:
        for r in rows:
            print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")

    print()
    conn.close()

# 6. 학생정렬
def stuOrder():
    print("1. 학생이름")
    print("2. 학생성적")
    choice = input("원하는 번호를 입력하세요.>> ")
    conn = getConnection()
    cursor = conn.cursor()
    if choice == "1":
        query = f"select * from stuscore3 order by name"
        cursor.execute(query)
    elif choice == "2":
        query = f"select * from stuscore3 order by avg desc"
        cursor.execute(query)
    rows = cursor.fetchall()
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    for r in rows:
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
    
    print()
    conn.commit()
    conn.close()

# 7. 등수처리
def stuRank():
    print("1. 등수처리")
    print("2. 등급처리")
    choice = input("원하는 번호를 입력하세요.>> ")
    conn = getConnection()
    cursor = conn.cursor()
    if choice == "1":
        query = f"update stuscore3 a set rank=(\
        select ranks from(\
        select sno,rank() over(order by avg desc) ranks from stuscore3) b\
        where a.sno = b.sno)"
        cursor.execute(query)
                
    elif choice == "2":
        query = f"update stuscore3 set grade=(\
                    select grade from scoregrade\
                    where avg between lowgrade and highgrade)"
        cursor.execute(query)
        
    query = f"select * from stuscore3 order by avg desc"
    cursor.execute(query)
    rows = cursor.fetchall()
    
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    for r in rows:
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
    
    print()
    conn.commit()
    conn.close()
