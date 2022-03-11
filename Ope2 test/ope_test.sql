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
if 	exists (select * from sysprocedure where proc_name = 'check_foreign_key') 						then drop function check_foreign_key 						endif;



-- Erinevate ülesannete järjekorrad
-- 1-9
create or replace variable praktikum_2_jr int = 1; 
create or replace variable praktikum_punktid_2_jr int = 2; 

create or replace variable kodutöö_2_jr int = 5;
create or replace variable kodutöö_punktid_2_jr int = 6;

create or replace variable praktikum_3_jr int = 10;
create or replace variable praktikum_punktid_3_jr int = 11;

-- 50 praktikumide punktid
create or replace variable praks_lõpp_punktid int = 50;

-- Kodutööde punktid
create or replace variable kodutöö_3_jr int = 54;
create or replace variable kodutöö_punktid_3_jr int = 55;
-- 100 kodutööde punktid
create or replace variable kodu_lõpp_punktid int = 100;

-- 101
create or replace variable tudengi_nimi int = 101;


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

-- praktikum 3 punktid
create or replace variable praktikum_3 numeric = 1; -- 9 testi, 8 tava 1 välisvõti
create or replace variable praktikum_3_tabel_inimene numeric = 0.1;
create or replace variable praktikum_3_tabel_asulad numeric = 0.1;
create or replace variable praktikum_3_tabel_riigid numeric = 0.1;
create or replace variable praktikum_3_riigid_andmed numeric = 0.1;
create or replace variable praktikum_3_asulad_andmed numeric = 0.1;
create or replace variable praktikum_3_klubid_asula numeric = 0.1;
create or replace variable praktikum_3_klubid_asula_andmed  numeric = 0.1;
create or replace variable praktikum_3_klubid_asukoht_kustutamine  numeric = 0.1;
create or replace variable praktikum_3_välisvõti_klubid_asulad numeric = 0.1;
-- kodutöö 3 punktid
create or replace variable kodutöö_3 numeric = 2;
create or replace variable kodutöö_3_inimesed_andmed numeric = 0.1;
create or replace variable kodutöö_3_turniirid_asula numeric = 0.1;
create or replace variable kodutöö_3_turniirid_asula_andmed numeric = 0.1;
create or replace variable kodutöö_3_turniirid_asukoht_kustutamine numeric = 0.1;
create or replace variable kodutöö_3_välisvõti_turniirid_asulad numeric = 0.1;




-- Eelenvate praktikumide ja kodutööde punktide väärtuste panemine 0.01 peale
--Praktikum ja kodutöö 2
if 	versioon > 2 then
	set praktikum_2_turniirid_asukoht = 0.01;
	set praktikum_2_isikud_perenimi  = 0.01;
	set praktikum_2_klubid_100 = 0.01;
	set praktikum_2_uus_klubi = 0.01;
	set praktikum_2_vastavus_check = 0.01;
	set kodutöö_2_isikud_klubis = 0.01;
	set kodutöö_2_partiid_kokkuvõte = 0.01;
	set kodutöö_2_klubi_asukoha_muutmine = 0.01;
	set kodutöö_2_isiku_klubi_muutmine = 0.01;
	set kodutöö_2_isikute_lisamine = 0.01;
	set kodutöö_2_ajakontroll_lopphetk_väiksem = 0.005;
	set kodutöö_2_ajakontroll_lopphetk_võrdub = 0.005;
	set kodutöö_2_ajakontroll_alguskuupäev_suurem = 0.005;
	set kodutöö_2_ajakontroll_alguskuupäev_võrdub = 0.005;
endif;

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
		declare kodu_punktid, kodu_max_punktid, praks_punktid, praks_max_punktid numeric;
		set 	max_punktid_jr = 10;
		
		if 		versioon = 2 then set max_punktid = 0.35;
		else	set praks_max_punktid = 1; 
				set kodu_max_punktid = 0.5;
		endif;
		
		if 		versioon = 2 then
			-- Protsendi arvutamine
			select count(*) into õiged from Staatus where olek = 'OK' and ylesanne = 'Praktikum';
			select count(*) into vead from Staatus where olek = 'VIGA' and ylesanne = 'Praktikum';
			
			-- Praktikumi õiged ja valed
			set kokku = õiged + vead;
			insert into Staatus values ('Praktikum', '-', '-', 'Õiged kokku', õiged, kokku, '', praktikum_punktid_2_jr);
			insert into Staatus values ('Praktikum', '-', '-', 'Vead Kokku', vead, 0, '', praktikum_punktid_2_jr);
			
			--Iseseisev punktid
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Iseseisev';
			insert into Staatus values ('Iseseisev','-','-', 'Hindepunktid', kodu_punktid, max_punktid, '', kodutöö_punktid_2_jr);
		endif;
		
		if 		versioon > 2 then
			select sum(punktid) into praks_punktid from staatus where ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Praktikum','-','-', 'Hindepunktid', praks_punktid, praks_max_punktid, '', praks_lõpp_punktid);
			
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, '', kodu_lõpp_punktid);
		endif;
		
	end;


create	procedure check_foreign_key(p_primary_table varchar(30), p_primary_column varchar(30), p_foreign_table varchar(30), p_foreign_column varchar(30), punktid numeric, Jr integer, ylesanne varchar(30))

begin
declare primary_t_id, foreign_t_id, primary_c_id, foreign_c_id, f_key_id int;
declare count_f_key, count_fk int;

// Salvestan kõikide vajalike tabelite ja veergude ID-d ning samal ajal kontrollin, kas need on olemas
select 	table_id into primary_t_id 	from systable where upper(table_name) = upper(p_primary_table);

select 	column_id into primary_c_id from syscolumn where table_id = primary_t_id
and 	upper(column_name) 			= upper(p_primary_column);

select 	table_id into foreign_t_id 	from systable where table_name = p_foreign_table;

select 	column_id into foreign_c_id from syscolumn where table_id = foreign_t_id
and 	upper(column_name) 			= upper(p_foreign_column);

// Loen kokku mitu välisvõtit vastab nendele andmetele (peaks olema 1)
select 	count(foreign_key_id) 		into count_f_key from sysfkcol
where 	foreign_table_id = foreign_t_id 
and 	foreign_column_id = foreign_c_id
and 	primary_column_id = primary_c_id;



// Kui 	on rohkem kui üks, siis tagastan veateate
if 		count_f_key != 1 	then insert Staatus values (ylesanne, 'Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"' || 
														p_primary_column || ' <-> ' || p_foreign_column, 
														'Välisvõtit pole nende tabelite ja/või veergude vahel.',
														'VIGA', punktid*0, punktid, '', Jr)

else
select 	foreign_key_id 		into f_key_id 		from sysfkcol
where 	foreign_table_id 	= foreign_t_id 
and 	foreign_column_id 	= foreign_c_id
and 	primary_column_id 	= primary_c_id;
endif;

select 	count(*) 			into count_fk 		from sysforeignkey
where	foreign_table_id 	= foreign_t_id 
and 	primary_table_id 	= primary_t_id
and		foreign_key_id		= f_key_id;

if 		count_fk != 1 		and count_f_key = 1	then insert Staatus values (ylesanne, 'Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"' || 
														p_primary_column || ' <-> ' || p_foreign_column, 
														'Välisvõtit pole nende tabelite ja/või veergude vahel.',
														'VIGA', punktid*0, punktid, '', Jrr)
endif;

if		count_fk = 1		and count_f_key = 1 then insert Staatus values (ylesanne, 'Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"' || 
														p_primary_column || ' <-> ' || p_foreign_column, 
														'Välisvõtit pole nende tabelite ja/või veergude vahel.',
														'VIGA', punktid*0, punktid, '', Jr)
endif;

end;


create procedure teine_praktikum()
	begin
		-- Tabel Turniirid veerg asukoht
		if versioon = 2 then
			begin try
				if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid')) 
				then 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht" ', 'ei ole olemas', 'VIGA', praktikum_2_turniirid_asukoht*0, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
				else 	insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht"', 'on olemas', 'OK', praktikum_2_turniirid_asukoht, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Praktikum', 'Tabel "Turniirid" Veergu "Asukoht" ', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_turniirid_asukoht*0, praktikum_2_turniirid_asukoht, '', praktikum_2_jr);
			end catch;
			
			-- Tabel klubid asukoht suuurus = 100
			begin try
				if		(select width from syscolumn where table_id = find_table_id('klubid') and column_name = 'asukoht') = 100
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on õige', 'OK', praktikum_2_klubid_100, praktikum_2_klubid_100, '', praktikum_2_jr);
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
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isik "Irys"', 'perenimi on õige', 'OK', praktikum_2_isikud_perenimi, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
			else 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys"', 'perenimi on vale', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, '', praktikum_2_jr);
		end catch;
		
		-- Klubi lisamine
		
		begin try
			if		(select count(*) from klubid where nimi = 'Osav Oda') = 1
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" ', 'on olemas', 'OK', praktikum_2_uus_klubi, praktikum_2_uus_klubi, '', praktikum_2_jr);
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
			if 		(select asukoht from klubid where nimi = 'Valge mask') = 'Valga'
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask"', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try
				if 		(select asulad.nimi from asulad, klubid where klubid.nimi = 'Valge mask' and klubid.asula = asulad.id) = 'Valga'
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask"', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
				endif;
			end try
			begin catch
				insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, '', kodutöö_2_jr);
			end catch;
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
			
			insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada väiksemat lõpphetke', 	'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, '', kodutöö_2_jr);
			delete from partiid where valge_tulemus = 1 and musta_tulemus = 1;
		end try
		begin catch
			if 		not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('partiid'))
			then 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, 'Veerg lopphetk on täpitähega.', kodutöö_2_jr);
			else 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_ajakontroll_lopphetk_väiksem, '', kodutöö_2_jr);
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
		
		-- turniirid ajakontroll ettevalmistus
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid'))
			then 	alter table turniirid rename toimumiskoht to asukoht
			endif;
		end try
		begin catch
		end catch;
		
		begin try
			if 		not exists (select * from syscolumn where column_name = 'nimetus' and table_id = find_table_id('turniirid'))
			then 	alter table turniirid rename nimi to nimetus
			endif;
		end try
		begin catch
		end catch;
		
			
		-- turniirid check	ajakontroll, alguskuupaev suurem kui lopp
		begin try
				
			insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1','Kambja','2005-01-13','2005-01-12');
			insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
			delete from turniirid where nimetus = 'Ajakontroll Check1';	
		end try
		begin catch
			begin try
				insert into turniirid (Nimetus,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1',1,'2005-01-13','2005-01-12');
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
		end catch;	
		-- alguskuupaev = loppkupäev
		begin try
			insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2','Kambja','2005-01-12','2005-01-12');
			insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
			delete from turniirid where nimetus = 'Ajakontroll Check2';
		end try
		begin catch
			begin try
				insert into turniirid (Nimetus,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2',1,'2005-01-12','2005-01-12');
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
		end catch;
		
		
	
	end;


create procedure kolmas_praktikum()
	begin
	
		-- tabeli inimesed kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Inimesed')
			then 	insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_inimene*0, praktikum_3_tabel_inimene, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'on olemas', 'OK', praktikum_3_tabel_inimene, praktikum_3_tabel_inimene, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_inimene*0, praktikum_3_tabel_inimene, '', praktikum_3_jr);
		end catch;
		
		-- tabeli asulad kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Asulad')
			then 	insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_asulad*0, praktikum_3_tabel_asulad, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'on olemas', 'OK', praktikum_3_tabel_asulad, praktikum_3_tabel_asulad, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_asulad*0, praktikum_3_tabel_asulad, '', praktikum_3_jr);
		end catch;
		
		-- tabeli riigid kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Riigid')
			then 	insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_riigid*0, praktikum_3_tabel_riigid, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'on olemas', 'OK', praktikum_3_tabel_riigid, praktikum_3_tabel_riigid, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_riigid*0, praktikum_3_tabel_riigid, '', praktikum_3_jr);
		end catch;
		
		-- tabeli riigid andmed
		begin try
			if 		(select count(*) from riigid) = 63
			then 	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'on olemas', 'OK', praktikum_3_riigid_andmed, praktikum_3_riigid_andmed, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'on puudu', 'VIGA', praktikum_3_riigid_andmed*0, praktikum_3_riigid_andmed, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_riigid_andmed*0, praktikum_3_riigid_andmed, '', praktikum_3_jr);
		end catch;
		
		-- tabeli asulad andmed
		begin try
			if 		(select count(*) from asulad) = 10
			then 	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'on olemas', 'OK', praktikum_3_asulad_andmed, praktikum_3_asulad_andmed, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'on puudu', 'VIGA', praktikum_3_asulad_andmed*0, praktikum_3_asulad_andmed, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_asulad_andmed*0, praktikum_3_asulad_andmed, '', praktikum_3_jr);
		end catch;
		
		-- klubid veerg asula
		begin try
			if 		exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('klubid'))
			then 	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula"', 'on olemas', 'OK', praktikum_3_klubid_asula, praktikum_3_klubid_asula, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula"', 'on puudu', 'VIGA', praktikum_3_klubid_asula*0, praktikum_3_klubid_asula, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_klubid_asula*0, praktikum_3_klubid_asula, '', praktikum_3_jr);
		end catch;
		
		-- klubid veerg asula andmed
		begin try
			if 		(select count(*) from klubid where asula is null) = 0
			then 	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'on olemas', 'OK', praktikum_3_klubid_asula_andmed, praktikum_3_klubid_asula_andmed, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'on puudu', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, '', praktikum_3_jr);
		end catch;
		
		-- klubid veerg asukoht kustutamine
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('klubid'))
			then 	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asukoht"', 'on kustutatud', 'OK', praktikum_3_klubid_asukoht_kustutamine, praktikum_3_klubid_asukoht_kustutamine, '', praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', praktikum_3_klubid_asukoht_kustutamine*0, praktikum_3_klubid_asukoht_kustutamine, '', praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_klubid_asukoht_kustutamine*0, praktikum_3_klubid_asukoht_kustutamine, '', praktikum_3_jr);
		end catch;
		
		-- välisvõtme kontroll klubid ja asulad vahel
		call check_foreign_key('Asulad','id','Klubid','asula',praktikum_3_välisvõti_klubid_asulad,praktikum_3_jr, 'Praktikum')
		
		
	end;
	
create procedure kolmas_kodutöö()
	begin
		-- tabeli inimesed andmed
		begin try
			if 		(select count(*) from inimesed) >= 1
			then 	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'on olemas', 'OK', kodutöö_3_inimesed_andmed, kodutöö_3_inimesed_andmed, '', kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'on puudu', 'VIGA', kodutöö_3_inimesed_andmed*0, kodutöö_3_inimesed_andmed, '', kodutöö_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_inimesed_andmed*0, kodutöö_3_inimesed_andmed, '', kodutöö_3_jr);
		end catch;
		
		-- Turniirid veerg asula
		begin try
			if 		exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('Turniirid'))
			then 	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula"', 'on olemas', 'OK', kodutöö_3_turniirid_asula, kodutöö_3_turniirid_asula, '', kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula"', 'on puudu', 'VIGA', kodutöö_3_turniirid_asula*0, kodutöö_3_turniirid_asula, '', kodutöö_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_turniirid_asula*0, kodutöö_3_turniirid_asula, '', kodutöö_3_jr);
		end catch;
		
		-- Turniirid veerg asula andmed
		begin try
			if 		(select count(*) from Turniirid where asula is null) = 0
			then 	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'on olemas', 'OK', kodutöö_3_turniirid_asula_andmed, kodutöö_3_turniirid_asula_andmed, '', kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'on puudu', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, '', kodutöö_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, '', kodutöö_3_jr);
		end catch;
		
		-- turniirid veerg asukoht kustutamine
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid'))
			then 	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asukoht"', 'on kustutatud', 'OK', kodutöö_3_turniirid_asukoht_kustutamine, kodutöö_3_turniirid_asukoht_kustutamine, '', kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', kodutöö_3_turniirid_asukoht_kustutamine*0, kodutöö_3_turniirid_asukoht_kustutamine, '', kodutöö_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_turniirid_asukoht_kustutamine*0, kodutöö_3_turniirid_asukoht_kustutamine, '', kodutöö_3_jr);
		end catch;
		
		-- välisvõti turniirid ja asulad vahel
		call check_foreign_key('Asulad','id','Turniirid','asula',kodutöö_3_välisvõti_turniirid_asulad,kodutöö_3_jr, 'Kodutöö')
		
	end;
	
create procedure käivita(versioon int)
	begin
		declare aeg datetime;
		if versioon >= 2 then
			call teine_praktikum();
			call teine_kodutöö();
		endif;
		
		if versioon >= 3 then
			call kolmas_praktikum();
			call kolmas_kodutöö();
		endif;
		
		call arvuta_punktid(versioon);
		
		begin try
			select min(sisestatud) into aeg from inimesed;
			insert into staatus values ('Tudeng', 	(select eesnimi from inimesed where sisestatud = aeg), 
													(select perenimi from inimesed where sisestatud = aeg), '-', praktikum_3*0, praktikum_3*0, '', tudengi_nimi);
		end try
		begin catch
			insert into staatus values ('Tudeng', 'Eesnimi puudub', 'Perenimi puudub', 'VIGA', praktikum_3*0, praktikum_3*0, '', tudengi_nimi);
		end catch;
	end;

call	käivita(versioon);

select  ylesanne, Kontroll, Tagasiside, Olek, Punktid, Max_punktid from staatus where Olek = 'VIGA' or Olek = 'Vead Kokku' or Olek = 'Õiged Kokku' or olek = 'Hindepunktid' or ylesanne = 'Tudeng'
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;