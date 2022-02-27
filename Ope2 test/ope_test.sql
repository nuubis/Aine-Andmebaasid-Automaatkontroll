-- Muutuja mis määrab, milline kodutöö käivitatakse, 3=kodutöö 3, 4=kodutöö 4
create or replace variable versioon int = 3;

-- Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab 
if 	exists (select * from sysprocedure where proc_name = 'check_column') 						then drop function check_column 						endif;



-- Staatus tabeli loomine/kustutamine - kui tabel eksisteerib siis kustutatakse see ära ja siis luuakse uuesti 
if 	exists (select * from systable where table_name = 'Staatus') then drop table Staatus endif; // Punktid numeric(7,2)
create table Staatus(
	Nimi varchar(100) not null, 
	Veerg varchar(100), 
	Tagasiside varchar(1000), 
	Olek varchar(100), 
	Punktid numeric, 
	Max_punktid numeric, 
	Soovitus varchar(1000), 
	Jr int default 100);
/* 
Staatus tabelis on siis: 
Nimi - tabeli, välivõtme, triggeri, vaate jne nimetus
Veerg - peamiselt tabeli veeru nimi, aga võib olla ka mingi muu kirjeldus
Tagasiside - mis on valesti, või '-' kui kõik on korras
Olek - veerg, mis näitab 'OK', 'VIGA', 'AEG', 'Kokku', 'Hindepunktid' märguandeid
Punktid - mitu punkti sai teatud ülesande osa eest
Max punktid - maksimum punktid, kui palju selle osa eest saab
Soovitus - soovitus, kust võib viga leida või kas sul on olemas X asi?
*/

-- delete staatus protseduur - protseduur, mis kustutab Staatus tabeli andmed
create procedure deleteS()
	begin
		delete Staatus;
	end;

-- Abifunktsioonid, et saada tabeli ID-st tabeli nimi, sissetulev muutujaks on tabeli ID süsteemis ja tagastus on tabeli nimi
create  function find_table_name(a_id int)
	returns varchar(100)
	begin 
		declare t_name varchar(100);
		select  table_name into t_name from systable
		where   table_id = a_id;
		return  t_name;
	end;

-- Abifunktsioon, et saada tabeli nimest tabeli ID, sissetulev muutujaks on tabeli nimi süsteemis ja tagastus on tabeli ID 
create  function find_table_id(a_table_name varchar(100))
	returns int
	begin 
		declare a_id int;
		select  table_id into a_id from systable
		where   upper(table_name) = upper(a_table_name);
		return  a_id;
	end;

-- Abifunktsioon, et saada tabeli ID-st ja tabeli nimest tudengi andmebaasi veeru nimi, sissetulev muutujaks on tabeli id ja veeru nimi süsteemis ja tagastus on andmebaasis oleva veeru nimi 
create  function find_column_name(a_table_id int, a_column_name varchar(100))
	returns varchar(100)
	begin 
		declare c_name varchar(100);
		select  column_name into c_name from syscolumn
		where   table_id = a_table_id and upper(column_name) = upper(a_column_name);
		return 	c_name;
	end;

/*create 	procedure arvuta_punktid(versioon int)
	begin
		declare summa, max_summa, hindepunkt, max_hindepunkt numeric;
		set 	summa = 0.0;

		if		versioon = 3 then set max_summa = kodutöö_3
		elseif	versioon = 5 then set max_summa = kodutöö_5
		elseif	versioon = 6 then set max_summa = kodutöö_6
		elseif	versioon = 7 then set max_summa = kodutöö_7
		else					  set max_summa = 1
		endif;

		-- Hindepunktide välja arvutamine 
		select sum(punktid) into summa from Staatus where Olek = 'OK' or Olek = 'VIGA';
		if 		versioon = 7 and aine = 'A'
			then	
			set 	hindepunkt = (summa / max_summa) * 2;
			set		max_hindepunkt = 2.0 
		else
			set 	hindepunkt = (summa / max_summa);
			set 	max_hindepunkt = 1.0
		endif;

		-- Punktide sisestamine 
		insert into Staatus values ('-', '-', '-', 'Kokku', summa, max_summa, '', max_punktid_jr);
		insert into Staatus values ('-', '-', '-', 'Hindepunktid', hindepunkt, max_hindepunkt, '', hindepunktid_jr);
	end;*/



create procedure kolmas_praktikum()
	begin
		declare punkt = 0.04 numeric;
		declare Jr = 1 int;
		
		-- Tabel Turniirid veerg nimi
		if 		not exists (select * from syscolumn where column_name = 'nimi' and table_id = find_table_id('turniirid')) 
		then 	insert 	Staatus values ('Tabel "' || 'Turniirid' || '"', 'Veergu "' || 'Nimi' || '" ei eksisteeri.', '-', 'VIGA', punktid*0, punktid, '', Jr);
		endif;

	end;


create procedure kolmas_iseseisev()
	begin



	end;



create procedure käivita(versioon)
	begin

		if versioon = 3 then
			call kolmas_praktikum();
			call kolmas_iseseisev()
		endif;
		
		call arvuta_punktid();
	end;





select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;
output to 'C:\TEMP\tulemus.txt' format text;