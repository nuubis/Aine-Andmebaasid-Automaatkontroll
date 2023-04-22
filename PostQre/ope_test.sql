create or replace procedure kontroll() as $kontroll$
declare versioon int := 8;
/*
Siin maarad, mis ylesandeid kontrollitakse. Koik eelnevad kontrollivad ka eelmisi.
0 - praktikum 9 ehk EDU

2 - praktikum 3
3 - praktikum 4 ja kodutoo 3
4 - kodutoo 4
5 - praktikum 7
6 - kodutoo 5
7 - praktikum 10
8 - kodutoo 6
*/

/* 
Jarmisega saad valida, kust kaustas on sul txt failid ja kuhu tekib tulemus.csv fail. 
OLULINE - vaata, et peale kausta nime poleks kaldkriipsu \ 
default on - 'C:\TEMP' 
*/
folder_path varchar(255) := 'C:\TEMP';
 
/* Jargmisega saad valida, mis delimiteriga tuleb tulemus fail. Kui tahad TAB-iga tulemus faili, siis tee vastav kommenteerimis muudatus jargmisel kahel real.*/
tulemus_andmed_delimiter varchar(10) := ',';
--tulemus_andmed_delimiter varchar(10) := E'\t';

/* Jargmised kaks maaravad, mis DELIMITER on sissetulevatel failidel. Default txt on '\t' ja default csv on ',' */
txt_lugemis_andmed_delimiter varchar(10) := '\t';
csv_lugemis_andmed_delimiter varchar(10) := ',';

/* Jargmised muutujaid saab kasutada muutujad.csv asemel - HETKEL EI PLAANI - Moodle'i jaoks vaja?
praktikum_punktid int :=1;
praktikum_3_jr int :=5;
praktikum3_oige int :=16;
praktikum_4_jr int :=10;
praktikum4_oige int :=8;
praktikum_jr int :=50;
kodutoo_3_jr int :=55;
kodutoo_4_jr int :=60;
kodutoo_3_turniirid_asula_andmed numeric :=0.2;
kodutoo_3_turniirid_asula numeric :=0.2;
kodutoo_3_inimesed_andmed numeric :=0.2;
kodutoo_3_turniirid_asukoht_kustutamine numeric:=0.2;
kodutoo_3_valisvoti_turniirid_asulad numeric:=0.2;
kodutoo_4_vaade_turniiripartiid numeric:=0.5;
kodutoo_4_vaade_klubipartiikogused numeric:=0.5;
kodutoo_4_vaade_keskminepartii numeric:=0.5;
kodutoo_4_vaade_partiide_arv_valgetega numeric:=0.5;
kodutoo_jr int :=90;
kodutoo_punktid int :=1;
tudeng int :=100;
*/
begin 

/* Andmete sisestamisega seotud protseduurid */
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'sisesta_txt_andmed') then drop procedure sisesta_txt_andmed; end if;
create or replace procedure sisesta_txt_andmed(table_name varchar(100), file_path varchar(255), veerud varchar(255)='', delimiter_code varchar(50)= '\t') as  $sisesta_andmed$
declare sqltext varchar(1000);
begin
sqltext ='COPY '||table_name||veerud||' from '''||file_path||'''DELIMITER E'''||delimiter_code||''' ENCODING ''UTF-8''' ;
execute sqltext; 
end;
$sisesta_andmed$ language plpgsql;

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'sisesta_csv_andmed') then drop procedure sisesta_csv_andmed; end if;
create or replace procedure sisesta_csv_andmed(table_name varchar(100), file_path varchar(255), delimiter_code varchar(50)= ',') as  $sisesta_andmed$
declare sqltext varchar(1000);
begin
sqltext ='COPY '||table_name||' from '''||file_path||'''with (format csv, delimiter'''||delimiter_code||''')' ;
execute sqltext; 
end;
$sisesta_andmed$ language plpgsql;

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'valjasta_tulemus') then drop procedure valjasta_tulemus; end if;
create or replace procedure valjasta_tulemus(file_path varchar(255), delimiter_code varchar(50)= ',') as  $valjasta_tulemus$
declare sqltext varchar(1000);
begin
sqltext ='Copy (Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid 
From staatus where olek in (''VIGA'',''Hindepunktid'') or ylesanne = ''Tudeng'' order by jr asc) 
To '''||file_path||'''WITH CSV DELIMITER'''||delimiter_code||'''HEADER' ;
execute sqltext; 
end;
$valjasta_tulemus$ language plpgsql;

/* Tabel muutujad igaks juhuks */
if exists (select * from information_schema.tables where table_name = 'muutujad') then drop table  muutujad; end if;
create table muutujad (
nimi varchar(1000) unique,
taisarv int,
komaarv numeric);
delete from muutujad;
call sisesta_csv_andmed('muutujad', folder_path || '\muutujad.csv', csv_lugemis_andmed_delimiter);
--copy muutujad from 'C:\TEMP\muutujad.csv' with (format csv, delimiter ',');

/* Tabel, kuhu kogutakse tudengi kontrolli tulemus */
if exists (select * from information_schema.tables where table_name = 'staatus') then drop table  staatus; end if;
create table Staatus (
Ylesanne varchar(100),
Kontrolli_nimi varchar(1000),
Tagasiside varchar(1000),
Olek varchar(100),
Punktid numeric,
Max_punktid numeric,
Jr int,
Id serial);

/* Protseduur, mis arvutab tudengi punktid praktikumi ja kodutoo eest */
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'arvuta_punktid') then drop procedure arvuta_punktid; end if;
create or replace procedure arvuta_punktid(versioon int) as $arvuta_punktid$
declare 
kodu_punktid numeric; 
kodu_max_punktid numeric;
kodutoo_jr int;
praktikum_jr int;
praktikum3_oige int;
praktikum3_saadud_oige int;
praktikum4_oige int;
praktikum4_saadud_oige int;
praktikum7_oige int;
praktikum7_saadud_oige int;
edu_oige int;
edu_saadud_oige int;
praktikum10_oige int;
praktikum10_saadud_oige int;
begin
	select taisarv into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	select taisarv into praktikum_jr from muutujad where nimi = 'praktikum_jr';
	select taisarv into praktikum3_oige from muutujad where nimi = 'praktikum3_oige';
	select taisarv into praktikum4_oige from muutujad where nimi = 'praktikum4_oige';
	select taisarv into praktikum7_oige from muutujad where nimi = 'praktikum7_oige';
	select taisarv into praktikum10_oige from muutujad where nimi = 'praktikum10_oige';
	select taisarv into edu_oige from muutujad where nimi = 'edu_oige';
	if versioon = 2 then
		select count(*) into praktikum3_saadud_oige from staatus where ylesanne = 'Praktikum 3' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 3', 'Oigesti tehtud: ' || praktikum3_saadud_oige,'Maksimum oiged: '|| praktikum3_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 3 then 
		select count(*) into praktikum4_saadud_oige from staatus where ylesanne = 'Praktikum 4' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 4', 'Oigesti tehtud: ' || praktikum4_saadud_oige,'Maksimum oiged: '|| praktikum4_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
		kodu_max_punktid := 1;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 3','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;
	if versioon = 4 then 
		kodu_max_punktid := 2;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 4','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;
	if versioon = 5 then
		select count(*) into praktikum7_saadud_oige from staatus where ylesanne = 'Praktikum 7' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 7', 'Oigesti tehtud: ' || praktikum7_saadud_oige,'Maksimum oiged: '|| praktikum7_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 0 then
		select count(*) into edu_saadud_oige from staatus where ylesanne = 'Edu andmebaas' and olek = 'OK'; 
		insert into Staatus values ('Edu andmebaas', 'Oigesti tehtud: ' || edu_saadud_oige,'Maksimum oiged: '|| edu_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 6 then 
		kodu_max_punktid := 2;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 5','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;
	if versioon = 7 then
		select count(*) into praktikum10_saadud_oige from staatus where ylesanne = 'Praktikum 10' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 10', 'Oigesti tehtud: ' || praktikum10_saadud_oige,'Maksimum oiged: '|| praktikum10_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
	end if;
	if versioon = 8 then 
		kodu_max_punktid := 2;
		select sum(punktid) into kodu_punktid from staatus where ylesanne like ('Kodutoo%');
		insert into Staatus values ('Kodutoo 6','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;

end;
$arvuta_punktid$ language plpgsql;

/* Tabeli veeru olemasolu kontroll */
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'check_column') then drop procedure check_column; end if;
create or replace procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100), olemasolu int) as $check_column$
	begin
		if 	olemasolu = 1 then
			if 		exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" veerg "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" veerg "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
			end if;
		else
			if 		not exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name))
			then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" veerg "'||a_column_name||'" ', 'on kustutatud', 'OK', punktid, punktid, jr);
			else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" veerg "'||a_column_name||'" ', 'ei ole kustutatud', 'VIGA', punktid*0, punktid, jr);
			end if;
		end if;
	exception 
		when others then 
			insert into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'VIGA AUTOMAATKONTROLLIS!', 'VIGA', punktid, punktid, jr);
	end;
$check_column$ language plpgsql;

/* Tabeli veeru andmetuubi kontroll */
if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'check_column_exists') then drop function check_column_exists; end if;
create or replace function check_column_exists(a_table_name varchar(100), a_column_name varchar(100)) returns int as $check_column_exists$
declare vastus int;
begin
	if 		exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name))
	then	vastus := 1;
	else 	vastus := 0;
	end if;
	return vastus;
end;
$check_column_exists$ language plpgsql;


/* Tabeli veeru andmetuubi kontroll */
if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'check_column_datatype') then drop function check_column_datatype; end if;
create or replace function check_column_datatype(a_table_name varchar(100), a_column_name varchar(100), a_datatype varchar(100)) returns int as $check_column_datatype$
declare vastus int;
begin
	if 		exists (select * from information_schema.columns where table_name = lower(a_table_name) and column_name = lower(a_column_name) and data_type like a_datatype)
	then	vastus := 1;
	else 	vastus := 0;
	end if;
	return vastus;
end;
$check_column_datatype$ language plpgsql;


/* Kitsenduste kontroll nimeliselt */
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'check_constraint') then drop procedure check_constraint; end if;
create or replace procedure check_constraint(a_table_name varchar(100), a_constraint_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100), olemasolu int) as $check_constraint$
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
$check_constraint$ language plpgsql;

-- Praktikum 3 kontroll. 27oN
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'praktikum_3') then drop procedure praktikum_3; end if;
create or replace procedure praktikum_3(versioon int) as $praktikum_3$
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
	if 		(select check_column_exists('isikud','eesnimi'))=1 and 	(select check_column_exists('isikud','perenimi'))=1
	then
		if 		exists (select * from isikud where eesnimi = 'Irys' and perenimi = 'Kompvek')
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on oige perenimi', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'on vale perenimi, peab olema Kompvek', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" Isikul "Irys" ', 'puuduvad veerud eesnimi ja/voi perenimi', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Osav oda klubi olemas
	if 		(select check_column_exists('klubid','nimi'))=1 then
		if 		exists (select * from klubid where nimi ilike 'osav oda')
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'on olemas', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda" ', 'ei ole olemas', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	else insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Osav Oda"', 'veergu "nimi" ei ole olemas', 'VIGA', 0, 0,	praktikum_3_jr);
	end if;
	-- Isikud klubi->klubis
	call 	check_column('Isikud', 'Klubis', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Partiid kokkuvote kustutatud
	call 	check_column('Partiid', 'Kokkuvote', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 0);
	-- Turniirid kitsendus ajakontroll
	if versioon < 8 then 
		call 	check_constraint('Turniirid', 'ajakontroll', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	end if;
	-- Partiid kitsendus ajakontroll
	call 	check_constraint('Partiid', 'ajakontroll', 0, praktikum_3_jr, 'Praktikum 3', 'Tabel', 1);
	-- Klubi Valge Mask valgas
	if 		(select check_column_exists('klubid','asukoht'))=1 then
		if 		(select asukoht from klubid where nimi = 'Valge Mask') = 'Valga'
		then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on vale, peab olema Valga', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	if 		(select check_column_exists('klubid','asula'))=1 then
		if 		(select check_column_exists('asulad','nimi'))=1 then
			if 		(select asula from klubid where nimi = 'Valge Mask') = (select id from asulad where nimi = 'Valga')
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukoht ', 'on vale, peab olema Valga', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
		else 	insert into Staatus values ('Praktikum 3', 'Tabel "Klubid" klubi "Valge Mask" asukohta', 'ei leia, sest puudub tabelis "Asulad" veerg "nimi"', 'VIGA', 0, 0,	praktikum_3_jr);
		end if;
	end if;
	-- Siim Susi klubis Laudnikud ja Osav Oda 5 uut liiget
	if 		(select check_column_exists('isikud','klubis'))=1 then
			if 		exists (select * from isikud where eesnimi = 'Siim' and perenimi = 'Susi' and klubis = (select id from klubid where nimi = 'Laudnikud'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" isik "Siim Susi" klubi ', 'on vale', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
			
			if 		exists (select count(*) from isikud where klubis = (select id from klubid where nimi = 'Osav Oda'))
			then 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on oige', 'OK', 0, 0,	praktikum_3_jr);
			else 	insert into Staatus values ('Praktikum 3', 'Tabel "Isikud" klubi Osav Oda liikmete arv ', 'on vale, peab olema 5', 'VIGA', 0, 0,	praktikum_3_jr);
			end if;
	end if;
			
	if 		(select check_column_exists('isikud','klubi'))=1 then
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
$praktikum_3$ language plpgsql;


-- Praktikum 4 kontroll. 28oN
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'praktikum_4') then drop procedure praktikum_4; end if;
create or replace procedure praktikum_4(versioon int) as $praktikum_4$
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
	if 		(select check_column_exists('klubid','asula'))=1 then
			if 		(select count(*) from klubid where asula is not null) > 0
			then 	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
			else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
			end if;
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" andmed', 'veergu "Asula" ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- valisvotme fk_klubi_2_asula olemasolu
	if 		exists (select * from information_schema.table_constraints where table_name = 'klubid' and constraint_type = 'FOREIGN KEY')
	then 	insert into Staatus values ('Praktikum 4', 'Valisvoti "fk_klubi_2_asula"', 'on olemas', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Valisvoti "fk_klubi_2_asula"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
	-- 5. tabeli turniirid veerg asukoht/toimumiskoht olemasolu puudumine
	if 		(select check_column_exists('klubid','asukoht'))=0 
	then 	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" veerg "Asukoht"', 'on kustutatud', 'OK', 0, 0, praktikum_4_jr);
	else	insert into Staatus values ('Praktikum 4', 'Tabel "Klubid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', 0, 0, praktikum_4_jr);
	end if;
	
end;	
$praktikum_4$ language plpgsql;


-- Praktikum 7 kontroll. 31oN, 56 oiget veergudest ja andmetest
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'praktikum_7') then drop procedure praktikum_7; end if;
create or replace procedure praktikum_7(versioon int) as $praktikum_7$
declare
praktikum_7_jr int;
check_count int;
begin
	select taisarv into praktikum_7_jr from muutujad where nimi = 'praktikum_7_jr';
	
	--v_isikudklubid olemasolu?
	if 		exists (select * from information_schema.views where table_name = 'v_isikudklubid') then
			
			-- veergude olemasolu
			call check_column('v_isikudklubid', 'isik_nimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_isikudklubid', 'isik_id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_isikudklubid', 'synniaeg', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_isikudklubid', 'klubi_nimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_isikudklubid', 'klubi_id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_isikudklubid', 'ranking', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_isikudklubid) = 80
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_isikudklubid" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_isikudklubid" kirjete arv', 'on vale, peaks olema 80', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_isikudklubid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	
	--v_partiid olemasolu?
	if 		exists (select * from information_schema.views where table_name = 'v_partiid') then
			
			-- veergude olemasolu
			call check_column('v_partiid', 'id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'turniir', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'algus', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'valge_nimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'valge_klubi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'valge_punkt', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'must_nimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'must_klubi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiid', 'must_punkt', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_partiid) = 299
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_partiid" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiid" kirjete arv', 'on vale, peaks olema 299', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_partiid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	-- v_partiidpisi olemasolu, veerud, andmetekogus, moni uksik andme kontroll
	if 		exists (select * from information_schema.views where table_name = 'v_partiidpisi') then
			
			-- veergude olemasolu
			call check_column('v_partiidpisi', 'id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiidpisi', 'valge_mangija', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiidpisi', 'valge_punkt', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiidpisi', 'must_mangija', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_partiidpisi', 'must_punkt', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_partiidpisi) = 299
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" kirjete arv', 'on vale, peaks olema 299', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			-- 10	Anna Raha	1.00000000000000000000	Aljona Aljas	0.00000000000000000000
			-- Nimekuju kontroll
			if 		(select check_column_exists('v_partiidpisi','valge_mangija'))=1 and 
					(select check_column_exists('v_partiidpisi','must_mangija'))=1 and 
					(select check_column_exists('v_partiidpisi','id'))=1 then
					
					select count(*) into check_count from v_partiidpisi where id = 10;
					if 		check_count = 1 then
							if 		(select valge_mangija from v_partiidpisi where id = 10) = 'Anna Raha'
							and 	(select must_mangija from v_partiidpisi where id = 10) = 'Aljona Aljas'
							then 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" mangijate nimekuju', 'on oige', 'OK', 0, 0, praktikum_7_jr);
							else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" mangijate nimekuju', 'on vale, peab olema ainult tuhik eesnime ja perenime vahel', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" mangijate nimekuju', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
			
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_partiidpisi" mangijate nimekuju', 'veergu "valge_mangija" ja/voi "must_mangija" ja/voi "id" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			-- Valge punktid = 1 
			if 		(select check_column_exists('v_partiidpisi','valge_punkt'))=1 and
					(select check_column_exists('v_partiidpisi','id'))=1 then
					
					if 		(select check_column_datatype('v_partiidpisi','valge_punkt','numeric')) = 1 then
							select count(*) into check_count from v_partiidpisi where id = 10;
							if 		check_count = 1 then
									if 		(select valge_punkt from v_partiidpisi where id = 10) = 1
									then 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 valge punktid', 'on oiged', 'OK', 0, 0, praktikum_7_jr);
									else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 valge punktid', 'on valed, peab olema 1.0', 'VIGA', 0, 0, praktikum_7_jr);
									end if;
							else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 valge punktid', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 valge punktid kontroll', 'veerg "valge_punkt" on vale andmetuubiga, peab olema numeric', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 valge punktid kontroll', 'veergu "valge_punkt" ja/voi "id" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;

			-- musta punktid = 0
			if 		(select check_column_exists('v_partiidpisi','must_punkt'))=1 and
					(select check_column_exists('v_partiidpisi','id'))=1 then
					
					if 		(select check_column_datatype('v_partiidpisi','must_punkt','numeric')) = 1 then
							select count(*) into check_count from v_partiidpisi where id = 10;
							if 		check_count = 1 then
									if 		(select must_punkt from v_partiidpisi where id = 10) = 0
									then 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 musta punktid', 'on oiged', 'OK', 0, 0, praktikum_7_jr);
									else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 musta punktid', 'on valed, peab olema 0.0', 'VIGA', 0, 0, praktikum_7_jr);
									end if;
							else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 musta punktid', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 musta punktid kontroll', 'veerg "must_punkt" on vale andmetuubiga, peab olema numeric', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
					
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 10 musta punktid kontroll', 'veergu "must_punkt" ja/voi "id" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			-- musta punktid = 0.5
			if 		(select check_column_exists('v_partiidpisi','must_punkt'))=1 and
					(select check_column_exists('v_partiidpisi','id'))=1 then
							
					if 		(select check_column_datatype('v_partiidpisi','must_punkt','numeric')) = 1 then
							select count(*) into check_count from v_partiidpisi where id = 10;
							if 		check_count = 1 then
									if 		(select must_punkt from v_partiidpisi where id = 12) = 0.5
									then 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 12 musta punktid', 'on oiged', 'OK', 0, 0, praktikum_7_jr);
									else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 12 musta punktid', 'on valed, peab olema 0.5', 'VIGA', 0, 0, praktikum_7_jr);
									end if;
							else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 12 musta punktid', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_partiidpisi" partii 12 musta punktid kontroll', 'veerg "must_punkt" on vale andmetuubiga, peab olema numeric', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
					
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_partiidpisi" partii 12 musta punktid kontroll', 'veergu "must_punkt" ja/voi "id" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_partiidpisi"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	
	-- v_punktid olemasolu, veerud, ...
	if 		exists (select * from information_schema.views where table_name = 'v_punktid') then
			
			-- veergude olemasolu
			call check_column('v_punktid', 'partii', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_punktid', 'turniir', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_punktid', 'mangija', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_punktid', 'varv', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_punktid', 'punkt', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_punktid) = 598
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" kirjete arv', 'on vale, peaks olema 598', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			-- mangija id, varvi ja punkti kontroll
			if 		(select check_column_exists('v_punktid','mangija'))=1 and
					(select check_column_exists('v_punktid','varv'))=1 and
					(select check_column_exists('v_punktid','partii'))=1 then
					
					if 		(select check_column_datatype('v_punktid','mangija','int%')) = 1 then
							if 		(select check_column_datatype('v_punktid','partii','int%')) = 1 then
									if 		(select check_column_datatype('v_punktid','varv','varchar%')) = 1 or
									 		(select check_column_datatype('v_punktid','varv','text')) = 1 then		
											
											-- Valge
											select count(*) into check_count from v_punktid where partii = 299 and mangija = 76;
											if 		check_count = 1 then
													if 		(select upper(varv) from v_punktid where partii = 299 and mangija = 76) = 'V'
													then 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
													else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv', 'on vale, peab olema "V"', 'VIGA', 0, 0, praktikum_7_jr);
													end if;
											else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv kontroll', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
											end if;
											
											-- Must
											select count(*) into check_count from v_punktid where partii = 299 and mangija = 85;
											if 		check_count = 1 then
													if 		(select upper(varv) from v_punktid where partii = 299 and mangija = 85) = 'M'
													then 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 85 varv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
													else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 85 varv', 'on vale, peab olema "M"', 'VIGA', 0, 0, praktikum_7_jr);
													end if;
											else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv kontroll', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
											end if;
									else 	
											insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv kontroll', 'veeru "varv" andmetuup on vale, peab olema "varchar"', 'VIGA', 0, 0, praktikum_7_jr);
											insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 85 varv kontroll', 'veeru "varv" andmetuup on vale, peab olema "varchar"', 'VIGA', 0, 0, praktikum_7_jr);
									end if;
							else 	
									insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv kontroll', 'veeru "partii" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
									insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 85 varv kontroll', 'veeru "partii" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	
							insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 varv kontroll', 'veeru "mangija" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
							insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 85 varv kontroll', 'veeru "mangija" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
					end if;		
									
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_punktid" partii 299 mangijate varvid kontroll', 'veergu "partii" ja/voi "mangija" ja/voi "varv" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			if 		(select check_column_exists('v_punktid','mangija'))=1 and
					(select check_column_exists('v_punktid','punkt'))=1 and
					(select check_column_exists('v_punktid','partii'))=1 then
					
					if 		(select check_column_datatype('v_punktid','mangija','int%')) = 1 then
							if 		(select check_column_datatype('v_punktid','punkt','numeric')) = 1 then
									if 		(select check_column_datatype('v_punktid','partii','int%')) = 1 then
											
											-- 0.5
											select count(*) into check_count from v_punktid where partii = 299 and mangija = 76;
											if 		check_count = 1 then
													if 		(select punkt from v_punktid where partii = 299 and mangija = 76) = 0.5
													then 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt', 'on oige', 'OK', 0, 0, praktikum_7_jr);
													else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt', 'on vale, peab olema 0.5', 'VIGA', 0, 0, praktikum_7_jr);
													end if;
											else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt kontroll', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
											end if;
											
											-- 0
											select count(*) into check_count from v_punktid where partii = 11 and mangija = 91;
											if 		check_count = 1 then
													if 		(select punkt from v_punktid where partii = 11 and mangija = 91) = 0
													then 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt', 'on oige', 'OK', 0, 0, praktikum_7_jr);
													else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt', 'on vale, peab olema 0', 'VIGA', 0, 0, praktikum_7_jr);
													end if;
											else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt kontroll', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
											end if;
											-- 1
											select count(*) into check_count from v_punktid where partii = 1 and mangija = 150;
											if 		check_count = 1 then
													if 		(select punkt from v_punktid where partii = 1 and mangija = 150) = 1
													then 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 1 mangija 150 punkt', 'on oige', 'OK', 0, 0, praktikum_7_jr);
													else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 1 mangija 150 punkt', 'on vale, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
													end if;
											else 	insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 150 punkt kontroll', 'tulemuseks on '|| check_count ||' kirjet, peab olema 1', 'VIGA', 0, 0, praktikum_7_jr);
											end if;
									else 	
											insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt kontroll', 'veeru "partii" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
											insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt kontroll', 'veeru "partii" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
											insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 150 punkt kontroll', 'veeru "partii" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
									end if;
							else 	
									insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt kontroll', 'veeru "punkt" andmetuup on vale, peab olema "numeric"', 'VIGA', 0, 0, praktikum_7_jr);
									insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt kontroll', 'veeru "punkt" andmetuup on vale, peab olema "numeric"', 'VIGA', 0, 0, praktikum_7_jr);
									insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 150 punkt kontroll', 'veeru "punkt" andmetuup on vale, peab olema "numeric"', 'VIGA', 0, 0, praktikum_7_jr);
							end if;
					else 	
							insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 299 mangija 76 punkt kontroll', 'veeru "mangija" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
							insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 91 punkt kontroll', 'veeru "mangija" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
							insert into Staatus values('Praktikum 7', 'Vaate "v_punktid" partii 11 mangija 150 punkt kontroll', 'veeru "mangija" andmetuup on vale, peab olema "integer"', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
			
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_punktid" partiis mangija punkti kontroll', 'veergu "partii" ja/voi "mangija" ja/voi "punkt" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_punktid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	
	--v_edetabelid
	if 		exists (select * from information_schema.views where table_name = 'v_edetabelid') then
			
			-- veergude olemasolu
			call check_column('v_edetabelid', 'id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'mangija', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'synniaeg', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'ranking', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'klubi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'turniir', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_edetabelid', 'punkte', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv =184
			if 		(select count(*) from v_edetabelid) = 184
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_edetabelid" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_edetabelid" kirjete arv', 'on vale, peaks olema 184', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_edetabelid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	
	-- mv_edetabelid
	if 		exists (select * from pg_matviews where matviewname = 'mv_edetabelid') then 
			REFRESH MATERIALIZED VIEW mv_edetabelid;
			
			if 		(select count(*) from mv_edetabelid) = 184
			then	insert into Staatus values('Praktikum 7', 'Vaate "mv_edetabelid" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "mv_edetabelid" kirjete arv', 'on vale, peaks olema 184', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "mv_edetabelid"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);	
	end if;
	
	-- v_klubi54
	if 		exists (select * from information_schema.views where table_name = 'v_klubi54') then
			
			-- veergude olemasolu
			call check_column('v_klubi54', 'eesnimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_klubi54', 'perenimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_klubi54', 'synniaeg', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_klubi54', 'ranking', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_klubi54', 'klubi_id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_klubi54) = 5
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_klubi54" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_klubi54" kirjete arv', 'on vale, peaks olema 5', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			if 		(select check_column_exists('v_klubi54','eesnimi'))=1 and
					(select check_column_exists('v_klubi54','perenimi'))=1 and
					(select check_column_exists('v_klubi54','klubi_id'))=1 then
					
					-- Maria Lihtne
					if 		(select klubi_id from v_klubi54 where eesnimi = 'Maria' and perenimi = 'Lihtne') = 54
					then 	insert into Staatus values('Praktikum 7', 'Vaate "v_klubi54" Maria Lihtne klubi', 'on oige', 'OK', 0, 0, praktikum_7_jr);
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_klubi54" Maria Lihtne klubi', 'on vale, peab olema 54', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
					
			else 	insert into Staatus values ('Praktikum 7', 'Vaate "v_klubi54" Maria Lihtne klubi', 'veergu "eesnimi" ja/voi "perenimi" ja/voi "klubi_id" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_klubi54"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
	
	--v_maletaht
	if 		exists (select * from information_schema.views where table_name = 'v_maletaht') then
			
			-- veergude olemasolu
			call check_column('v_maletaht', 'id', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'eesnimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'perenimi', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'isikukood', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'klubis', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'synniaeg', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'sugu', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			call check_column('v_maletaht', 'ranking', 0, praktikum_7_jr, 'Praktikum 7', 'Vaade',1);
			-- kirjete arv = 80
			if 		(select count(*) from v_maletaht) = 9
			then	insert into Staatus values('Praktikum 7', 'Vaate "v_maletaht" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_7_jr);
			else 	insert into Staatus values('Praktikum 7', 'Vaate "v_maletaht" kirjete arv', 'on vale, peaks olema 9', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
			
			if 		(select check_column_exists('v_maletaht','klubis'))=1 then
					if 	(select distinct klubis from v_maletaht) = 56
					then 	insert into Staatus values('Praktikum 7', 'Vaate "v_maletaht" klubi id', 'on oige', 'OK', 0, 0, praktikum_7_jr);
					else 	insert into Staatus values('Praktikum 7', 'Vaate "v_maletaht" klubi id', 'on vale, peaks olema 56', 'VIGA', 0, 0, praktikum_7_jr);
					end if;
			else	insert into Staatus values ('Praktikum 7', 'Vaate "v_maletaht" klubi id kontroll', 'veergu "klubis" pole olemas', 'VIGA', 0, 0, praktikum_7_jr);
			end if;
					
	else 	insert into Staatus values ('Praktikum 7', 'Vaadet "v_maletaht"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_7_jr);
	end if;
end;	
$praktikum_7$ language plpgsql;

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'edu_test') then drop procedure edu_test; end if;
create or replace procedure edu_test () as $edu_test$
declare
edu_jr int;
begin
	select taisarv into edu_jr from muutujad where nimi = 'edu_jr';
	-- tabelite ja kirjete olemasolu
	-- persons
	if 		exists (select * from information_schema.tables where table_name = 'persons') then
			if 		(select count(*) from persons) = 300
			then 	insert into Staatus values ('Edu andmebaas', 'Tabel "persons" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Tabel "persons" kirjete arv', 'on vale, peab olema 300', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'lecturers' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_person_institute"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_person_institute"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Tabelit "persons"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- courses
	if 		exists (select * from information_schema.tables where table_name = 'courses') then
			if 		(select count(*) from courses) = 101
			then 	insert into Staatus values ('Edu andmebaas', 'Tabel "courses" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Tabel "courses" kirjete arv', 'on vale, peab olema 101, aine "Sissejuhatus andmebaasidesse" on lisamata', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'lecturers' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_course"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_course"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Tabelit "courses"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- registrations
	if 		exists (select * from information_schema.tables where table_name = 'registrations') then
			if 		(select count(*) from registrations) = 1213
			then 	insert into Staatus values ('Edu andmebaas', 'Tabel "registrations" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Tabel "registrations" kirjete arv', 'on vale, peab olema 1213, aine "Sissejuhatus andmebaasidesse" osalejad on lisamata', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'registrations' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_registration_person"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_registration_person"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'registrations' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_registration_courses"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_registration_courses"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
			
	else 	insert into Staatus values ('Edu andmebaas', 'Tabelit "registrations"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- lecturers
	if 		exists (select * from information_schema.tables where table_name = 'lecturers') then
			if 		(select count(*) from lecturers) = 149
			then 	insert into Staatus values ('Edu andmebaas', 'Tabel "lecturers" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Tabel "lecturers" kirjete arv', 'on vale, peab olema 149', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'lecturers' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_person"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_person"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'lecturers' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_course"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_lecturer_course"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Tabelit "lecturers"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- institutes
	if 		exists (select * from information_schema.tables where table_name = 'institutes') then
			if 		(select count(*) from institutes) = 10
			then 	insert into Staatus values ('Edu andmebaas', 'Tabel "institutes" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Tabel "institutes" kirjete arv', 'on vale, peab olema 10', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'institutes' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_institute_person_dean"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_institute_person_dean"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		exists (select * from information_schema.table_constraints where table_name = 'institutes' and constraint_type = 'FOREIGN KEY')
			then 	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_institute_person_vice_dean"', 'on olemas', 'OK', 0, 0, edu_jr);
			else	insert into Staatus values ('Edu andmebaas', 'Valisvoti "fk_institute_person_vice_dean"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
			end if;
			
	else 	insert into Staatus values ('Edu andmebaas', 'Tabelit "institutes"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	
	-- vaated ja kirjed
	-- v_oigusteaduskonna_inimesed
	if 		exists (select * from information_schema.views where table_name = 'v_oigusteaduskonna_inimesed') then
			if 		(select count(*) from v_oigusteaduskonna_inimesed) = 28
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_oigusteaduskonna_inimesed" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_oigusteaduskonna_inimesed" kirjete arv', 'on vale, peab olema 28', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_oigusteaduskonna_inimesed"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- v_persons_institute
	if 		exists (select * from information_schema.views where table_name = 'v_persons_institute') then
			if 		(select count(*) from v_persons_institute) = 300
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_institute" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_institute" kirjete arv', 'on vale, peab olema 300', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_institute"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- v_Institute_deans
	if 		exists (select * from information_schema.views where table_name = 'v_institute_deans') then
			if 		(select count(*) from v_institute_deans) = 10
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_institute_deans" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_institute_deans" kirjete arv', 'on vale, peab olema 10', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_institute_deans"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- v_top20Students
	if 		exists (select * from information_schema.views where table_name = 'v_top20students') then
			if 		(select count(*) from v_top20students) = 20
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top20students" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top20students" kirjete arv', 'on vale, peab olema 20', 'VIGA', 0, 0, edu_jr);
			end if;
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top20students"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	
	-- Tapsemad kontrollid
	-- v_persons_atleast_4eap
	if 		exists (select * from information_schema.views where table_name = 'v_persons_atleast_4eap') then
			if 		(select count(*) from v_persons_atleast_4eap) = 135
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_atleast_4eap" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_atleast_4eap" kirjete arv', 'on vale, peab olema 135, isik peab esinema uhekordselt', 'VIGA', 0, 0, edu_jr);
			end if;
			
			call check_column('v_persons_atleast_4eap', 'firstname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			call check_column('v_persons_atleast_4eap', 'lastname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_persons_atleast_4eap"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- v_countOfA
	if 		exists (select * from information_schema.views where table_name = 'v_countofa') then
			if 		(select count(*) from v_countofa) = 119
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_countOfA" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_countOfA" kirjete arv', 'on vale, peab olema 119', 'VIGA', 0, 0, edu_jr);
			end if;
			
			call check_column('v_countofa', 'firstname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			call check_column('v_countofa', 'lastname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			call check_column('v_countofa', 'countofa', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			
			if 		(select check_column_exists('v_countofa','countofa'))=1 then
					if 		(select max(countofa) from v_countofa) = 5
					then 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'on oige', 'OK', 0, 0, edu_jr);
					else 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'on vale, peab olema 5, kas arvestasid ainult eksamiga aineid', 'VIGA', 0, 0, edu_jr);
					end if;
			else	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'ei saa leida, sest puudub veerg "countOfA"', 'VIGA', 0, 0, edu_jr);
			end if;
			
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_countOfA"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
	-- v_top40A
	if 		exists (select * from information_schema.views where table_name = 'v_top40a') then
			if 		(select count(*) from v_top40a) = 40
			then 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top40A" kirjete arv', 'on oige', 'OK', 0, 0, edu_jr);
			else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top40A" kirjete arv', 'on vale, peab olema 40', 'VIGA', 0, 0, edu_jr);
			end if;
			
			call check_column('v_top40a', 'firstname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			call check_column('v_top40a', 'lastname', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			call check_column('v_top40a', 'countofa', 0, edu_jr, 'Edu andmebaas', 'Vaade',1);
			
			if 		(select check_column_exists('v_top40a','countofa'))=1 then
					if 		(select max(countofa) from v_top40a) = 6
					then 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'on oige', 'OK', 0, 0, edu_jr);
					else 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'on vale, peab olema 6, kas arvestasid koikide ainetega', 'VIGA', 0, 0, edu_jr);
					end if;
			else	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" maksimum vaartus', 'ei saa leida, sest puudub veerg "countOfA"', 'VIGA', 0, 0, edu_jr);
			end if;
			
			if 		(select check_column_exists('v_top40a','countofa'))=1 then
					if 		(select min(countofa) from v_top40a) = 4
					then 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" miinimum vaartus', 'on oige', 'OK', 0, 0, edu_jr);
					else 	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" miinimum vaartus', 'on vale, peab olema 6, kas arvestasid koikide ainetega', 'VIGA', 0, 0, edu_jr);
					end if;
			else	insert into Staatus values ('Edu andmebaas', 'Veeru "countOfA" miinimum vaartus', 'ei saa leida, sest puudub veerg "countOfA"', 'VIGA', 0, 0, edu_jr);
			end if;
			
	else 	insert into Staatus values ('Edu andmebaas', 'Vaade "v_top40A"', 'ei ole olemas', 'VIGA', 0, 0, edu_jr);
	end if;
end;
$edu_test$ LANGUAGE plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'praktikum_10') then drop procedure praktikum_10; end if;
create or replace procedure praktikum_10(versioon int) as $praktikum_10$ 
declare 
praktikum_10_jr int;
begin
	select taisarv into praktikum_10_jr from muutujad where nimi = 'praktikum_10_jr';
	
	call function_mangija_punktid_turniiril(praktikum_10_jr);
	call function_infopump(praktikum_10_jr);
	call function_klubisuurus(praktikum_10_jr);
	call function_nimi(praktikum_10_jr);
	call function_mangija_koormus(praktikum_10_jr);
	call function_mangija_voite_turniiril(praktikum_10_jr);
	call function_mangija_viike_turniiril(praktikum_10_jr);
	call function_mangija_kaotusi_turniiril(praktikum_10_jr);
	call function_voit_viik_kaotus(praktikum_10_jr);
	call function_klubiparimad(praktikum_10_jr);
	call procedure_uus_isik(praktikum_10_jr);
end;	
$praktikum_10$ language plpgsql;


-- f_mangija_punktid_turniiril
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_mangija_punktid_turniiril') then drop procedure function_mangija_punktid_turniiril; end if;
create or replace procedure function_mangija_punktid_turniiril(praktikum_10_jr int) as $function_mangija_punktid_turniiril$ 
declare 
arg_count int;
begin
	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_mangija_punktid_turniiril') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_mangija_punktid_turniiril';
		if 		arg_count = 2 then 
			
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			if 		(select * from f_mangija_punktid_turniiril(92,42)) = 5.5 
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril" mangija "92" turniiril "42" punktid', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril" mangija "92" turniiril "42" punktid', 'ei ole oige, peab olema 5.5', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril" argumentide arv', 'ei ole oige, peab olema 2', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;	
	exception 
			when others then 
				insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_punktid_turniiril"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;
$function_mangija_punktid_turniiril$ language plpgsql;

-- f_infopump
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_infopump') then drop procedure function_infopump; end if;
create or replace procedure function_infopump(praktikum_10_jr int) as $function_infopump$ 
declare 
arg_count int;
begin
	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_infopump') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_infopump';
		if 		arg_count = 0 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		exists (select * from information_schema.views where table_name = 'check_infopump') then drop view check_infopump; end if;
			create or replace view check_infopump as select * from f_infopump();
			
			if 		(select count(*) from check_infopump) = 105
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump" kirjete arv', 'ei ole oige, peab olema 105', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump" argumentide arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;	
	
	if 		exists (select * from information_schema.views where table_name = 'check_infopump') then drop view check_infopump; end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_infopump"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
			if 		exists (select * from information_schema.views where table_name = 'check_infopump') then drop view check_infopump; end if;
end;	
$function_infopump$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_klubisuurus') then drop procedure function_klubisuurus; end if;
create or replace procedure function_klubisuurus(praktikum_10_jr int) as $function_klubisuurus$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_klubisuurus') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_klubisuurus';
		if 		arg_count = 1 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_klubisuurus(54)) = 5
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus" klubi "54" suurus', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus" klubi "54" suurus', 'ei ole oige, peab olema 5', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubisuurus"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_klubisuurus$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_nimi') then drop procedure function_nimi; end if;
create or replace procedure function_nimi(praktikum_10_jr int) as $function_nimi$ 
declare 
arg_count int;
begin
	
	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_nimi') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_nimi';
		if 		arg_count = 2 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_nimi('test', 'kesk')) = 'kesk, test'
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi" tulemus', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi" tulemus', 'ei ole oige', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi" argumentide arv', 'ei ole oige, peab olema 2', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_nimi"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_nimi$ language plpgsql;



if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_mangija_koormus') then drop procedure function_mangija_koormus; end if;
create or replace procedure function_mangija_koormus(praktikum_10_jr int) as $function_mangija_koormus$ 
declare 
arg_count int;
begin
	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_mangija_koormus') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_mangija_koormus';
		if 		arg_count = 1 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_mangija_koormus(73)) = 18
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus" mangija "73" koormus', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus" mangija "73" koormus', 'ei ole oige, peab olema 18', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_koormus"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_mangija_koormus$ language plpgsql;



if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_mangija_voite_turniiril') then drop procedure function_mangija_voite_turniiril; end if;
create or replace procedure function_mangija_voite_turniiril(praktikum_10_jr int) as $function_mangija_voite_turniiril$ 
declare 
arg_count int;
begin
	
	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_mangija_voite_turniiril') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_mangija_voite_turniiril';
		if 		arg_count = 2 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_mangija_voite_turniiril(197,43)) = 3
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" mangija "197" turniiril "43" voitude arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" mangija "197" turniiril "43" voitude arv', 'ei ole oige, peab olema 3', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
			if 		(select * from f_mangija_voite_turniiril(75,44)) = 0
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" mangija "75" turniiril "44" voitude arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" mangija "75" turniiril "44" voitude arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril" argumentide arv', 'ei ole oige, peab olema 2', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_voite_turniiril"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_mangija_voite_turniiril$ language plpgsql;



if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_mangija_viike_turniiril') then drop procedure function_mangija_viike_turniiril; end if;
create or replace procedure function_mangija_viike_turniiril(praktikum_10_jr int) as $function_mangija_viike_turniiril$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_mangija_viike_turniiril') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_mangija_viike_turniiril';
		if 		arg_count = 2 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_mangija_viike_turniiril(197,43)) = 1
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" mangija "197" turniiril "43" viikide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" mangija "197" turniiril "43" viikide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
			if 		(select * from f_mangija_viike_turniiril(75,44)) = 0
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" mangija "75" turniiril "44" viikide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" mangija "75" turniiril "44" viikide arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril" argumentide arv', 'ei ole oige, peab olema 2', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_viike_turniiril"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_mangija_viike_turniiril$ language plpgsql;



if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_mangija_kaotusi_turniiril') then drop procedure function_mangija_kaotusi_turniiril; end if;
create or replace procedure function_mangija_kaotusi_turniiril(praktikum_10_jr int) as $function_mangija_kaotusi_turniiril$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_mangija_kaotusi_turniiril') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_mangija_kaotusi_turniiril';
		if 		arg_count = 2 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			if 		(select * from f_mangija_kaotusi_turniiril(197,43)) = 0
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" mangija "197" turniiril "43" kaotusi arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" mangija "197" turniiril "43" kaotusi arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
			if 		(select * from f_mangija_kaotusi_turniiril(75,44)) = 2
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" mangija "75" turniiril "44" kaotusi arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" mangija "75" turniiril "44" kaotusi arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril" argumentide arv', 'ei ole oige, peab olema 2', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_mangija_kaotusi_turniiril"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
end;	
$function_mangija_kaotusi_turniiril$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_klubiparimad') then drop procedure function_klubiparimad; end if;
create or replace procedure function_klubiparimad(praktikum_10_jr int) as $function_klubiparimad$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_klubiparimad') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_klubiparimad';
		if 		arg_count = 1 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			create or replace view check_klubiparimad as select * from f_klubiparimad('Areng');
			
			if 		(select count(*) from check_klubiparimad) = 3
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" kirjete arv', 'ei ole oige, peab olema 3', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
			
			if 		(select check_column_exists('check_klubiparimad','isik')) = 1 then
				if 		(select isik from check_klubiparimad where isik = 'Pőder, Priit') = 'Pőder, Priit'
				then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangija "Põder, Priit"', 'on olemas', 'OK', 0, 0, praktikum_10_jr);
				else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangija "Põder, Priit"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
				end if;
				
				if 		(select check_column_exists('check_klubiparimad','punktisumma')) = 1 then
					if 		(select punktisumma from check_klubiparimad where isik = 'Pőder, Priit') = 4.5
					then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangija "Põder, Priit" punktid', 'on oige', 'OK', 0, 0, praktikum_10_jr);
					else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangija "Põder, Priit" punktid', 'ei ole oige, peab olema 4.5', 'VIGA', 0, 0, praktikum_10_jr);
					end if;
				else	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangija "Põder, Priit" punkte', 'ei saa leida, sest puudub veerg "punktisumma"', 'VIGA', 0, 0, praktikum_10_jr);
				end if;
			else	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" klubi "Areng" mangijat "Põder, Priit"', 'ei saa leida, sest puudub veerg "isik"', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	if 		exists (select * from information_schema.views where table_name = 'check_klubiparimad') then drop view check_klubiparimad; end if;
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_klubiparimad"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
			if 		exists (select * from information_schema.views where table_name = 'check_klubiparimad') then drop view check_klubiparimad; end if;
end;	
$function_klubiparimad$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_voit_viik_kaotus') then drop procedure function_voit_viik_kaotus; end if;
create or replace procedure function_voit_viik_kaotus(praktikum_10_jr int) as $function_voit_viik_kaotus$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_voit_viik_kaotus') then
		
		select pronargs into arg_count from pg_proc where proname = 'f_voit_viik_kaotus';
		if 		arg_count = 1 then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			create or replace view check_voit_viik_kaotus as select * from f_voit_viik_kaotus(44);
			
			if 		(select count(*) from check_voit_viik_kaotus) = 63
			then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" turniiril "44" kirjete arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" turniiril "44" kirjete arv', 'ei ole oige, peab olema 63', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
			
			if 		(select check_column_exists('check_voit_viik_kaotus','id')) = 1 and
					(select check_column_exists('check_voit_viik_kaotus','voite')) = 1 and 
					(select check_column_exists('check_voit_viik_kaotus','viike')) = 1 and
					(select check_column_exists('check_voit_viik_kaotus','kaotusi')) = 1 then
					
					if 		(select voite from check_voit_viik_kaotus where id = 193) = 1
					then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" voitude arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
					else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" voitude arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
					end if;
					
					if 		(select viike from check_voit_viik_kaotus where id = 193) = 1
					then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" viikide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
					else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" viikide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
					end if;
					
					if 		(select kaotusi from check_voit_viik_kaotus where id = 193) = 0
					then 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" kaotusi arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
					else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" kaotusi arv', 'ei ole oige, peab olema 0', 'VIGA', 0, 0, praktikum_10_jr);
					end if;
				
				
			else	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" mangija "Heli Jalg" turniiril "44" kontroll', 'ei saa leida, sest puuduvad veerud "id", "voite", "viike", "kaotusi"', 'VIGA', 0, 0, praktikum_10_jr);
			end if;
		else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	if 		exists (select * from information_schema.views where table_name = 'check_voit_viik_kaotus') then drop view check_voit_viik_kaotus; end if;
	
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Funktsioon "f_voit_viik_kaotus"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
			if 		exists (select * from information_schema.views where table_name = 'check_voit_viik_kaotus') then drop view check_voit_viik_kaotus; end if;
end;	
$function_voit_viik_kaotus$ language plpgsql;

-- copy
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'procedure_uus_isik') then drop procedure procedure_uus_isik; end if;
create or replace procedure procedure_uus_isik(praktikum_10_jr int) as $procedure_uus_isik$ 
declare 
arg_count int;
begin

	if 	exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'sp_uus_isik') then
		
		select pronargs into arg_count from pg_proc where proname = 'sp_uus_isik';
		if 		arg_count = 3 then 
			insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik" argumentide arv', 'on oige', 'OK', 0, 0, praktikum_10_jr);
			
			call sp_uus_isik('Test', 'Kesk', 4);
			if 		exists (select * from isikud where eesnimi = 'Test' and perenimi = 'Kesk')
			then 	insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik" lisatud isik', 'on olemas', 'OK', 0, 0, praktikum_10_jr);
			else 	insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik" lisatud isik', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
			end if; 
				
		else 	insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik" argumentide arv', 'ei ole oige, peab olema 3', 'VIGA', 0, 0, praktikum_10_jr);
		end if;
	else 	insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik"', 'ei ole olemas', 'VIGA', 0, 0, praktikum_10_jr);
	end if;
	
	delete from isikud where eesnimi = 'Test' and perenimi = 'Kesk';
	exception 
		when others then 
			insert into Staatus values('Praktikum 10', 'Protseduur "sp_uus_isik"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', 0, 0, praktikum_10_jr);
			delete from isikud where eesnimi = 'Test' and perenimi = 'Kesk';
end;	
$procedure_uus_isik$ language plpgsql;


/* Kodutoode kontrollid algavad siit */

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kodutoo_3') then drop procedure kodutoo_3; end if;
create or replace procedure kodutoo_3(versioon int) as $kodutoo_3$ -- punktid kokku 2p: 1-5. ul. 0.5p, 6 ul. 0.75p, 7.ul 0.75p 
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
			
			-- primaarvotme olemasolu
			if 		(select count(*) from information_schema.table_constraints where table_name = 'inimesed' and constraint_type = 'PRIMARY KEY') > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" primaarvoti', 'on olemas', 'OK', kodutoo_3_inimesed_andmed/5, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" primaarvoti', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed/5, kodutoo_3_jr);
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
	if 		(select check_column_exists('turniirid','asula'))=1 then
			if 		(select count(*) from turniirid where asula is not null) > 0
			then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'on olemas', 'OK', kodutoo_3_turniirid_asula, kodutoo_3_turniirid_asula, kodutoo_3_jr);
			else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula*0, kodutoo_3_turniirid_asula, kodutoo_3_jr);
			end if;
	else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" andmed', 'veergu "Asula" ei ole olemas', 'VIGA', kodutoo_3_turniirid_asula*0, kodutoo_3_turniirid_asula, kodutoo_3_jr);
	end if;
	
	-- 4. valisvotme fk_turniir_2_asula kontroll
	if 		exists (select * from information_schema.table_constraints where table_name = 'turniirid' and constraint_type = 'FOREIGN KEY')
	then 	insert into Staatus values ('Kodutoo 3', 'Valisvoti "fk_turniir_2_asula"', 'on olemas', 'OK', kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_jr);
	else	insert into Staatus values ('Kodutoo 3', 'Valisvoti "fk_turniir_2_asula"', 'ei ole olemas', 'VIGA', kodutoo_3_valisvoti_turniirid_asulad*0, kodutoo_3_valisvoti_turniirid_asulad, kodutoo_3_jr);
	end if;
	
	-- 5. tabeli turniirid veerg asukoht/toimumiskoht olemasolu puudumine
	if 		not exists (select * from information_schema.columns where table_name = 'turniirid' and column_name in ('asukoht', 'toimumiskoht'))
	then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asukoht" voi "Toimumiskoht"', 'on kustutatud', 'OK', kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_jr);
	else	insert into Staatus values ('Kodutoo 3', 'Tabel "Turniirid" veerg "Asukoht" voi "Toimumiskoht"', 'ei ole kustutatud', 'VIGA', kodutoo_3_turniirid_asukoht_kustutamine*0, kodutoo_3_turniirid_asukoht_kustutamine, kodutoo_3_jr);
	end if;
	
	
	-- 6. paringu kontroll
	
	-- 7. paringu kontroll
	
end;	
$kodutoo_3$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kodutoo_4') then drop procedure kodutoo_4; end if;
create or replace procedure kodutoo_4(versioon int) as $kodutoo_4$ -- punktid kokku 2p: 1-5. ul. 0.5p, 6 ul. 0.75p, 7.ul 0.75p 
declare 
kodutoo_4_jr int;
kodutoo_4_vaade_turniiripartiid numeric;
kodutoo_4_vaade_klubipartiikogused numeric;
klubidepartiikogustesumma int;
kodutoo_4_vaade_keskminepartii numeric;
kodutoo_4_vaade_partiide_arv_valgetega numeric;
hilisem_kodutoo int;
count_check int;
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
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" kirjete arv', 'on oige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" kirjete arv', 'on vale, peaks olema partiide koguarv', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
			end if;
			-- pisteliselt 3 veeru kontroll
			if 		(select check_column_exists('v_turniiripartiid','kes_voitis'))=1 and
					(select check_column_exists('v_turniiripartiid','partii_id'))=1 then
					-- valge 270
					select count(*) into count_check from v_turniiripartiid where partii_id = 270;
					if 		(count_check) = 1 then
							if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 270) = 'valge'
							then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 270, kes voitis varv', 'on oige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 270, kes voitis varv', 'on vale, peaks olema valge', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							end if;
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 270, kes voitis varv kontroll', 'tulemuseks on '|| count_check ||' kirjet, peab olema 1', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if; 	
					-- must 271
					select count(*) into count_check from v_turniiripartiid where partii_id = 241;
					if 		(count_check) = 1 then
							if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 241) = 'must'
							then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 241, kes voitis varv', 'on oige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 241, kes voitis varv', 'on vale, peaks olema must', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							end if;
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 241, kes voitis varv kontroll', 'tulemuseks on '|| count_check ||' kirjet, peab olema 1', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if;
					-- viik 193
					select count(*) into count_check from v_turniiripartiid where partii_id = 193;
					if 		(count_check) = 1 then
							if 		(select lower(kes_voitis) from v_turniiripartiid where partii_id = 193) = 'viik'
							then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 193, kes voitis varv', 'on oige', 'OK', kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 193, kes voitis varv', 'on vale, peaks olema viik', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
							end if;
					else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" partii 193, kes voitis varv kontroll', 'tulemuseks on '|| count_check ||' kirjet, peab olema 1', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10, kodutoo_4_jr);
					end if;
			else	insert into Staatus values('Kodutoo 4', 'Vaate "v_turniiripartiid" veeru kes voitis', 'ei saa kontrollida, sest puudub veerg "kes_voitis" voi "partii_id"', 'VIGA', kodutoo_4_vaade_turniiripartiid*0, kodutoo_4_vaade_turniiripartiid/10*3, kodutoo_4_jr);
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
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" kirjete arv', 'on oige', 'OK', kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" kirjete arv', 'on vale, peaks olema 12', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5, kodutoo_4_jr);
			end if;
			-- partiide kogusumma kontroll
			if 		(select check_column_exists('v_klubipartiikogused','partiisid'))=1 then
					select sum(partiisid) into klubidepartiikogustesumma from v_klubipartiikogused;
					-- partiide kogu summa on 571
					if 		klubidepartiikogustesumma = 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on oige', 'OK', kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
					elsif 	klubidepartiikogustesumma > 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on vale, sul on: '||klubidepartiikogustesumma||', peaks olema vahem', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
					elsif 	klubidepartiikogustesumma < 571
					then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_klubipartiikogused" partiide kogusumma', 'on vale, sul on: '||klubidepartiikogustesumma||', peaks olema rohkem', 'VIGA', kodutoo_4_vaade_klubipartiikogused*0, kodutoo_4_vaade_klubipartiikogused/5*2, kodutoo_4_jr);
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
			then	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" kirjete arv', 'on oige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" kirjete arv', 'on vale, peaks olema 5', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
			end if;
			-- pisteliselt 2 veeru kontroll
			if 		(select check_column_exists('v_keskminepartii','keskmine_partii'))=1 and
					(select check_column_exists('v_keskminepartii','turniiri_nimi'))=1 then
					-- Plekkkarikas 2010 keskmine
					if (check_column_datatype('v_keskminepartii','keskmine_partii','interval'))=0 then
						if 		(select round(keskmine_partii::numeric,3) from v_keskminepartii where turniiri_nimi = 'Plekkkarikas 2010') = 23.765
						then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Plekkkarikas 2010" keskmine', 'on oige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						elsif	(select round(keskmine_partii::numeric,3) from v_keskminepartii where turniiri_nimi = 'Plekkkarikas 2010') = 24.267
						then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Plekkkarikas 2010" keskmine', 'on oige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Plekkkarikas 2010" keskmine', 'on vale', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						end if;
						-- Kolmeklubi kohtumine keskmine
						if 		(select round(keskmine_partii::numeric,3) from v_keskminepartii where turniiri_nimi = 'Kolme klubi kohtumine') = 23.04
						then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine', 'on oige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						elsif 	(select round(keskmine_partii::numeric,3) from v_keskminepartii where turniiri_nimi = 'Kolme klubi kohtumine') = 23.601
						then 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine', 'on oige', 'OK', kodutoo_4_vaade_keskminepartii/5, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						else 	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine', 'on vale', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5, kodutoo_4_jr);
						end if;
					else insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiride keskmisi', 'ei saa kontrollida, sest veerg "keskmine_partii" on andmetuubiga "interval", peab olema numeric', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5*2, kodutoo_4_jr);
					end if;
			else	insert into Staatus values('Kodutoo 4', 'Vaate "v_keskminepartii" turniiride keskmisi', 'ei saa kontrollida, sest puudub veerg "turniiri_nimi" voi "keskmine_partii"', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii/5*2, kodutoo_4_jr);
			end if;
	else 	insert into Staatus values ('Kodutoo 4', 'Vaadet "v_keskminepartii"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_keskminepartii*0, kodutoo_4_vaade_keskminepartii, kodutoo_4_jr);
	end if;
	
	-- mv_partiide_arv_valgetega
	call mv_vaate_kontroll(kodutoo_4_vaade_partiide_arv_valgetega, kodutoo_4_jr);
end;	
$kodutoo_4$ language plpgsql;	

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'mv_vaate_kontroll') then drop procedure mv_vaate_kontroll; end if;
create or replace procedure mv_vaate_kontroll(kodutoo_4_vaade_partiide_arv_valgetega numeric, kodutoo_4_jr int) as $mv_vaate_kontroll$ 
begin 
	if 		exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega') then 
		REFRESH MATERIALIZED VIEW mv_partiide_arv_valgetega;
		-- Kirjete arv
		if 		(select count(*) from mv_partiide_arv_valgetega) = 85
		then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kirjete arv', 'on oige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
		else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kirjete arv', 'on vale, peaks olema 85 koos 0 partiidega', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
		end if;
		
		-- mangija Tarmo Kooser on olemas
		if 		exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega' and definition ilike '%eesnimi%') 
		and 	exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega' and definition ilike '%perenimi%') then 
			if 		exists (select * from mv_partiide_arv_valgetega where eesnimi = 'Tarmo' and perenimi = 'Kooser')
			then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" mangija 0 partiiga', '"Tarmo Kooser" on olemas', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" mangija 0 partiiga', '"Tarmo Kooser" ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_jr);
			end if;
		else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" mangija 0 partiiga', 'veergu "eesnimi" ja/voi "perenimi" ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5*2, kodutoo_4_jr);
		end if;
		-- min = 0
		if 		exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega' and definition ilike '%partiisid_valgetega%') then
			if 		(select min(partiisid_valgetega) from mv_partiide_arv_valgetega) = 0
			then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" miinimum valgete partiide arv', 'on oige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" miinimum valgete partiide arv', 'on vale, peaks olema 0', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			end if;
		else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" miinimum valgete partiide arv', 'veergu "partiisid_valgetega" ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
		end if;
		-- max = 14
		if 		exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega' and definition ilike '%partiisid_valgetega%') then
			if 		(select max(partiisid_valgetega) from mv_partiide_arv_valgetega) = 14
			then	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" maksimum valgete partiide arv', 'on oige', 'OK', kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" maksimum valgete partiide arv', 'on vale, peaks olema 14', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			end if;
		else 	insert into Staatus values('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" maksimum valgete partiide arv', 'veergu "partiisid_valgetega" ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
		end if;
	else 	insert into Staatus values('Kodutoo 4', 'Vaadet "mv_partiide_arv_valgetega"', 'ei ole olemas', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega, kodutoo_4_jr);
	end if;
	
	--exception 
		--when others then 
			--insert into Staatus values ('Kodutoo 4', 'Vaate "mv_partiide_arv_valgetega" kontrollides tekkis viga', 'oppejoud annab tagasiside! Vaadet pole voi veerge pole!', 'VIGA', kodutoo_4_vaade_partiide_arv_valgetega*0, kodutoo_4_vaade_partiide_arv_valgetega/5, kodutoo_4_jr);
			
end;	
$mv_vaate_kontroll$ language plpgsql;





if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kodutoo_5') then drop procedure kodutoo_5; end if;
create or replace procedure kodutoo_5(versioon int) as $kodutoo_5$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare
kodutoo_5_jr int;
kodutoo_5_funk_vanus numeric;
kodutoo_5_funk_klubiranking numeric;
kodutoo_5_funk_top10 numeric;
kodutoo_5_prot_uus_turniir numeric;
hilisem_kodutoo int;
sqltext text;
punktid numeric;
begin 
	if 		versioon = 6 then hilisem_kodutoo :=1;
	else 	hilisem_kodutoo :=0;
	end if;
	select taisarv into kodutoo_5_jr from muutujad where nimi = 'kodutoo_5_jr';
	select komaarv*hilisem_kodutoo into kodutoo_5_funk_vanus from muutujad where nimi = 'kodutoo_5_funk_vanus';
	select komaarv*hilisem_kodutoo into kodutoo_5_funk_klubiranking from muutujad where nimi = 'kodutoo_5_funk_klubiranking';
	select komaarv*hilisem_kodutoo into kodutoo_5_funk_top10 from muutujad where nimi = 'kodutoo_5_funk_top10';
	select komaarv*hilisem_kodutoo into kodutoo_5_prot_uus_turniir from muutujad where nimi = 'kodutoo_5_prot_uus_turniir';
	
	-- f_vanus
	call function_vanus(kodutoo_5_funk_vanus, kodutoo_5_jr);
	
	-- f_klubiranking
	call function_klubiranking(kodutoo_5_funk_klubiranking, kodutoo_5_jr);
	
	-- f_top10
	call function_top10(kodutoo_5_funk_top10, kodutoo_5_jr);
	
	-- sp_uus_turniir
	call procedure_uus_turniir(kodutoo_5_prot_uus_turniir, kodutoo_5_jr);
end;	
$kodutoo_5$ language plpgsql;


-- f_vanus
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_vanus') then drop procedure function_vanus; end if;
create or replace procedure function_vanus(kodutoo_5_funk_vanus numeric, kodutoo_5_jr int) as $function_vanus$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare 
arg_count int;
begin
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_vanus') then 
		select pronargs into arg_count from pg_proc where proname = 'f_vanus';
		if 		arg_count = 1 then 
			insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" argumentide arv', 'on oige', 'OK', kodutoo_5_funk_vanus/5, kodutoo_5_funk_vanus/5, kodutoo_5_jr);
			
			if 		(select f_vanus('09.09.2000')) = 22
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" kuupaeva "09.09.2000" vanus', 'on oige', 'OK', kodutoo_5_funk_vanus/5*2, kodutoo_5_funk_vanus/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" kuupaeva "09.09.2000" vanus', 'on vale, peab olema 22', 'VIGA', kodutoo_5_funk_vanus*0, kodutoo_5_funk_vanus/5*2, kodutoo_5_jr);
			end if;
			
			if 		(select f_vanus('01.01.2000')) = 23
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" kuupaeva "01.01.2000" vanus', 'on oige', 'OK', kodutoo_5_funk_vanus/5*2, kodutoo_5_funk_vanus/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" kuupaeva "01.01.2000" vanus', 'on vale, peab olema 23', 'VIGA', kodutoo_5_funk_vanus*0, kodutoo_5_funk_vanus/5*2, kodutoo_5_jr);
			end if;
			
		else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_vanus" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', kodutoo_5_funk_vanus/5*0, kodutoo_5_funk_vanus/5, kodutoo_5_jr);
		end if;
	else 	insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_vanus"', 'ei ole olemas', 'VIGA', kodutoo_5_funk_vanus*0, kodutoo_5_funk_vanus, kodutoo_5_jr);
	end if;
	
	exception 
		when others then
			insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_vanus"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_5_funk_vanus*0, kodutoo_5_funk_vanus, kodutoo_5_jr);
end;	
$function_vanus$ language plpgsql;


-- f_klubiranking
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_klubiranking') then drop procedure function_klubiranking; end if;
create or replace procedure function_klubiranking(kodutoo_5_funk_klubiranking numeric, kodutoo_5_jr int) as $function_klubiranking$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare 
arg_count int;
begin
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_klubiranking') then 
		select pronargs into arg_count from pg_proc where proname = 'f_klubiranking';
		if 		arg_count = 1 then 
			insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" argumentide arv', 'on oige', 'OK', kodutoo_5_funk_klubiranking/5, kodutoo_5_funk_klubiranking/5, kodutoo_5_jr);
			
			if 		(select f_klubiranking(54)) = 1279.6
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" klubi "54" mangijate keskmine ranking', 'on oige', 'OK', kodutoo_5_funk_klubiranking/5*2, kodutoo_5_funk_klubiranking/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" klubi "54" mangijate keskmine ranking', 'on vale, peab olema 1279.6', 'VIGA', kodutoo_5_funk_klubiranking*0, kodutoo_5_funk_klubiranking/5*2, kodutoo_5_jr);
			end if;
			
			if 		(select f_klubiranking(59)) = 1407.0
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" klubi "59" mangijate keskmine ranking', 'on oige', 'OK', kodutoo_5_funk_klubiranking/5*2, kodutoo_5_funk_klubiranking/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" klubi "59" mangijate keskmine ranking', 'on vale, peab olema 1407.0', 'VIGA', kodutoo_5_funk_klubiranking*0, kodutoo_5_funk_klubiranking/5*2, kodutoo_5_jr);
			end if;
			
		else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_klubiranking" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', kodutoo_5_funk_klubiranking*0, kodutoo_5_funk_klubiranking/5, kodutoo_5_jr);
		end if;
	else 	insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_klubiranking"', 'ei ole olemas', 'VIGA', kodutoo_5_funk_klubiranking*0, kodutoo_5_funk_klubiranking, kodutoo_5_jr);
	end if;
	
	exception 
		when others then
			insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_klubiranking"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_5_funk_klubiranking*0, kodutoo_5_funk_klubiranking, kodutoo_5_jr);
end;	
$function_klubiranking$ language plpgsql;


-- f_top10
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'function_top10') then drop procedure function_top10; end if;
create or replace procedure function_top10(kodutoo_5_funk_top10 numeric, kodutoo_5_jr int) as $function_top10$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare
v_func_top10_punktid numeric;
v_func_top10_nimi text;
arg_count int;
begin
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_top10') then 
		select pronargs into arg_count from pg_proc where proname = 'f_top10';
		if 		arg_count = 1 then 
			insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" argumentide arv', 'on oige', 'OK', kodutoo_5_funk_top10/5, kodutoo_5_funk_top10/5, kodutoo_5_jr);
			
			if 		exists (select * from information_schema.views where table_name = 'v_func_top10') then drop view v_func_top10; end if;
		
			create or replace view v_func_top10(nimi, punktid) as (select * from f_top10(44));
			if 		(select count(*) from v_func_top10) = 10
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" kirjete arv', 'on oige', 'OK', kodutoo_5_funk_top10/5*2, kodutoo_5_funk_top10/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" kirjete arv', 'on vale, peab olema 10', 'VIGA', kodutoo_5_funk_top10*0, kodutoo_5_funk_top10/5*2, kodutoo_5_jr);
			end if;
			
			if 		(select ft.punktid from v_func_top10 ft where ft.nimi like 'Murakas%') = 3.5
			then 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" turniiril "44" mangija "Murakas, Maria" punktid', 'on oiged', 'OK', kodutoo_5_funk_top10/5*2, kodutoo_5_funk_top10/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" turniiril "44" mangija "Murakas, Maria"', 'ei ole oiged', 'VIGA', kodutoo_5_funk_top10*0, kodutoo_5_funk_top10/5*2, kodutoo_5_jr);
			end if;
			
		else 	insert into Staatus values('Kodutoo 5', 'Funktsioon "f_top10" argumentide arv', 'ei ole oige, peab olema 1', 'VIGA', kodutoo_5_funk_top10/5*0, kodutoo_5_funk_top10/5, kodutoo_5_jr);
		end if;
	else 	insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_top10"', 'ei ole olemas', 'VIGA', kodutoo_5_funk_top10*0, kodutoo_5_funk_top10, kodutoo_5_jr);
	end if;
	
	exception 
		when others then
			insert into Staatus values('Kodutoo 5', 'Funktsiooni "f_top10"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_5_funk_top10*0, kodutoo_5_funk_top10, kodutoo_5_jr);
end;	
$function_top10$ language plpgsql;



-- sp_uus_turniir
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'procedure_uus_turniir') then drop procedure procedure_uus_turniir; end if;
create or replace procedure procedure_uus_turniir(kodutoo_5_prot_uus_turniir numeric, kodutoo_5_jr int) as $procedure_uus_turniir$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare
arg_count int;
begin
	if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'sp_uus_turniir') then 
		--delete from turniirid where nimi ='Tartu Meister'; 
		select pronargs into arg_count from pg_proc where proname = 'sp_uus_turniir';
		if 		arg_count = 4 then 
			insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir" argumentide arv', 'on oige', 'OK', kodutoo_5_prot_uus_turniir/5, kodutoo_5_prot_uus_turniir/5, kodutoo_5_jr);
				
			if 		exists (select * from turniirid where nimi = 'Tartu Meister') then delete from turniirid where nimi ='Tartu Meister'; end if;
			call sp_uus_turniir('Tartu Meister', '02.02.2022',1,'Tartu');
			if exists 	(select * from turniirid where nimi = 'Tartu Meister' and loppkuupaev = '02.02.2022')
			then 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir" uus turniir kuupaevaga "02.02.2022" ja paevade arvuga "0"', 'on olemas ja oigete kuupaevadega', 'OK', kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir"  uus turniir kuupaevaga "02.02.2022" ja paevade arvuga "0"', 'ei olemas voi on valed kuupaevad', 'VIGA', kodutoo_5_prot_uus_turniir*0, kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_jr);
			end if;	
			if 		exists (select * from turniirid where nimi = 'Tartu Meister') then delete from turniirid where nimi ='Tartu Meister'; end if;
			call sp_uus_turniir('Tartu Meister', '02.02.2022',2,'Tartu');
			if exists 	(select * from turniirid where nimi = 'Tartu Meister' and loppkuupaev = '03.02.2022')
			then 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir" uus turniir kuupaevaga "02.02.2022" ja paevade arvuga "2"', 'on olemas ja oigete kuupaevadega', 'OK', kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_jr);
			else 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir"  uus turniir kuupaevaga "02.02.2022" ja paevade arvuga "2"', 'ei olemas voi on valed kuupaevad', 'VIGA', kodutoo_5_prot_uus_turniir*0, kodutoo_5_prot_uus_turniir/5*2, kodutoo_5_jr);
			end if;
			
		else 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir" argumentide arv', 'ei ole oige, peab olema 4', 'VIGA', kodutoo_5_prot_uus_turniir/5*0, kodutoo_5_prot_uus_turniir/5, kodutoo_5_jr);
		end if;
	else 	insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir"', 'ei ole olemas', 'VIGA', kodutoo_5_prot_uus_turniir*0, kodutoo_5_prot_uus_turniir, kodutoo_5_jr);
	end if;
	
	exception 
		when others then 
			insert into Staatus values('Kodutoo 5', 'Protseduur "sp_uus_turniir"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_5_prot_uus_turniir*0, kodutoo_5_prot_uus_turniir, kodutoo_5_jr);
end;	
$procedure_uus_turniir$ language plpgsql;


-- kodutöö 6
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kodutoo_6') then drop procedure kodutoo_6; end if;
create or replace procedure kodutoo_6(versioon int) as $kodutoo_6$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare
kodutoo_6_jr int;
kodutoo_6_ix_riiginimi numeric;
kodutoo_6_ix_suurus numeric;
kodutoo_6_tg_partiiaeg numeric;
kodutoo_6_tg_klubi_olemasolu numeric;
hilisem_kodutoo int;
sqltext text;
punktid numeric;
begin 
	if 		versioon = 8 then hilisem_kodutoo :=1;
	else 	hilisem_kodutoo :=0;
	end if;
	select taisarv into kodutoo_6_jr from muutujad where nimi = 'kodutoo_6_jr';
	select komaarv*hilisem_kodutoo into kodutoo_6_ix_riiginimi from muutujad where nimi = 'kodutoo_6_ix_riiginimi';
	select komaarv*hilisem_kodutoo into kodutoo_6_ix_suurus from muutujad where nimi = 'kodutoo_6_ix_suurus';
	select komaarv*hilisem_kodutoo into kodutoo_6_tg_partiiaeg from muutujad where nimi = 'kodutoo_6_tg_partiiaeg';
	select komaarv*hilisem_kodutoo into kodutoo_6_tg_klubi_olemasolu from muutujad where nimi = 'kodutoo_6_tg_klubi_olemasolu';
	
	-- ix_riiginimi
	if 		exists (select * from pg_indexes where indexname = 'ix_riiginimi')
	then 	insert into Staatus values('Kodutoo 6', 'Indeks "ix_riiginimi"', 'on olemas', 'OK', kodutoo_6_ix_riiginimi, kodutoo_6_ix_riiginimi, kodutoo_6_jr);
	else 	insert into Staatus values('Kodutoo 6', 'Indeks "ix_riiginimi"', 'ei olemas', 'VIGA', kodutoo_6_ix_riiginimi*0, kodutoo_6_ix_riiginimi, kodutoo_6_jr);
	end if;
	-- ix_suurus
	if 		exists (select * from pg_indexes where indexname = 'ix_suurus')
	then 	insert into Staatus values('Kodutoo 6', 'Indeks "ix_suurus"', 'on olemas', 'OK', kodutoo_6_ix_suurus, kodutoo_6_ix_suurus, kodutoo_6_jr);
	else 	insert into Staatus values('Kodutoo 6', 'Indeks "ix_suurus"', 'ei olemas', 'VIGA', kodutoo_6_ix_suurus*0, kodutoo_6_ix_suurus, kodutoo_6_jr);
	end if;
	
	-- tg_partiiaeg
	call trigger_partiiaeg(kodutoo_6_tg_partiiaeg, kodutoo_6_jr);
	
	-- tg_klubi_olemasolu
	call trigger_klubi_olemasolu(kodutoo_6_tg_klubi_olemasolu, kodutoo_6_jr);
end;	
$kodutoo_6$ language plpgsql;


-- tg_partiiaeg
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'trigger_partiiaeg') then drop procedure trigger_partiiaeg; end if;
create or replace procedure trigger_partiiaeg(kodutoo_6_tg_partiiaeg numeric, kodutoo_6_jr int) as $trigger_partiiaeg$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare
mangija_1 int;
mangija_2 int;
begin

	if 	exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_partiiaeg') then
		ALTER TABLE partiid DISABLE TRIGGER ALL;
		ALTER TABLE partiid ENABLE TRIGGER tg_partiiaeg;
		-- update
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_partiiaeg' and event_manipulation = 'UPDATE') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" event "UPDATE"', 'on olemas', 'OK', kodutoo_6_tg_partiiaeg/10, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" event "UPDATE"', 'ei olemas', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		end if;
		-- insert
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_partiiaeg' and event_manipulation = 'INSERT') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" event "INSERT"', 'on olemas', 'OK', kodutoo_6_tg_partiiaeg/10, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" event "INSERT"', 'ei olemas', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		end if;
		-- before
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_partiiaeg' and action_timing = 'BEFORE') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" kaivitusaeg "BEFORE"', 'on olemas', 'OK', kodutoo_6_tg_partiiaeg/10, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" kaivitusaeg "BEFORE"', 'ei olemas', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg/10, kodutoo_6_jr);
		end if;
		
		if 	exists (select id from isikud where eesnimi = 'Man' and perenimi = 'Ka') then delete from isikud where eesnimi = 'Man' and perenimi = 'Ka'; end if;
		insert into isikud (id, eesnimi, perenimi) values (nextval('serial_registration'),'Man', 'Ka');
		select id into mangija_1 from isikud where eesnimi = 'Man' and perenimi = 'Ka';
		
		if 	exists (select id from isikud where eesnimi = 'Kan' and perenimi = 'Ma') then delete from isikud where eesnimi = 'Kan' and perenimi = 'Ma'; end if;
		insert into isikud (id, eesnimi, perenimi) values (nextval('serial_registration'),'Kan', 'Ma');
		select id into mangija_2 from isikud where eesnimi = 'Kan' and perenimi = 'Ma';
		
		insert into partiid values (44,'2023-04-22 17:45:24.000','2023-03-22 17:45:24.000',mangija_1,mangija_2,2,0, nextval('serial_registration'));
		
		if 		(select lopphetk from partiid where valge = mangija_1 and must = mangija_2) is null
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" partii lisamisel', 'on lopphetk oige', 'OK', kodutoo_6_tg_partiiaeg/10*7, kodutoo_6_tg_partiiaeg/10*7, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg" partii lisamisel', 'ei ole lopphetk oige, peab olema NULL', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg/10*7, kodutoo_6_jr);
		end if;
	
	else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg"', 'ei ole olemas', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg, kodutoo_6_jr);
	end if;

	exception 
		when others then 
			insert into Staatus values('Kodutoo 6', 'Triger "tg_partiiaeg"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_6_tg_partiiaeg*0, kodutoo_6_tg_partiiaeg, kodutoo_6_jr);
end;	
$trigger_partiiaeg$ language plpgsql;


-- tg_klubi_olemasolu
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'trigger_klubi_olemasolu') then drop procedure trigger_klubi_olemasolu; end if;
create or replace procedure trigger_klubi_olemasolu(kodutoo_6_tg_klubi_olemasolu numeric, kodutoo_6_jr int) as $trigger_klubi_olemasolu$ -- punktid kokku 2p: 1 - 0.5, 2 - 0.5, 3 - 0.5, 4 - 0.5
declare 
klubi_id int;
begin
	
	if 	exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_klubi_olemasolu') then
		ALTER TABLE isikud DISABLE TRIGGER ALL;
		ALTER TABLE isikud ENABLE TRIGGER tg_klubi_olemasolu;
		-- update
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_klubi_olemasolu' and event_manipulation = 'UPDATE') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" event "UPDATE"', 'on olemas', 'OK', kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" event "UPDATE"', 'ei olemas', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		end if;
		-- insert
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_klubi_olemasolu' and event_manipulation = 'INSERT') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" event "INSERT"', 'on olemas', 'OK', kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" event "INSERT"', 'ei olemas', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		end if;
		-- before
		if 		exists (select trigger_name from information_schema.triggers where trigger_name = 'tg_klubi_olemasolu' and action_timing = 'AFTER') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" kaivitusaeg "AFTER"', 'on olemas', 'OK', kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" kaivitusaeg "AFTER"', 'ei olemas', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		end if;
		
		-- klubi Klubitud
		if 		exists (select * from klubid where nimi ilike 'Klubitud') 
		then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" klubi "Klubitud"', 'on olemas', 'OK', kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" klubi "Klubitud"', 'ei ole olemas, lisatakse', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10, kodutoo_6_jr);
				insert into klubid(nimi) values ('Klubitud');
		end if;
		select id into klubi_id from klubid where nimi = 'Klubitud';
		
		if 	exists (select id from isikud where eesnimi = 'Kan' and perenimi = 'Ma') then delete from isikud where eesnimi = 'Kan' and perenimi = 'Ma'; end if;
		insert into isikud (id, eesnimi, perenimi) values (nextval('serial_registration'),'Kan', 'Ma');
		
		if 		(select check_column_exists('isikud','klubis'))=1 then 
			if 		(select klubis from isikud where eesnimi = 'Kan' and perenimi = 'Ma') = klubi_id
			then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" isiku lisamisel klubi', 'on oige', 'OK', kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_jr);
			else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" isiku lisamisel klubi', 'ei ole oige, peab olema "' || klubi_id ||'"', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_jr);
			end if;
		elsif 	(select check_column_exists('isikud','klubi'))=1 then 
			if 		(select klubi from isikud where eesnimi = 'Kan' and perenimi = 'Ma') = klubi_id
			then 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" isiku lisamisel klubi', 'on oige', 'OK', kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_jr);
			else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" isiku lisamisel klubi', 'ei ole oige, peab olema "' || klubi_id ||'"', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_jr);
			end if;
		else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu" isiku lisamisel klubi kontroll', 'ei saa teha, sest puudub veerg "klubi" või "klubis"', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu/10*6, kodutoo_6_jr);
		end if;
	
	else 	insert into Staatus values('Kodutoo 6', 'Triger "tg_klubi_olemasolu"', 'ei ole olemas', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu, kodutoo_6_jr);
	end if;

	--exception 
		--when others then 
			--insert into Staatus values('Kodutoo 5', 'Triger "tg_klubi_olemasolu"', 'Kontrollis tekkis viga! Oppejoud peab vaatama!', 'VIGA', kodutoo_6_tg_klubi_olemasolu*0, kodutoo_6_tg_klubi_olemasolu, kodutoo_6_jr);
end;	
$trigger_klubi_olemasolu$ language plpgsql;


if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'andmete_taassisestus') then drop procedure andmete_taassisestus; end if;
create or replace procedure andmete_taassisestus (folder_path varchar(255), txt_lugemis_andmed_delimiter varchar(50)) as $andmete_taassisestus$
begin 
	truncate table klubid, partiid, isikud, turniirid  cascade;
	/*if (select count(*) from partiid) > 0 then truncate table partiid cascade; end if;
	if (select count(*) from isikud) > 0 then truncate table isikud cascade; end if;
	if (select count(*) from turniirid) > 0 then truncate table turniirid cascade; end if;
	if (select count(*) from klubid) > 0 then truncate table klubid cascade; end if;*/
	if exists (select * from information_schema.tables where table_name = 'asulad') then 
		if (select count(*) from asulad) > 0 then truncate table asulad cascade; end if;
	end if;
	
	--truncate table partiid, turniirid, isikud, klubid, asulad, riigid;
	-- Asulad andmed
	if exists (select * from information_schema.tables where table_name = 'asulad') then
		call sisesta_txt_andmed('asulad', folder_path || '\asulad.txt', '',txt_lugemis_andmed_delimiter);
	end if;
	
	--Klubid
	if exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asula') then 
		if exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asukoht') then
			ALTER TABLE klubid ALTER COLUMN asukoht DROP NOT NULL;
		end if;
		call sisesta_txt_andmed('klubid', folder_path || '\klubid.txt', '(id, nimi, asula)',txt_lugemis_andmed_delimiter);
	elsif exists (select * from information_schema.columns where table_name = 'klubid' and column_name = 'asukoht') then
		call sisesta_txt_andmed('klubid', folder_path || '\klubid.txt', '(id, nimi, asukoht)',txt_lugemis_andmed_delimiter);
	else 
		alter table klubid add column asula_test int;
		call sisesta_txt_andmed('klubid', folder_path || '\klubid.txt', '(id, nimi, asula_test)',txt_lugemis_andmed_delimiter);
	end if;
	
	-- Turniirid
	if exists (select * from information_schema.columns where table_name = 'turniirid' and column_name = 'asula') then 
		if exists (select * from information_schema.columns where table_name = 'turniirid' and column_name = 'asukoht') then
			ALTER TABLE turniirid ALTER COLUMN asukoht DROP NOT NULL;
		end if;
		call sisesta_txt_andmed('turniirid', folder_path || '\turniirid.txt', '(id, nimi, alguskuupaev, loppkuupaev, asula)', txt_lugemis_andmed_delimiter);
	elsif exists (select * from information_schema.columns where table_name = 'turniirid' and column_name = 'asukoht') then
		call sisesta_txt_andmed('turniirid', folder_path || '\turniirid.txt', '(id, nimi, alguskuupaev, loppkuupaev, asukoht)', txt_lugemis_andmed_delimiter);
	else
		call sisesta_txt_andmed('turniirid', folder_path || '\turniirid.txt', '(id, nimi, alguskuupaev, loppkuupaev, toimumiskoht)', txt_lugemis_andmed_delimiter);
	end if;
	
	-- Isikud
	if exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'klubis') then 
		call sisesta_txt_andmed('isikud', folder_path || '\isikud.txt', '(id, eesnimi, perenimi, isikukood, klubis, synniaeg, sugu, ranking)',txt_lugemis_andmed_delimiter);
		update isikud set klubis = null where id in (9,10,8,13,6);
	elsif  exists (select * from information_schema.columns where table_name = 'isikud' and column_name = 'klubi') then 
		call sisesta_txt_andmed('isikud', folder_path || '\isikud.txt', '(id, eesnimi, perenimi, isikukood, klubi, synniaeg, sugu, ranking)',txt_lugemis_andmed_delimiter);
		update isikud set klubi = null where id in (9,10,8,13,6);
	else
		alter table isikud add column klubis int;
		call sisesta_txt_andmed('isikud', folder_path || '\isikud.txt', '(id, eesnimi, perenimi, isikukood, klubis, synniaeg, sugu, ranking)',txt_lugemis_andmed_delimiter);
		update isikud set klubis = null where id in (9,10,8,13,6);
	end if;
	
	-- Partiid
	call sisesta_txt_andmed('partiid', folder_path || '\partiid.txt', '(turniir, algushetk, lopphetk, valge, must, valge_tulemus, must_tulemus, id)',txt_lugemis_andmed_delimiter);
	
	/*
	copy asulad from 'C:\TEMP\asulad.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy klubid from 'C:\TEMP\klubid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy turniirid from 'C:\TEMP\turniirid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy isikud from 'C:\TEMP\isikud.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy partiid from 'C:\TEMP\partiid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	copy riigid from 'C:\TEMP\riigid.txt' DELIMITER E'\t'ENCODING 'UTF-8';
	*/
	
end;
$andmete_taassisestus$ LANGUAGE plpgsql;

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'tudengi_nimi') then drop procedure tudengi_nimi; end if;
create or replace procedure tudengi_nimi() as $tudengi_nimi$
declare aeg timestamp;
tudeng int;
e_nimi varchar(100);
p_nimi varchar(100);
begin
	select taisarv into tudeng from muutujad where nimi = 'tudeng';
	if 	(select check_column_exists('inimesed','sisestatud'))=1 then
		select max(sisestatud) into aeg from inimesed;
		select eesnimi into e_nimi from inimesed where sisestatud = aeg limit 1;
		select perenimi into p_nimi from inimesed where sisestatud = aeg limit 1;
		insert into staatus values ('Tudeng', 	e_nimi, p_nimi, '-', 0, 0, tudeng);
	else insert into Staatus values ('Tudeng', 'Nime leidmisel', 'tekkis viga!', '-', 0, 0, tudeng);
	end if;
	
	
	exception 
		when others then 
			insert into Staatus values ('Tudeng', 'Nime leidmisel', 'tekkis viga!', '-', 0, 0, tudeng);
			

end;
$tudengi_nimi$ LANGUAGE plpgsql;

if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kaivita') then drop procedure kaivita; end if;
create or replace procedure kaivita (versioon int, folder_path varchar(255), txt_lugemis_andmed_delimiter varchar(50)) as $kaivita$
begin 
	
	if versioon = 0 then 
		call edu_test();
	end if;
	
	if versioon >= 4 then 
		call andmete_taassisestus(folder_path, txt_lugemis_andmed_delimiter);
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
	if versioon >= 5 then
		call praktikum_7(versioon);
	end if;
	if versioon >= 6 then
		call kodutoo_5(versioon);
	end if;
	if versioon >= 7 then
		call praktikum_10(versioon);
	end if;
	if versioon >= 8 then
		call kodutoo_6(versioon);
	end if;
	call arvuta_punktid(versioon);
	
	if versioon >= 3 then
		call tudengi_nimi();
	end if;
	
end;
$kaivita$ LANGUAGE plpgsql;
SET client_min_messages TO WARNING;
if exists (select * from pg_catalog.pg_sequences where sequencename = 'serial_registration') then drop sequence serial_registration; end if;
CREATE SEQUENCE serial_registration START 3000;

ALTER TABLE isikud DISABLE TRIGGER ALL;
ALTER TABLE klubid DISABLE TRIGGER ALL;
ALTER TABLE partiid DISABLE TRIGGER ALL;
ALTER TABLE turniirid DISABLE TRIGGER ALL;
call kaivita(versioon, folder_path, txt_lugemis_andmed_delimiter);
--Copy (Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') or ylesanne = 'Tudeng' order by jr asc) To 'C:\TEMP\tulemus.csv' With CSV DELIMITER ',' HEADER;
call valjasta_tulemus(folder_path || '\tulemus.csv', tulemus_andmed_delimiter);
ALTER TABLE isikud ENABLE TRIGGER ALL;
ALTER TABLE klubid ENABLE TRIGGER ALL;
ALTER TABLE partiid ENABLE TRIGGER ALL;
ALTER TABLE turniirid ENABLE TRIGGER ALL;
SET client_min_messages TO NOTICE;
end;
$kontroll$ LANGUAGE plpgsql;
call kontroll();
--Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus where olek in ('VIGA','Hindepunktid') or ylesanne = 'Tudeng' order by jr asc;