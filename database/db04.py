import oracledb
def getConnection():
    return oracledb.connect\
    (user="ora_user",password="1111",dsn="localhost:1521/xe")

title = ['번호','이름','국어','영어','수학','합계','평균']

while (True):
    print("[ 학생성적프로그램 ]")
    print("-"*65)
    print("1. 학생성적입력")
    print("2. 학생성적출력")
    print("3. 학생성적수정")
    print("4. 학생성적삭제")
    print("0. 프로그램종료")
    choice = int(input("원하는 번호를 입력하세요.>> "))
    print("")
    if choice == 1:
        print("[ 학생성적입력 ]")
        name = input("학생 이름을 입력하세요.>> ")
        kor = int(input("국어 점수를 입력하세요.>> "))
        eng = int(input("영어 점수를 입력하세요.>> "))
        math = int(input("수학 점수를 입력하세요.>> "))
        total = kor+eng+math
        avg = total/3
        # db저장
        conn = getConnection() # ora_user 사용자 생성
        cursor = conn.cursor() # sql developer 실행
        query = f"insert into stuscore values(stuscore_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},sysdate)"
        cursor.execute(query)  # query문 실행
        conn.commit()          # insert, update, delete - commit 실행
        
        print("학생 성적을 저장합니다.")
        print()
        conn.close()
        
    elif choice == 2:
        conn = getConnection()
        cursor = conn.cursor()
        query = "select * from stuscore order by sno"
        cursor.execute(query)
        rows = cursor.fetchall() # 검색된 내용 출력
        
        print("[ 학생성적출력 ]")
        print("-"*65)
        print("{}\t{:13s}{}\t{}\t{}\t{}\t{}".format(*title))
        print("-"*65)
        for row in rows:
            print("{}\t{:15s}{}\t{}\t{}\t{}\t{:.2f}".format(*row))
        conn.close() # db연결종료
        
    else:
        print("[ 프로그램종료 ]")
        print("")
        print("프로그램을 종료합니다.")
        break
    print("")
    