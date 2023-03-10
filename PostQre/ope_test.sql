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
praktikum3_oige int;
praktikum3_saadud_oige int;
praktikum4_oige int;
praktikum4_saadud_oige int;
begin
	select taisarv into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	select taisarv into praktikum_jr from muutujad where nimi = 'praktikum_jr';
	select taisarv into praktikum3_oige from muutujad where nimi = 'praktikum3_oige';
	select taisarv into praktikum4_oige from muutujad where nimi = 'praktikum4_oige';
	if versioon = 2 then
		select count(*) into praktikum3_saadud_oige from staatus where ylesanne = 'Praktikum 3' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 3', 'Õigesti tehtud: ' || praktikum3_saadud_oige,'Maksimum õiged: '|| praktikum3_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 3 then 
		select count(*) into praktikum4_saadud_oige from staatus where ylesanne = 'Praktikum 4' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 4', 'Õigesti tehtud: ' || praktikum4_saadud_oige,'Maksimum õiged: '|| praktikum4_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
		kodu_max_punktid := 1;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 3','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;
	if versioon = 4 then 
		select count(*) from staatus where ylesanne = 'Praktikum 4';
		kodu_max_punktid := 2;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 4','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
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
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" andmetuup', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" andmetuup', 'on vale, peab olema varchar(100)', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Klubid asukoht default asukoht drop
	if versioon = 2 then
		if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asukoht' and column_default is null)
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" vaikimisi vaartus', 'on kustutatud', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" Veeru "Asukoht" vaikimisi vaartus', 'ei ole kustutatud', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Irys on Kompvek perenimega
	if 		exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'eesnimi') 
	and 	exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'perenimi')
	then
		if 		exists (select * from isikud where eesnimi = 'Irys' and perenimi = 'Kompvek')
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on õige perenimi', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on vale perenimi, peab olema Kompvek', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'puuduvad veerud eesnimi ja/või perenimi', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Osav oda klubi olemas
	if 		exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'nimi') then
		if 		exists (select * from klubid where nimi ilike 'osav oda')
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'on olemas', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'ei ole olemas', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	else insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" veergu "nimi"', 'ei ole olemas', 'VIGA', 0, 0,	praktikum_3_jr);
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
hilisem_kodutoo int;
begin 
	if 		versioon = 3 then hilisem_kodutoo :=1;
	else 	hilisem_kodutoo :=0;
	end if;
	select taisarv into kodutoo_3_jr from muutujad where nimi = 'kodutoo_3_jr';
	select komaarv*hilisem_kodutoo into kodutoo_3_turniirid_asula from muutujad where nimi = 'kodutoo_3_turniirid_asula';
	select komaarv*hilisem_kodutoo into kodutoo_3_inimesed_andmed from muutujad where nimi = 'kodutoo_3_turniirid_asula';
	select komaarv*hilisem_kodutoo into kodutoo_3_turniirid_asukoht_kustutamine from muutujad where nimi = 'kodutoo_3_turniirid_asukoht_kustutamine';
	select komaarv*hilisem_kodutoo into kodutoo_3_valisvoti_turniirid_asulad from muutujad where nimi = 'kodutoo_3_valisvoti_turniirid_asulad';
	
	-- 1. tabeli inimesed olemasolu ja vajalikud kontrollid
	if 		exists (select * from information_schema.tables where table_name = 'inimesed') then 
			-- inimesed andmed
			if 		(select count(*) from inimesed) > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on olemas', 'OK', kodutoo_3_inimesed_andmed/5*2, kodutoo_3_inimesed_andmed/5*2, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed/5*2, kodutoo_3_jr);
			end if;
			
			-- primaarvõtme olemasolu
			if 		(select count(*) from information_schema.table_constraints where table_name = 'inimesed' and constraint_type = 'PRIMARY KEY') > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" primaarvõti', 'on olemas', 'OK', kodutoo_3_inimesed_andmed/5, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" primaarvõti', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			end if;
			
			-- unikaalne isikukood
			if 		(select count(*) from information_schema.table_constraints where table_name = 'inimesed' and constraint_type = 'UNIQUE') > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" isikukoodi unikaalsus', 'on olemas', 'OK', kodutoo_3_inimesed_andmed/5, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" isikukoodi unikaalsus', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			end if;
			
			-- sugu check?
			if 		(select count(*) from information_schema.table_constraints where table_name = 'inimesed' and constraint_type ='CHECK' and constraint_name not like '%not_null%') > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" sugu kitsendus', 'on olemas', 'OK', kodutoo_3_inimesed_andmed/5, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" sugu kitsendus', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 3', 'Tabelit "Inimesed"', 'ei ole olemas', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
	end if;
	
	-- 2. Turniirid veerg asula
	call check_column('turniirid', 'asula', kodutoo_3_turniirid_asula, kodutoo_3_jr, 'Kodutoo 3', 'Tabel',1);
	
	-- 3. Kontrollida tabeli turniirid veergu asula kirjeid
	if 		exists (select * from information_schema.columns where table_name = 'turniirid' and column_name = 'asula') then
			if 		(select count(*) from turniirid where asula is not null) > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'on olemas', 'OK', kodutoo_3_turniirid_asula, kodutoo_3_turniirid_asula, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula*0, kodutoo_3_turniirid_asula, kodutoo_3_jr);
			end if;
	else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'veergu "Asula" ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula*0, kodutoo_3_turniirid_asula, kodutoo_3_jr);
	end if;
	
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



create or replace procedure kodutoo_4(versioon int) as $$ -- punktid kokku 2p: 1-5. ül. 0.5p, 6 ül. 0.75p, 7.ül 0.75p 
declare 
kodutoo_4_jr int;
kodutoo_4_vaade_turniiripartiid numeric;
kodutoo_4_vaade_klubipartiikogused numeric;
klubidepartiikogustesumma int;
kodutoo_4_vaade_keskminepartii numeric;
kodutoo_4_vaade_partiide_arv_valgetega numeric;
hilisem_kodutoo int;
begin 
	if 		versioon = 4 then hilisem_kodutoo :=1;
	else 	hilisem_kodutoo :=0;
	end if;
	select taisarv into kodutoo_4_jr from muutujad where nimi = 'kodutoo_4_jr';
	select komaarv*hilisem_kodutoo into kodutoo_4_vaade_turniiripartiid from muutujad where nimi = 'kodutoo_4_vaade_turniiripartiid';
	select komaarv*hilisem_kodutoo into kodutoo_4_vaade_klubipartiikogused from muutujad where nimi = 'kodutoo_4_vaade_klubipartiikogused';
	select komaarv*hilisem_kodutoo into kodutoo_4_vaade_keskminepartii from muutujad where nimi = 'kodutoo_4_vaade_keskminepartii';
	select komaarv*hilisem_kodutoo into kodutoo_4_vaade_partiide_arv_valgetega from muutujad where nimi = 'kodutoo_4_vaade_partiide_arv_valgetega';
	
	-- v_turniiripartiid
	if 		exists (select * from information_schema.views where table_name = 'v_turniiripartiid') then
			
			-- veergude olemasolu
			call check_column('v_turniiripartiid', 'turniir_nimi', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_turniiripartiid', 'toimumiskoht', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_turniiripartiid', 'partii_id', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_turniiripartiid', 'partii_algus', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_turniiripartiid', 'partii_lopp', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_turniiripartiid', 'kes_voitis', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			-- kirjete arv = 299
			if 		(select count(*) from v_turniiripartiid) = 299 
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" kirjete arv', 'on õige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" kirjete arv', 'on vale, peaks olema partiide koguarv', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
			end if;
			-- pisteliselt 3 veeru kontroll
			if 		exists (select * from information_schema.columns where table_name = 'v_turniiripartiid' and column_name = 'kes_voitis')
			and 	exists (select * from information_schema.columns where table_name = 'v_turniiripartiid' and column_name = 'partii_id') then
					-- valge 270
					if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 270) = 'valge'
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 270, kes voitis varv', 'on õige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 270, kes voitis varv', 'on vale, peaks olema valge', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if;
					-- must 271
					if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 241) = 'must'
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 241, kes voitis varv', 'on õige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 241, kes voitis varv', 'on vale, peaks olema must', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if;
					-- viik 193
					if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 193) = 'viik'
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 193, kes voitis varv', 'on õige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 193, kes voitis varv', 'on vale, peaks olema viik', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if;
			else	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" veeru kes voitis', 'ei saa kontrollida, sest puudub veerg "kes_voitis" või "partii_id"', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10*3, kodutoo_4_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 4', 'Vaadet "v_turniiripartiid"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid, kodutoo_4_jr);
	end if;
	
	-- v_klubipartiikogused
	if 		exists (select * from information_schema.views where table_name = 'v_klubipartiikogused') then
			
			-- veergude olemasolu
			call check_column('v_klubipartiikogused', 'klubi_nimi', kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_klubipartiikogused', 'partiisid', kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			-- kirjete arv = 12
			if 		(select count(*) from v_klubipartiikogused) = 12 
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" kirjete arv', 'on õige', 'OK', kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" kirjete arv', 'on vale, peaks olema 12', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr);
			end if;
			-- partiide kogusumma kontroll
			if 		exists (select * from information_schema.columns where table_name = 'v_klubipartiikogused' and column_name = 'partiisid') then
					select sum(partiisid) into klubidepartiikogustesumma from v_klubipartiikogused;
					-- partiide kogu summa on 571
					if 		klubidepartiikogustesumma = 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on õige', 'OK', kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
					elsif 	klubidepartiikogustesumma > 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on vale, sul on:'||klubidepartiikogustesumma||', peaks olema vähem', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
					elsif 	klubidepartiikogustesumma < 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on vale, sul on:'||klubidepartiikogustesumma||', peaks olema rohkem', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
					end if;
					
			else	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'ei saa kontrollida, sest puudub veerg "partiisid"', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 4', 'Vaadet "v_klubipartiikogused"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused, kodutoo_4_jr);
	end if;
	
	-- v_keskminepartii
	if 		exists (select * from information_schema.views where table_name = 'v_keskminepartii') then
			
			-- veergude olemasolu
			call check_column('v_keskminepartii', 'turniiri_nimi', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			call check_column('v_keskminepartii', 'keskmine_partii', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr, 'Kodutoo 4', 'Vaade',1);
			-- kirjete arv = 5
			if 		(select count(*) from v_keskminepartii) = 5 
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" kirjete arv', 'on õige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" kirjete arv', 'on vale, peaks olema 5', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
			end if;
			-- pisteliselt 2 veeru kontroll
			if 		exists (select * from information_schema.columns where table_name = 'v_keskminepartii' and column_name = 'keskmine_partii')
			and 	exists (select * from information_schema.columns where table_name = 'v_keskminepartii' and column_name = 'turniiri_nimi') then
					-- Plekkkarikas 2010 keskmine
					if 		(select round(keskmine_partii,3) from v_keskminepartii where turniiri_nimi = 'Plekkkarikas 2010') = 23.765
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Plekkkarikas 2010" keskmine', 'on õige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Plekkkarikas 2010" keskmine', 'on vale, peaks olema 23.765', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
					end if;
					-- Kolmeklubi kohtumine keskmine
					if 		(select round(keskmine_partii,3) from v_keskminepartii where turniiri_nimi = 'Kolme klubi kohtumine') = 23.04
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine', 'on õige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine', 'on vale, peaks olema 23.04', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
					end if;
					
			else	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiride keskmisi', 'ei saa kontrollida, sest puudub veerg "turniiri_nimi" või "keskmine_partii"', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5*2, kodutoo_4_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 4', 'Vaadet "v_keskminepartii"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii, kodutoo_4_jr);
	end if;
	
	-- mv_partiide_arv_valgetega
	call mv_vaate_kontroll(kodutoo_4_vaade_partiide_arv_valgetega, kodutoo_4_jr);
end;	
$$ language plpgsql;	

create or replace procedure mv_vaate_kontroll(kodutoo_4_vaade_partiide_arv_valgetega numeric, kodutoo_4_jr int) as $$ 
begin 
	-- Kirjete arv
	if 		(select count(*) from mv_partiide_arv_valgetega) = 85
	then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kirjete arv', 'on õige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kirjete arv', 'on vale, peaks olema 85', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	end if;
	
	-- mängija Tarmo Kooser on olemas
	if 		exists (select * from mv_partiide_arv_valgetega where eesnimi = 'Tarmo' and perenimi = 'Kooser')
	then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" mängija "Tarmo Kooser"', 'on olemas', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_jr);
	else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" mängija "Tarmo Kooser"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_jr);
	end if;
	
	-- min = 0
	if 		(select min(partiisid_valgetega) from mv_partiide_arv_valgetega) = 0
	then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" miinimum valgete partiide arv', 'on õige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" miinimum valgete partiide arv', 'on vale, peaks olema 0', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	end if;
	
	-- max = 14
	if 		(select max(partiisid_valgetega) from mv_partiide_arv_valgetega) = 14
	then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" maksimum valgete partiide arv', 'on õige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" maksimum valgete partiide arv', 'on vale, peaks olema 14', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
	end if;

	exception 
		when others then 
			insert into Staatus values ('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kontrollides tekkis viga', 'Õppejõud annab tagasiside! Vaadet pole või veerge pole!', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			
end;	
$$ language plpgsql;
	
create or replace procedure andmete_taassisestus (versioon int) as $$
-- , source varchar(1000), tab varchar(50))
begin 
	truncate table partiid, turniirid, isikud, klubid, asulad, riigid;
	
	copy asulad (id, nimi) from 'C:\TEMP\asulad.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy klubid from 'C:\TEMP\klubid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy turniirid from 'C:\TEMP\turniirid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy isikud from 'C:\TEMP\isikud.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy partiid from 'C:\TEMP\partiid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy riigid from 'C:\TEMP\riigid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	update isikud set klubis = null where id in (9,10,8,13,6);
end;
$$ LANGUAGE plpgsql;


create or replace procedure kaivita (versioon int) as $$
declare aeg timestamp;
tudeng int;
begin 
	select taisarv into tudeng from muutujad where nimi = 'tudeng';
	
	if versioon >= 4 then 
		call andmete_taassisestus(versioon);
	end if;
	if versioon >= 2 then
		call praktikum_3(versioon);
	end if;
	if versioon >= 3 then
		call praktikum_4(versioon);
		call kodutoo_3(versioon); 
	end if;
	if versioon >= 4 then
		call kodutoo_4(versioon);
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
4 - kodutöö 4

*/
call kaivita(3);
Copy (Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') or ylesanne = 'Tudeng' order by jr asc) To 'C:\TEMP\tulemus.csv' With CSV DELIMITER ',' HEADER;
--Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') or ylesanne = 'Tudeng' order by jr asc;