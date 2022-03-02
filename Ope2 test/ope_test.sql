-- Muutuja mis määrab, milline kodutöö käivitatakse, 3=kodutöö 3, 4=kodutöö 4
create or replace variable versioon int = 3;

-- Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab 
if 	exists (select * from sysprocedure where proc_name = 'deleteS') 						then drop function deleteS 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_name') 						then drop function find_table_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_id') 						then drop function find_table_id 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_column_name') 						then drop function find_column_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_praktikum') 						then drop function kolmas_praktikum 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_iseseisev') 						then drop function kolmas_iseseisev 						endif;
if 	exists (select * from sysprocedure where proc_name = 'käivita') 						then drop function käivita 						endif;
if 	exists (select * from sysprocedure where proc_name = 'arvuta_punktid') 						then drop function arvuta_punktid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'check_check') 						then drop function check_check 						endif;



-- Staatus tabeli loomine/kustutamine - kui tabel eksisteerib siis kustutatakse see ära ja siis luuakse uuesti 
if 	exists (select * from systable where table_name = 'Staatus') then drop table Staatus endif; // Punktid numeric(7,2)
create table Staatus(
	Nimi varchar(100) not null, 
	Veerg varchar(100), 
	Tagasiside varchar(1000), 
	Olek varchar(100), 
	Punktid int, 
	Max_punktid int, 
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

create 	procedure arvuta_punktid()
	begin
		declare max_punktid_jr, õiged, vead, puudu, kokku int;
		set 	max_punktid_jr = 3;

		-- Protsendi arvutamine
		select count(*) into õiged from Staatus where olek = 'OK';
		select count(*) into vead from Staatus where olek = 'VIGA';
		select count(*) into puudu from Staatus where olek = 'PUUDU';
		
		--
		set kokku = õiged + vead + puudu;
		insert into Staatus values ('-', '-', '-', 'Õiged kokku', õiged, kokku, '', max_punktid_jr);
		insert into Staatus values ('-', '-', '-', 'Vead Kokku', vead, kokku, '', max_punktid_jr);
		insert into Staatus values ('-', '-', '-', 'Puudu Kokku', puudu, kokku, '', max_punktid_jr);
	end;


/* Protseduur, mis kontrollib, kas teatud tabelis on olemas vastav check kitsendus 
Sissetulevad andmed:
Check-i definitsioon = check_defn ehk see on selle checki kirjeldus süsteemis
tabeli nimi = table_name
veeru nimi = column_name

Protseduuri sisesne muutuja: check_count = check kogus antud tingimustel.

Kõigepealt loetakse kokku tabelist "syscheck" mitu check kitsendust on vastavalt sellele definitsioonile, peab olema ÜKS
seejärel kui tulemus ei ole 1 siis lisatakse veateade Staatus tabelisse ja kui on 1 siis lisatakse 'OK' Staatus tabelisse
*/
create 	procedure check_check(p_check_defn varchar(500), p_table_name varchar(30), p_column_name varchar(50), punktid numeric, Jr integer)
begin
declare check_count int;
declare soovitus varchar(5000) = '';

select 	count(*) into check_count		from syscheck where check_defn = p_check_defn;
if 		check_count = 1				
then 	insert Staatus values ('Tabel "' || p_table_name || '" check', p_column_name, '-',  								'OK', 	punktid, 	punktid, soovitus, Jr)
else	insert Staatus values ('Tabel "' || p_table_name || '" check', p_column_name, 'Tabelis ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, soovitus, Jr)
endif;

end;


create procedure kolmas_praktikum()
	begin
		declare punktid numeric;
		declare Jr int;
		set punktid = 0;
		set Jr = 1;
		
		-- Tabel Turniirid veerg nimi
		if 		not exists (select * from syscolumn where column_name = 'nimi' and table_id = find_table_id('turniirid')) 
		then 	insert 	Staatus values ('Tabel "Turniirid"', 'Veergu "Nimi" ei eksisteeri.', 	'-', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabel "Turniirid"', 'Veerg "Nimi".', 					'-', 'OK', punktid*0, punktid, '', Jr);
		endif;
		
		-- Tabel Isikud perenime muutmine
		if 		(select perenimi from isikud where eesnimi = 'Irys') = 'Kompvek'
		then 	insert 	Staatus values ('Tabelis "Isikud"', 'Isik "Irys"', '-', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabelis "Isikud"', 'Isiku "Irys" perenimi on vale.', '-', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- Tabel klubid asukoht suuurus = 100
		if		(select width from syscolumn where table_id = find_table_id('klubid') and column_name = 'asukoht') = 100
		then 	insert 	Staatus values ('Tabelis "Klubid"', 'Veerg "Asukoht" suurus.', '-', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabelis "Klubid"', 'Veerg "Asukoht" suurus on vales.', '-', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- Klubi lisamine
		if		(select count(*) from klubid where nimi = 'Osav Oda') = 1
		then 	insert 	Staatus values ('Tabelis "Klubid"', 'Klubi "Osav Oda" olemasolu.', '-', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabelis "Klubid"', 'Klubi "Osav Oda" on puudu.', '-', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- partii check		
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("valge_tulemus"+"musta_tulemus" = 2)') = 1				
		then 	insert Staatus values ('Tabel "Partiid" check', 'Valge_tulemus + Musta_tulemus', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Tabel "Partiid" check', 'Valge_tulemus + Musta_tulemus', 'Tabelis ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		
		-- sugu puudumine
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("sugu" in( ''m'',''n'' ) )') = 0				
		then 	insert Staatus values ('Tabel "Isikud" check', 'sugu kustutamine', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Tabel "Isikud" check', 'sugu kustutamine', 'Kitsendust ei ole kustutatud', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		
		-- unique puudumine?
		if 		(select 	count(*) into unique_count 	from sysindex where creator = 1 and table_id = find_table_id('isikud') and "unique" = 'U') = 1				
		then 	insert Staatus values ('Tabel "Isikud" unique', 'un_nimi kustutamine', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Tabel "Isikud" unique', 'un_nimi kustutamine', 'Kitsendust ei ole kustutatud', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		
	end;


create procedure kolmas_iseseisev()
	begin
		declare punktid numeric;
		declare Jr int;
		set punktid = 0;
		set Jr = 2;
		
		-- Tabel Isikud veerg klubis
		if 		not exists (select * from syscolumn where column_name = 'klubis' and table_id = find_table_id('isikud')) 
		then 	insert 	Staatus values ('Tabel "Isikud"', 'Veergu "Klubis" ei eksisteeri.', 	'-', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabel "Isikud"', 'Veerg "Klubis".', 					'-', 'OK', punktid*0, punktid, '', Jr);
		endif;
		
		-- Tabel partiid veerg kokkuvõte
		if 		exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('partiid')) 
		then 	insert 	Staatus values ('Tabel "Partiid"', 'Veergu "Kokkuvote" ei ole kustutatud.', 	'-', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabel "Partiid"', 'Veerg "Kokkuvote" on kustutatud.', 					'-', 'OK', punktid*0, punktid, '', Jr);
		endif;
		
		-- partii check ajakontroll
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("lopphetk" > "algushetk")') = 1				
		then 	insert Staatus values ('Tabel "Partiid" check', 'Lopphetk > algushetk', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Tabel "Partiid" check', 'Lopphetk > algushetk', 'Tabelis ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		--
		
		-- turniirid check	ajakontroll	
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("alguskuupaev" <= "loppkuupaev")') = 1				
		then 	insert Staatus values ('Tabel "Turniirid" check', 'Lopphetk <= algushetk', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Tabel "Turniirid" check', 'Lopphetk <= algushetk', 'Tabelis ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		
		-- Tabel klubid klubi asukoha muutmine
		if 		(select asukoht from klubid where nimi = 'Valge mask') = 'Valga'
		then 	insert 	Staatus values ('Tabelis "Klubid"', 'Klubi "Valge mask"', '-', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Tabelis "Klubid"', 'Klubid "Valge mask" asukoht on vale.', '-', 'VIGA', punktid*0, punktid, '', Jr);
		endif;

		-- Tabel isikud isiku klubi muutmine
		begin try
			if 		(select klubis from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Tabelis "Isikud"', 'Isiku "Siim Susi" klubi on õige.', '-', 'OK', punktid*0, punktid, '', Jr);
			else 	insert 	Staatus values ('Tabelis "Isikud"', 'Isiku "Siim Susi" klubi on vale.', '-', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end try
		begin catch
			if 		(select klubi from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Tabelis "Isikud"', 'Isiku "Siim Susi" klubi on õige.', '-', 'OK', punktid*0, punktid, '', Jr);
			else 	insert 	Staatus values ('Tabelis "Isikud"', 'Isiku "Siim Susi" klubi on vale.', '-', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end catch;
		
		-- Tabel Isikud lisamine klubisse Osav Oda
		begin try
			if 		(select count(*) from isikud where klubis = 62) = 5
			then 	insert 	Staatus values ('Tabelis "Isikud"', 'Klubi "Osav Oda" liikmed on olemas.', '-', 'OK', punktid*0, punktid, '', Jr);
			else 	insert 	Staatus values ('Tabelis "Isikud"', 'Klubi "Osav Oda" liikmeid ei ole lisatud', '-', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end try
		begin catch
			if 		(select count(*) from isikud where klubi = 62) = 5
			then 	insert 	Staatus values ('Tabelis "Isikud"', 'Klubi "Osav Oda" liikmed on olemas.', '-', 'OK', punktid*0, punktid, '', Jr);
			else 	insert 	Staatus values ('Tabelis "Isikud"', 'Klubi "Osav Oda" liikmeid ei ole lisatud', '-', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end catch;
		


	end;



create procedure käivita(versioon int)
	begin

		if versioon = 3 then
			call kolmas_praktikum();
			call kolmas_iseseisev();
		endif;
		
		call arvuta_punktid();
	end;



call	käivita(versioon);

select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus --where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;
output to 'C:\TEMP\tulemus.txt' format text;