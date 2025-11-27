import oracledb

def getConnection():
    return oracledb.connect\
        (user='ora_user',password='1111',dsn='localhost:1521/xe')
      
# db연결실행
conn = getConnection()
cursor = conn.cursor()

title = ['국번', '번호1', '번호2']

# 1. member 테이블에서 phone 컬럼을 분리해서 가져와서 출력
# 국번 전화번호1 전화번호2
query = "select substr(phone,1,3),substr(phone,5,3),substr(phone,9,4) from member"
cursor.execute(query)
rows = cursor.fetchall()

print("{}\t{}\t{}".format(*title))
print("-"*25)
for row in rows:
    print("{}\t{}\t{}".format(*row))

# 2. member 테이블에서 phone 컬럼을 가져와서 파이썬에서 분리해서 출력
query = "select phone from member"
cursor.execute(query)
rows = cursor.fetchall()

print("{}\t{}\t{}".format(*title))
print("-"*25)
for row in rows:
    r = row[0].split("-")
    print("{}\t{}\t{}".format(*r))

conn.close()
