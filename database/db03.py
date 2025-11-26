import oracledb

conn = oracledb.connect(user="ora_user",password="1111",dsn="localhost:1521/xe")
cursor = cursor = conn.cursor()
cursor.execute("select * from stuscore order by kor desc, eng asc")
rows = cursor.fetchall()

for row in rows:
    print("{}\t{:15s}\t{}\t{}\t{}\t{}\t{:.2f}".format(*row))

print("연결: ",conn)
