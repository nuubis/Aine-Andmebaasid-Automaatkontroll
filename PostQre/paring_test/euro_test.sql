create or replace procedure kontroll() as $kontroll$
declare versioon int := 1;
/*
Siin maarad, mis ylesandeid kontrollitakse. Koik eelnevad kontrollivad ka eelmisi.
2 - kodutoo 2
3 - kodutoo 3
4 - kodutoo 4

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

begin 


/* Väljasta tagasiside tulemusfaili */
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

/* Tabel muutujad vajalike kontrollandmete hoidmiseks  */
if exists (select * from information_schema.tables where table_name = 'muutujad') then drop table  muutujad; end if;
create table muutujad (
nimi varchar(1000) unique,
taisarv int,
komaarv numeric);
delete from muutujad;
call sisesta_csv_andmed('muutujad', folder_path || '\muutujad.csv', csv_lugemis_andmed_delimiter);

/* Tabel Staatus, kuhu kogutakse tudengi kontrollide tulemus */
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

/* Eelkontrollide funktsioonid */
/* Tabeli veeru olemasolu eelkontroll */
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


/* Tabeli veeru andmetuubi eelkontroll */
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

/* KOntrollide abiprotseduurid */
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
praktikum11_oige int;
praktikum11_saadud_oige int;
begin
	select taisarv into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	select taisarv into praktikum_jr from muutujad where nimi = 'praktikum_jr';
	select taisarv into praktikum3_oige from muutujad where nimi = 'praktikum3_oige';
	select taisarv into praktikum4_oige from muutujad where nimi = 'praktikum4_oige';
	select taisarv into praktikum7_oige from muutujad where nimi = 'praktikum7_oige';
	select taisarv into praktikum10_oige from muutujad where nimi = 'praktikum10_oige';
	select taisarv into praktikum11_oige from muutujad where nimi = 'praktikum11_oige';
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
	if versioon = 9 then
		select count(*) into praktikum11_saadud_oige from staatus where ylesanne = 'Praktikum 11' and olek = 'OK'; 
		insert into Staatus values ('Praktikum 11', 'Oigesti tehtud: ' || praktikum11_saadud_oige,'Maksimum oiged: '|| praktikum11_oige, 'Hindepunktid', 1, 1,	praktikum_jr);
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


/* Kontrollid */


/* Protseduur kaivita */
if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'kaivita') then drop procedure kaivita; end if;
create or replace procedure kaivita (versioon int, folder_path varchar(255), txt_lugemis_andmed_delimiter varchar(50)) as $kaivita$
begin 
	
	if versioon = 0 then 
		call edu_test();
	end if;
	
	if versioon >= 4 then 
		call andmete_taassisestus(folder_path, txt_lugemis_andmed_delimiter, versioon);
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
	if versioon >= 9 then
		call praktikum_11(versioon);
	end if;
	call arvuta_punktid(versioon);
	
	if versioon >= 3 then
		call tudengi_nimi();
	end if;
	
end;
$kaivita$ LANGUAGE plpgsql;

/* Andmebaasi teadete väljalülitamine */
SET client_min_messages TO WARNING;

/* Kõikide kontrollide käivitamine vastavalt versioonile */
call kaivita(versioon, folder_path, txt_lugemis_andmed_delimiter);

/* Tulemuse väljastamine */
call valjasta_tulemus(folder_path || '\tulemus.csv', tulemus_andmed_delimiter);

/* Andmebaasi teadete sisselülitamine */
SET client_min_messages TO NOTICE;
end;
$kontroll$ LANGUAGE plpgsql;

/* Automaatkontrollide käivitamine */
call kontroll();