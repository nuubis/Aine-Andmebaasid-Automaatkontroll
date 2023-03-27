create or replace procedure kustuta_vaated() as $$
begin
	if exists (select * from information_schema.tables where table_name = 'v_turniiripartiid') then 
		drop view v_turniiripartiid cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_klubipartiikogused') then 
		drop view v_klubipartiikogused cascade;
	end if;
	
	if exists (select * from information_schema.tables where table_name = 'v_keskminepartii') then 
		drop view v_keskminepartii cascade;
	end if;
	
	if exists (select * from pg_matviews where matviewname = 'mv_partiide_arv_valgetega') then 
		drop materialized view mv_partiide_arv_valgetega cascade;
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
	
end;
$$ LANGUAGE plpgsql;

create or replace procedure kustuta () as $$
begin
	call kustuta_vaated();
	call kustuta_tabelid();
end;
$$ LANGUAGE plpgsql;
call kustuta();