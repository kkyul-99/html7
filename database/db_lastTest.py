import datetime
from db_lastConn import *
conn = getConnection()

title = ['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']

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
    # print("개수: ",len(rows))

    # 출력부분
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    if len(rows)>0:
        for r in rows:
            print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        choice = input("수정하려는 학생번호(sno)를 입력하세요.>> ")
        query = f"select * from stuscore3 where sno = {choice}"
        cursor.execute(query)
        r = cursor.fetchone()
        r = list(r) # 튜플타입을 리스트타입으로 변경
        if r:
            print(f"[ {r[1]} 학생 성적수정 ]")
            print("1. 국어점수")
            print("2. 영어점수")
            print("3. 수학점수")
            choice2 = int(input("원하는 과목을 선택하세요.>> "))
            # title[2]: 국어, title[3]: 영어, title[4]: 수학
            if 1 <= choice2 <= 3:
                print(f"현재 {title[choice2+1]} 점수: ",r[choice2+1])
                r[choice2+1] = int(input(f"{title[choice2+1]} 변경 점수를 입력하세요.>> "))
                r[5] = r[2]+r[3]+r[4]
                r[6] = r[5]/3
                query = f"""update stuscore3 set kor={r[2]},eng={r[3]},math={r[4]},
                            total={r[5]},avg={r[6]}
                            where sno={r[0]}"""
                cursor.execute(query)
                conn.commit()
                conn.close()
                print(f"{title[choice2+1]} 과목 수정을 완료하였습니다.")
            else:
                print("과목 선택을 잘못하셨습니다. 다시 입력하세요.")
        else:
            print("번호를 잘못 입력하셨습니다. 다시 시작해주세요.")
    else:
        print("수정하려는 학생이 없습니다. 다시 검색하세요.")
        
    print()

# 1. 성적입력
def stuInput():
    name = input("이름을 입력하세요.>> ")
    kor = int(input("국어 점수를 입력하세요.>> "))
    eng = int(input("영어 점수를 입력하세요.>> "))
    math = int(input("수학 점수를 입력하세요.>> "))
    total = kor+eng+math
    avg = total/3
    # db 연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"insert into stuscore3 values(\
    stuscore3_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},sysdate,0,' ')"
    cursor.execute(query)
        
    print(name,"학생 성적이 입력되었습니다.")
    
    print()
    conn.commit()
    conn.close()

# 2. 성적출력
def stuOutput():
    # db 연결
    conn = getConnection()
    cursor = conn.cursor()
    query = "select * from stuscore3 order by sno"
    cursor.execute(query)
    rows = cursor.fetchall()
    
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    for r in rows:
        # print("{}\t{}\t{}\t{}\t{}\t{}\t{:.2f}\t{}\t{}\t{}".format(*r))
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
    
    print()
    conn.commit()
    conn.close()

# 4. 성적삭제
def stuDelete():
    name = input("삭제하려는 학생이름을 입력하세요.>> ")
    # db연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore3 where name = '{name}'"
    cursor.execute(query)
    r = cursor.fetchone()
    if r: # 검색해서 있을 경우
        # 출력부분
        print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
        print("-"*85)
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        print()
        choice = input("정말 학생성적을 삭제하시겠습니까?(1.삭제 0.취소) ")
        if choice == "1":
            query = f"delete stuscore3 where name='{name}'"
            cursor.execute(query)
            conn.commit()
            print(f"{name} 학생 성적이 삭제되었습니다.")
        else: print(f"{name} 학생 성적 삭제가 취소되었습니다.")
    else:
        print("삭제하려는 학생 성적이 없습니다.")
    
    print()
    conn.close()

# 6. 성적정렬
def stuOrder():
    print("1. 학생이름")
    print("2. 학생성적")
    choice = input("원하는 번호를 입력하세요.>> ")
    conn = getConnection()
    cursor = conn.cursor()
    if choice == "1":
        query = f"select * from stuscore3 order by name"
        cursor.execute(query)
    else:
        query = f"select * from stuscore3 order by total desc"
        cursor.execute(query)
    rows = cursor.fetchall()
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t\t{}\t{}".format(*title))
    print("-"*85)
    for r in rows:
        # print("{}\t{}\t{}\t{}\t{}\t{}\t{:.2f}\t{}\t{}\t{}".format(*r))
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
    
    print()
    conn.commit()
    conn.close()

# 7. 등수처리
def stuRank():
    conn = getConnection()
    cursor = conn.cursor()
    query = f"""update stuscore a set rank = (
                select ranks from(
                select sno,rank() over(order by total desc) ranks from stuscore) b
                where a.sno = b.sno)"""
    cursor.execute(query)
    conn.commit()
    conn.close()
    print("등수처리가 완료되었습니다.")
    print()

# 8. 등급처리
def stuGrade():
    conn = getConnection()
    cursor = conn.cursor()
    query = f"""update stuscore set grade = (
                select grade from scoregrade
                where avg between lowgrade and highgrade)"""
    cursor.execute(query)
    conn.commit()
    conn.close()
    print("등급처리가 완료되었습니다.")
    print()
