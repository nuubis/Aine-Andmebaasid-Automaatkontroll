if exists (select * from sysprocedure where proc_name = 'f_klubisuurus') then drop function f_klubisuurus endif;
create function f_klubisuurus(a_id integer) 
returns integer 
begin 
declare suurus int; 
select count(*) into suurus from isikud where klubi = a_id; 
return suurus; 
end;

if exists (select * from sysprocedure where proc_name = 'f_nimi') then drop function f_nimi endif;
create function f_nimi(e_nimi varchar(50), p_nimi varchar(50)) 
returns varchar(102) 
begin 
return p_nimi || ', ' || e_nimi; 
end;

if exists (select * from sysprocedure where proc_name = 'f_mangija_koormus') then drop function f_mangija_koormus endif;
create function f_mangija_koormus(a_id int) 
returns int 
begin 
declare koormus int; 
select count(*) into koormus from partiid where a_id = must or a_id = valge; 
return koormus; 
end;

if exists (select * from sysprocedure where proc_name = 'f_mangija_voite_turniiril') then drop function f_mangija_voite_turniiril endif;
create function f_mangija_voite_turniiril (isik_id int, turniir_id int) 
returns integer 
begin 
declare voite int; 
select count(*) into voite from v_punktid where turniir = turniir_id and mangija = isik_id and punkt = 1.0;
return voite; 
end;

if exists (select * from sysprocedure where proc_name = 'f_mangija_kaotusi_turniiril') then drop function f_mangija_kaotusi_turniiril endif;
// lisa funktsioon sp_voit_viik_kaotus jaoks
create function f_mangija_kaotusi_turniiril (isik_id int, turniir_id int)
returns int
begin
declare viike int;
select count(*) into viike from partiid
where turniir_id = turniir and ((isik_id = must and musta_tulemus = 0) 
or (isik_id = valge and  valge_tulemus = 0));
return viike;
end;

if exists (select * from sysprocedure where proc_name = 'f_mangija_viike_turniiril') then drop function f_mangija_viike_turniiril endif;
// lisa funktsioon sp_voit_viik_kaotus jaoks
create function f_mangija_viike_turniiril (isik_id int, turniir_id int)
returns int
begin
declare viike int;
select count(*) into viike from partiid
where turniir_id = turniir and ((isik_id = must and musta_tulemus = 1) 
or (isik_id = valge and  valge_tulemus = 1));
return viike;
end;

if exists (select * from sysprocedure where proc_name = 'f_mangija_punktid_turniiril') then drop function f_mangija_punktid_turniiril endif;
create function f_mangija_punktid_turniiril (isik_id int, turniir_id int) 
returns float 
begin 
declare punktid float; 
select sum(if isik_id = valge then valge_tulemus else musta_tulemus endif)/2.0 
into punktid from partiid where (isik_id = must or isik_id = valge) and turniir_id = Turniir; 
return punktid; 
end;

if exists (select * from sysprocedure where proc_name = 'sp_uus_isik') then drop procedure sp_uus_isik endif;
create procedure sp_uus_isik (in e_nimi varchar(50), in p_nimi varchar(50), in klubi_id int, out a_id int) 
begin 
declare i_id int;
INSERT INTO isikud (Eesnimi, Perenimi, Isikukood, Klubi) VALUES (e_nimi , p_nimi, null, klubi_id); 
select @@identity into i_id;
set a_id = i_id;
end;

if exists (select * from sysprocedure where proc_name = 'sp_infopump') then drop procedure sp_infopump endif;
create procedure sp_infopump() 
result( nimi varchar(200), suurus int) 
begin 
select nimi as nimi, f_klubisuurus(id) as suurus, 1 as järjestus
from klubid
union all 
select nimi as nimi, count(*), 2 
from turniirid join partiid
group by nimi
union all 
select f_nimi(eesnimi, perenimi), f_mangija_koormus(id), 3 
from isikud
order by järjestus, nimi asc
end;

if exists (select * from sysprocedure where proc_name = 'sp_top10') then drop procedure sp_top10 endif;
create procedure sp_top10 (turniiri_id int)
begin 
select top 10 mangija, punkte from v_edetabelid where turniir = turniiri_id
order by punkte desc;
end;


if exists (select * from sysprocedure where proc_name = 'f_enimi') then drop procedure f_enimi endif;
create function f_enimi(isiku_id int)
returns varchar(50)
begin
declare nimi varchar(50);
select Eesnimi into nimi from isikud where id = isiku_id;
return nimi;
end;

if exists (select * from sysprocedure where proc_name = 'f_pnimi') then drop procedure f_pnimi endif;
create function f_pnimi(isiku_id int)
returns varchar(50)
begin
declare nimi varchar(50);
select Perenimi into nimi from isikud where id = isiku_id;
return nimi;
end;

if exists (select * from sysprocedure where proc_name = 'sp_voit_viik_kaotus') then drop procedure sp_voit_viik_kaotus endif;
create procedure sp_voit_viik_kaotus(turniir_id int) 
result( id int, eesnimi varchar(50), perenimi varchar(50), voite int, viike int, kaotusi int) 
begin 
select distinct mangija as id, f_enimi(mangija) as eesnimi, f_pnimi(mangija) as perenimi,
f_mangija_voite_turniiril(mangija, turniir_id) as voite, 
f_mangija_viike_turniiril(mangija, turniir_id) as viike, 
f_mangija_kaotusi_turniiril(mangija, turniir_id) as kaotusi 
from v_punktid where turniir = turniir_id;
end;

if exists (select * from sysindex where index_name = 'turniir_algus') then drop index turniir_algus endif;
create index turniir_algus on turniirid (Alguskuupaev);

if exists (select * from sysindex where index_name = 'partii_must_indeks') then drop index partii_must_indeks endif;
create index partii_must_indeks on partiid (musta_tulemus desc);

if exists (select * from sysindex where index_name = 'partii_valge_indeks') then drop index partii_valge_indeks endif;
create index partii_valge_indeks on partiid (valge_tulemus desc);