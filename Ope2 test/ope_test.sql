-- Muutuja mis määrab, milline kodutöö käivitatakse, 2=praktikum 3(27õn), 3=kodutöö(28õn) 3, 4=kodutöö 4(31õn), 5=kodutöö 5(?õn)
create or replace variable versioon int = 5;

-- Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab 
if 	exists (select * from sysprocedure where proc_name = 'deleteS') 						then drop function deleteS 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_name') 						then drop function find_table_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_table_id') 						then drop function find_table_id 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_column_name') 						then drop function find_column_name 						endif;
if 	exists (select * from sysprocedure where proc_name = 'find_column_id') 						then drop function find_column_id 						endif;
if 	exists (select * from sysprocedure where proc_name = 'teine_praktikum') 						then drop function teine_praktikum 						endif;
if 	exists (select * from sysprocedure where proc_name = 'teine_kodutöö') 						then drop function teine_kodutöö 						endif;
if 	exists (select * from sysprocedure where proc_name = 'käivita') 						then drop function käivita 						endif;
if 	exists (select * from sysprocedure where proc_name = 'arvuta_punktid') 						then drop function arvuta_punktid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'check_check') 						then drop function check_check 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_praktikum') 						then drop function kolmas_praktikum 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kolmas_kodutöö') 						then drop function kolmas_kodutöö 						endif;
if 	exists (select * from sysprocedure where proc_name = 'check_foreign_key') 						then drop function check_foreign_key 						endif;
if 	exists (select * from sysprocedure where proc_name = 'neljas_kodutöö') 						then drop function neljas_kodutöö 						endif;
if 	exists (select * from sysprocedure where proc_name = 'check_column') 						then drop function check_column 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_keskminepartii') 						then drop function view_keskminepartii 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_turniiripartiid') 						then drop function view_turniiripartiid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_klubipartiikogused') 						then drop function view_klubipartiikogused 						endif;
if 	exists (select * from sysprocedure where proc_name = 'm_view_keskminepartii') 						then drop function m_view_keskminepartii 						endif;
if 	exists (select * from sysprocedure where proc_name = 'function_liida') 						then drop function function_liida 						endif;
if 	exists (select * from sysprocedure where proc_name = 'function_klubisuurus') 						then drop function function_klubisuurus 						endif;
if 	exists (select * from sysprocedure where proc_name = 'procedure_uus_isik') 						then drop function procedure_uus_isik 						endif;
if 	exists (select * from sysprocedure where proc_name = 'procedure_top10') 						then drop function procedure_top10 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_edetabelid') 						then drop function view_edetabelid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_partiid') 						then drop function view_partiid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_isikudklubid') 						then drop function view_isikudklubid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_punktid') 						then drop function view_punktid 						endif;

-- Erinevate ülesannete järjekorrad
-- 1-9
create or replace variable praktikum_2_jr int = 1; 
create or replace variable praktikum_punktid_2_jr int = 2; 

create or replace variable kodutöö_2_jr int = 5;
create or replace variable kodutöö_punktid_2_jr int = 6;

create or replace variable praktikum_3_jr int = 10;
create or replace variable praktikum_punktid_3_jr int = 11;

create or replace variable praktikum_5_jr int = 15;
create or replace variable praktikum_punktid_5_jr int = 16;

-- 50 praktikumide punktid
create or replace variable praks_lõpp_punktid int = 50;

-- Kodutööde punktid
create or replace variable kodutöö_3_jr int = 54;
create or replace variable kodutöö_punktid_3_jr int = 55;

create or replace variable kodutöö_4_jr int = 64;
create or replace variable kodutöö_punktid_4_jr int = 65;

create or replace variable kodutöö_5_jr int = 74;
create or replace variable kodutöö_punktid_5_jr int = 75;

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

-- kodutöö 4 punktid
create or replace variable kodutöö_4 numeric = 2;
-- v_turniiripartiid
create or replace variable kodutöö_4_v_turniiripartiid numeric = 0.4;
create or replace variable kodutöö_4_v_turniiripartiid_olemasolu numeric = 0.1;
create or replace variable kodutöö_4_v_turniiripartiid_turniir_nimi numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_toimumiskoht numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_partii_id numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_partii_algus numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_partii_lopp numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_kes_voitis numeric = 0.01;
create or replace variable kodutöö_4_v_turniiripartiid_veergude_arv numeric = 0.12;
create or replace variable kodutöö_4_v_turniiripartiid_viigid numeric = 0.12;
create or replace variable kodutöö_4_v_turniiripartiid_partii numeric = 0.12;

-- v_klubipartiikogused
create or replace variable kodutöö_4_v_klubipartiikogused numeric = 0.4;
create or replace variable kodutöö_4_v_klubipartiikogused_olemasolu numeric = 0.1;
create or replace variable kodutöö_4_v_klubipartiikogused_klubi_nimi numeric = 0.05;
create or replace variable kodutöö_4_v_klubipartiikogused_partiisid numeric = 0.05;
create or replace variable kodutöö_4_v_klubipartiikogused_veergude_arv numeric = 0.1;
create or replace variable kodutöö_4_v_klubipartiikogused_areng_kogus numeric = 0.05;
create or replace variable kodutöö_4_v_klubipartiikogused_ajurebend_kogus numeric = 0.05;

-- v_keskminepartii
create or replace variable kodutöö_4_v_keskminepartii numeric = 0.4;
create or replace variable kodutöö_4_v_keskminepartii_olemasolu numeric = 0.1;
create or replace variable kodutöö_4_v_keskminepartii_turniiri_nimi numeric = 0.05;
create or replace variable kodutöö_4_v_keskminepartii_keskmine_partii numeric = 0.05;
create or replace variable kodutöö_4_v_keskminepartii_veergude_arv numeric = 0.05;
create or replace variable kodutöö_4_v_keskminepartii_kirjete_arv numeric = 0.05;
create or replace variable kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine numeric = 0.1;

-- mvpartiide_arv_valgetega
create or replace variable kodutöö_4_mv_partiide_arv_valgetega numeric = 0.4;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_olemasolu numeric = 0.1;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_eesnimi numeric = 0.05;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_perenimi numeric = 0.05;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_kogus numeric = 0.05;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_veergude_arv numeric = 0.05;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur numeric = 0.05;
create or replace variable kodutöö_4_mv_partiide_arv_valgetega_artur_muld numeric = 0.05;


-- kodutöö 5 punktid
create or replace variable praktikum_5 numeric = 0;
create or replace variable kodutöö_5 numeric = 2;
create or replace variable kodutöö_5_f_liida numeric = 0.5;
create or replace variable kodutöö_5_f_liida_olemasolu numeric = 0.25;
create or replace variable kodutöö_5_f_liida_tulemus numeric = 0.25;

create or replace variable kodutöö_5_f_klubisuurus numeric = 0.5;
create or replace variable kodutöö_5_f_klubisuurus_olemasolu numeric = 0.25;
create or replace variable kodutöö_5_f_klubisuurus_tulemus numeric = 0.25;

create or replace variable kodutöö_5_sp_uus_isik numeric = 0.5;
create or replace variable kodutöö_5_sp_uus_isik_olemasolu numeric = 0.25;
create or replace variable kodutöö_5_sp_uus_isik_tulemus numeric = 0.25;

create or replace variable kodutöö_5_sp_top10 numeric = 0.5;
create or replace variable kodutöö_5_sp_top10_olemasolu numeric = 0.25;
create or replace variable kodutöö_5_sp_top10_tulemus numeric = 0.25;

-- Eelenvate praktikumide ja kodutööde punktide väärtuste panemine 0.01 peale
--Praktikum ja kodutöö 2
if 	versioon > 2 then -- 0.10
	set praktikum_2_isikud_perenimi  = 0.01;
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

if versioon > 3 then -- 0.14
	set kodutöö_3_inimesed_andmed = 0.02;
	set kodutöö_3_turniirid_asula = 0.02;
	set kodutöö_3_turniirid_asula_andmed = 0.02;
	set kodutöö_3_turniirid_asukoht_kustutamine = 0.02;
	set kodutöö_3_välisvõti_turniirid_asulad = 0.03;
	set praktikum_3_tabel_inimene = 0.02;
	set praktikum_3_tabel_asulad = 0.02;
	set praktikum_3_tabel_riigid = 0.02;
	set praktikum_3_riigid_andmed = 0.02;
	set praktikum_3_asulad_andmed = 0.02;
	set praktikum_3_klubid_asula_andmed = 0.02;
	set praktikum_3_klubid_asula = 0.02;
	set praktikum_3_klubid_asukoht_kustutamine = 0.02;
	set praktikum_3_välisvõti_klubid_asulad = 0.03;
endif;

if versioon > 4 then --
	
	
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


-- Abifunktsioon, et saada tabeli nimest tabeli ID, sissetulev muutujaks on tabeli nimi süsteemis ja tagastus on tabeli ID 
create  function find_table_id(a_table_name varchar(100))
	returns int
	begin 
		declare a_id int;
		select  table_id into a_id from systable
		where   upper(table_name) = upper(a_table_name);
		return  a_id;
	end;

create  function find_column_id(a_table_name varchar(100), a_column_name varchar(100))
	returns int
	begin 
		declare c_id int;
		select  column_id into c_id from syscolumn
		where   table_id = find_table_id(a_table_name) and upper(column_name) = upper(a_column_name);
		return 	c_id;
	end;

create 	procedure arvuta_punktid(versioon int)
	begin
		declare max_punktid_jr, õiged, vead, kokku int;
		declare kodu_punktid, kodu_max_punktid, praks_punktid, praks_max_punktid numeric;
		set 	max_punktid_jr = 10;
		
		if 		versioon = 2 then set kodu_max_punktid = 0.35;
		endif;
		if		versioon = 3 then
				set praks_max_punktid = 1; 
				set kodu_max_punktid = 0.5;
		endif;
		if		versioon = 4 then 	
				set kodu_max_punktid = 2;
		endif;
		if		versioon = 5 then
				set praks_max_punktid = 0;
				set kodu_max_punktid = 2;
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
			insert into Staatus values ('Iseseisev','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, '', kodutöö_punktid_2_jr);
		endif;
		
		if 		versioon = 3 then
			select sum(punktid) into praks_punktid from staatus where ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Praktikum','-','-', 'Hindepunktid', praks_punktid, praks_max_punktid, '', praks_lõpp_punktid);
			
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, '', kodu_lõpp_punktid);
		endif;
		
		if 		versioon = 4 then
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö' or ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, '', kodu_lõpp_punktid);
		endif;
		
		if 		versioon = 5 then
			select sum(punktid) into praks_punktid from staatus where ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Praktikum','-','-', 'Hindepunktid', praks_punktid, praks_max_punktid, '', praks_lõpp_punktid);
			
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, '', kodu_lõpp_punktid);
		endif;
		
	end;

create procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, jr int,
								ylesanne varchar(100), olem varchar(100))
	begin
		
		begin try
			if 		not exists (select * from syscolumn where column_name = a_column_name and table_id = find_table_id(a_table_name)) 
			then 	insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, '', jr);
			else 	insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, '', jr);
			endif;
		end try
		begin catch
			insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'"', 'Automaatkontrollis on viga!', 'VIGA', punktid*0, punktid, '', jr);
		end catch;
	
	
	end;

create procedure teine_praktikum()
	begin
		
		if versioon = 2 then
			
			-- Tabel Turniirid veerg asukoht
			call check_column('Turniirid', 'Asukoht', praktikum_2_turniirid_asukoht, praktikum_2_jr, 'Praktikum', 'Tabel');
			
			
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
		call check_column('Isikud', 'Klubis', kodutöö_2_isikud_klubis, kodutöö_2_jr, 'Kodutöö', 'Tabel');
		
		
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
				begin try
					insert into turniirid (Nimi,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1','Kambja','2005-01-13','2005-01-12');
					insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
					delete from turniirid where nimi = 'Ajakontroll Check1';	
				end try
				begin catch
					begin try
						insert into turniirid (Nimi,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1',1,'2005-01-13','2005-01-12');
						insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
						
						delete from turniirid where nimi = 'Ajakontroll Check1';	
					end try
					begin catch
						if 		not exists (select * from syscolumn where column_name = 'Alguskuupaev' and table_id = find_table_id('turniirid'))
						or 		not exists (select * from syscolumn where column_name = 'Loppkuupaev' and table_id = find_table_id('turniirid'))
						then 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, 'Veerg lopphetk on täpitähega.', kodutöö_2_jr);
						else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_suurem, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, '', kodutöö_2_jr);
						endif;
					end catch;
				end catch;
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
				begin try
					insert into turniirid (Nimi,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2','Kambja','2005-01-12','2005-01-12');
					insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
					delete from turniirid where nimi = 'Ajakontroll Check2';
				end try
				begin catch
					begin try
						insert into turniirid (Nimi,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2',1,'2005-01-12','2005-01-12');
						insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
						delete from turniirid where nimi = 'Ajakontroll Check2';
					end try
					begin catch
						if 		not exists (select * from syscolumn where column_name = 'Alguskuupaev' and table_id = find_table_id('turniirid'))
						or 		not exists (select * from syscolumn where column_name = 'Loppkuupaev' and table_id = find_table_id('turniirid'))
						then 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 'Veerg alguskuupaev või loppkuupaev on täpitähega.', kodutöö_2_jr);
						else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus peab lubama võrdset algus ja Loppkuupaev', 	'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, '', kodutöö_2_jr);
						endif;
					end catch;
				end catch;
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
		call check_column('Klubid', 'Asula', praktikum_3_klubid_asula, praktikum_3_jr, 'Praktikum', 'Tabel');
				
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
		begin try
			if 		(select count(foreign_key_id) into count_f_key from sysfkcol where 	foreign_table_id = find_table_id('Klubid') 
					and foreign_column_id = find_column_id('Klubid','Asula') and primary_column_id = find_column_id('Asulad', 'Id')) = 1
			then	insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'on olemas', 'OK', praktikum_3_välisvõti_klubid_asulad, praktikum_3_välisvõti_klubid_asulad, '', praktikum_3_jr);		
			else	insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'pole olemas vajalike tabelite ja/või veergude vahel', 'VIGA', praktikum_3_välisvõti_klubid_asulad*0, praktikum_3_välisvõti_klubid_asulad, '', praktikum_3_jr);
			endif;
		end try
		begin catch
					insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_välisvõti_klubid_asulad*0, praktikum_3_välisvõti_klubid_asulad, '', praktikum_3_jr);
		end catch;

		
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
		call check_column('Turniirid', 'Asula', kodutöö_3_turniirid_asula, kodutöö_3_jr, 'Kodutöö', 'Tabel');
				
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
		begin try
			if 		(select count(foreign_key_id) into count_f_key from sysfkcol where 	foreign_table_id = find_table_id('Turniirid') 
					and foreign_column_id = find_column_id('Turniirid','Asula') and primary_column_id = find_column_id('Asulad', 'Id')) = 1
			then	insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'on olemas', 'OK', kodutöö_3_välisvõti_turniirid_asulad, kodutöö_3_välisvõti_turniirid_asulad, '', praktikum_3_jr);		
			else	insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'pole olemas vajalike tabelite ja/või veergude vahel', 'VIGA', kodutöö_3_välisvõti_turniirid_asulad*0, kodutöö_3_välisvõti_turniirid_asulad, '', praktikum_3_jr);
			endif;
		end try
		begin catch
					insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_välisvõti_turniirid_asulad*0, kodutöö_3_välisvõti_turniirid_asulad, '', praktikum_3_jr);
		end catch;
		
	end;
	
	
	-- mitte tuvastatav viga 555
-- vaade v_turniiripartiid
create procedure view_turniiripartiid()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_turniiripartiid')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'ei ole olemas', 'VIGA', kodutöö_4_v_turniiripartiid*0, kodutöö_4_v_turniiripartiid, '', kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'on olemas', 'OK', kodutöö_4_v_turniiripartiid_olemasolu, kodutöö_4_v_turniiripartiid_olemasolu, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid*0, kodutöö_4_v_turniiripartiid, '', kodutöö_4_jr);
			return;
		end catch;
		
		-- turniir_nimi, toimumiskoht, partii_id, partii_algus, partii_lopp, kes_voitis
		call check_column('v_turniiripartiid', 'Turniir_nimi', kodutöö_4_v_turniiripartiid_turniir_nimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_turniiripartiid', 'Toimumiskoht', kodutöö_4_v_turniiripartiid_toimumiskoht, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_turniiripartiid', 'Partii_id', kodutöö_4_v_turniiripartiid_partii_id, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_turniiripartiid', 'Partii_algus', kodutöö_4_v_turniiripartiid_partii_algus, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_turniiripartiid', 'Partii_lopp', kodutöö_4_v_turniiripartiid_partii_lopp, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_turniiripartiid', 'kes_voitis', kodutöö_4_v_turniiripartiid_kes_voitis, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_turniiripartiid')) = 6
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'on õige', 'OK', kodutöö_4_v_turniiripartiid_veergude_arv, kodutöö_4_v_turniiripartiid_veergude_arv, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_turniiripartiid_veergude_arv*0, kodutöö_4_v_turniiripartiid_veergude_arv, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid_veergude_arv*0, kodutöö_4_v_turniiripartiid_veergude_arv, '', kodutöö_4_jr);
		end catch;
		
		-- kes võitis viike
		begin try
			if 		(select count(*) from v_turniiripartiid where kes_voitis = 'viik') > 0
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis "Asula" andmed', 'viigid on olemas', 'OK', kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_v_turniiripartiid_viigid, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis "Asula" andmed', 'viigid on puudu', 'VIGA', kodutöö_4_v_turniiripartiid_viigid*0, kodutöö_4_v_turniiripartiid_viigid, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid_viigid*0, kodutöö_4_v_turniiripartiid_viigid, '', kodutöö_4_jr);
		end catch;
		
		-- üks partii kontroll
		
		-- kodutöö_4_v_turniiripartiid_partii
	
	end;
	
	
create procedure view_klubipartiikogused()

	begin
		-- vaade v_klubipartiikogused
		begin try
			if 		not exists (select * from systable where table_name = 'v_klubipartiikogused')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'ei ole olemas', 'VIGA', kodutöö_4_v_klubipartiikogused*0, kodutöö_4_v_klubipartiikogused, '', kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'on olemas', 'OK', kodutöö_4_v_klubipartiikogused_olemasolu, kodutöö_4_v_klubipartiikogused_olemasolu, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused*0, kodutöö_4_v_klubipartiikogused, '', kodutöö_4_jr);
			return;
		end catch;
		
		-- klubi_nimi, partiisid
		call check_column('v_klubipartiikogused', 'klubi_nimi', kodutöö_4_v_klubipartiikogused_klubi_nimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_klubipartiikogused', 'partiisid', kodutöö_4_v_klubipartiikogused_partiisid, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_klubipartiikogused')) = 2
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_veergude_arv, kodutöö_4_v_klubipartiikogused_veergude_arv, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_veergude_arv*0, kodutöö_4_v_klubipartiikogused_veergude_arv, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_veergude_arv*0, kodutöö_4_v_klubipartiikogused_veergude_arv, '', kodutöö_4_jr);
		end catch;
		
		-- klubi Areng kogus 33
		begin try
			if 		(select partiisid from v_klubipartiikogused where klubi_nimi = 'Areng') >= 33
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_v_klubipartiikogused_areng_kogus, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_areng_kogus*0, kodutöö_4_v_klubipartiikogused_areng_kogus, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_areng_kogus*0, kodutöö_4_v_klubipartiikogused_areng_kogus, '', kodutöö_4_jr);
		end catch;
		
		-- klubi Ajurebend kogus 70
		begin try
			if 		(select partiisid from v_klubipartiikogused where klubi_nimi = 'Ajurebend') >= 70
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_ajurebend_kogus*0, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_ajurebend_kogus*0, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, '', kodutöö_4_jr);
		end catch;
		
		
	end;
	
create procedure view_keskminepartii()

	begin
		-- vaade v_keskminepartii
		begin try
			if 		not exists (select * from systable where table_name = 'v_keskminepartii')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'ei ole olemas', 'VIGA', kodutöö_4_v_keskminepartii*0, kodutöö_4_v_keskminepartii, '', kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'on olemas', 'OK', kodutöö_4_v_keskminepartii_olemasolu, kodutöö_4_v_keskminepartii_olemasolu, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_olemasolu*0, kodutöö_4_v_keskminepartii_olemasolu, '', kodutöö_4_jr);
		end catch;
		
		-- turniiri_nimi ja keskmine_partii
		call check_column('v_keskminepartii', 'turniiri_nimi', kodutöö_4_v_keskminepartii_turniiri_nimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_keskminepartii', 'keskmine_partii', kodutöö_4_v_keskminepartii_keskmine_partii, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_keskminepartii')) = 2
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'on õige', 'OK', kodutöö_4_v_keskminepartii_veergude_arv, kodutöö_4_v_keskminepartii_veergude_arv, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_veergude_arv*0, kodutöö_4_v_keskminepartii_veergude_arv, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_veergude_arv*0, kodutöö_4_v_keskminepartii_veergude_arv, '', kodutöö_4_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_keskminepartii) = 5
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'on õige', 'OK', kodutöö_4_v_keskminepartii_kirjete_arv, kodutöö_4_v_keskminepartii_kirjete_arv, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_kirjete_arv*0, kodutöö_4_v_keskminepartii_kirjete_arv, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_kirjete_arv*0, kodutöö_4_v_keskminepartii_kirjete_arv, '', kodutöö_4_jr);
		end catch;
		
		-- kolme klub kohtumine 23,04
		begin try
			if 		(select keskmine_partii from v_keskminepartii where turniiri_nimi = 'Kolme klubi kohtumine') = 23.04
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'on õige', 'OK', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine*0, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine*0, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, '', kodutöö_4_jr);
		end catch;
		
	end;
	
create procedure m_view_keskminepartii()

	begin
		-- vaade mv_partiide_arv_valgetega
		begin try
			if 		not exists (select * from systable where table_name = 'mv_partiide_arv_valgetega')
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega*0, kodutöö_4_mv_partiide_arv_valgetega, '', kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'on olemas', 'OK', kodutöö_4_mv_partiide_arv_valgetega_olemasolu, kodutöö_4_mv_partiide_arv_valgetega_olemasolu, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega*0, kodutöö_4_mv_partiide_arv_valgetega, '', kodutöö_4_jr);
		end catch;
		
		call check_column('mv_partiide_arv_valgetega', 'eesnimi', kodutöö_4_mv_partiide_arv_valgetega_eesnimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('mv_partiide_arv_valgetega', 'perenimi', kodutöö_4_mv_partiide_arv_valgetega_perenimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('mv_partiide_arv_valgetega', 'partiisid_valgetega', kodutöö_4_mv_partiide_arv_valgetega_kogus, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('mv_partiide_arv_valgetega')) = 3
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv*0, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv*0, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, '', kodutöö_4_jr);
		end catch;
		
		begin try
			--refresh materialized view mv_partiide_arv_valgetega;
		end try
		begin catch
		end catch;
				
		-- 0
		begin try
			if 		(select partiisid_valgetega from mv_partiide_arv_valgetega where eesnimi = 'Vahur' and perenimi = 'Kahur') = 0
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, '', kodutöö_4_jr);
		end catch;
		
		-- 14
		begin try
			if 		(select partiisid_valgetega from mv_partiide_arv_valgetega where eesnimi = 'Artur' and perenimi = 'Muld') = 14
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, '', kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, '', kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, '', kodutöö_4_jr);
		end catch;
		
	end;

create procedure view_edetabelid()
	begin
		-- vaade v_edetabel
		begin try
			if 		not exists (select * from systable where table_name = 'v_edetabelid')
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
					return;
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'on olemas', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			return;
		end catch;
		
		
		call check_column('v_edetabelid', 'id', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'isik_nimi', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'klubi', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'turniir', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'punkte', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_edetabelid')) = 5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
		
		-- id 71, turniir 43 = 1.5
		begin try
			if 		(select punkte from v_edetabelid where id = 71 and turniir = 43) = 1.5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabel" Mets, Arvo punktid turniiril 43', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
		
		begin try
			if 		(select punkte from v_edetabelid where id = 157 and turniir = 43) = 0.0
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets Arvo punktid turniiril 43', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets Arvo punktid turniiril 43', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Kirves Kristi punktid turniiril 43', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
	end;
	
create procedure view_punktid()
	begin
		-- vaade v_punktid
		begin try
			if 		not exists (select * from systable where table_name = 'v_punktid')
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
					return;
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'on olemas', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			return;
		end catch;
		
		call check_column('v_punktid', 'partii', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_punktid', 'turniir', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_punktid', 'mangija', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_punktid', 'varv', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_punktid', 'punkt', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_punktid')) = 5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
		
		-- select * from v_punktid where (partii = 1 and mangija = 73 and turniir = 41)or (partii = 2 and mangija = 77)
		begin try
			if 		(select punkt from v_punktid where partii = 1 and mangija = 73 and turniir = 41) = 0.5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
		
		begin try
			if 		(select punkt from v_punktid where partii = 2 and mangija = 77 and turniir = 41) = 1.0
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'on õige', 'OK', praktikum_5, praktikum_5, '', praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, '', praktikum_5_jr);
		end catch;
	end;


		
	
create 	procedure function_liida()
	begin
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'f_liida') 
			then	insert Staatus values('Kodutöö', 'Funktsioon "f_liida"', 'ei ole olemas','VIGA', kodutöö_5_f_liida*0, kodutöö_5_f_liida, '', kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Funktsioon "f_liida"', 'on olemas','OK', kodutöö_5_f_liida_olemasolu, kodutöö_5_f_liida_olemasolu, '', kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade Funktsioon "f_liida"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_liida*0, kodutöö_5_f_liida, '', kodutöö_5_jr);
			return;
		end catch;
		
		begin try
			if 		f_liida(100,100) = 200
			then	insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'on õige','OK', kodutöö_5_f_liida_tulemus, kodutöö_5_f_liida_tulemus, '', kodutöö_5_jr)
			else	insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'on vale','VIGA', kodutöö_5_f_liida_tulemus*0, kodutöö_5_f_liida_tulemus, '', kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_liida_tulemus*0, kodutöö_5_f_liida_tulemus, '', kodutöö_5_jr);
		end catch;
		
	end;
	
	
create 	procedure function_klubisuurus()
	begin
	begin try
		if 		not exists (select * from sysprocedure where proc_name = 'f_klubisuurus') 
		then	insert Staatus values('Kodutöö', 'Funktsioon "f_klubisuurus"', 'ei ole olemas', 'VIGA', kodutöö_5_f_klubisuurus*0, kodutöö_5_f_klubisuurus, '', kodutöö_5_jr);
		return;
		else 	insert Staatus values('Kodutöö', 'Funktsioon "f_klubisuurus"', 'on olemas', 'OK', kodutöö_5_f_klubisuurus_olemasolu, kodutöö_5_f_klubisuurus, '', kodutöö_5_jr);
		endif;
	end try
	begin catch
		insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_klubisuurus*0, kodutöö_5_f_klubisuurus, '', kodutöö_5_jr);
		return;
	end catch;

	begin try
		if 		f_klubisuurus(51) = 4
		then	insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus" klubi "" suurus', 'on õige', 'OK', kodutöö_5_f_klubisuurus_tulemus, kodutöö_5_f_klubisuurus_tulemus, '', kodutöö_5_jr)
		else	insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus" klubi "" suurus', 'on vale', 'VIGA', kodutöö_5_f_klubisuurus_tulemus*0, kodutöö_5_f_klubisuurus_tulemus, '', kodutöö_5_jr)
		endif;
	end try
	begin catch
		insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_klubisuurus_tulemus*0, kodutöö_5_f_klubisuurus_tulemus, '', kodutöö_5_jr);
	end catch;
	end;

create 	procedure procedure_uus_isik()
	begin
		declare nimi varchar(50);
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_uus_isik') 
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik"', 'ei ole olemas', 'VIGA', kodutöö_5_sp_uus_isik*0, kodutöö_5_sp_uus_isik, '', kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik"', 'on olemas', 'OK', kodutöö_5_sp_uus_isik_olemasolu, kodutöö_5_sp_uus_isik_olemasolu, '', kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Protseduur "sp_uus_isik"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_uus_isik*0, kodutöö_5_sp_uus_isik, '', kodutöö_5_jr);
			return;
		end catch;

		-- Eesnimi, perenimi, klubi_id
		begin try
			create or replace variable isiku_id int;
			call 	sp_uus_isik('Test_ees', 'Test_pere', 51, isiku_id);
			select 	eesnimi into nimi from isikud where eesnimi = 'Test_ees';
			
			if 		(select eesnimi from isikud where eesnimi = 'Test_ees') = 'Test_ees'
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik" uus isik', 'on lisatud', 'OK', kodutöö_5_sp_uus_isik_tulemus, kodutöö_5_sp_uus_isik_tulemus, '', kodutöö_5_jr)
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik" uus isik', 'ei ole lisatud', 'VIGA', kodutöö_5_sp_uus_isik_tulemus*0, kodutöö_5_sp_uus_isik_tulemus, '', kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_uus_isik_tulemus*0, kodutöö_5_sp_uus_isik_tulemus, '', kodutöö_5_jr)
		end catch;

		delete	from isikud where eesnimi = 'Test_ees';

	end;



create	procedure procedure_top10()
	begin
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_top10') 
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_top10"', 'ei ole olemas', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, '', kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_top10"', 'on olemas', 'OK', kodutöö_5_sp_top10_olemasolu, kodutöö_5_sp_top10_olemasolu, '', kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Protseduur "sp_top10"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, '', kodutöö_5_jr);
		end catch;

		begin try
			create	table #Temp (id integer not null default autoincrement, mangija varchar(102), punkte numeric(5,1));
			unload 	select * from sp_top10(41) to 'C:\\TEMP\\kodutoo_check.txt' ENCODING 'UTF-8';
			load 	table #Temp (mangija, punkte) from 'C:\\TEMP\\kodutoo_check.txt' defaults on;

			if 		(select mangija from #Temp where id = 1) = 'Maasikas, Malle' 
			then  	insert 	Staatus values('Kodutöö ', 'Protseduur "sp_top10" sp_top10(41), esimene koht = Maasikas, Malle', '-', 'OK', kodutöö_5_sp_top10, kodutöö_5_sp_top10, '', kodutöö_5_jr)
			else	insert 	Staatus values('Kodutöö', 'sp_top10(41), esimene koht = Maasikas, Malle', 'Kirjete või veergude järjestus on vale.', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, 'Kas nime kirjapilt õige?', kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert 	Staatus values('Protseduur "sp_top10"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli protseduuri.', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, '', kodutöö_5_jr)
		end catch;
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
		
		if versioon >= 4 then
			call view_turniiripartiid();
			call view_klubipartiikogused();
			call view_keskminepartii();
			call m_view_keskminepartii();
		endif;

		if versioon >= 5 then
			call view_edetabelid();
			call view_punktid();
			call function_liida();
			call function_klubisuurus();
			call procedure_uus_isik();
			call procedure_top10();
		endif;
		
		call arvuta_punktid(versioon);
		
		
		if versioon >= 5 then
			call function_liida();
			call function_klubisuurus();
			call procedure_uus_isik();
			call procedure_top10();
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