import oracledb

def getConnection():
    return oracledb.connect\
        (user='ora_user',password='1111',dsn='localhost:1521/xe')
      
# db연결실행
conn = getConnection()
cursor = conn.cursor()

### 
while(True):
    score = int(input("점수를 입력하세요.>> "))
    # stuscore 테이블 total 컬럼을 비교해서
    # 입력한 점수보다 합계점수가 높은 학생이 몇명인지 출력하시오.
    query = f"select count(total) from stuscore where total>={score}"
    cursor.execute(query)
    rows = cursor.fetchone()
    
    print("입력점수: ",score,"점")
    print("입력한 점수보다 높은 학생수: ",rows[0],"명")
conn.close()

# 월급 연봉 원화 - 천단위 표시해서 출력하시오.
# query = "select to_char(salary,'99,999'),to_char(salary*12,'999,999') y_salary,to_char(salary*12*1473,'999,999,999') y_ksalary from employees"
# cursor.execute(query)
# rows = cursor.fetchall()
# print(f"   월급\t\t   연봉\t\t\t     원화")
# print("-"*55)
# for row in rows:
#     print("{}\t\t{}\t\t{}".format(row[0],row[1],row[2]))
