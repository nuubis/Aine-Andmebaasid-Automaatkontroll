create table if not exists muutujad (
nimi varchar(1000) unique,
vaartus int);
copy muutujad from 'C:\TEMP\muutujad.csv' with (format csv, delimiter ';');


create table Staatus (
Ylesanne varchar(100),
Kontroll varchar(1000),
Tagasiside varchar(1000),
Olek varchar(100),
Punktid numeric,
Max_punktid numeric,
Jr int,
Id serial);


--Muutuja loomine - asendusena teha tabel, kõigi muutujatega.
WITH myconstants (var1, var2) as (
   values (5, 'foo')
)
SELECT *
FROM myconstants
WHERE 5 = var1
   OR 'foo' = var2;
   
set session my.versioon = '1'; 


create  function find_table_id(a_table_name varchar(100))
	returns int
	begin 
		declare a_id int;
		select  table_id into a_id from systable
		where   upper(table_name) = upper(a_table_name);
		return  a_id;
	end;
	

select * from pg_proc where proname like '%isikud%';
--pg_tables - tabelid;
-- pg_stats - veerud;
-- pg_views, pg_index?
-- pg_proc - funk/protseduur


insert into muutujad(nimi, väärtus) values ('versioon', 1);
select * from muutujad; 
delete from muutujad;

copy muutujad from 'C:\TEMP\muutujad.csv' with (format csv, delimiter ';');
drop table staatus;
create table if not exists Staatus (
Ylesanne varchar(100),
Kontroll varchar(1000),
Tagasiside varchar(1000),
Olek varchar(100),
Punktid numeric,
Max_punktid numeric,
Jr int,
Id serial);


CREATE FUNCTION getIsikud()
RETURNS TABLE (e_nimi varchar(25), p_nimi varchar(25))
AS 'SELECT eesnimi, perenimi FROM isikud;'
LANGUAGE SQL;


SELECT getIsikud();