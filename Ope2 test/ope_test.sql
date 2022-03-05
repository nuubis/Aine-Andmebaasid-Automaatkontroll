-- Muutuja mis määrab, milline kodutöö käivitatakse, 2=praktikum 3(27õn), 3=kodutöö(28õn) 3, 4=kodutöö 4(31õn)
create or replace variable versioon int = 2;

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
if 	exists (select * from systable where table_name = 'Staatus') then drop table Staatus endif; 

/* 
Staatus tabelis on: 
Nimi - tabeli, välivõtme, triggeri, vaate jne nimetus
Veerg - peamiselt tabeli veeru nimi, aga võib olla ka mingi muu kirjeldus
Tagasiside - mis on valesti, või '-' kui kõik on korras
Olek - veerg, mis näitab 'OK', 'VIGA', 'AEG', 'Kokku', 'Hindepunktid' märguandeid
Punktid - mitu punkti sai teatud ülesande osa eest
Max punktid - maksimum punktid, kui palju selle osa eest saab
Soovitus - soovitus, kust võib viga leida või kas sul on olemas X asi?
Jr - määrab järjestuse kuidas tulemused on näha
*/
create table Staatus(
	ylesanne varchar(1000), 
	Kontroll varchar(1000), 
	Tagasiside varchar(1000), 
	Olek varchar(100), 
	Punktid numeric(7,2), 
	Max_punktid numeric(7,2), 
	Soovitus varchar(1000), 
	Jr int default 100);


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

create 	procedure arvuta_punktid(versioon int)
	begin
		declare max_punktid_jr, õiged, vead, kokku int;
		declare punktid, max_punktid numeric;
		set 	max_punktid_jr = 10;
		
		if 		versioon = 2 then set max_punktid = 0.35;
		endif;

		-- Protsendi arvutamine
		select count(*) into õiged from Staatus where olek = 'OK' and ylesanne = 'Praktikum';
		select count(*) into vead from Staatus where olek = 'VIGA' and ylesanne = 'Praktikum';
		
		-- Praktikumi õiged ja valed
		set kokku = õiged + vead;
		insert into Staatus values ('Praktikum', '-', '-', 'Õiged kokku', õiged, kokku, '', max_punktid_jr);
		insert into Staatus values ('Praktikum', '-', '-', 'Vead Kokku', vead, 0, '', max_punktid_jr);
		
		--Iseseisev punktid
		select sum(punktid) into punktid from staatus where ylesanne = 'Iseseisev';
		insert into Staatus values ('Iseseisev','-','-', 'Hindepunktid', punktid, max_punktid, '', max_punktid_jr+1);
		
		
	end;


create procedure kolmas_praktikum()
	begin
		declare punktid numeric = 0;
		declare Jr int;
		set Jr = 1;
		
		-- Tabel Turniirid veerg nimi
		if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid')) 
		then 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht" ', 'ei ole olemas.', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht"', 'on olemas', 'OK', punktid*0, punktid, '', Jr);
		endif;
		
		-- Tabel Isikud perenime muutmine
		if 		(select perenimi from isikud where eesnimi = 'Irys') = 'Kompvek'
		then 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isik "Irys"', 'perenimi on õige', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys"', 'perenimi on vale.', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- Tabel klubid asukoht suuurus = 100
		if		(select width from syscolumn where table_id = find_table_id('klubid') and column_name = 'asukoht') = 100
		then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on õige', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on vale', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- Klubi lisamine
		if		(select count(*) from klubid where nimi = 'Osav Oda') = 1
		then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'on olemas', 'OK', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'on puudu', 'VIGA', punktid*0, punktid, '', Jr);
		endif;
		
		-- partii check
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:19:28.000', 73, 92, 0, 1);
			
			insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendust ei ole', 'VIGA', punktid*0, 	punktid, '', Jr)
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendus on olemas', 'OK', 	punktid, 	punktid, '', Jr)
		end catch;
		
		/*-- sugu puudumine
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("sugu" in( ''m'',''n'' ) )') = 0				
		then 	insert Staatus values ('Praktikum', 'Tabel "Isikud" check sugu', 'on kustutatud', 'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Praktikum', 'Tabel "Isikud" check sugu', 'ei ole kustutatud', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif; 
		
		-- unique puudumine?
		if 		(select 	count(*) into unique_count 	from sysindex where creator = 1 and table_id = find_table_id('isikud') and "unique" = 'U') = 1				
		then 	insert Staatus values ('Praktikum', 'Tabel "Isikud" unique un_nimi', 'on kustutatud', 'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Praktikum', 'Tabel "Isikud" unique un_nimi ', 'ei ole kustutatud', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;*/
		
	end;


create procedure kolmas_iseseisev()
	begin
		declare punktid numeric = 0.05;
		declare Jr int = 2;
		
		-- Tabel Isikud veerg klubis
		if 		not exists (select * from syscolumn where column_name = 'klubis' and table_id = find_table_id('isikud')) 
		then 	insert 	Staatus values ('Iseseisev', 'Tabel "Isikud" Veergu "Klubis" ', 	'ei eksisteeri.', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Iseseisev', 'Tabel "Isikud" Veerg "Klubis".', 					'-', 'OK', punktid, punktid, '', Jr);
		endif;
		
		-- Tabel partiid veerg kokkuvõte
		if 		exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('partiid')) 
		then 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote" ', 	'ei ole kustutatud.', 'VIGA', punktid*0, punktid, '', Jr);
		else 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veerg "Kokkuvote" ', 					'on kustutatud.', 'OK', punktid, punktid, '', Jr);
		endif;
		
		-- partii check ajakontroll, lopphetk väiksem, l
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:01:28.000', 73, 92, 1, 1);
			
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada väiksemat lõpphetke', 	'VIGA', punktid*0, 	punktid, '', Jr)
		end try
		begin catch
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', punktid, punktid, '', Jr)
		end catch;
		-- opphetk = algushetk 
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:02:00.000', 73, 92, 1, 1);
			
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada võrdset algus ja lõpphetke', 	'VIGA', punktid*0, 	punktid, '', Jr)
		end try
		begin catch
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', punktid, punktid, '', Jr)
		end catch;
		
		-- turniirid check	ajakontroll, alguskuupaev suurem kui lopp
		
		begin try
		end try
		begin catch
		end catch;		
		if 		(select 	count(*) into check_count		from syscheck where check_defn = 'check("alguskuupaev" <= "loppkuupaev")') = 1				
		then 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Lopphetk <= algushetk', '-',  								'OK', 	punktid, 	punktid, '', Jr)
		else	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Lopphetk <= algushetk', 'ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, '', Jr)
		endif;
		-- alguskuupaev = loppkupäev
		begin try
		end try
		begin catch
		end catch;
		
		-- Tabel klubid klubi asukoha muutmine
		if 		(select asukoht from klubid where nimi = 'Valge mask') = 'Valga'
		then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask"', '-', 'OK', punktid, punktid, '', Jr);
		else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" ', 'asukoht on vale.', 'VIGA', punktid*0, punktid, '', Jr);
		endif;

		-- Tabel isikud isiku klubi muutmine
		begin try
			if 		(select klubis from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" ', 'klubi on õige.', 'OK', punktid, punktid, '', Jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" ', 'klubi on vale.', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end try
		begin catch
			if 		(select klubi from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" ', 'klubi on õige.', 'OK', punktid, punktid, '', Jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" ', 'klubi on vale.', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end catch;
		
		-- Tabel Isikud lisamine klubisse Osav Oda
		begin try
			if 		(select count(*) from isikud where klubis = 62) = 5
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda" ', 'liikmed on olemas.', 'OK', punktid, punktid, '', Jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda" ', 'liikmeid ei ole lisatud', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end try
		begin catch
			if 		(select count(*) from isikud where klubi = 62) = 5
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda" ', 'liikmed on olemas.', 'OK', punktid, punktid, '', Jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda" ', 'liikmeid ei ole lisatud', 'VIGA', punktid*0, punktid, '', Jr);
			endif;
		end catch;
		


	end;

create procedure käivita(versioon int)
	begin

		if versioon = 2 then
			call kolmas_praktikum();
			call kolmas_iseseisev();
		endif;
		
		call arvuta_punktid(versioon);
	end;

call	käivita(versioon);

select  ylesanne, Kontroll, Tagasiside, Olek, Punktid, Max_punktid from staatus where Olek = 'VIGA' or Olek = 'Vead Kokku' or Olek = 'Õiged Kokku' or olek = 'Hindepunktid'
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;