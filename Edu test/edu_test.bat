del C:\TEMP\edu.* /F
copy edu.* C:\TEMP /Y
#copy isikud.txt C:\TEMP /Y
#copy klubid.txt C:\TEMP /Y
#copy partiid.txt C:\TEMP /Y
#copy turniirid.txt C:\TEMP /Y
#copy asulad.txt C:\TEMP /Y
"C:/Program Files/SQL Anywhere 17/bin64/dbisql.exe" -c "uid=dba;pwd=sql;dbf=C:\temp\edu.db" edu_test.sql
copy c:\TEMP\tulemus.txt . /Y
copy c:\TEMP\tulemus.csv . /Y

