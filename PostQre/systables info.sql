/* Tabeli ja vaadete olemasolu kontroll*/
select * from information_schema.tables where table_schema ='public'; 

/* Veeru olemasolu kontroll */
select * from information_schema.columns where table_schema = 'public';
-- klubid asukoht varchar pikkus 
select * from information_schema.columns where table_name = 'klubid' and character_maximum_length =70;


-- Moodle test: 
-- https://demovpl.dis.ulpgc.es/mod/vpl/forms/executionfiles.php?id=582
-- https://demovpl.dis.ulpgc.es/mod/vpl/views/checkjailservers.php?id=275

-- Problem? https://moodle.org/mod/forum/discuss.php?d=432700

/* Muutujate puudus on probleem
Lahendused:
* Muutujate tabel, kust saab queryda hindeid - kõik on csv-s, kust saab kõiki muuta/lisada
* iga testi sees on hinded - kõik on ühes skriptis, aga peab iga testi juures kontrollima. VB mõistlik, kuihidamine ei ole skaleeritud.
* Moodle variandis ei olegi üldse test skripti kasutuses, vaid on sql päringud.


*/

Hetkel olev tööprotsess.
Õppejõud paneb tudengi backupi kausta.
õppejõud käivitab bat faili või taskid dbeaveris.
1. task load backup
2- task run script
	2.1 script delete andmed
	2.2 script insert default andmed
	2.3 Run tests

select * from pg_proc where proname like '%isikud%';
--pg_tables - tabelid;
-- pg_stats - veerud;
-- pg_views, pg_index?
-- pg_proc - funk/protseduur

https://courses.cs.ut.ee/2022/Andmebaasid/fall/Main/CreatingFunctionsAndProcedures

CREATE [ OR REPLACE ] FUNCTION name ( [ [ argname ] argtype ] )
[ RETURNS rettype
| RETURNS TABLE ( column_name column_type [, ...] ) ]
LANGUAGE lang_name
AS 'definition';

-- CREATE or replace FUNCTION getIsikud()
drop function getIsikud();
CREATE FUNCTION getIsikud()
RETURNS TABLE (e_nimi varchar(25), p_nimi varchar(25))
AS 'SELECT eesnimi, perenimi FROM isikud;'
LANGUAGE SQL;


SELECT getIsikud();


--Muutuja loomine - asendusena teha tabel, kõigi muutujatega.
WITH myconstants (var1, var2) as (
   values (5, 'foo')
)
SELECT *
FROM myconstants
WHERE 5 = var1
   OR 'foo' = var2;
   
set session my.versioon = '1'; 




CREATE [ OR REPLACE ] PROCEDURE name ( [ [ argname ] argtype ] )
AS 'definition'
LANGUAGE lang_name;

Andmete sisestus:
COPY <tabel> ({veerud})
FROM '<täielik tee failini>'
DELIMITER E'\t'
ENCODING 'UTF-8';

Connection:
C:\Users\marttika\AppData\Local\DBeaverEE\dbeaver-cli.exe -con "driver=postgres-jdbc|url=jdbc:postgresql://localhost:5432/postgres|user=postgres|password=sql"

Runtasks:
-runTask "@projectName:taskName"
C:\Users\marttika\AppData\Local\DBeaverEE\dbeaver-cli.exe -runTask "@General:Testing"



postqreSQl driver=postgres-jdbc

url: jdbc:postgresql://{host}[:{port}]/[{database}]
jdbc:postgresql://localhost:5432/postgres

Port: 5432
Deafult database: postgres
Default user: postgres

Username:postgres
Password: sql