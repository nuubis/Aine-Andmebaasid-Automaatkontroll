create or replace procedure kustuta_vaated() as $$
begin

	if exists (select * from pg_matviews where matviewname = 'mv_edetabelid') then 
		drop materialized view mv_edetabelid;
	end if;
	
	if exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega') then 
		drop materialized view mv_partiide_arv_valgetega;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_edetabelid') then 
		drop view v_edetabelid;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_partiidpisi') then 
		drop view v_partiidpisi;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_partiid') then 
		drop view v_partiid;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_turniiripartiid') then 
		drop view v_turniiripartiid cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_klubipartiikogused') then 
		drop view v_klubipartiikogused cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_keskminepartii') then 
		drop view v_keskminepartii cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_turniiripartiid') then 
		drop view v_turniiripartiid cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_isikudklubid') then 
		drop view v_isikudklubid cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_punktid') then 
		drop view v_punktid cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_klubi54') then 
		drop view v_klubi54 cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_maletaht') then 
		drop view v_maletaht cascade;
	end if;
	
	
	-- Edu
	
	if exists (select * from information_schema.tables where table_name = 'v_persons_atleast_4eap') then 
		drop view v_persons_atleast_4eap cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_countofa') then 
		drop view v_countofa cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_top40a') then 
		drop view v_top40a cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_institute_deans') then 
		drop view v_institute_deans cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_oigusteaduskonna_inimesed') then 
		drop view v_oigusteaduskonna_inimesed cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_persons_institute') then 
		drop view v_persons_institute cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_top20students') then 
		drop view v_top20students cascade;
	end if;
	
end;
$$ LANGUAGE plpgsql;


create or replace procedure kustuta_tabelid () as $$
begin
	if 	exists (select * from information_schema.tables where table_name = 'inimesed') then
		drop table inimesed cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'partiid') then
		drop table partiid cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'isikud') then
		drop table isikud cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'klubid') then
		drop table klubid cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'turniirid') then
		drop table turniirid cascade;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'asulad') then
		drop table asulad cascade;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'riigid') then
		drop table riigid cascade;
	end if;
	
	-- Edu
	if 	exists (select * from information_schema.tables where table_name = 'registrations') then
		drop table registrations cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'persons') then
		drop table persons cascade;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'lecturers') then
		drop table lecturers cascade;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'institutes') then
		drop table institutes cascade;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'courses') then
		drop table courses cascade;
	end if;
	

	
end;
$$ LANGUAGE plpgsql;

create or replace procedure kustuta_funk_ja_prot () as $$
begin
	if exists (select routine_name from information_schema.routines where routine_type = 'PROCEDURE' and routine_name = 'sp_uus_turniir') then drop procedure sp_uus_turniir cascade; end if;
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_vanus') then drop function f_vanus(date) cascade; end if;
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_vanus') then drop function f_vanus(varchar) cascade; end if;
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_klubiranking') then drop function f_klubiranking cascade; end if;
	if exists (select routine_name from information_schema.routines where routine_type = 'FUNCTION' and routine_name = 'f_top10') then drop function f_top10 cascade; end if;
	
end;
$$ LANGUAGE plpgsql;

create or replace procedure kustuta () as $$
begin
	call kustuta_vaated();
	call kustuta_tabelid();
	call kustuta_funk_ja_prot();
end;
$$ LANGUAGE plpgsql;
SET client_min_messages TO WARNING;
call kustuta();
SET client_min_messages TO NOTICE;