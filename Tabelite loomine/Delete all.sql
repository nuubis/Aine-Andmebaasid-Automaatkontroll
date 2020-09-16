// Tabelid
if exists (select * from systable where table_name = 'klubid') then drop table klubid endif;
if exists (select * from systable where table_name = 'isikud') then drop table isikud endif;
if exists (select * from systable where table_name = 'turniirid') then drop table turniirid endif;
if exists (select * from systable where table_name = 'partiid') then drop table partiid endif;
if exists (select * from systable where table_name = 'inimesed') then drop table inimesed endif;
if exists (select * from systable where table_name = 'asulad') then drop table asulad endif;

// Vaated
if exists (select * from systable where table_name = 'v_mangijad') then drop view v_mangijad endif;
if exists (select * from systable where table_name = 'v_partiid') then drop view v_partiid endif;
if exists (select * from systable where table_name = 'v_turniiripartiid') then drop view v_turniiripartiid endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused') then drop view v_klubipartiikogused endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused_1') then drop view v_klubipartiikogused_1 endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused_2') then drop view v_klubipartiikogused_2 endif;
if exists (select * from systable where table_name = 'v_punktid') then drop view v_punktid endif;
if exists (select * from systable where table_name = 'v_edetabelid') then drop view v_edetabelid endif;
if exists (select * from systable where table_name = 'v_1') then drop view v_1 endif;
if exists (select * from systable where table_name = 'v_2') then drop view v_2 endif;
if exists (select * from systable where table_name = 'v_3') then drop view v_3 endif;
if exists (select * from systable where table_name = 'v_4') then drop view v_4 endif;
if exists (select * from systable where table_name = 'v_5') then drop view v_5 endif;
if exists (select * from systable where table_name = 'v_6') then drop view v_6 endif;
if exists (select * from systable where table_name = 'v_7') then drop view v_7 endif;
if exists (select * from systable where table_name = 'v_8') then drop view v_8 endif;
if exists (select * from systable where table_name = 'v_9') then drop view v_9 endif;
if exists (select * from systable where table_name = 'v_10') then drop view v_10 endif;
if exists (select * from systable where table_name = 'v_11') then drop view v_11 endif;
if exists (select * from systable where table_name = 'v_12') then drop view v_12 endif;
if exists (select * from systable where table_name = 'v_asulaklubisid') then drop view v_asulaklubisid endif;
if exists (select * from systable where table_name = 'v_asulasuurus') then drop view v_asulasuurus endif;

//Funktsioonid ja protseduurid
if exists (select * from sysprocedure where proc_name = 'f_klubisuurus') then drop function f_klubisuurus endif;
if exists (select * from sysprocedure where proc_name = 'f_nimi') then drop function f_nimi endif;
if exists (select * from sysprocedure where proc_name = 'f_enimi') then drop function f_enimi endif;
if exists (select * from sysprocedure where proc_name = 'f_pnimi') then drop function f_pnimi endif;
if exists (select * from sysprocedure where proc_name = 'f_mangija_koormus') then drop function f_mangija_koormus endif;
if exists (select * from sysprocedure where proc_name = 'f_mangija_voite_turniiril') then drop function f_mangija_voite_turniiril endif;
if exists (select * from sysprocedure where proc_name = 'f_mangija_kaotusi_turniiril') then drop function f_mangija_kaotusi_turniiril endif;
if exists (select * from sysprocedure where proc_name = 'f_mangija_viike_turniiril') then drop function f_mangija_viike_turniiril endif;
if exists (select * from sysprocedure where proc_name = 'f_mangija_punktid_turniiril') then drop function f_mangija_punktid_turniiril endif;
if exists (select * from sysprocedure where proc_name = 'sp_uus_isik') then drop procedure sp_uus_isik endif;
if exists (select * from sysprocedure where proc_name = 'sp_infopump') then drop procedure sp_infopump endif;
if exists (select * from sysprocedure where proc_name = 'sp_top10') then drop procedure sp_top10 endif;
if exists (select * from sysprocedure where proc_name = 'sp_voit_viik_kaotus') then drop procedure sp_voit_viik_kaotus endif;
if exists (select * from sysindex where index_name = 'turniir_algus') then drop index turniir_algus endif;
if exists (select * from sysindex where index_name = 'partii_must_indeks') then drop index partii_must_indeks endif;
if exists (select * from sysindex where index_name = 'partii_valge_indeks') then drop index partii_valge_indeks endif;
if exists (select * from sysprocedure where proc_name = 'sp_kustuta_klubi') then drop procedure sp_kustuta_klubi endif;

//Triggerid
if exists (select * from systrigger where trigger_name = 'tg_lisa_klubi') then drop trigger tg_lisa_klubi endif;
if exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi') then drop trigger tg_kustuta_klubi endif;
if exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi_isikutega') then drop trigger tg_kustuta_klubi_isikutega endif;