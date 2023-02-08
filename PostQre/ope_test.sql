drop table muutujad;
create table muutujad (
nimi varchar(1000) unique,
taisarv int,
komaarv numeric);
delete from muutujad;
copy muutujad from 'C:\TEMP\muutujad.csv' with (format csv, delimiter ',');

drop table staatus;
create table Staatus (
Ylesanne varchar(100),
Kontrolli_nimi varchar(1000),
Tagasiside varchar(1000),
Olek varchar(100),
Punktid numeric,
Max_punktid numeric,
Jr int,
Id serial);
delete from Staatus;


create or replace procedure arvuta_punktid(versioon int) as $$
declare 
kodu_punktid numeric; 
kodu_max_punktid numeric;
kodutoo_jr int;
praktikum_jr int;
begin
	select taisarv into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	select taisarv into praktikum_jr from muutujad where nimi = 'praktikum_jr';
	if versioon = 2 then
		insert into Staatus values ('Praktikum 3', '-', '-', 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 3 then 
		insert into Staatus values ('Praktikum 4', '-', '-', 'Hindepunktid', 1, 1,	praktikum_jr);
		kodu_max_punktid := 0.5;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 3','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;

end;
$$ language plpgsql;

/* Tabeli veeru olemasolu kontroll */
create or replace procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100), olemasolu int) as $$
	begin
		if 	olemasolu = 1 then
			if 		exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veerg "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
			end if;
		else
			if 		not exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on kustutatud', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veerg "'||a_column_name||'" ', 'ei ole kustutatud', 'VIGA', punktid*0, punktid, jr);
			end if;
		end if;
	exception 
		when others then 
			insert into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'VIGA AUTOMAATKONTROLLIS!', 'VIGA', punktid, punktid, jr);
	end;
$$ language plpgsql;

/* Kitsenduste kontroll nimeliselt */
create or replace procedure check_constraint(a_table_name varchar(100), a_constraint_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100), olemasolu int) as $$
	begin
		if 	olemasolu = 1 then
			if 		exists (select * from information_schema.table_constraints where table_name = lower(a_table_name) and constraint_name = lower(a_constraint_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Kitsendus "'||a_constraint_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Kitsendus "'||a_constraint_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
			end if;
		else
			if 		not exists (select * from information_schema.table_constraints where table_name = lower(a_table_name) and constraint_name = lower(a_constraint_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Kitsendus "'||a_constraint_name||'" ', 'on kustutatud', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Kitsendus "'||a_constraint_name||'" ', 'ei ole kustutatud', 'VIGA', punktid*0, punktid, jr);
			end if;
		end if;
		
	exception 
		when others then 
			insert into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Kitsendus "'||a_constraint_name||'" ', 'VIGA AUTOMAATKONTROLLIS!', 'VIGA', punktid, punktid, jr);
	end;
$$ language plpgsql;

-- Praktikum 3 kontroll. 27ÕN
create or replace procedure praktikum_3(versioon int) as $$
declare
praktikum_3_jr int;
begin
	select taisarv into praktikum_3_jr from muutujad where nimi = 'praktikum_3_jr';
	-- Turniirid Asukoht
	if versioon = 2 then
			call check_column('Turniirid', 'Asukoht', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	end if;
	-- Partiid kitsendus vastavus
	call 	check_constraint('Partiid', 'vastavus', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Isikud veergude arv = 8
	if 		(select count(*) from information_schema.columns where table_name = 'isikud') = 8
	then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Veergude arv', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
	else	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Veergude arv', 'on vale, peab olema 8', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Isikud kitsendus isikukoodile
	call 	check_constraint('Isikud', 'un_isikukood', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Isikud kitsendus un_nimi on kustutatud
	call 	check_constraint('Isikud', 'nimi_unique', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 0);
	-- Klubid asukoht suurus
	if versioon = 2 then
		if		(select character_maximum_length from information_schema.columns c where table_name = 'klubid' and column_name = 'asukoht') = 100
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" andmetüüp', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" andmetüüp', 'on vale, peab olema varchar(100)', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Klubid asukoht default asukoht drop
	if versioon = 2 then
		if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asukoht' and column_default is null)
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" vaikimisi väärtus', 'on kustutatud', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" vaikimisi väärtus', 'ei ole kustutatud', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Irys on Kompvek perenimega
	if 		exists (select * from isikud where eesnimi = 'Irys' and perenimi = 'Kompvek')
	then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on õige perenimi', 'OK', 0, 0,	praktikum_3_jr);
	else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on vale perenimi, peab olema Kompvek', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Ei tohi olla ühtegi P tähea isikuid
	if		not exists (select * FROM isikud WHERE eesnimi LIKE 'P%' AND RIGHT(eesnimi,1)='P')
	then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" andmeid ', 'on kustutatud', 'OK', 0, 0,	praktikum_3_jr);
	else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" andmeid ', 'ei ole kustutatud', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Osav oda klubi olemas
	if 		exists (select * from klubid where nimi = 'Osav Oda')
	then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'on olemas', 'OK', 0, 0,	praktikum_3_jr);
	else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'ei ole olemas', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Isikud klubi->klubis
	call 	check_column('Isikud', 'Klubis', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Partiid kokkuvote kustutatud
	call 	check_column('Partiid', 'Kokkuvote', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 0);
	-- Turniirid kitsendus ajakontroll
	call 	check_constraint('Turniirid', 'ajakontroll', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Partiid kitsendus ajakontroll
	call 	check_constraint('Partiid', 'ajakontroll', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Klubi Valge Mask valgas
	if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asukoht') then
		if 		(select asukoht from klubid where nimi = 'Valge Mask') = 'Valga'
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on vale, peab olema Valga', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asula') then
		if 		(select asula from klubid where nimi = 'Valge Mask') = (select id from asulad where nimi = 'Valga')
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on vale, peab olema Valga', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Siim Susi klubis Laudnikud ja Osav Oda 5 uut liiget
	if 		exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'klubis') then
			if 		exists (select * from isikud where eesnimi = 'Siim' and perenimi = 'Susi' and klubis = (select id from klubid where nimi = 'Laudnikud'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on vale', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
			
			if 		exists (select count(*) from isikud where klubis = (select id from klubid where nimi = 'Osav Oda'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on vale, peab olema 5', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
	end if;
			
	if 		exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'klubi') then
			if 		exists (select * from isikud where eesnimi = 'Siim' and perenimi = 'Susi' and klubi = (select id from klubid where nimi = 'Laudnikud'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on vale', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
			
			if 		exists (select count(*) from isikud where klubi = (select id from klubid where nimi = 'Osav Oda'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on vale, peab olema 5', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
	end if;
	
end;	
$$ language plpgsql;


-- Praktikum 4 kontroll. 28ÕN
create or replace procedure praktikum_4(versioon int) as $$
declare
praktikum_4_jr int;
begin
	select taisarv into praktikum_4_jr from muutujad where nimi = 'praktikum_4_jr';
	-- tabel asulad slaid 10
	if 		exists (select * from information_schema.tables where table_name = 'asulad')
	then 	insert into Staatus values ('Praktikum 4', 'Tabel "Asulad"', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Asulad"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;	
	
	-- tabel riigid slaid 11
	if 		exists (select * from information_schema.tables where table_name = 'riigid')
	then 	insert into Staatus values ('Praktikum 4', 'Tabel "Riigid"', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Riigid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;	
	
	-- tabel riigid andmed slaid 16
	if 		exists (select * from information_schema.tables where table_name = 'riigid') then
			if 		(select count(*) from riigid) > 0
			then 	insert into Staatus values ('Praktikum 4', 'Tabel "Riigid" andmed', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
			else	insert into Staatus values ('Praktikum 4', 'Tabel "Riigid" andmed', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 4', 'Tabel "Riigid" andmed', 'tabelit "Riigid" ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- tabelis asulad andmed slaid 17
	if 		exists (select * from information_schema.tables where table_name = 'asulad') then
			if 		(select count(*) from asulad) > 0
			then 	insert into Staatus values ('Praktikum 4', 'Tabel "Asulad" andmed', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
			else	insert into Staatus values ('Praktikum 4', 'Tabel "Asulad" andmed', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
			end if;
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Asulad" andmed', 'tabelit "Asulat" ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- klubid veerg asula slaid 18
	call check_column('klubid', 'asula', 0, praktikum_4_jr, 'Praktikum 4', 'Tabel',1);
	
	-- klubid veerg asula andmed slaid 18
	if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asula') then
			if 		(select count(*) from klubid where asula is not null) > 0
			then 	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
			else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
			end if;
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'veergu "Asula" ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- välisvõtme fk_klubi_2_asula olemasolu
	if 		exists (select * from information_schema.table_constraints where table_name = 'klubid' and constraint_type = 'FOREIGN KEY')
	then 	insert into Staatus values ('Praktikum 4', 'Välisvõti "fk_klubi_2_asula"', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Välisvõti "fk_klubi_2_asula"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- 5. tabeli turniirid veerg asukoht/toimumiskoht olemasolu puudumine
	if 		not exists (select * from information_schema.columns where table_name = 'klubid' and column_name in ('asukoht'))
	then 	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" veerg "Asukoht"', 'on kustutatud', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
end;	
$$ language plpgsql;


create or replace procedure kodutoo_3(versioon int) as $$ -- punktid kokku 2p: 1-5. ül. 0.5p, 6 ül. 0.75p, 7.ül 0.75p 
declare 
kodutoo_3_jr int;
kodutoo_3_inimesed_andmed numeric;
kodutoo_3_turniirid_asula numeric;
kodutoo_3_turniirid_asukoht_kustutamine numeric;
kodutoo_3_valisvoti_turniirid_asulad numeric;
begin 
	select taisarv into kodutoo_3_jr from muutujad where nimi = 'kodutoo_3_jr';
	select komaarv into kodutoo_3_turniirid_asula from muutujad where nimi = 'kodutoo_3_turniirid_asula';
	select komaarv into kodutoo_3_inimesed_andmed from muutujad where nimi = 'kodutoo_3_inimesed_andmed';
	select komaarv into kodutoo_3_turniirid_asukoht_kustutamine from muutujad where nimi = 'kodutoo_3_turniirid_asukoht_kustutamine';
	select komaarv into kodutoo_3_valisvoti_turniirid_asulad from muutujad where nimi = 'kodutoo_3_valisvoti_turniirid_asulad';
	
	-- 1. tabeli inimesed andmed
	if 		exists (select * from information_schema.tables where table_name = 'inimesed') then 
			if 		(select count(*) from inimesed) > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on olemas', 'OK', kodutoo_3_inimesed_andmed, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 3', 'Tabelit "Inimesed"', 'ei ole olemas', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
	end if;
	
	-- 2. Turniirid veerg asula
	call check_column('turniirid', 'asula', kodutoo_3_turniirid_asula, kodutoo_3_jr, 'Kodutoo 3', 'Tabel',1);
	
	-- 3. Kontrollida tabeli turniirid veergu asula kirjeid
	call turniirid_asula_andmed(kodutoo_3_jr);
	
	-- 4. välisvõtme fk_turniir_2_asula kontroll
	if 		exists (select * from information_schema.table_constraints where table_name = 'turniirid' and constraint_type = 'FOREIGN KEY')
	then 	insert into Staatus values ('Kodutoo 3', 'Välisvõti "fk_turniir_2_asula"', 'on olemas', 'OK', kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_jr);
	else	insert into Staatus values ('Kodutoo 3', 'Välisvõti "fk_turniir_2_asula"', 'ei ole olemas', 'VIGA', kodutoo_3_valisvoti_turniirid_asulad*0, kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_jr);
	end if;
	
	-- 5. tabeli turniirid veerg asukoht/toimumiskoht olemasolu puudumine
	if 		not exists (select * from information_schema.columns where table_name = 'turniirid' and column_name in ('asukoht', 'toimumiskoht'))
	then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asukoht" voi "Toimumiskoht"', 'on kustutatud', 'OK', kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_jr);
	else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asukoht" voi "Toimumiskoht"', 'ei ole kustutatud', 'VIGA', kodutoo_3_turniirid_asukoht_kustutamine*0, kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_jr);
	end if;
	
	-- 6. päringu kontroll
	
	-- 7. päringu kontroll
	
end;	
$$ language plpgsql;

create or replace procedure turniirid_asula_andmed(kodutoo_3_jr int) as $$ 
declare 
kodutoo_3_turniirid_asula_andmed numeric;
begin 

	select komaarv into kodutoo_3_turniirid_asula_andmed from muutujad where nimi = 'kodutoo_3_turniirid_asula_andmed';

	if (select count(*) from Turniirid where asula isnull) = 0 then 
	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asula" andmed', 'on olemas', 'OK', kodutoo_3_turniirid_asula_andmed, kodutoo_3_turniirid_asula_andmed, kodutoo_3_jr);
	else 
	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asula" andmed', 'on puudu', 'VIGA', kodutoo_3_turniirid_asula_andmed*0, kodutoo_3_turniirid_asula_andmed, kodutoo_3_jr);
	end if;
	
	exception 
		when others then 
			case
				when	not exists (select * from information_schema.tables where table_name = 'turniirid')
				then	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asula" andmed', 'Tabelit "Turniirid" ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula_andmed*0, kodutoo_3_turniirid_asula_andmed, kodutoo_3_jr);
				when	not exists (select * from information_schema.columns where table_name = 'turniirid' and column_name = 'asula')
				then	insert into  Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asula" andmed', 'Veergu "Asula" ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula_andmed*0, kodutoo_3_turniirid_asula_andmed, kodutoo_3_jr);
				else	insert into Staatus values ('Kodutoo', 'Tabel "Turniirid" veerg "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutoo_3_turniirid_asula_andmed*0, kodutoo_3_turniirid_asula_andmed, kodutoo_3_jr);
			end case;
end;	
$$ language plpgsql;

create or replace procedure kaivita (versioon int) as $$
declare aeg timestamp;
tudeng int;
begin 
	select taisarv into tudeng from muutujad where nimi = 'tudeng';
	if versioon >= 2 then
		call praktikum_3(versioon);
	end if;
	if versioon >= 3 then
		call praktikum_4(versioon);
		call kodutoo_3(versioon); 
	end if;
	
	call arvuta_punktid(versioon);
	
	if 		exists (select * from information_schema.tables where table_name = 'inimesed') then
			select min(sisestatud) into aeg from inimesed;
			insert into staatus values ('Tudeng', 	(select eesnimi from inimesed where sisestatud = aeg), 
				(select perenimi from inimesed where sisestatud = aeg), '-', 0, 0, tudeng);
	end if;
end;
$$ LANGUAGE plpgsql;
/*
Siin määrad, mis ülesandeid kontrollitakse. Kõik eelnevad kontrollivad ka eelmisi.
2 - praktikum 3
3 - praktikum 4 ja kodutöö 3

*/
call kaivita(2);
Copy (Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') order by jr asc) To 'C:\TEMP\tulemus.csv' With CSV DELIMITER ',' HEADER;
--Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') order by jr asc;