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
begin
	select taisarv into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	if versioon = 3 then 
		kodu_max_punktid := 1.0;
		select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutoo 3';
		insert into Staatus values ('Kodutoo 3','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;

end;
$$ language plpgsql;


create or replace procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100)) as $$
	begin
		
		if 		exists (select * from information_schema.columns where table_name = a_table_name and column_name = a_column_name)
		then	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
		else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veerg "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
		end if;
		
	exception 
		when others then 
			insert into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'VIGA AUTOMAATKONTROLLIS!', 'VIGA', punktid, punktid, jr);
	
	
	end;
-- call check_column('Turniirid', 'Asukoht', praktikum_2_turniirid_asukoht, praktikum_2_jr, 'Praktikum', 'Tabel');
$$ language plpgsql;

create or replace procedure kodutoo_3() as $$ -- punktid kokku 2p: 1-5. ül. 0.5p, 6 ül. 0.75p, 7.ül 0.75p 
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
	if 		(select count(*) from inimesed) > 0
	then 	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on olemas', 'OK', kodutoo_3_inimesed_andmed, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
	else	insert into Staatus values ('Kodutoo 3', 'Tabel "Inimesed" andmed', 'on puudu', 'VIGA', kodutoo_3_inimesed_andmed*0, kodutoo_3_inimesed_andmed, kodutoo_3_jr);
	end if;
	
	-- 2. Turniirid veerg asula
	call check_column('turniirid', 'asula', kodutoo_3_turniirid_asula, kodutoo_3_jr, 'Kodutoo 3', 'Tabel');
	
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
	
	exception
		when others then
		insert into Staatus values ('Kodutoo 3', '', 'Automaatkontrollis on viga!', 'VIGA', 0*0, 0, kodutoo_3_jr);

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
	if versioon = 3 then 
		call kodutoo_3(); 
	end if;
	
	call arvuta_punktid(versioon);
	
	select min(sisestatud) into aeg from inimesed;
	insert into staatus values ('Tudeng', 	(select eesnimi from inimesed where sisestatud = aeg), 
		(select perenimi from inimesed where sisestatud = aeg), '-', 0, 0, tudeng);
end;
$$ LANGUAGE plpgsql;


call kaivita(3);

Copy (Select ylesanne, kontrolli_nimi, tagasiside, olek, punktid, max_punktid From staatus order by jr asc) To 'C:\TEMP\tulemus.csv' With CSV DELIMITER ',' HEADER;