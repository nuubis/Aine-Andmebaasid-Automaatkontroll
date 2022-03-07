-- Muutuja mis määrab, milline kodutöö käivitatakse, 2=praktikum 3(27õn), 3=kodutöö(28õn) 3, 4=kodutöö 4(31õn)
create or replace variable versioon int = 3;

-- Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab 
if 	exists (select * from sysprocedure where proc_name = 'deleteS') 						then drop function deleteS 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_name') 						then drop function find_table_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_id') 						then drop function find_table_id 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_column_name') 						then drop function find_column_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'teine_praktikum') 						then drop function teine_praktikum 						endif;
if 	exists (select * from sysprocedure where proc_name = 'teine_kodutöö') 						then drop function teine_kodutöö 						endif;
if 	exists (select * from sysprocedure where proc_name = 'käivita') 						then drop function käivita 						endif;
if 	exists (select * from sysprocedure where proc_name = 'arvuta_punktid') 						then drop function arvuta_punktid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'check_check') 						then drop function check_check 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_praktikum') 						then drop function kolmas_praktikum 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_kodutöö') 						then drop function kolmas_kodutöö 						endif;



-- Erinevate ülesannete järjekorrad
create or replace variable praktikum_2_jr int = 1; 
create or replace variable praktikum_punktid_2_jr int = 3; 
create or replace variable kodutöö_2_jr int = 2;
create or replace variable kodutöö_punktid_2_jr int = 4;

create or replace variable praktikum_3_jr int = 2;
create or replace variable kodutöö_3_jr int = 2;


-- Ülesannete punktid
-- Praktikum 2 punktid
create or replace variable praktikum_2_punktid numeric = 0.3; -- 5 testi, alates 3: 3 testi
create or replace variable praktikum_2_turniirid_asukoht numeric = 0.06;
create or replace variable praktikum_2_isikud_perenimi numeric = 0.06;
create or replace variable praktikum_2_klubid_100 numeric = 0.06;
create or replace variable praktikum_2_uus_klubi numeric = 0.06;
create or replace variable praktikum_2_vastavus_check numeric = 0.06;
-- kodutöö 2 punktid
create or replace variable kodutöö_2 numeric = 0.7; -- 9 testi, millest 4 = 2 , alates 3: 7 testi 4 = 2
create or replace variable kodutöö_2_isikud_klubis numeric = 0.1;
create or replace variable kodutöö_2_partiid_kokkuvõte numeric = 0.1;
create or replace variable kodutöö_2_klubi_asukoha_muutmine numeric = 0.1;
create or replace variable kodutöö_2_isiku_klubi_muutmine numeric = 0.1;
create or replace variable kodutöö_2_isikute_lisamine numeric = 0.1;
create or replace variable kodutöö_2_ajakontroll_lopphetk_väiksem numeric = 0.05;
create or replace variable kodutöö_2_ajakontroll_lopphetk_võrdub numeric = 0.05;
create or replace variable kodutöö_2_ajakontroll_alguskuupäev_suurem numeric = 0.05;
create or replace variable kodutöö_2_ajakontroll_alguskuupäev_võrdub numeric = 0.05;
-- eelnevad kokku on 14 testi, alates 3: 10


create or replace variable praktikum_3 numeric = 1;
create or replace variable kodutöö_3 numeric = 2;

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
	Punktid numeric(7,3), 
	Max_punktid numeric(7,3), 
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
		else	set max_punktid = 3;
		endif;
		
		if 		versioon = 2 then
			-- Protsendi arvutamine
			select count(*) into õiged from Staatus where olek = 'OK' and ylesanne = 'Praktikum';
			select count(*) into vead from Staatus where olek = 'VIGA' and ylesanne = 'Praktikum';
			
			-- Praktikumi õiged ja valed
			set kokku = õiged + vead;
			insert into Staatus values ('Praktikum', '-', '-', 'Õiged kokku', õiged, kokku, '', praktikum_punktid_2_jr);
			insert into Staatus values ('Praktikum', '-', '-', 'Vead Kokku', vead, 0, '', praktikum_punktid_2_jr);
			
		endif;
		--Iseseisev punktid
		select sum(punktid) into punktid from staatus where ylesanne = 'Iseseisev';
		insert into Staatus values ('Iseseisev','-','-', 'Hindepunktid', punktid, max_punktid, '', kodutöö_punktid_2_jr);
		
	end;


create procedure teine_praktikum()
	begin
		declare punktid numeric = 0;
		declare Jr int;
		set Jr = 1;
		
		
		-- Tabel Turniirid veerg asukoht
		if versioon = 2 then
			begin try
				if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid')) 
				then 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht" ', 'ei ole olemas', 'VIGA', praktikum_2_turniirid_asukoht*0, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
				else 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht"', 'on olemas', 'OK', praktikum_2_turniirid_asukoht*0, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht" ', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_turniirid_asukoht*0, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
			end catch;
			
			-- Tabel klubid asukoht suuurus = 100
			begin try
				if		(select width from syscolumn where table_id = find_table_id('klubid') and column_name = 'asukoht') = 100
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on õige', 'OK', praktikum_2_klubid_100*0, praktikum_2_klubid_100, '', praktikum_2_jr);
				else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on vale', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, '', praktikum_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, '', praktikum_2_jr);
			end catch;
			
		endif;
		
		-- Tabel Isikud perenime muutmine
		begin try
				if 		(select perenimi from isikud where eesnimi = 'Irys') = 'Kompvek'
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isik "Irys"', 'perenimi on õige', 'OK', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
			else 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys"', 'perenimi on vale', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
		end catch;
		
		-- Klubi lisamine
		
		begin try
			if		(select count(*) from klubid where nimi = 'Osav Oda') = 1
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'on olemas', 'OK', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, '', praktikum_2_jr);
			else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'on puudu', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, '', praktikum_2_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, '', praktikum_2_jr);
		end catch;
		
		-- partii check
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:19:28.000', 73, 92, 0, 1);
			
			insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendust ei ole', 'VIGA', praktikum_2_vastavus_check*0, 	praktikum_2_vastavus_check, '', praktikum_2_jr);
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('partiid'))
			then 	insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_vastavus_check*0, 	praktikum_2_vastavus_check, '', praktikum_2_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendus on olemas', 'OK', 	praktikum_2_vastavus_check, 	praktikum_2_vastavus_check, '', praktikum_2_jr);
			endif;
		end catch;		
	end;


create procedure teine_kodutöö()
	begin
		
		-- Tabel Isikud veerg klubis
		begin try
			if 		not exists (select * from syscolumn where column_name = 'klubis' and table_id = find_table_id('isikud')) 
			then 	insert 	Staatus values ('Iseseisev', 'Tabel "Isikud" Veergu "Klubis" ', 'ei ole olemas', 'VIGA', kodutöö_2_isikud_klubis*0, kodutöö_2_isikud_klubis, '', kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabel "Isikud" Veerg "Klubis".', 'on olemas', 'OK', kodutöö_2_isikud_klubis, kodutöö_2_isikud_klubis, '', kodutöö_2_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values ('Iseseisev', 'Tabel "Isikud" Veerg "Klubis".', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isikud_klubis, kodutöö_2_isikud_klubis, '', kodutöö_2_jr);
		end catch;
		
		-- Tabel partiid veerg kokkuvõte
		begin try
			if 		exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('partiid')) 
			then 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote" ', 'ei ole kustutatud.', 'VIGA', kodutöö_2_partiid_kokkuvõte*0, kodutöö_2_partiid_kokkuvõte, '', kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veerg "Kokkuvote" ', 'on kustutatud.', 'OK', kodutöö_2_partiid_kokkuvõte, kodutöö_2_partiid_kokkuvõte, '', kodutöö_2_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote" ', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_partiid_kokkuvõte*0, kodutöö_2_partiid_kokkuvõte, '', kodutöö_2_jr);
		end catch;
		
		-- Tabel klubid klubi asukoha muutmine
		begin try
			if versioon = 2 then
				if 		(select asukoht from klubid where nimi = 'Valge mask') = 'Valga'
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask"', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				endif;
			else
				if 		(select asulad.nimi from asulad, klubid where klubid.nimi = 'Valge mask' and klubid.asula = asulad.id) = 'Valga'
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask"', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				endif;
		end try
		begin catch
			insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
		end catch;
		
		-- Tabel isikud isiku klubi muutmine
		begin try
			if 		(select klubis from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi"', 'klubi on õige.', 'OK', kodutöö_2_isiku_klubi_muutmine, kodutöö_2_isiku_klubi_muutmine, '', kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi"', 'klubi on vale.', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, '', kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try 
				if 		(select klubi from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi"', 'klubi on õige.', 'OK', kodutöö_2_isiku_klubi_muutmine, kodutöö_2_isiku_klubi_muutmine, '', kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi"', 'klubi on vale.', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, '', kodutöö_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, '', kodutöö_2_jr);
			end catch;
		end catch;
		
		-- Tabel Isikud lisamine klubisse Osav Oda
		begin try
			if 		(select count(*) from isikud where klubis = 62) = 5
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmed on olemas.', 'OK', kodutöö_2_isikute_lisamine, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmeid ei ole lisatud', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try
				if 		(select count(*) from isikud where klubi = 62) = 5
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmed on olemas.', 'OK', kodutöö_2_isikute_lisamine, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmeid ei ole lisatud', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
			end catch;
		end catch;
		
		-- partii check ajakontroll, lopphetk väiksem, l
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:01:28.000', 73, 92, 1, 1);
			
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada väiksemat lõpphetke', 	'VIGA', kodutöö_2_isikute_lisamine*0, 	kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
			delete from partiid where valge_tulemus = 1 and musta_tulemus = 1;
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('partiid'))
			then 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isikute_lisamine*0, 	kodutöö_2_isikute_lisamine, 'Veerg lopphetk on täpitähega.', kodutöö_2_jr);
			else 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', kodutöö_2_isikute_lisamine, kodutöö_2_isikute_lisamine, '', kodutöö_2_jr);
			endif;
		end catch;
		
		-- lopphetk = algushetk 
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:02:00.000', 73, 92, 1, 1);
			
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada võrdset algus ja lõpphetke', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, kodutöö_2_ajakontroll_lopphetk_võrdub, '', kodutöö_2_jr);
			delete from partiid where valge_tulemus = 1 and musta_tulemus = 1;
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('partiid'))
			then 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, 	kodutöö_2_ajakontroll_lopphetk_võrdub, 'Veerg lopphetk on täpitähega.', kodutöö_2_jr);
			else 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_ajakontroll_lopphetk_võrdub, '', kodutöö_2_jr);
			endif;
		end catch;
		
		-- turniirid check	ajakontroll, alguskuupaev suurem kui lopp
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid'))
			then 	alter table turniirid rename toimumiskoht to asukoht
			endif;
			if 		not exists (select * from syscolumn where column_name = 'nimetus' and table_id = find_table_id('turniirid'))
			then 	alter table turniirid rename nimi to nimetus
			endif;
			
			insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1','Kambja','2005-01-13','2005-01-12');
			insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
			delete from turniirid where nimetus = 'Ajakontroll Check1';	
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'Alguskuupaev' and table_id = find_table_id('turniirid'))
			or 		not exists (select * from syscolumn where column_name = 'Loppkuupaev' and table_id = find_table_id('turniirid'))
			then 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, 'Veerg lopphetk on täpitähega.', kodutöö_2_jr);
			else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_suurem, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
			endif;
		end catch;	
		-- alguskuupaev = loppkupäev
		begin try
			insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2','Kambja','2005-01-12','2005-01-12');
			insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
			delete from turniirid where nimetus = 'Ajakontroll Check2';
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'Alguskuupaev' and table_id = find_table_id('turniirid'))
			or 		not exists (select * from syscolumn where column_name = 'Loppkuupaev' and table_id = find_table_id('turniirid'))
			then 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 'Veerg alguskuupaev või loppkuupaev on täpitähega.', kodutöö_2_jr);
			else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus peab lubama võrdset algus ja Loppkuupaev', 	'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
			endif;
		end catch;
		
		
	
	end;


create procedure kolmas_praktikum()
	begin
	
	end;
	
create procedure kolmas_kodutöö()
	begin
	
	end;
	
create procedure käivita(versioon int)
	begin

		if versioon >= 2 then
			call teine_praktikum();
			call teine_kodutöö();
		endif;
		
		if versioon >= 3 then
			call kolmas_praktikum();
			call kolmas_kodutöö();
		endif;
		
		call arvuta_punktid(versioon);
	end;

call	käivita(versioon);

select  ylesanne, Kontroll, Tagasiside, Olek, Punktid, Max_punktid from staatus where Olek = 'VIGA' or Olek = 'Vead Kokku' or Olek = 'Õiged Kokku' or olek = 'Hindepunktid'
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;