del C:\TEMP\ope.* /F
del C:\TEMP\kodutoo_check.txt /F
del C:\TEMP\eksam_check.txt /F
copy ope.* C:\TEMP /Y
"C:/Program Files/SQL Anywhere 17/bin64/dbisql.exe" -c "uid=dba;pwd=sql;dbf=C:\temp\ope.db" ope_test.sql
copy c:\TEMP\tulemus.txt . /Y
copy c:\TEMP\tulemus.csv . /Y

