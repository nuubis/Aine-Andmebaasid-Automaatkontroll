create or replace procedure kustuta () as $$
DECLARE
   sql_e text;
BEGIN

	for sql_e in 
   		SELECT 'DROP TABLE ' || p.tablename || ' cascade;' 
   		FROM pg_catalog.pg_tables p
   		WHERE  p.schemaname = 'public'
   	loop
   		execute sql_e;
   	end loop;
	
	for sql_e in 
   		SELECT 'DROP VIEW ' || p.viewname || ' cascade;' 
   		FROM pg_catalog.pg_views p
   		WHERE  p.schemaname = 'public'
   	loop
   		execute sql_e;
   	end loop;
	
	for sql_e in 
   		SELECT 'DROP MATERIALIZED VIEW ' || p.matviewname || ' cascade;' 
   		FROM pg_catalog.pg_matviews p
   		WHERE  p.schemaname = 'public'
   	loop
   		execute sql_e;
   	end loop;
	
	for sql_e in 
   		SELECT 'DROP INDEX ' || p.indexname || ';' 
   		FROM pg_catalog.pg_indexes p
   		WHERE  p.schemaname = 'public' and indexname like 'ix%'
   	loop
   		execute sql_e;
   	end loop;
	
   	for sql_e in 
   		SELECT 'DROP FUNCTION ' || p.proname || '(' || oidvectortypes(proargtypes) ||') cascade;' 
   		FROM pg_catalog.pg_namespace n JOIN pg_catalog.pg_proc p ON p.pronamespace = n.oid 
   		WHERE p.prokind = 'f' AND n.nspname = 'public'
   	loop
   		execute sql_e;
   	end loop;
	
	for sql_e in 
   		SELECT 'DROP PROCEDURE ' || p.proname || '(' || oidvectortypes(proargtypes) ||') cascade;' 
   		FROM pg_catalog.pg_namespace n JOIN pg_catalog.pg_proc p ON p.pronamespace = n.oid 
   		WHERE p.prokind = 'p' AND n.nspname = 'public'
   	loop
   		execute sql_e;
   	end loop;
end;
$$ LANGUAGE plpgsql;
call kustuta();