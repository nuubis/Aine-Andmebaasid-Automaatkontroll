SET src=C:\Users\marttika\Downloads
FOR /F "TOKENS=*" %%A IN ('DIR /B "%Src%\*" /A-D') DO IF /I [%%~nxA]==[%%~nA] ren %src%\%%A %%A.backup
FOR /F "eol=| delims=" %%I IN ('DIR %src%\*.backup /A-D /B /O-D /TW 2^>nul') DO (
    SET "NewestFile=%%I"
    GOTO FoundFile
)
ECHO No *.backup file found!
GOTO :EOF

:FoundFile
copy %src%\%NewestFile% .\male.backup
psql -U postgres -d andmebaasi_nimi -f lisa_tabelite_kustutamine.sql
pg_restore -U postgres -d andmebaasi_nimi -c -v male.backup 
psql -U postgres -d andmebaasi_nimi -f ope_test.sql
copy c:\TEMP\tulemus.csv . /Y
pause