del C:\TEMP\edu.* /F
copy edu.* C:\TEMP /Y
copy course.txt C:\TEMP /Y
copy faculty.txt C:\TEMP /Y
copy lecturers.txt C:\TEMP /Y
copy person.txt C:\TEMP /Y
copy registrations.txt C:\TEMP /Y
"C:/Program Files/SQL Anywhere 17/bin64/dbisql.exe" -c "uid=dba;pwd=sql;dbf=C:\temp\edu.db" edu_test.sql
copy c:\TEMP\tulemus.txt . /Y
copy c:\TEMP\tulemus.csv . /Y

