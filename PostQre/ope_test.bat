SET src=C:\sinu_faili_teekond
FOR /F "eol=| delims=" %%I IN ('DIR %src%\*.backup /A-D /B /O-D /TW 2^>nul') DO (
    SET "NewestFile=%%I"
    GOTO FoundFile
)
ECHO No *.backup file found!
pause
GOTO :EOF

:FoundFile
ren %NewestFile% male.backup
psql -U postgres -d andmebaasi_nimi -f lisa_tabelite_kustutamine.sql
pg_restore -U postgres -d andmebaasi_nimi -c male.backup 
psql -U postgres -d andmebaasi_nimi -f ope_test.sql
copy c:\TEMP\tulemus.csv . /Y
pause