del C:\TEMP\ope.* /F
del C:\TEMP\info.txt /F
del C:\TEMP\kodutoo_check.txt /F
copy ope.* C:\TEMP /Y
copy isikud.txt C:\TEMP /Y
copy klubid.txt C:\TEMP /Y
copy partiid.txt C:\TEMP /Y
copy turniirid.txt C:\TEMP /Y
copy asulad.txt C:\TEMP /Y

curl -J -O "https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/download"
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('DBTest.zip', '.'); }"
copy DBTest\Vead.sql C:\TEMP /Y
copy DBTest\Vead_AB.sql C:\TEMP /Y
copy DBTest\AB.sql C:\TEMP /Y

"C:/Program Files/SQL Anywhere 17/bin64/dbisql.exe" -c "uid=dba;pwd=sql;dbf=C:\temp\ope.db" ope_test.sql
copy c:\TEMP\tulemus.txt . /Y
copy c:\TEMP\tulemus.csv . /Y
copy c:\TEMP\Vead.sql . /Y
copy c:\TEMP\Vead_AB.sql . /Y
copy c:\TEMP\AB.sql . /Y

curl -u "N6rKsdYKizFoTZ3:" -T Vead.sql "https://owncloud.ut.ee/owncloud/public.php/webdav/Vead.sql"
curl -u "N6rKsdYKizFoTZ3:" -T Vead_AB.sql "https://owncloud.ut.ee/owncloud/public.php/webdav/Vead_AB.sql"
curl -u "N6rKsdYKizFoTZ3:" -T AB.sql "https://owncloud.ut.ee/owncloud/public.php/webdav/AB.sql"

del DBTest.zip
cd DBTest
del .
cd ..
rmdir DBTest