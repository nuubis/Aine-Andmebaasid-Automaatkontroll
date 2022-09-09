
curl -J -O "https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/download"

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('DBTest.zip', '.'); }"

tar.exe -a -c -f DBTest.zip tulemus.md

REM curl -X PUT "https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/DBTest.zip" --data-binary @"DBTest.zip"
REM curl -X PUT -u username:password "https://owncloud.ut.ee/index.php/webdav/DBTest/tulemus.md" -F myfile=@"tulemus.md"
REM curl -X PUT -u username:password "https://owncloud.ut.ee/index.php/webdav/DBTest.zip" -F myfile=@"tulemus.md"
REM curl -k -T tulemus.md -u username:password -H 'X-Requested-With: XMLHttpRequest' https://owncloud.ut.ee/index.php/webdav/DBTest/tulemus.md
REM curl -k -T tulemus.md -u username:password -H 'X-Requested-With: XMLHttpRequest' https://owncloud.ut.ee/index.php/webdav/tulemus.md

REM curl -u user:password --upload-file "c:\TEMP\tulemus.md" "https://owncloud.ut.ee/owncloud/remote.php/webdav/tulemus.md"
REM curl -u user:password --upload-file "c:\TEMP\tulemus.md" "https://owncloud.ut.ee/owncloud/remote.php/webdav/DBTest"

REM curl -u user:password --upload-file "c:\TEMP\tulemus2.md" "https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/download"
REM curl --upload-file "c:\TEMP\tulemus2.md" "https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/download"

curl -u "N6rKsdYKizFoTZ3:" -T tulemus.md "https://owncloud.ut.ee/owncloud/public.php/webdav/tulemus.md"

del DBTest.zip
cd DBTest
del Koondtulemused.csv
del tulemus.md
cd ..
rmdir DBTest

REM Vambola dbtest - https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/download
REM minu dbtest - https://owncloud.ut.ee/owncloud/index.php/s/DHDafQ52QW4QAAY
REM https://owncloud.ut.ee/owncloud/remote.php/dav/files/0b447bbe-c1fe-1033-88df-531639ff9e99/
REM "N6rKsdYKizFoTZ3"
REM https://owncloud.ut.ee/owncloud/index.php/s/N6rKsdYKizFoTZ3/DBTest/tulemus.md




pause