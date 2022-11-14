create table if not exists muutujad (
nimi varchar(1000) unique,
vaartus int);
delete from muutujad;
copy muutujad from 'C:\TEMP\muutujad.csv' with (format csv, delimiter ',');


create table if not exists Staatus (
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
	select vaartus into kodutoo_jr from muutujad where nimi = 'kodutoo_jr';
	if versioon = 3 then set kodu_max_punktid = 1.0;
		select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö 3';
		insert into Staatus values ('Kodutöö 3','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutoo_jr);
	end if;

end;
$$ language plpgsql;


create or replace procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, 
	jr int, ylesanne varchar(100), olem varchar(100)) as $$
	begin
		
		
		--begin try
			--if 		not exists (select * from syscolumn where column_name = a_column_name and table_id = find_table_id(a_table_name)) 
			--then 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
			--else 	insert 	into Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
			--end if;
		--end try
		--begin catch
			--insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'"', 'Veerukontrollis on viga!', 'VIGA', punktid*0, punktid, jr);
		--end catch;
	
	
	end;
-- call check_column('Turniirid', 'Asukoht', praktikum_2_turniirid_asukoht, praktikum_2_jr, 'Praktikum', 'Tabel');
$$ language plpgsql;

create or replace procedure kodutoo_3() as $$
begin 
	-- Turniirid veerg asula
	call check_column('Turniirid', 'Asula', kodutöö_3_turniirid_asula, kodutöö_3_jr, 'Kodutöö', 'Tabel');
end;	
$$ language plpgsql;


create or replace procedure kaivita (versioon int) as $$
declare aeg timestamp;
tudeng int;
begin 
	select vaartus into tudeng from muutujad where nimi = 'tudeng';
	if versioon = 3 then call kodutoo_3(); 
	end if;
	call arvuta_punktid(versioon);
	select min(sisestatud) into aeg from inimesed;
	insert into staatus values ('Tudeng', 	(select eesnimi from inimesed where sisestatud = aeg), 
		(select perenimi from inimesed where sisestatud = aeg), '-', 0, 0, (select vaartus from muutujad where nimi = 'tudeng'));
end;
$$ LANGUAGE plpgsql;


call kaivita(1);

Copy (Select ylesanne, kontroll, tagasiside, olek, punktid, max_punktid From staatus order by jr asc) To 'C:\TEMP\tulemus.csv' With CSV DELIMITER ',' HEADER;