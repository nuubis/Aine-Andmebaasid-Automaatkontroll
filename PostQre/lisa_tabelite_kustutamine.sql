create or replace procedure kustuta () as $$

	begin 
	if 	exists (select * from information_schema.tables where table_name = 'inimesed') then
		drop table inimesed;
	end if;

	
	if 	exists (select * from information_schema.tables where table_name = 'partiid') then
		drop table partiid;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'isikud') then
		drop table isikud;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'klubid') then
		drop table klubid;
	end if;
	
	if 	exists (select * from information_schema.tables where table_name = 'turniirid') then
		drop table turniirid;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'asulad') then
		drop table asulad;
	end if;

	if 	exists (select * from information_schema.tables where table_name = 'riigid') then
		drop table riigid;
	end if;
	
end;
$$ LANGUAGE plpgsql;

call kustuta();