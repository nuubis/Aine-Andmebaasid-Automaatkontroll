-- Muutuja mis määrab, milline kodutöö käivitatakse, 2=praktikum 3(27õn), 3=kodutöö(28õn) 3, 4=kodutöö 4(31õn), 5=kodutöö 5(?õn), 6=kodutöö 6, 7 = eksam
create or replace variable versioon int = 7;

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
if 	exists (select * from sysprocedure where proc_name = 'mv_partiide_arv_valgetega') 						then drop function mv_partiide_arv_valgetega 						endif;
if 	exists (select * from sysprocedure where proc_name = 'function_liida') 						then drop function function_liida 						endif;
if 	exists (select * from sysprocedure where proc_name = 'function_klubisuurus') 						then drop function function_klubisuurus 						endif;
if 	exists (select * from sysprocedure where proc_name = 'procedure_uus_isik') 						then drop function procedure_uus_isik 						endif;
if 	exists (select * from sysprocedure where proc_name = 'procedure_top10') 						then drop function procedure_top10 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_edetabelid') 						then drop function view_edetabelid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_partiid') 						then drop function view_partiid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_isikudklubid') 						then drop function view_isikudklubid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'view_punktid') 						then drop function view_punktid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'kuues_kodutöö') 						then drop function kuues_kodutöö 						endif;
if 	exists (select * from sysprocedure where proc_name = 'trigger_klubi_olemasolu') 						then drop function trigger_klubi_olemasolu 						endif;
if 	exists (select * from sysprocedure where proc_name = 'trigger_partiiaeg') 						then drop function trigger_partiiaeg 						endif;
-- Eksami vaated
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_eelnevussuhe') 						then drop function eksam_view_eelnevussuhe 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_kaotusi_rohkem_yhest') 						then drop function eksam_view_kaotusi_rohkem_yhest 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_must_valge') 						then drop function eksam_view_must_valge 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_kiirviik') 						then drop function eksam_view_kiirviik 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_klubisisesed_viigid') 						then drop function eksam_view_klubisisesed_viigid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_must1') 						then drop function eksam_view_must1 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_nimekiri_partiidest') 						then drop function eksam_view_nimekiri_partiidest 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_rohkem_kolmest') 						then drop function eksam_view_rohkem_kolmest 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_voit_must_valge') 						then drop function eksam_view_voit_must_valge 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_rohkemkahestkaotusest') 						then drop function eksam_view_rohkemkahestkaotusest 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_samaeesnimi') 						then drop function eksam_view_samaeesnimi 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_sama_tahega_nimed') 						then drop function eksam_view_sama_tahega_nimed 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_tulemused') 						then drop function eksam_view_tulemused 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_valge1') 						then drop function eksam_view_valge1 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_vordne_summa') 						then drop function eksam_view_vordne_summa 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_view_vahemalt_kaks_viiki') 						then drop function eksam_view_vahemalt_kaks_viiki 						endif;
-- Eksami funktsioonid
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_must_viik_min') 						then drop function eksam_function_must_viik_min 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_mangija_aeg_turniiril') 						then drop function eksam_function_mangija_aeg_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_turniiril_kolmas') 						then drop function eksam_function_turniiril_kolmas 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_voitja_punktid_turniiril') 						then drop function eksam_function_voitja_punktid_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_lyhema_partii_mangijad') 						then drop function eksam_function_lyhema_partii_mangijad 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_viigimeister') 						then drop function eksam_function_viigimeister 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_parim_klubimangija_turniiril') 						then drop function eksam_function_parim_klubimangija_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_function_eelviimane') 						then drop function eksam_function_eelviimane 						endif;
--Eksami protseduurid
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_ei_manginud') 						then drop function eksam_procedure_ei_manginud 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_koige_rohkem_partiisid_turniiril') 						then drop function eksam_procedure_koige_rohkem_partiisid_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_koige_vahem_partiisid_turniiril') 						then drop function eksam_procedure_koige_vahem_partiisid_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_mustadega_mangija_partiid_turniiril') 						then drop function eksam_procedure_mustadega_mangija_partiid_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_teine_kolmas') 						then drop function eksam_procedure_teine_kolmas 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_turniiri_kokkuvote') 						then drop function eksam_procedure_turniiri_kokkuvote 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_manguaeg_turniiril') 						then drop function eksam_procedure_manguaeg_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_vordne_nime_pikkus') 						then drop function eksam_procedure_vordne_nime_pikkus 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_asula_viigid') 						then drop function eksam_procedure_asula_viigid 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_pikima_partii_mängijad') 						then drop function eksam_procedure_pikima_partii_mangijad 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_valgetega_parem') 						then drop function eksam_procedure_valgetega_parem 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_must_viik') 						then drop function eksam_procedure_must_viik 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_rohkem_kui_2') 						then drop function eksam_procedure_rohkem_kui_2 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_manguaeg_valgetega_turniiril') 						then drop function eksam_procedure_manguaeg_valgetega_turniiril 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_viik_klubikaaslasega') 						then drop function eksam_procedure_viik_klubikaaslasega 						endif;
if 	exists (select * from sysprocedure where proc_name = 'eksam_procedure_vahem_kui_3') 						then drop function eksam_procedure_vahem_kui_3 						endif;


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

create or replace variable kodutöö_6_jr int = 84;
create or replace variable kodutöö_punktid_6_jr int = 85;

create or replace variable eksam_jr int = 94;
create or replace variable eksam_punktid_jr int = 95;
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
create or replace variable kodutöö_2 numeric = 0.7; -- 9 testi, millest 4 = 2 , alates 3: 7 testi, kus 4 = 2, alates 6: 3 testi 
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
create or replace variable kodutöö_5_f_liida numeric = 0.4;
create or replace variable kodutöö_5_f_liida_olemasolu numeric = 0.2;
create or replace variable kodutöö_5_f_liida_tulemus numeric = 0.2;

create or replace variable kodutöö_5_f_klubisuurus numeric = 0.4;
create or replace variable kodutöö_5_f_klubisuurus_olemasolu numeric = 0.2;
create or replace variable kodutöö_5_f_klubisuurus_tulemus numeric = 0.2;

create or replace variable kodutöö_5_sp_uus_isik numeric = 0.4;
create or replace variable kodutöö_5_sp_uus_isik_olemasolu numeric = 0.2;
create or replace variable kodutöö_5_sp_uus_isik_tulemus numeric = 0.2;

create or replace variable kodutöö_5_sp_top10 numeric = 0.4;
create or replace variable kodutöö_5_sp_top10_olemasolu numeric = 0.2;
create or replace variable kodutöö_5_sp_top10_tulemus numeric = 0.2;

-- kodutöö 6 punktid
create or replace variable kodutöö_6 numeric = 2;
create or replace variable kodutöö_6_ix_riiginimi_olemasolu numeric = 0.2;
create or replace variable kodutöö_6_ix_suurus_olemasolu numeric = 0.2;
create or replace variable kodutöö_6_klubitud_olemasolu numeric = 0.18;

create or replace variable kodutöö_6_tg_partiiaeg numeric = 0.5;
create or replace variable kodutöö_6_tg_partiiaeg_olemasolu numeric = 0.25;
create or replace variable kodutöö_6_tg_partiiaeg_tulemus numeric = 0.25;

create or replace variable kodutöö_6_tg_klubiolemasolu numeric = 0.5;
create or replace variable kodutöö_6_tg_klubiolemasolu_olemasolu numeric = 0.25;
create or replace variable kodutöö_6_tg_klubiolemasolu_tulemus numeric = 0.25;

-- Eelenvate praktikumide ja kodutööde punktide väärtuste panemine 0.01 peale
--Praktikum ja kodutöö 2
if 	versioon > 2 then -- 0.10 / 6: 0.08, sest ajakontrolle pole
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
	set kodutöö_3_inimesed_andmed = 0.01;
	set kodutöö_3_turniirid_asula = 0.01;
	set kodutöö_3_turniirid_asula_andmed = 0.01;
	set kodutöö_3_turniirid_asukoht_kustutamine = 0.01;
	set kodutöö_3_välisvõti_turniirid_asulad = 0.01;
	set praktikum_3_tabel_inimene = 0.01;
	set praktikum_3_tabel_asulad = 0.01;
	set praktikum_3_tabel_riigid = 0.01;
	set praktikum_3_riigid_andmed = 0.01;
	set praktikum_3_asulad_andmed = 0.01;
	set praktikum_3_klubid_asula_andmed = 0.01;
	set praktikum_3_klubid_asula = 0.01;
	set praktikum_3_klubid_asukoht_kustutamine = 0.01;
	set praktikum_3_välisvõti_klubid_asulad = 0.01;
endif;

if versioon > 4 then --0.165
	set kodutöö_4_v_turniiripartiid = 0.055;
	set kodutöö_4_v_turniiripartiid_olemasolu = 0.01;
	set kodutöö_4_v_turniiripartiid_turniir_nimi = 0.005;
	set kodutöö_4_v_turniiripartiid_toimumiskoht = 0.005;
	set kodutöö_4_v_turniiripartiid_partii_id = 0.005;
	set kodutöö_4_v_turniiripartiid_partii_algus = 0.005;
	set kodutöö_4_v_turniiripartiid_partii_lopp = 0.005;
	set kodutöö_4_v_turniiripartiid_kes_voitis = 0.005;
	set kodutöö_4_v_turniiripartiid_veergude_arv = 0.005;
	set kodutöö_4_v_turniiripartiid_viigid = 0.005;
	set kodutöö_4_v_turniiripartiid_partii = 0.005;

	-- v_klubipartiikogused
	set kodutöö_4_v_klubipartiikogused = 0.035;
	set kodutöö_4_v_klubipartiikogused_olemasolu = 0.01;
	set kodutöö_4_v_klubipartiikogused_klubi_nimi = 0.005;
	set kodutöö_4_v_klubipartiikogused_partiisid = 0.005;
	set kodutöö_4_v_klubipartiikogused_veergude_arv = 0.005;
	set kodutöö_4_v_klubipartiikogused_areng_kogus = 0.005;
	set kodutöö_4_v_klubipartiikogused_ajurebend_kogus = 0.005;

	-- v_keskminepartii
	set kodutöö_4_v_keskminepartii = 0.035;
	set kodutöö_4_v_keskminepartii_olemasolu = 0.01;
	set kodutöö_4_v_keskminepartii_turniiri_nimi = 0.005;
	set kodutöö_4_v_keskminepartii_keskmine_partii = 0.005;
	set kodutöö_4_v_keskminepartii_veergude_arv = 0.005;
	set kodutöö_4_v_keskminepartii_kirjete_arv = 0.005;
	set kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine = 0.005;

	-- mvpartiide_arv_valgetega
	set kodutöö_4_mv_partiide_arv_valgetega = 0.04;
	set kodutöö_4_mv_partiide_arv_valgetega_olemasolu = 0.01;
	set kodutöö_4_mv_partiide_arv_valgetega_eesnimi = 0.005;
	set kodutöö_4_mv_partiide_arv_valgetega_perenimi = 0.005;
	set kodutöö_4_mv_partiide_arv_valgetega_kogus = 0.005;
	set kodutöö_4_mv_partiide_arv_valgetega_veergude_arv = 0.005;
	set kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur = 0.005;
	set kodutöö_4_mv_partiide_arv_valgetega_artur_muld = 0.005;
endif;

if versioon > 5 then -- 0.04
	set kodutöö_5_f_liida = 0.001;
	set kodutöö_5_f_liida_olemasolu = 0.005;
	set kodutöö_5_f_liida_tulemus = 0.005;

	set kodutöö_5_f_klubisuurus = 0.001;
	set kodutöö_5_f_klubisuurus_olemasolu = 0.005;
	set kodutöö_5_f_klubisuurus_tulemus = 0.005;

	set kodutöö_5_sp_uus_isik = 0.001;
	set kodutöö_5_sp_uus_isik_olemasolu = 0.005;
	set kodutöö_5_sp_uus_isik_tulemus = 0.005;

	set kodutöö_5_sp_top10 = 0.001;
	set kodutöö_5_sp_top10_olemasolu = 0.005;
	set kodutöö_5_sp_top10_tulemus = 0.005;
endif;

-- Eksami punktid
create or replace variable eksam numeric = 7;
create or replace variable eksam_v_eelnevussuhe numeric = 7;
create or replace variable eksam_v_eelnevussuhe_olemasolu numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_partii_id numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_valge numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_must numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_valge_tulemus numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_musta_tulemus numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_veergude_arv numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_kirjete_arv numeric = 0.5;
create or replace variable eksam_v_eelnevussuhe_partii_1_1 numeric = 1;
create or replace variable eksam_v_eelnevussuhe_partii_2_0 numeric = 1;
create or replace variable eksam_v_eelnevussuhe_partii_0_2 numeric = 1;

create or replace variable eksam_v_kaotusi_rohkem_yhest numeric = 7;
create or replace variable eksam_v_kaotusi_rohkem_yhest_olemasolu numeric = 1;
create or replace variable eksam_v_kaotusi_rohkem_yhest_partii_id numeric = 2;
create or replace variable eksam_v_kaotusi_rohkem_yhest_veergude_arv numeric = 1;
create or replace variable eksam_v_kaotusi_rohkem_yhest_kirjete_arv numeric = 1;
create or replace variable eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu numeric = 1;
create or replace variable eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo numeric = 1;

create or replace variable eksam_v_must_valge numeric = 7;
create or replace variable eksam_v_must_valge_olemasolu numeric = 0.5;
create or replace variable eksam_v_must_valge_eesnimi numeric = 0.5;
create or replace variable eksam_v_must_valge_perenimi numeric = 0.5;
create or replace variable eksam_v_must_valge_partiisid_mustadega numeric = 0.5;
create or replace variable eksam_v_must_valge_partiisid_valgetega numeric = 0.5;
create or replace variable eksam_v_must_valge_veergude_arv numeric = 0.5;
create or replace variable eksam_v_must_valge_kirjete_arv numeric = 2;
create or replace variable eksam_v_must_valge_arvo_mets numeric = 1;
create or replace variable eksam_v_must_valge_anneli_mets numeric = 1;

create or replace variable eksam_v_kiirviik numeric = 7;
create or replace variable eksam_v_kiirviik_olemasolu numeric = 1;
create or replace variable eksam_v_kiirviik_valge numeric = 1;
create or replace variable eksam_v_kiirviik_must numeric = 1;
create or replace variable eksam_v_kiirviik_veergude_arv numeric = 1;
create or replace variable eksam_v_kiirviik_kirjete_arv numeric = 1;
create or replace variable eksam_v_kiirviik_tulemus numeric = 2;

create or replace variable eksam_v_klubisisesed_viigid numeric = 7;
create or replace variable eksam_v_klubisisesed_viigid_olemasolu numeric = 1;
create or replace variable eksam_v_klubisisesed_viigid_klubinimi numeric = 1;
create or replace variable eksam_v_klubisisesed_viigid_viike numeric = 1;
create or replace variable eksam_v_klubisisesed_viigid_veergude_arv numeric = 1;
create or replace variable eksam_v_klubisisesed_viigid_kirjete_arv numeric = 1;
create or replace variable eksam_v_klubisisesed_viigid_tulemus numeric = 2;

create or replace variable eksam_v_must1 numeric = 7;
create or replace variable eksam_v_must1_olemasolu numeric = 1;
create or replace variable eksam_v_must1_isikuandmed numeric = 1;
create or replace variable eksam_v_must1_veergude_arv numeric = 1;
create or replace variable eksam_v_must1_kirjete_arv numeric = 1;
create or replace variable eksam_v_must1_tulemus numeric = 3;

create or replace variable eksam_v_nimekiri_partiidest numeric = 7;
create or replace variable eksam_v_nimekiri_partiidest_olemasolu numeric = 0.5;
create or replace variable eksam_v_nimekiri_partiidest_partii_id numeric = 0.5;
create or replace variable eksam_v_nimekiri_partiidest_valge_nimi numeric = 0.5;
create or replace variable eksam_v_nimekiri_partiidest_musta_nimi numeric = 0.5;
create or replace variable eksam_v_nimekiri_partiidest_veergude_arv numeric = 1;
create or replace variable eksam_v_nimekiri_partiidest_kirjete_arv numeric = 1;
create or replace variable eksam_v_nimekiri_partiidest_tulemus numeric = 3;

create or replace variable eksam_v_rohkem_kolmest numeric = 7;
create or replace variable eksam_v_rohkem_kolmest_olemasolu numeric = 1;
create or replace variable eksam_v_rohkem_kolmest_isikuandmed numeric = 1;
create or replace variable eksam_v_rohkem_kolmest_veergude_arv numeric = 1;
create or replace variable eksam_v_rohkem_kolmest_kirjete_arv numeric = 1;
create or replace variable eksam_v_rohkem_kolmest_tulemus numeric = 3;

create or replace variable eksam_v_voit_must_valge numeric = 7;
create or replace variable eksam_v_voit_must_valge_olemasolu numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_eesnimi numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_perenimi numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_partiisid_mustadega numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_partiisid_valgetega numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_veergude_arv numeric = 0.5;
create or replace variable eksam_v_voit_must_valge_kirjete_arv numeric = 1;
create or replace variable eksam_v_voit_must_valge_arvo_mets numeric = 2;
create or replace variable eksam_v_voit_must_valge_toomas_umnik numeric = 1;

-- Protseduurid
create or replace variable eksam_sp_ei_manginud numeric = 7;
create or replace variable eksam_sp_ei_manginud_olemasolu numeric = 1;
create or replace variable eksam_sp_ei_manginud_sander numeric = 2;
create or replace variable eksam_sp_ei_manginud_tatjana numeric = 2;
create or replace variable eksam_sp_ei_manginud_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_ei_manginud_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril numeric = 7;
create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril_olemasolu numeric = 1;
create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril_kalle numeric = 2;
create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril_maari numeric = 2;
create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_koige_vahem_partiisid_turniiril numeric = 7;
create or replace variable eksam_sp_koige_vahem_partiisid_turniiril_olemasolu numeric = 1;
create or replace variable eksam_sp_koige_vahem_partiisid_turniiril_ere1 numeric = 2;
create or replace variable eksam_sp_koige_vahem_partiisid_turniiril_ere2 numeric = 2;
create or replace variable eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril numeric = 7;
create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril_olemasolu numeric = 1;
create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril_isik2 numeric = 2;
create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril_isik3 numeric = 2;
create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_teine_kolmas numeric = 7;
create or replace variable eksam_sp_teine_kolmas_olemasolu numeric = 1;
create or replace variable eksam_sp_teine_kolmas_kalle numeric = 2;
create or replace variable eksam_sp_teine_kolmas_toomas numeric = 2;
create or replace variable eksam_sp_teine_kolmas_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_teine_kolmas_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_turniiri_kokkuvote numeric = 7;
create or replace variable eksam_sp_turniiri_kokkuvote_olemasolu numeric = 1;
create or replace variable eksam_sp_turniiri_kokkuvote_andrei numeric = 2;
create or replace variable eksam_sp_turniiri_kokkuvote_laine numeric = 2;
create or replace variable eksam_sp_turniiri_kokkuvote_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_turniiri_kokkuvote_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_manguaeg_turniiril numeric = 7;
create or replace variable eksam_sp_manguaeg_turniiril_olemasolu numeric = 1;
create or replace variable eksam_sp_manguaeg_turniiril_andrei numeric = 2;
create or replace variable eksam_sp_manguaeg_turniiril_laine numeric = 2;
create or replace variable eksam_sp_manguaeg_turniiril_kirjete_arv44 numeric = 1;
create or replace variable eksam_sp_manguaeg_turniiril_kirjete_arv41 numeric = 1;

create or replace variable eksam_sp_vordne_nime_pikkus numeric = 7;
create or replace variable eksam_sp_vordne_nime_pikkus_olemasolu numeric = 1;
create or replace variable eksam_sp_vordne_nime_pikkus_andrei numeric = 4;
create or replace variable eksam_sp_vordne_nime_pikkus_kirjete_arv44 numeric = 2;

create or replace variable eksam_f_must_viik_min numeric = 7;
create or replace variable eksam_f_must_viik_min_olemasolu numeric = 2;
create or replace variable eksam_f_must_viik_min_tulemus numeric = 5;

create or replace variable eksam_f_mangija_aeg_turniiril numeric = 7;
create or replace variable eksam_f_mangija_aeg_turniiril_olemasolu numeric = 2;
create or replace variable eksam_f_mangija_aeg_turniiril_tulemus numeric = 5;
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
				set kodu_max_punktid = 2;
		endif;
		if		versioon = 6 then
				set kodu_max_punktid = 2;
		endif;
		if versioon = 7 then
				set kodu_max_punktid = 14;
		endif;
		if 		versioon = 2 then
			-- Protsendi arvutamine
			select count(*) into õiged from Staatus where olek = 'OK' and ylesanne = 'Praktikum';
			select count(*) into vead from Staatus where olek = 'VIGA' and ylesanne = 'Praktikum';
			
			-- Praktikumi õiged ja valed
			set kokku = õiged + vead;
			insert into Staatus values ('Praktikum', '-', '-', 'Õiged kokku', õiged, kokku, praktikum_punktid_2_jr);
			insert into Staatus values ('Praktikum', '-', '-', 'Vead Kokku', vead, 0, praktikum_punktid_2_jr);
			
			--Iseseisev punktid
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Iseseisev';
			insert into Staatus values ('Iseseisev','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodutöö_punktid_2_jr);
		endif;
		
		if 		versioon = 3 then
			select sum(punktid) into praks_punktid from staatus where ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Praktikum','-','-', 'Hindepunktid', praks_punktid, praks_max_punktid, praks_lõpp_punktid);
			
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodu_lõpp_punktid);
		endif;
		
		if 		versioon = 4 then
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö' or ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodu_lõpp_punktid);
		endif;
		
		if 		versioon = 5 then
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö' or ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodu_lõpp_punktid);
		endif;
		
		if 		versioon = 6 then
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Kodutöö' or ylesanne = 'Praktikum' or ylesanne = 'Iseseisev';
			insert into Staatus values ('Kodutöö','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodu_lõpp_punktid);
		endif;
		if 		versioon = 7 then
			select sum(punktid) into kodu_punktid from staatus where ylesanne = 'Eksam';
			insert into Staatus values ('Eksam','-','-', 'Hindepunktid', kodu_punktid, kodu_max_punktid, kodu_lõpp_punktid);
		endif;
		
	end;

create procedure check_column(a_table_name varchar(100), a_column_name varchar(100), punktid numeric, jr int,
								ylesanne varchar(100), olem varchar(100))
	begin
		
		begin try
			if 		not exists (select * from syscolumn where column_name = a_column_name and table_id = find_table_id(a_table_name)) 
			then 	insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'ei ole olemas', 'VIGA', punktid*0, punktid, jr);
			else 	insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'" ', 'on olemas', 'OK', punktid, punktid, jr);
			endif;
		end try
		begin catch
			insert 	Staatus values (ylesanne, olem ||' "'||a_table_name||'" Veergu "'||a_column_name||'"', 'Veerukontrollis on viga!', 'VIGA', punktid*0, punktid, jr);
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
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on õige', 'OK', praktikum_2_klubid_100, praktikum_2_klubid_100, praktikum_2_jr);
				else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'on vale', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, praktikum_2_jr);
				endif;
			end try
			begin catch
				case
					when not exists (select * from systable where table_name = 'Klubid')
					then insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'Tabelit "Klubid" pole olemas', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, praktikum_2_jr);
					when not exists (select * from syscolumn where column_name = 'Asukoht' and table_id = find_table_id('Klubid'))
					then insert Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'Veergu "Asukoht" pole olemas', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, praktikum_2_jr);
					else insert Staatus values ('Praktikum', 'Tabelis "Klubid" Veerg "Asukoht" suurus', 'Automaatkontrollis on muu viga!', 'VIGA', praktikum_2_klubid_100*0, praktikum_2_klubid_100, praktikum_2_jr);
				end;
			end catch;
			
		endif;
		
		-- Tabel Isikud perenime muutmine
		begin try
			if 		(select perenimi from isikud where eesnimi = 'Irys') = 'Kompvek'
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isik "Irys" perenime muutmine', 'perenimi on õige', 'OK', praktikum_2_isikud_perenimi, praktikum_2_isikud_perenimi, praktikum_2_jr);
			else 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys" perenime muutmine', 'perenimi on vale', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, praktikum_2_jr);
			endif;
		end try
		begin catch
			case
				when 	not exists (select * from systable where table_name = 'Isikud')
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys" perenime muutmine', 'Tabelit "Isikud" pole olemas', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, praktikum_2_jr);
				when 	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('Isikud'))
				or 		not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('Isikud'))
				then 	insert Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys" perenime muutmine', 'Veergu "eesnimi" või "perenimi" pole olemas', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, praktikum_2_jr);
				else 	insert Staatus values ('Praktikum', 'Tabelis "Isikud" Isiku "Irys" perenime muutmine', 'Automaatkontrollis on muu viga!', 'VIGA', praktikum_2_isikud_perenimi*0, praktikum_2_isikud_perenimi, praktikum_2_jr);
			end;
		end catch;
		
		-- Klubi lisamine
		
		begin try
			if		(select count(*) from klubid where nimi = 'Osav Oda') = 1
			then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" klubi "Osav Oda" lisamine', 'klubi on olemas', 'OK', praktikum_2_uus_klubi, praktikum_2_uus_klubi, praktikum_2_jr);
			else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" klubi "Osav Oda" lisamine', 'klubi on puudu', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, praktikum_2_jr);
			endif;
		end try
		begin catch
			case
				when 	not exists (select * from systable where table_name = 'Klubid')
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" lisamine', 'Tabelit "Klubid" pole olemas', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, praktikum_2_jr);
				when 	not exists (select * from syscolumn where column_name = 'nimi' and table_id = find_table_id('klubid'))
				then 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" lisamine', 'Veergu "Nimi" pole olemas', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, praktikum_2_jr);
				else 	insert 	Staatus values ('Praktikum', 'Tabelis "Klubid" Klubi "Osav Oda" lisamine', 'Automaatkontrollis on muu viga!', 'VIGA', praktikum_2_uus_klubi*0, praktikum_2_uus_klubi, praktikum_2_jr);
			end;
			
		end catch;
		
		-- partii check
		begin try
			insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
			values (41, '2005-01-12 08:02:00.000','2005-01-12 08:19:28.000', 73, 92, 0, 1);
			
			insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendust ei ole', 'VIGA', praktikum_2_vastavus_check*0, 	praktikum_2_vastavus_check, praktikum_2_jr);
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Turniirid')
				then	insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'Tabelit "Turniirid" ei ole olemas', 'VIGA', praktikum_2_vastavus_check*0, 	praktikum_2_vastavus_check, praktikum_2_jr);
				when 	not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('partiid'))
				then	insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'Veergu "Lopphetk" pole olemas', 'VIGA', praktikum_2_vastavus_check*0, 	praktikum_2_vastavus_check, praktikum_2_jr);
				else	insert Staatus values ('Praktikum', 'Tabel "Partiid" check Valge_tulemus + Musta_tulemus', 'kitsendus on olemas', 'OK', 	praktikum_2_vastavus_check, 	praktikum_2_vastavus_check, praktikum_2_jr);
			end;
		end catch;		
	end;


create procedure teine_kodutöö()
	begin
		
		-- Tabel Isikud veerg klubis
		call check_column('Isikud', 'Klubis', kodutöö_2_isikud_klubis, kodutöö_2_jr, 'Kodutöö', 'Tabel');
		
		
		-- Tabel partiid veerg kokkuvõte
		begin try
			if 		exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('partiid')) 
			then 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote"', 'ei ole kustutatud.', 'VIGA', kodutöö_2_partiid_kokkuvõte*0, kodutöö_2_partiid_kokkuvõte, kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veerg "Kokkuvote"', 'on kustutatud.', 'OK', kodutöö_2_partiid_kokkuvõte, kodutöö_2_partiid_kokkuvõte, kodutöö_2_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Partiid')
				then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote"', 'Tabelit "Partiid" ei ole olemas', 'VIGA', kodutöö_2_partiid_kokkuvõte*0, 	kodutöö_2_partiid_kokkuvõte, praktikum_2_jr);
				else	insert 	Staatus values ('Iseseisev', 'Tabel "Partiid" Veergu "Kokkuvote"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_partiid_kokkuvõte*0, kodutöö_2_partiid_kokkuvõte, kodutöö_2_jr);
			end;
			
		end catch;
		
		-- Tabel klubid klubi asukoha muutmine
		begin try
			if 		(select asukoht from klubid where nimi = 'Valge mask') = 'Valga'
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask" asukoha muutmine', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try
				if 		(select asulad.nimi from asulad, klubid where klubid.nimi = 'Valge mask' and klubid.asula = asulad.id) = 'Valga'
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubi "Valge mask" asukoha muutmine', 'asukoht on õige', 'OK', kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask asukoha muutmine"', 'asukoht on vale', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
				endif;
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Klubid')
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'Tabelit "Klubid" ei ole olemas', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('klubid')) and versioon = 3
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'Veergu "Asukoht" ei ole olemas', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
					when	not exists (select * from systable where table_name = 'Asulad') and versioon > 3
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'Tabelit "Asulad" ei ole olemas', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('asulad'))
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'Veergu "Asula" ei ole olemas', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
					else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Klubid" Klubid "Valge mask" asukoha muutmine', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_klubi_asukoha_muutmine*0, kodutöö_2_klubi_asukoha_muutmine, kodutöö_2_jr);
				end;
				
			end catch;
		end catch;
		
		-- Tabel isikud isiku klubi muutmine
		begin try
			if 		(select klubis from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'klubi on õige.', 'OK', kodutöö_2_isiku_klubi_muutmine, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'klubi on vale.', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try 
				if 		(select klubi from isikud where eesnimi = 'Siim' and perenimi = 'Susi') = 51
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'klubi on õige.', 'OK', kodutöö_2_isiku_klubi_muutmine, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'klubi on vale.', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
				endif;
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Isikud')
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'Tabelit "Isikud" ei ole olemas', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('isikud'))
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'Veergu "Eesnimi" ei ole olemas', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('isikud'))
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'Veergu "Perenimi" ei ole olemas', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
					else	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Isiku "Siim Susi" klubi muutmine', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isiku_klubi_muutmine*0, kodutöö_2_isiku_klubi_muutmine, kodutöö_2_jr);
				end;
			end catch;
		end catch;
		
		-- Tabel Isikud lisamine klubisse Osav Oda
		begin try
			if 		(versioon < 5 and (select count(*) from isikud where klubi = (select id from klubid where nimi = 'Osav Oda')) >= 5)
			or		(versioon > 4 and (select count(*) from isikud where klubi = (select id from klubid where nimi = 'Osav Oda')) >= 6)
			
			then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmed on olemas.', 'OK', kodutöö_2_isikute_lisamine, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
			else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmeid ei ole piisavalt lisatud', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
			endif;
		end try
		begin catch
			begin try
				if 		(versioon < 5 and (select count(*) from isikud where klubis = (select id from klubid where nimi = 'Osav Oda')) >= 5)
				or		(versioon > 4 and (select count(*) from isikud where klubis = (select id from klubid where nimi = 'Osav Oda')) >= 6)
				
				then 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmed on olemas.', 'OK', kodutöö_2_isikute_lisamine, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
				else 	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'liikmeid ei ole piisavalt lisatud', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
				endif;
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Isikud')
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'Tabelit "Isikud" ei ole olemas', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'klubis' and table_id = find_table_id('isikud'))
					then	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'Veergu "klubis" ei ole olemas', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
					else	insert 	Staatus values ('Iseseisev', 'Tabelis "Isikud" Klubi "Osav Oda"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_2_isikute_lisamine*0, kodutöö_2_isikute_lisamine, kodutöö_2_jr);
				end;
			end catch;
		end catch;
		
		-- partii check ajakontroll, lopphetk väiksem, l
		if versioon < 6 then
			begin try
				insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
				values (41, '2005-01-12 08:02:00.000','2005-01-12 08:01:28.000', 73, 92, 1, 1);
				
				insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada väiksemat lõpphetke', 	'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_jr);
				delete from partiid where valge_tulemus = 1 and musta_tulemus = 1 and turniir = 41 and valge = 73 and must = 92 and (lopphetk = '2005-01-12 08:01:28.000' or lopphetk is null);
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Partiid')
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Tabelit "Partiid" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('Partiid'))
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Veergu "Lopphetk" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_jr);
					when	exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('Partiid')) and versioon > 2
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Veerg "Kokkuvote" ei ole kustutatud', 'VIGA', kodutöö_2_ajakontroll_lopphetk_väiksem*0, 	kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_jr);
					else 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_ajakontroll_lopphetk_väiksem, kodutöö_2_jr);
				end;
			end catch;
			
			-- lopphetk = algushetk 
			begin try
				insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
				values (41, '2005-01-12 08:02:00.000','2005-01-12 08:02:00.000', 73, 92, 1, 1);
				
				insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'kitsendus ei tohi lubada võrdset algus ja lõpphetke', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_jr);
				delete from partiid where valge_tulemus = 1 and musta_tulemus = 1 and turniir = 41 and valge = 73 and must = 92 and (lopphetk = '2005-01-12 08:02:00.000' or lopphetk is null);
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Partiid')
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Tabelit "Partiid" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, 	kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_jr);
					when	not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('Partiid'))
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Veergu "Lopphetk" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, 	kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_jr);
					when	exists (select * from syscolumn where column_name = 'kokkuvote' and table_id = find_table_id('Partiid')) and versioon > 2
					then	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', 'Veerg "Kokkuvote" ei ole kustutatud', 'VIGA', kodutöö_2_ajakontroll_lopphetk_võrdub*0, 	kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_jr);
					else 	insert Staatus values ('Iseseisev', 'Tabel "Partiid" check Lopphetk > algushetk', '-', 'OK', kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_ajakontroll_lopphetk_võrdub, kodutöö_2_jr);
				end;
			end catch;
		endif;
			
		-- turniirid check	ajakontroll, alguskuupaev suurem kui lopp
		if versioon < 6 then
			begin try
					
				insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1','Kambja','2005-01-13','2005-01-12');
				insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
				delete from turniirid where nimetus = 'Ajakontroll Check1';	
			end try
			begin catch
				begin try
					insert into turniirid (Nimetus,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1',1,'2005-01-13','2005-01-12');
					insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
					
					delete from turniirid where nimetus = 'Ajakontroll Check1';	
				end try
				begin catch
					begin try
						insert into turniirid (Nimi,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1','Kambja','2005-01-13','2005-01-12');
						insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
						delete from turniirid where nimi = 'Ajakontroll Check1';	
					end try
					begin catch
						begin try
							insert into turniirid (Nimi,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check1',1,'2005-01-13','2005-01-12');
							insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'kitsendus ei tohi lubada väiksemat Loppkuupaev', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
							
							delete from turniirid where nimi = 'Ajakontroll Check1';	
						end try
						begin catch
							case
								when	not exists (select * from systable where table_name = 'Turniirid')
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Tabelit "Turniirid" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'alguskuupaev' and table_id = find_table_id('Turniirid'))
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Alguskuupaev" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'loppkuupaev' and table_id = find_table_id('Turniirid'))
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Lopphetk" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('Turniirid')) and versioon = 3
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Asukoht" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('Turniirid')) and versioon > 3
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Asula" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_suurem*0, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
								else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_suurem, 	kodutöö_2_ajakontroll_alguskuupäev_suurem, kodutöö_2_jr);
							end;
						end catch;
					end catch;
				end catch;
			end catch;	
			-- alguskuupaev = loppkupäev
			begin try
				insert into turniirid (Nimetus,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2','Kambja','2005-01-12','2005-01-12');
				insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
				delete from turniirid where nimetus = 'Ajakontroll Check2';
			end try
			begin catch
				begin try
					insert into turniirid (Nimetus,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2',1,'2005-01-12','2005-01-12');
					insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
					delete from turniirid where nimetus = 'Ajakontroll Check2';
				end try
				begin catch
					begin try
						insert into turniirid (Nimi,asukoht,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2','Kambja','2005-01-12','2005-01-12');
						insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
						delete from turniirid where nimi = 'Ajakontroll Check2';
					end try
					begin catch
						begin try
							insert into turniirid (Nimi,asula,Alguskuupaev,Loppkuupaev) values ('Ajakontroll Check2',1,'2005-01-12','2005-01-12');
							insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
							delete from turniirid where nimi = 'Ajakontroll Check2';
						end try
						begin catch
							case
								when	not exists (select * from systable where table_name = 'Turniirid')
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Tabelit "Turniirid" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'alguskuupaev' and table_id = find_table_id('Turniirid'))
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Alguskuupaev" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'loppkuupaev' and table_id = find_table_id('Turniirid'))
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Lopphetk" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('Turniirid')) and versioon = 3
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Asukoht" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
								when	not exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('Turniirid')) and versioon > 3
								then	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', 'Veergu "Asula" ei ole olemas', 'VIGA', kodutöö_2_ajakontroll_alguskuupäev_võrdub*0, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
								else 	insert Staatus values ('Iseseisev', 'Tabel "Turniirid" check Alguskuupaev <= Loppkuupaev', '-',  'OK', 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, 	kodutöö_2_ajakontroll_alguskuupäev_võrdub, kodutöö_2_jr);
							end;
						end catch;
					end catch;
				end catch;
			end catch;
		endif;
		
		
	
	end;


create procedure kolmas_praktikum()
	begin
	
		-- tabeli inimesed kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Inimesed')
			then 	insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_inimene*0, praktikum_3_tabel_inimene, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'on olemas', 'OK', praktikum_3_tabel_inimene, praktikum_3_tabel_inimene, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Inimesed"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_inimene*0, praktikum_3_tabel_inimene, praktikum_3_jr);
		end catch;
		
		-- tabeli asulad kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Asulad')
			then 	insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_asulad*0, praktikum_3_tabel_asulad, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'on olemas', 'OK', praktikum_3_tabel_asulad, praktikum_3_tabel_asulad, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Asulad"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_asulad*0, praktikum_3_tabel_asulad, praktikum_3_jr);
		end catch;
		
		-- tabeli riigid kontroll
		begin try
			if 		not exists (select * from systable where table_name = 'Riigid')
			then 	insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'ei ole olemas', 'VIGA', praktikum_3_tabel_riigid*0, praktikum_3_tabel_riigid, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'on olemas', 'OK', praktikum_3_tabel_riigid, praktikum_3_tabel_riigid, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Riigid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_tabel_riigid*0, praktikum_3_tabel_riigid, praktikum_3_jr);
		end catch;
		
		-- tabeli riigid andmed
		begin try
			if 		(select count(*) from riigid) = 63
			then 	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'on olemas', 'OK', praktikum_3_riigid_andmed, praktikum_3_riigid_andmed, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'on puudu', 'VIGA', praktikum_3_riigid_andmed*0, praktikum_3_riigid_andmed, praktikum_3_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Riigid')
				then	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'Tabelit "Riigid" ei ole olemas', 'VIGA', praktikum_3_riigid_andmed*0, praktikum_3_riigid_andmed, praktikum_3_jr);
				else 	insert Staatus values ('Praktikum', 'Tabel "Riigid" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_riigid_andmed*0, praktikum_3_riigid_andmed, praktikum_3_jr);
			end;
		end catch;
		
		-- tabeli asulad andmed
		begin try
			if 		(select count(*) from asulad) >= 10
			then 	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'on olemas', 'OK', praktikum_3_asulad_andmed, praktikum_3_asulad_andmed, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'on puudu', 'VIGA', praktikum_3_asulad_andmed*0, praktikum_3_asulad_andmed, praktikum_3_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Asulad')
				then	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'Tabelit "Asulad" ei ole olemas', 'VIGA', praktikum_3_asulad_andmed*0, praktikum_3_asulad_andmed, praktikum_3_jr);
				else	insert Staatus values ('Praktikum', 'Tabel "Asulad" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_asulad_andmed*0, praktikum_3_asulad_andmed, praktikum_3_jr);
			end;
			
		end catch;
		
		-- klubid veerg asula
		call check_column('Klubid', 'Asula', praktikum_3_klubid_asula, praktikum_3_jr, 'Praktikum', 'Tabel');
				
		-- klubid veerg asula andmed
		begin try
			if 		(select count(*) from klubid where asula is null and nimi != 'Klubitud') = 0
			then 	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'on olemas', 'OK', praktikum_3_klubid_asula_andmed, praktikum_3_klubid_asula_andmed, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'on puudu', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, praktikum_3_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Klubid')
				then	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'Tabelit "Klubid" ei ole olemas', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, praktikum_3_jr);
				when	not exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('Klubid'))
				then	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'Veergu "Asula" ei ole olemas', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, praktikum_3_jr);
				else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_klubid_asula_andmed*0, praktikum_3_klubid_asula_andmed, praktikum_3_jr);
			end;
			
		end catch;
		
		-- klubid veerg asukoht kustutamine
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('klubid'))
			then 	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asukoht"', 'on kustutatud', 'OK', praktikum_3_klubid_asukoht_kustutamine, praktikum_3_klubid_asukoht_kustutamine, praktikum_3_jr);
			else	insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', praktikum_3_klubid_asukoht_kustutamine*0, praktikum_3_klubid_asukoht_kustutamine, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Tabel "Klubid" veerg "Asukoht"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_klubid_asukoht_kustutamine*0, praktikum_3_klubid_asukoht_kustutamine, praktikum_3_jr);
		end catch;
		
		-- välisvõtme kontroll klubid ja asulad vahel
		begin try
			if 		(select count(foreign_key_id) into count_f_key from sysfkcol where 	foreign_table_id = find_table_id('Klubid') 
					and foreign_column_id = find_column_id('Klubid','Asula') and primary_column_id = find_column_id('Asulad', 'Id')) = 1
			then	insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'on olemas', 'OK', praktikum_3_välisvõti_klubid_asulad, praktikum_3_välisvõti_klubid_asulad, praktikum_3_jr);		
			else	insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'pole olemas vajalike tabelite ja/või veergude vahel', 'VIGA', praktikum_3_välisvõti_klubid_asulad*0, praktikum_3_välisvõti_klubid_asulad, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Välisvõti "fk_klubi_2_asula"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_3_välisvõti_klubid_asulad*0, praktikum_3_välisvõti_klubid_asulad, praktikum_3_jr);
		end catch;

		
	end;
	
create procedure kolmas_kodutöö()
	begin
		-- tabeli inimesed andmed
		begin try
			if 		(select count(*) from inimesed) >= 1
			then 	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'on olemas', 'OK', kodutöö_3_inimesed_andmed, kodutöö_3_inimesed_andmed, kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'on puudu', 'VIGA', kodutöö_3_inimesed_andmed*0, kodutöö_3_inimesed_andmed, kodutöö_3_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Inimesed')
				then	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'Tabelit "Inimesed" ei ole olemas', 'VIGA', kodutöö_3_inimesed_andmed*0, kodutöö_3_inimesed_andmed, kodutöö_3_jr);
				else	insert Staatus values ('Kodutöö', 'Tabel "Inimesed" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_inimesed_andmed*0, kodutöö_3_inimesed_andmed, kodutöö_3_jr);
			end;
			
		end catch;
		
		-- Turniirid veerg asula
		call check_column('Turniirid', 'Asula', kodutöö_3_turniirid_asula, kodutöö_3_jr, 'Kodutöö', 'Tabel');
				
		-- Turniirid veerg asula andmed
		begin try
			if 		(select count(*) from Turniirid where asula is null) = 0
			then 	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'on olemas', 'OK', kodutöö_3_turniirid_asula_andmed, kodutöö_3_turniirid_asula_andmed, kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'on puudu', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, kodutöö_3_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Turniirid')
				then	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'Tabelit "Turniirid" ei ole olemas', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, kodutöö_3_jr);
				when	not exists (select * from syscolumn where column_name = 'asula' and table_id = find_table_id('Turniirid'))
				then	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'Veergu "Asula" ei ole olemas', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, kodutöö_3_jr);
				else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asula" andmed', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_turniirid_asula_andmed*0, kodutöö_3_turniirid_asula_andmed, kodutöö_3_jr);
			end;
			
		end catch;
		
		-- turniirid veerg asukoht kustutamine
		begin try
			if 		not exists (select * from syscolumn where column_name = 'asukoht' and table_id = find_table_id('turniirid'))
			then 	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asukoht"', 'on kustutatud', 'OK', kodutöö_3_turniirid_asukoht_kustutamine, kodutöö_3_turniirid_asukoht_kustutamine, kodutöö_3_jr);
			else	insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asukoht"', 'ei ole kustutatud', 'VIGA', kodutöö_3_turniirid_asukoht_kustutamine*0, kodutöö_3_turniirid_asukoht_kustutamine, kodutöö_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Tabel "Turniirid" veerg "Asukoht"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_turniirid_asukoht_kustutamine*0, kodutöö_3_turniirid_asukoht_kustutamine, kodutöö_3_jr);
		end catch;
		
		-- välisvõti turniirid ja asulad vahel
		begin try
			if 		(select count(foreign_key_id) into count_f_key from sysfkcol where 	foreign_table_id = find_table_id('Turniirid') 
					and foreign_column_id = find_column_id('Turniirid','Asula') and primary_column_id = find_column_id('Asulad', 'Id')) = 1
			then	insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'on olemas', 'OK', kodutöö_3_välisvõti_turniirid_asulad, kodutöö_3_välisvõti_turniirid_asulad, praktikum_3_jr);		
			else	insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'pole olemas vajalike tabelite ja/või veergude vahel', 'VIGA', kodutöö_3_välisvõti_turniirid_asulad*0, kodutöö_3_välisvõti_turniirid_asulad, praktikum_3_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Välisvõti "fk_turniir_2_asula"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_3_välisvõti_turniirid_asulad*0, kodutöö_3_välisvõti_turniirid_asulad, praktikum_3_jr);
		end catch;
		
	end;
	
-- vaade v_turniiripartiid
create procedure view_turniiripartiid()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_turniiripartiid')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'ei ole olemas', 'VIGA', kodutöö_4_v_turniiripartiid*0, kodutöö_4_v_turniiripartiid, kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'on olemas', 'OK', kodutöö_4_v_turniiripartiid_olemasolu, kodutöö_4_v_turniiripartiid_olemasolu, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid*0, kodutöö_4_v_turniiripartiid, kodutöö_4_jr);
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
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'on õige', 'OK', kodutöö_4_v_turniiripartiid_veergude_arv, kodutöö_4_v_turniiripartiid_veergude_arv, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_turniiripartiid_veergude_arv*0, kodutöö_4_v_turniiripartiid_veergude_arv, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid_veergude_arv*0, kodutöö_4_v_turniiripartiid_veergude_arv, kodutöö_4_jr);
		end catch;
		
		-- kes võitis viike
		begin try
			if 		(select count(*) from v_turniiripartiid where kes_voitis = 'viik') > 0
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis', 'viigid on olemas', 'OK', kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis', 'viigid on puudu', 'VIGA', kodutöö_4_v_turniiripartiid_viigid*0, kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'kes_voitis' and table_id = find_table_id('v_turniiripartiid'))
				then	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis', 'Veergu "kes_voitis" ei ole olemas', 'VIGA', kodutöö_4_v_turniiripartiid_viigid*0, kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_jr);
				else 	insert Staatus values ('Kodutöö', 'Vaade "v_turniiripartiid" kes_voitis', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_turniiripartiid_viigid*0, kodutöö_4_v_turniiripartiid_viigid, kodutöö_4_jr);
			end;
		end catch;
	
	end;
	
	
create procedure view_klubipartiikogused()

	begin
		-- vaade v_klubipartiikogused
		begin try
			if 		not exists (select * from systable where table_name = 'v_klubipartiikogused')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'ei ole olemas', 'VIGA', kodutöö_4_v_klubipartiikogused*0, kodutöö_4_v_klubipartiikogused, kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'on olemas', 'OK', kodutöö_4_v_klubipartiikogused_olemasolu, kodutöö_4_v_klubipartiikogused_olemasolu, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused*0, kodutöö_4_v_klubipartiikogused, kodutöö_4_jr);
			return;
		end catch;
		
		-- klubi_nimi, partiisid
		call check_column('v_klubipartiikogused', 'klubi_nimi', kodutöö_4_v_klubipartiikogused_klubi_nimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_klubipartiikogused', 'partiisid', kodutöö_4_v_klubipartiikogused_partiisid, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_klubipartiikogused')) = 2
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_veergude_arv, kodutöö_4_v_klubipartiikogused_veergude_arv, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_veergude_arv*0, kodutöö_4_v_klubipartiikogused_veergude_arv, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_veergude_arv*0, kodutöö_4_v_klubipartiikogused_veergude_arv, kodutöö_4_jr);
		end catch;
		
		-- klubi Areng kogus 33
		begin try
			if 		(select partiisid from v_klubipartiikogused where klubi_nimi = 'Areng') >= 33
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_areng_kogus*0, kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'klubi_nimi' and table_id = find_table_id('v_klubipartiikogused'))
				then	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'Veergu "klubi_nimi" ei ole olemas', 'VIGA', kodutöö_4_v_klubipartiikogused_areng_kogus*0, kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_jr);
				else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Areng" partiide arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_areng_kogus*0, kodutöö_4_v_klubipartiikogused_areng_kogus, kodutöö_4_jr);
			end;
			
		end catch;
		
		-- klubi Ajurebend kogus 70
		begin try
			if 		(select partiisid from v_klubipartiikogused where klubi_nimi = 'Ajurebend') >= 70
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'on õige', 'OK', kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'on vale', 'VIGA', kodutöö_4_v_klubipartiikogused_ajurebend_kogus*0, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'klubi_nimi' and table_id = find_table_id('v_klubipartiikogused'))
				then	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'Veergu "klubi_nimi" ei ole olemas', 'VIGA', kodutöö_4_v_klubipartiikogused_ajurebend_kogus*0, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_jr);
				else	insert Staatus values ('Kodutöö', 'Vaade "v_klubipartiikogused" klubi "Ajurebend" partiide arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_klubipartiikogused_ajurebend_kogus*0, kodutöö_4_v_klubipartiikogused_ajurebend_kogus, kodutöö_4_jr);
			end;
			
		end catch;
		
		
	end;
	
create procedure view_keskminepartii()

	begin
		-- vaade v_keskminepartii
		begin try
			if 		not exists (select * from systable where table_name = 'v_keskminepartii')
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'ei ole olemas', 'VIGA', kodutöö_4_v_keskminepartii*0, kodutöö_4_v_keskminepartii, kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'on olemas', 'OK', kodutöö_4_v_keskminepartii_olemasolu, kodutöö_4_v_keskminepartii_olemasolu, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_olemasolu*0, kodutöö_4_v_keskminepartii_olemasolu, kodutöö_4_jr);
		end catch;
		
		-- turniiri_nimi ja keskmine_partii
		call check_column('v_keskminepartii', 'turniiri_nimi', kodutöö_4_v_keskminepartii_turniiri_nimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('v_keskminepartii', 'keskmine_partii', kodutöö_4_v_keskminepartii_keskmine_partii, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_keskminepartii')) = 2
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'on õige', 'OK', kodutöö_4_v_keskminepartii_veergude_arv, kodutöö_4_v_keskminepartii_veergude_arv, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_veergude_arv*0, kodutöö_4_v_keskminepartii_veergude_arv, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_veergude_arv*0, kodutöö_4_v_keskminepartii_veergude_arv, kodutöö_4_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_keskminepartii) >= 5
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'on õige', 'OK', kodutöö_4_v_keskminepartii_kirjete_arv, kodutöö_4_v_keskminepartii_kirjete_arv, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_kirjete_arv*0, kodutöö_4_v_keskminepartii_kirjete_arv, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_kirjete_arv*0, kodutöö_4_v_keskminepartii_kirjete_arv, kodutöö_4_jr);
		end catch;
		
		-- kolme klub kohtumine 23,04
		begin try
			if 		(select keskmine_partii from v_keskminepartii where turniiri_nimi = 'Kolme klubi kohtumine') = 23.04
			then 	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'on õige', 'OK', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'on vale', 'VIGA', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine*0, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'turniiri_nimi' and table_id = find_table_id('v_keskminepartii'))
				then	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'Veergu "turniiri_nimi" ei ole olemas', 'VIGA', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine*0, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_jr);
				else	insert Staatus values ('Kodutöö', 'Vaade "v_keskminepartii" turniiri "Kolme klubi kohtumine" keskmine partii', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine*0, kodutöö_4_v_keskminepartii_kolme_klubi_kohtumine, kodutöö_4_jr);
			end;
			
		end catch;
		
	end;
	
create procedure mv_partiide_arv_valgetega()

	begin
		-- vaade mv_partiide_arv_valgetega
		begin try
			if 		not exists (select * from systable where table_name = 'mv_partiide_arv_valgetega')
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega*0, kodutöö_4_mv_partiide_arv_valgetega, kodutöö_4_jr);
					return;
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'on olemas', 'OK', kodutöö_4_mv_partiide_arv_valgetega_olemasolu, kodutöö_4_mv_partiide_arv_valgetega_olemasolu, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_olemasolu*0, kodutöö_4_mv_partiide_arv_valgetega_olemasolu, kodutöö_4_jr);
		end catch;
		
		call check_column('mv_partiide_arv_valgetega', 'eesnimi', kodutöö_4_mv_partiide_arv_valgetega_eesnimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('mv_partiide_arv_valgetega', 'perenimi', kodutöö_4_mv_partiide_arv_valgetega_perenimi, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		call check_column('mv_partiide_arv_valgetega', 'partiisid_valgetega', kodutöö_4_mv_partiide_arv_valgetega_kogus, kodutöö_4_jr, 'Kodutöö', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('mv_partiide_arv_valgetega')) = 3
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv*0, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, kodutöö_4_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_veergude_arv*0, kodutöö_4_mv_partiide_arv_valgetega_veergude_arv, kodutöö_4_jr);
		end catch;
		
		begin try
			refresh materialized view mv_partiide_arv_valgetega;
		end try
		begin catch
		end catch;
				
		-- 0
		begin try
			if 		(select partiisid_valgetega from mv_partiide_arv_valgetega where eesnimi = 'Vahur' and perenimi = 'Kahur') = 0
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('mv_partiide_arv_valgetega'))
				then	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'Veergu "eesnimi" ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('mv_partiide_arv_valgetega'))
				then	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'Veergu "perenimi" ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_jr);
				else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Vahur Kahur" valgete võitude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur*0, kodutöö_4_mv_partiide_arv_valgetega_vahur_kahur, kodutöö_4_jr);
			end;
			
		end catch;
		
		-- 14
		begin try
			if 		(select partiisid_valgetega from mv_partiide_arv_valgetega where eesnimi = 'Artur' and perenimi = 'Muld') = 14
			then 	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'on õige', 'OK', kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_jr);
			else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'on vale', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('mv_partiide_arv_valgetega'))
				then	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'Veergu "eesnimi" ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('mv_partiide_arv_valgetega'))
				then	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'Veergu "perenimi" ei ole olemas', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_jr);
				else	insert Staatus values ('Kodutöö', 'Vaade "mv_partiide_arv_valgetega" "Artur Muld" valgete võitude arv', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_4_mv_partiide_arv_valgetega_artur_muld*0, kodutöö_4_mv_partiide_arv_valgetega_artur_muld, kodutöö_4_jr);
			end;
		end catch;
		
	end;

create procedure view_edetabelid()
	begin
		-- vaade v_edetabel
		begin try
			if 		not exists (select * from systable where table_name = 'v_edetabelid')
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
					return;
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'on olemas', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabelid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			return;
		end catch;
		
		
		call check_column('v_edetabelid', 'id', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'mangija', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'klubi', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'turniir', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		call check_column('v_edetabelid', 'punkte', praktikum_5, praktikum_5_jr, 'Praktikum', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_edetabelid')) = 5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
		end catch;
		
		-- id 71, turniir 43 = 1.5
		begin try
			if 		(select punkte from v_edetabelid where id = 71 and turniir = 43) = 1.5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'id' and table_id = find_table_id('v_edetabelid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'Veergu "id" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'turniir' and table_id = find_table_id('v_edetabelid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'Veergu "turniir" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets, Arvo punktid turniiril 43', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			end;
			
		end catch;
		
		begin try
			if 		(select punkte from v_edetabelid where id = 157 and turniir = 43) = 0.0
			then 	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets Arvo punktid turniiril 43', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Mets Arvo punktid turniiril 43', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'id' and table_id = find_table_id('v_edetabelid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Kirves Kristi punktid turniiril 43', 'Veergu "id" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'turniir' and table_id = find_table_id('v_edetabelid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Kirves Kristi punktid turniiril 43', 'Veergu "turniir" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				else	insert Staatus values ('Praktikum', 'Vaade "v_edetabelid" Kirves Kristi punktid turniiril 43', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			end;
			
		end catch;
	end;
	
create procedure view_punktid()
	begin
		-- vaade v_punktid
		begin try
			if 		not exists (select * from systable where table_name = 'v_punktid')
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
					return;
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'on olemas', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid"', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
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
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Praktikum', 'Vaade "v_punktid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
		end catch;
		
		-- select * from v_punktid where (partii = 1 and mangija = 73 and turniir = 41)or (partii = 2 and mangija = 77)
		begin try
			if 		(select punkt from v_punktid where partii = 1 and mangija = 73 and turniir = 41) = 0.5
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'partii' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'Veergu "partii" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'mangija' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'Veergu "mangija" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'turniir' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'Veergu "turniir" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" esimene partii mangija 73 punktid', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			end;
			
		end catch;
		
		begin try
			if 		(select punkt from v_punktid where partii = 2 and mangija = 77 and turniir = 41) = 1.0
			then 	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'on õige', 'OK', praktikum_5, praktikum_5, praktikum_5_jr);
			else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'on vale', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'partii' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'Veergu "partii" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'mangija' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'Veergu "mangija" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				when	not exists (select * from syscolumn where column_name = 'turniir' and table_id = find_table_id('v_punktid'))
				then	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'Veergu "turniir" ei ole olemas', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
				else	insert Staatus values ('Praktikum', 'Vaade "v_punktid" teine partii mangija 77 punktid', 'Automaatkontrollis on viga!', 'VIGA', praktikum_5*0, praktikum_5, praktikum_5_jr);
			end;
			
		end catch;
	end;


		
	
create 	procedure function_liida()
	begin
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'f_liida') 
			then	insert Staatus values('Kodutöö', 'Funktsioon "f_liida"', 'ei ole olemas','VIGA', kodutöö_5_f_liida*0, kodutöö_5_f_liida, kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Funktsioon "f_liida"', 'on olemas','OK', kodutöö_5_f_liida_olemasolu, kodutöö_5_f_liida_olemasolu, kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Vaade Funktsioon "f_liida"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_liida*0, kodutöö_5_f_liida, kodutöö_5_jr);
			return;
		end catch;
		
		begin try
			if 		f_liida(100,100) = 200
			then	insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'on õige','OK', kodutöö_5_f_liida_tulemus, kodutöö_5_f_liida_tulemus, kodutöö_5_jr)
			else	insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'on vale','VIGA', kodutöö_5_f_liida_tulemus*0, kodutöö_5_f_liida_tulemus, kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Funktsioon "f_liida" 100 + 100 tulemus', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_liida_tulemus*0, kodutöö_5_f_liida_tulemus, kodutöö_5_jr);
		end catch;
		
	end;
	
	
create 	procedure function_klubisuurus()
	begin
	begin try
		if 		not exists (select * from sysprocedure where proc_name = 'f_klubisuurus') 
		then	insert Staatus values('Kodutöö', 'Funktsioon "f_klubisuurus"', 'ei ole olemas', 'VIGA', kodutöö_5_f_klubisuurus*0, kodutöö_5_f_klubisuurus, kodutöö_5_jr);
		return;
		else 	insert Staatus values('Kodutöö', 'Funktsioon "f_klubisuurus"', 'on olemas', 'OK', kodutöö_5_f_klubisuurus_olemasolu, kodutöö_5_f_klubisuurus_olemasolu, kodutöö_5_jr);
		endif;
	end try
	begin catch
		insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_klubisuurus*0, kodutöö_5_f_klubisuurus, kodutöö_5_jr);
		return;
	end catch;

	begin try
		if 		f_klubisuurus(51) = 4
		then	insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus" klubi "Laudnikud" suurus', 'on õige', 'OK', kodutöö_5_f_klubisuurus_tulemus, kodutöö_5_f_klubisuurus_tulemus, kodutöö_5_jr)
		else	insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus" klubi "Laudnikud" suurus', 'on vale', 'VIGA', kodutöö_5_f_klubisuurus_tulemus*0, kodutöö_5_f_klubisuurus_tulemus, kodutöö_5_jr)
		endif;
	end try
	begin catch
		insert Staatus values ('Kodutöö', 'Funktsioon "f_klubisuurus" klubi "Laudnikud" suurus', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_f_klubisuurus_tulemus*0, kodutöö_5_f_klubisuurus_tulemus, kodutöö_5_jr);
	end catch;
	end;

create 	procedure procedure_uus_isik()
	begin
		declare nimi varchar(50);
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_uus_isik') 
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik"', 'ei ole olemas', 'VIGA', kodutöö_5_sp_uus_isik*0, kodutöö_5_sp_uus_isik, kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik"', 'on olemas', 'OK', kodutöö_5_sp_uus_isik_olemasolu, kodutöö_5_sp_uus_isik_olemasolu, kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Protseduur "sp_uus_isik"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_uus_isik*0, kodutöö_5_sp_uus_isik, kodutöö_5_jr);
			return;
		end catch;

		-- Eesnimi, perenimi, klubi_id
		begin try
			create or replace variable isiku_id int;
			call 	sp_uus_isik('Test_ees', 'Test_pere', 51, isiku_id);
			select 	eesnimi into nimi from isikud where eesnimi = 'Test_ees';
			
			if 		(select eesnimi from isikud where eesnimi = 'Test_ees') = 'Test_ees'
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik" uus isik', 'on lisatud', 'OK', kodutöö_5_sp_uus_isik_tulemus, kodutöö_5_sp_uus_isik_tulemus, kodutöö_5_jr)
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik" uus isik', 'ei ole lisatud', 'VIGA', kodutöö_5_sp_uus_isik_tulemus*0, kodutöö_5_sp_uus_isik_tulemus, kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert Staatus values('Kodutöö', 'Protseduur "sp_uus_isik" uus isik', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_uus_isik_tulemus*0, kodutöö_5_sp_uus_isik_tulemus, kodutöö_5_jr)
		end catch;

		delete	from isikud where eesnimi = 'Test_ees';

	end;



create	procedure procedure_top10()
	begin
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_top10') 
			then	insert Staatus values('Kodutöö', 'Protseduur "sp_top10"', 'ei ole olemas', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, kodutöö_5_jr);
			return;
			else	insert Staatus values('Kodutöö', 'Protseduur "sp_top10"', 'on olemas', 'OK', kodutöö_5_sp_top10_olemasolu, kodutöö_5_sp_top10_olemasolu, kodutöö_5_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Protseduur "sp_top10"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_top10*0, kodutöö_5_sp_top10, kodutöö_5_jr);
		end catch;

		begin try
			create	table #Temp (id integer not null default autoincrement, punkte numeric(5,1), mangija varchar(102));
			unload 	select * from sp_top10(41) to 'C:\\TEMP\\kodutoo_check.txt' ENCODING 'UTF-8';
			load 	table #Temp (punkte, mangija) from 'C:\\TEMP\\kodutoo_check.txt' defaults on;

			if 		(select mangija from #Temp where id = 1) = 'Maasikas, Malle' 
			then  	insert 	Staatus values('Kodutöö', 'Protseduur "sp_top10" sp_top10(41), esimene koht = Maasikas, Malle', '-', 'OK', kodutöö_5_sp_top10_tulemus, kodutöö_5_sp_top10_tulemus, kodutöö_5_jr)
			else	insert 	Staatus values('Kodutöö', 'Protseduur "sp_top10" sp_top10(41), esimene koht = Maasikas, Malle', 'Kirjete või veergude järjestus on vale.', 'VIGA', kodutöö_5_sp_top10_tulemus*0, kodutöö_5_sp_top10_tulemus, kodutöö_5_jr)
			endif;
		end try
		begin catch
			insert 	Staatus values('Kodutöö', 'Protseduur "sp_top10" sp_top10(41), esimene koht = Maasikas, Malle', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_5_sp_top10_tulemus*0, kodutöö_5_sp_top10_tulemus, kodutöö_5_jr)
		end catch;
	end;

create procedure kuues_kodutöö ()
	begin
	
		-- ix_riiginimi
		begin try
			if 		not exists (select * from sysindex where creator = 1 and "unique" = 'N' and index_name = 'ix_riiginimi' and table_id = find_table_id('Riigid'))
			then 	insert Staatus values ('Kodutöö', 'Indexit "ix_riiginimi"', 'ei ole olemas', 'VIGA', kodutöö_6_ix_riiginimi_olemasolu*0, kodutöö_6_ix_riiginimi_olemasolu, kodutöö_6_jr)
			else 	insert Staatus values ('Kodutöö', 'Indexit "ix_riiginimi"', 'on olemas', 'OK', kodutöö_6_ix_riiginimi_olemasolu, kodutöö_6_ix_riiginimi_olemasolu, kodutöö_6_jr)
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Riigid')
				then	insert Staatus values ('Kodutöö', 'Indexit "ix_riiginimi"', 'Tabelit "Riigid" ei ole olemas', 'VIGA', kodutöö_6_ix_riiginimi_olemasolu*0, kodutöö_6_ix_riiginimi_olemasolu, kodutöö_6_jr)
				else	insert Staatus values ('Kodutöö', 'Indexit "ix_riiginimi"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_ix_riiginimi_olemasolu*0, kodutöö_6_ix_riiginimi_olemasolu, kodutöö_6_jr)
			end;
		end catch;
		
		-- ix_suurus
		begin try
			if 		not exists (select * from sysindex where creator = 1 and "unique" = 'N' and index_name = 'ix_suurus' and table_id = find_table_id('Riigid'))
			then 	insert Staatus values ('Kodutöö', 'Indexit "ix_suurus"', 'ei ole olemas', 'VIGA', kodutöö_6_ix_suurus_olemasolu*0, kodutöö_6_ix_suurus_olemasolu, kodutöö_6_jr)
			else 	insert Staatus values ('Kodutöö', 'Indexit "ix_suurus"', 'on olemas', 'OK', kodutöö_6_ix_suurus_olemasolu, kodutöö_6_ix_suurus_olemasolu, kodutöö_6_jr)
			endif;
		end try
		begin catch
			case
				when	not exists (select * from systable where table_name = 'Riigid')
				then	insert Staatus values ('Kodutöö', 'Indexit "ix_suurus"', 'Tabelit "Riigid" ei ole olemas', 'VIGA', kodutöö_6_ix_suurus_olemasolu*0, kodutöö_6_ix_suurus_olemasolu, kodutöö_6_jr)
				else	insert Staatus values ('Kodutöö', 'Indexit "ix_suurus"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_ix_suurus_olemasolu*0, kodutöö_6_ix_suurus_olemasolu, kodutöö_6_jr)
			end;
		end catch;
		
		-- uus klubi "klubitud"
		begin try
			if 		not exists (select * from klubid where nimi = 'Klubitud')
			then 	insert Staatus values ('Kodutöö', 'Klubi "Klubitud"', 'ei ole olemas', 'VIGA', kodutöö_6_klubitud_olemasolu*0, kodutöö_6_klubitud_olemasolu, kodutöö_6_jr)
			else 	insert Staatus values ('Kodutöö', 'Klubi "Klubitud"', 'on olemas', 'OK', kodutöö_6_klubitud_olemasolu, kodutöö_6_klubitud_olemasolu, kodutöö_6_jr)
			endif;
		end try
		begin catch
			case 
				when 	not exists (select * from systable where table_name = 'Klubid') 
				then 	insert Staatus values ('Kodutöö', 'Klubi "Klubitud"', 'Tabelit "Klubid" ei ole olemas', 'VIGA', kodutöö_6_klubitud_olemasolu*0, kodutöö_6_klubitud_olemasolu, kodutöö_6_jr)
				when	not exists (select * from syscolumn where column_name = 'Klubid' and table_id = find_table_id('nimi'))
				then 	insert Staatus values ('Kodutöö', 'Klubi "Klubitud"', 'Veergu "nimi" ei ole olemas', 'VIGA', kodutöö_6_klubitud_olemasolu*0, kodutöö_6_klubitud_olemasolu, kodutöö_6_jr)
				else 	insert Staatus values ('Kodutöö', 'Klubi "Klubitud"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_klubitud_olemasolu*0, kodutöö_6_klubitud_olemasolu, kodutöö_6_jr)
			end;
		end catch;
		
	end;
	
create procedure trigger_partiiaeg ()
	begin
		begin try
			if 		not exists (select * from systrigger where trigger_name = 'tg_partiiaeg') 
			then	insert Staatus values('Kodutöö', 'Triger "tg_partiiaeg"', 'ei ole olemas', 'VIGA', kodutöö_6_tg_partiiaeg*0, kodutöö_6_tg_partiiaeg, kodutöö_6_jr);
			return;
			else 	insert Staatus values('Kodutöö', 'Triger "tg_partiiaeg"', 'on olemas', 'OK', kodutöö_6_tg_partiiaeg_olemasolu, kodutöö_6_tg_partiiaeg_olemasolu, kodutöö_6_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Triger "tg_partiiaeg"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_tg_partiiaeg*0, kodutöö_6_tg_partiiaeg, kodutöö_6_jr);
			return;
		end catch;
		
		-- insert lower date, check if null
		begin try
				insert into partiid (turniir, algushetk, lopphetk, valge, must, valge_tulemus, musta_tulemus) 
				values (41, '2005-01-12 08:02:00.000','2005-01-12 08:01:28.000', 73, 92, 1, 1);
				
				if 		exists (select * from partiid where lopphetk is null)
				then 	insert Staatus values ('Kodutöö', 'Triger "Partiiaeg" lopphetk väiksem kui algushetk', 'tekitas NULL väärtuse', 'OK', kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_jr);
				else 	insert Staatus values ('Kodutöö', 'Triger "Partiiaeg" lopphetk väiksem kui algushetk', 'ei tekitanud NULL väärtuse', 'VIGA', kodutöö_6_tg_partiiaeg_tulemus*0, kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_jr);
				endif;
				delete from partiid where valge_tulemus = 1 and musta_tulemus = 1 and turniir = 41 and valge = 73 and must = 92 and (lopphetk = '2005-01-12 08:01:28.000' or lopphetk is null);
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Partiid')
					then	insert Staatus values ('Kodutöö', 'Triger "Partiiaeg" lopphetk väiksem kui algushetk', 'Tabelit "Partiid" ei ole olemas', 'VIGA', kodutöö_6_tg_partiiaeg_tulemus*0, kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_jr);
					when	not exists (select * from syscolumn where column_name = 'lopphetk' and table_id = find_table_id('Partiid'))
					then	insert Staatus values ('Kodutöö', 'Triger "Partiiaeg" lopphetk väiksem kui algushetk', 'Veergu "Lopphetk" ei ole olemas', 'VIGA', kodutöö_6_tg_partiiaeg_tulemus*0, kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_jr);
					else 	insert Staatus values ('Kodutöö', 'Triger "Partiiaeg" lopphetk väiksem kui algushetk', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_tg_partiiaeg_tulemus*0, kodutöö_6_tg_partiiaeg_tulemus, kodutöö_6_jr);
				end;
			end catch;
		
	
	end;
	
create procedure trigger_klubi_olemasolu ()
	begin
		declare klubitud int = 1;
		begin try
			if 		not exists (select * from systrigger where trigger_name = 'tg_klubi_olemasolu') 
			then	insert Staatus values('Kodutöö', 'Triger "tg_klubi_olemasolu"', 'ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu*0, kodutöö_6_tg_klubiolemasolu, kodutöö_6_jr);
			return;
			else 	insert Staatus values('Kodutöö', 'Triger "tg_klubi_olemasolu"', 'on olemas', 'OK', kodutöö_6_tg_klubiolemasolu_olemasolu, kodutöö_6_tg_klubiolemasolu_olemasolu, kodutöö_6_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu"', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_tg_klubiolemasolu*0, kodutöö_6_tg_klubiolemasolu, kodutöö_6_jr);
			return;
		end catch;
		
		-- insert test user, check if id correct
		begin try
			if 		not exists (select * from klubid where nimi = 'Klubitud')
			then 	insert Klubid (nimi) values ('Klubitud'); set klubitud = 0;
			endif;
			
			if 		not exists (select * from isikud where eesnimi = 'Test_ees')
			then 	insert 	Isikud (Eesnimi, Perenimi, Klubis) values ('Test_ees', 'Test_pere', 111);
			endif; 
			
			if 		not exists (select * from isikud where klubis = (select id from klubid where nimi = 'Klubitud'))
			then 	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'lisas vale klubi id', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
			else 	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'lisas õige klubi id', 'OK', kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
			endif;
		end try
		begin catch
			begin try
				if 		not exists (select * from klubid where nimi = 'Klubitud')
				then 	insert Klubid (nimi) values ('Klubitud'); set klubitud = 0;
				endif;
				
				if 		not exists (select * from isikud where eesnimi = 'Test_ees')
				then 	insert 	Isikud (Eesnimi, Perenimi, Klubi) values ('Test_ees', 'Test_pere', 111);
				endif;
				if 		not exists (select * from isikud where klubi = (select id from klubid where nimi = 'Klubitud'))
				then 	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'lisas vale klubi id', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
				else 	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'lisas õige klubi id', 'OK', kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
				endif;
			end try
			begin catch
				case
					when	not exists (select * from systable where table_name = 'Klubid')
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabelit "Klubid" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					when	not exists (select * from systable where table_name = 'Isikud')
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabelit "Isikud" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					when	not exists (select * from syscolumn where column_name = 'nimi' and table_id = find_table_id('Klubid'))
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabeli "Klubid" veergu "nimi" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					when	not exists (select * from syscolumn where column_name = 'Eesnimi' and table_id = find_table_id('Isikud'))
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabeli "Isikud" veergu "Eesnimi" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					when	not exists (select * from syscolumn where column_name = 'Perenimi' and table_id = find_table_id('Isikud'))
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabeli "Isikud" veergu "Perenimi" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					when	not exists (select * from syscolumn where column_name = 'Klubis' and table_id = find_table_id('Isikud'))
					and 	not exists (select * from syscolumn where column_name = 'Klubi' and table_id = find_table_id('Isikud'))
					then	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Tabeli "Isikud" veergu "Klubis" ei ole olemas', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
					else 	insert Staatus values ('Kodutöö', 'Triger "tg_klubi_olemasolu" isiku lisamine', 'Automaatkontrollis on viga!', 'VIGA', kodutöö_6_tg_klubiolemasolu_tulemus*0, kodutöö_6_tg_klubiolemasolu_tulemus, kodutöö_6_jr);
				end;
			end catch;
		end catch;
		if 	klubitud = 0 then delete from klubid where nimi = 'Klubitud'; endif;
		delete from isikud where eesnimi = 'Test_ees';
	end;
	
create procedure eksam_view_eelnevussuhe()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_eelnevussuhe')
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe"', 'ei ole olemas', 'VIGA', eksam_v_eelnevussuhe*0, eksam_v_eelnevussuhe, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe"', 'on olemas', 'OK', eksam_v_eelnevussuhe_olemasolu, eksam_v_eelnevussuhe_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe*0, eksam_v_eelnevussuhe, eksam_jr);
			return;
		end catch;
		
		
		call check_column('v_eelnevussuhe', 'partii_id', eksam_v_eelnevussuhe_partii_id, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_eelnevussuhe', 'valge', eksam_v_eelnevussuhe_valge, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_eelnevussuhe', 'must', eksam_v_eelnevussuhe_must, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_eelnevussuhe', 'valge_tulemus', eksam_v_eelnevussuhe_valge_tulemus, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_eelnevussuhe', 'musta_tulemus', eksam_v_eelnevussuhe_musta_tulemus, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_eelnevussuhe')) = 5
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" veergude arv', 'on õige', 'OK', eksam_v_eelnevussuhe_veergude_arv, eksam_v_eelnevussuhe_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" veergude arv', 'on vale', 'VIGA', eksam_v_eelnevussuhe_veergude_arv*0, eksam_v_eelnevussuhe_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe_veergude_arv*0, eksam_v_eelnevussuhe_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_eelnevussuhe) >= 199
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" kirjete arv', 'on õige', 'OK', eksam_v_eelnevussuhe_kirjete_arv, eksam_v_eelnevussuhe_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" kirjete arv', 'on vale, peab olema 199', 'VIGA', eksam_v_eelnevussuhe_kirjete_arv*0, eksam_v_eelnevussuhe_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe_kirjete_arv*0, eksam_v_eelnevussuhe_kirjete_arv, eksam_jr);
		end catch;
		
		-- 
		begin try
			if 		exists (select * from v_eelnevussuhe where valge = 73 and must = 92 and valge_tulemus = 1 and musta_tulemus = 1)
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'tulemused on õiged', 'OK', eksam_v_eelnevussuhe_partii_1_1, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'tulemused on vale', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'valge' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'Veergu "valge" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'must' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'Veergu "must" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'valge_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'Veergu "valge_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'musta_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'Veergu "musta_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 73 ja must 92', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe_partii_1_1*0, eksam_v_eelnevussuhe_partii_1_1, eksam_jr);
			end;
		end catch;		
		
		begin try
			if 		exists (select * from v_eelnevussuhe where valge = 92 and must = 87 and valge_tulemus = 2 and musta_tulemus = 0)
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'tulemused on õiged', 'OK', eksam_v_eelnevussuhe_partii_2_0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'tulemused on vale', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'valge' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'Veergu "valge" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'must' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'Veergu "must" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'valge_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'Veergu "valge_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'musta_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'Veergu "musta_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 92 ja must 87', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe_partii_2_0*0, eksam_v_eelnevussuhe_partii_2_0, eksam_jr);
			end;
		end catch;	
		
		begin try
			if 		exists (select * from v_eelnevussuhe where valge = 71 and must = 93 and valge_tulemus = 0 and musta_tulemus = 2)
			then 	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'tulemused on õiged', 'OK', eksam_v_eelnevussuhe_partii_0_2, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'tulemused on vale', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'valge' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'Veergu "valge" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'must' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'Veergu "must" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'valge_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'Veergu "valge_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'musta_tulemus' and table_id = find_table_id('v_eelnevussuhe'))
				then	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'Veergu "musta_tulemus" ei ole olemas', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_eelnevussuhe" partii valge 71 ja must 93', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_eelnevussuhe_partii_0_2*0, eksam_v_eelnevussuhe_partii_0_2, eksam_jr);
			end;
		end catch;	
	end;
	

-- v_kaotusi_rohkem_yhest
create procedure eksam_view_kaotusi_rohkem_yhest()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_kaotusi_rohkem_yhest')
			then 	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest"', 'ei ole olemas', 'VIGA', eksam_v_kaotusi_rohkem_yhest*0, eksam_v_kaotusi_rohkem_yhest, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest"', 'on olemas', 'OK', eksam_v_kaotusi_rohkem_yhest_olemasolu, eksam_v_kaotusi_rohkem_yhest_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kaotusi_rohkem_yhest*0, eksam_v_kaotusi_rohkem_yhest, eksam_jr);
			return;
		end catch;
		
		
		call check_column('v_kaotusi_rohkem_yhest', 'võistleja_andmed', eksam_v_kaotusi_rohkem_yhest_partii_id, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_kaotusi_rohkem_yhest')) = 1
			then 	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" veergude arv', 'on õige', 'OK', eksam_v_kaotusi_rohkem_yhest_veergude_arv, eksam_v_kaotusi_rohkem_yhest_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" veergude arv', 'on vale', 'VIGA', eksam_v_kaotusi_rohkem_yhest_veergude_arv*0, eksam_v_kaotusi_rohkem_yhest_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kaotusi_rohkem_yhest_veergude_arv*0, eksam_v_kaotusi_rohkem_yhest_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_kaotusi_rohkem_yhest) = 38
			then 	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" kirjete arv', 'on õige', 'OK', eksam_v_kaotusi_rohkem_yhest_kirjete_arv, eksam_v_kaotusi_rohkem_yhest_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" kirjete arv', 'on vale, peab olema 38', 'VIGA', eksam_v_kaotusi_rohkem_yhest_kirjete_arv*0, eksam_v_kaotusi_rohkem_yhest_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kaotusi_rohkem_yhest_kirjete_arv*0, eksam_v_kaotusi_rohkem_yhest_kirjete_arv, eksam_jr);
		end catch;
		
		-- 
		begin try
			if 		exists (select * from v_kaotusi_rohkem_yhest where võistleja_andmed = 'Või, Keiu (Areng)')
			then 	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Või, Keiu (Areng)', 'on olemas', 'OK', eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu, eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Või, Keiu (Areng)', 'ei ole olemas', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'võistleja_andmed' and table_id = find_table_id('v_kaotusi_rohkem_yhest'))
				then	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Või, Keiu (Areng)', 'Veergu "võistleja_andmed" ei ole olemas', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Või, Keiu (Areng)', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Keiu, eksam_jr);
			end;
		end catch;		
		
		begin try
			if 		exists (select * from v_kaotusi_rohkem_yhest where võistleja_andmed = 'Ilus, Ilo (Ruudu Liine)')
			then 	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Ilus, Ilo (Ruudu Liine)', 'on olemas', 'OK', eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo, eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Ilus, Ilo (Ruudu Liine)', 'ei ole olemas', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'võistleja_andmed' and table_id = find_table_id('v_kaotusi_rohkem_yhest'))
				then	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Ilus, Ilo (Ruudu Liine)', 'Veergu "võistleja_andmed" ei ole olemas', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_kaotusi_rohkem_yhest" võistleja Ilus, Ilo (Ruudu Liine)', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo*0, eksam_v_kaotusi_rohkem_yhest_võistleja_Ilo, eksam_jr);
			end;
		end catch;	
		
		
	end;
	
create procedure eksam_view_must_valge()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_must_valge')
			then 	insert Staatus values ('Eksam', 'Vaade "v_must_valge"', 'ei ole olemas', 'VIGA', eksam_v_must_valge*0, eksam_v_must_valge, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_must_valge"', 'on olemas', 'OK', eksam_v_must_valge_olemasolu, eksam_v_must_valge_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must_valge"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must_valge*0, eksam_v_must_valge, eksam_jr);
			return;
		end catch;
		
		call check_column('v_must_valge', 'eesnimi', eksam_v_must_valge_eesnimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_must_valge', 'perenimi', eksam_v_must_valge_perenimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_must_valge', 'partiisid_mustadega', eksam_v_must_valge_partiisid_mustadega, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_must_valge', 'partiisid_valgetega', eksam_v_must_valge_partiisid_valgetega, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_must_valge')) = 4
			then 	insert Staatus values ('Eksam', 'Vaade "v_must_valge" veergude arv', 'on õige', 'OK', eksam_v_must_valge_veergude_arv, eksam_v_must_valge_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must_valge" veergude arv', 'on vale', 'VIGA', eksam_v_must_valge_veergude_arv*0, eksam_v_must_valge_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must_valge" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must_valge_veergude_arv*0, eksam_v_must_valge_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_must_valge) = 26
			then 	insert Staatus values ('Eksam', 'Vaade "v_must_valge" kirjete arv', 'on õige', 'OK', eksam_v_must_valge_kirjete_arv, eksam_v_must_valge_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must_valge" kirjete arv', 'on vale, peab olema 26', 'VIGA', eksam_v_must_valge_kirjete_arv*0, eksam_v_must_valge_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must_valge" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must_valge_kirjete_arv*0, eksam_v_must_valge_kirjete_arv, eksam_jr);
		end catch;
		
		-- Arvo,Mets,9,5
		begin try
			if 		exists (select * from v_must_valge where eesnimi = 'Arvo' and perenimi = 'Mets' and partiisid_mustadega = 9 and partiisid_valgetega = 5)
			then 	insert Staatus values ('Eksam', 'Vaade "v_must_valge" Arvo Mets partiisid mustadega 9 ja valgetega 5', 'on olemas', 'OK', eksam_v_must_valge_arvo_mets, eksam_v_must_valge_arvo_mets, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'ei ole olemas', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'Veergu "eesnimi" ei ole olemas', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'Veergu "perenimi" ei ole olemas', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_mustadega' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'Veergu "partiisid_mustadega" ei ole olemas', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_valgetega' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'Veergu "partiisid_valgetega" ei ole olemas', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Arvo Mets partiisid mustadega 9 ja valgetega 5', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must_valge_arvo_mets*0, eksam_v_must_valge_arvo_mets, eksam_jr);
			end;
		end catch;		
		
		-- Anneli,Mets,1,0
		begin try
			if 		exists (select * from v_must_valge where eesnimi = 'Anneli' and perenimi = 'Mets' and partiisid_mustadega = 1 and partiisid_valgetega = 0)
			then 	insert Staatus values ('Eksam', 'Vaade "v_must_valge" Anneli Mets partiisid mustadega 1 ja valgetega 0', 'on olemas', 'OK', eksam_v_must_valge_anneli_mets, eksam_v_must_valge_anneli_mets, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'ei ole olemas', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'Veergu "eesnimi" ei ole olemas', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'Veergu "perenimi" ei ole olemas', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_mustadega' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'Veergu "partiisid_mustadega" ei ole olemas', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_valgetega' and table_id = find_table_id('v_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'Veergu "partiisid_valgetega" ei ole olemas', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_must_valge"  Anneli Mets partiisid mustadega 1 ja valgetega 0', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must_valge_anneli_mets*0, eksam_v_must_valge_anneli_mets, eksam_jr);
			end;
		end catch;	
	end;
	
create procedure eksam_view_kiirviik()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_kiirviik')
			then 	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"', 'ei ole olemas', 'VIGA', eksam_v_kiirviik*0, eksam_v_kiirviik, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"', 'on olemas', 'OK', eksam_v_kiirviik_olemasolu, eksam_v_kiirviik_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kiirviik"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kiirviik*0, eksam_v_kiirviik, eksam_jr);
			return;
		end catch;
		
		call check_column('v_kiirviik', 'valge', eksam_v_kiirviik_valge, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_kiirviik', 'must', eksam_v_kiirviik_must, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_kiirviik')) = 2
			then 	insert Staatus values ('Eksam', 'Vaade "v_kiirviik" veergude arv', 'on õige', 'OK', eksam_v_kiirviik_veergude_arv, eksam_v_kiirviik_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kiirviik" veergude arv', 'on vale', 'VIGA', eksam_v_kiirviik_veergude_arv*0, eksam_v_kiirviik_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kiirviik" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kiirviik_veergude_arv*0, eksam_v_kiirviik_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_kiirviik) = 1
			then 	insert Staatus values ('Eksam', 'Vaade "v_kiirviik" kirjete arv', 'on õige', 'OK', eksam_v_kiirviik_kirjete_arv, eksam_v_kiirviik_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kiirviik" kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_v_kiirviik_kirjete_arv*0, eksam_v_kiirviik_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_kiirviik" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kiirviik_kirjete_arv*0, eksam_v_kiirviik_kirjete_arv, eksam_jr);
		end catch;
		
		-- 
		begin try
			if 		exists (select * from v_kiirviik where valge = 89 and must = 88)
			then 	insert Staatus values ('Eksam', 'Vaade "v_kiirviik" valge 89 ja must 88', 'on olemas', 'OK', eksam_v_kiirviik_tulemus, eksam_v_kiirviik_tulemus, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"  valge 89 ja must 88', 'ei ole olemas', 'VIGA', eksam_v_kiirviik_tulemus*0, eksam_v_kiirviik_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'valge' and table_id = find_table_id('v_kiirviik'))
				then	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"  valge 89 ja must 88', 'Veergu "valge" ei ole olemas', 'VIGA', eksam_v_kiirviik_tulemus*0, eksam_v_kiirviik_tulemus, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'must' and table_id = find_table_id('v_kiirviik'))
				then	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"  valge 89 ja must 88', 'Veergu "must" ei ole olemas', 'VIGA', eksam_v_kiirviik_tulemus*0, eksam_v_kiirviik_tulemus, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_kiirviik"  valge 89 ja must 88', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_kiirviik_tulemus*0, eksam_v_kiirviik_tulemus, eksam_jr);
			end;
		end catch;		
		
	end;
	
create procedure eksam_view_klubisisesed_viigid()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_kiirviik')
			then 	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"', 'ei ole olemas', 'VIGA', eksam_v_klubisisesed_viigid*0, eksam_v_klubisisesed_viigid, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"', 'on olemas', 'OK', eksam_v_klubisisesed_viigid_olemasolu, eksam_v_klubisisesed_viigid_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_klubisisesed_viigid*0, eksam_v_klubisisesed_viigid, eksam_jr);
			return;
		end catch;
		
		call check_column('v_klubisisesed_viigid', 'klubinimi', eksam_v_klubisisesed_viigid_klubinimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_klubisisesed_viigid', 'viike', eksam_v_klubisisesed_viigid_viike, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_klubisisesed_viigid')) = 2
			then 	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" veergude arv', 'on õige', 'OK', eksam_v_klubisisesed_viigid_veergude_arv, eksam_v_klubisisesed_viigid_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" veergude arv', 'on vale', 'VIGA', eksam_v_klubisisesed_viigid_veergude_arv*0, eksam_v_klubisisesed_viigid_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_klubisisesed_viigid_veergude_arv*0, eksam_v_klubisisesed_viigid_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_klubisisesed_viigid) = 6
			then 	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" kirjete arv', 'on õige', 'OK', eksam_v_klubisisesed_viigid_kirjete_arv, eksam_v_klubisisesed_viigid_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" kirjete arv', 'on vale, peab olema 6', 'VIGA', eksam_v_klubisisesed_viigid_kirjete_arv*0, eksam_v_klubisisesed_viigid_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_klubisisesed_viigid_kirjete_arv*0, eksam_v_klubisisesed_viigid_kirjete_arv, eksam_jr);
		end catch;
		
		-- 
		begin try
			if 		exists (select * from v_klubisisesed_viigid where klubinimi = 'Valge Mask' and viike = 2)
			then 	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" Valge Mask 2 viiki', 'on olemas', 'OK', eksam_v_klubisisesed_viigid_tulemus, eksam_v_klubisisesed_viigid_tulemus, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid" Valge Mask 2 viiki', 'ei ole olemas', 'VIGA', eksam_v_klubisisesed_viigid_tulemus*0, eksam_v_klubisisesed_viigid_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'klubinimi' and table_id = find_table_id('v_klubisisesed_viigid'))
				then	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"  Valge Mask 2 viiki', 'Veergu "klubinimi" ei ole olemas', 'VIGA', eksam_v_klubisisesed_viigid_tulemus*0, eksam_v_klubisisesed_viigid_tulemus, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'viike' and table_id = find_table_id('v_klubisisesed_viigid'))
				then	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"  Valge Mask 2 viiki', 'Veergu "viike" ei ole olemas', 'VIGA', eksam_v_klubisisesed_viigid_tulemus*0, eksam_v_klubisisesed_viigid_tulemus, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_klubisisesed_viigid"  Valge Mask 2 viiki', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_klubisisesed_viigid_tulemus*0, eksam_v_klubisisesed_viigid_tulemus, eksam_jr);
			end;
		end catch;		
		
	end;
	
create procedure eksam_view_must1()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_must1')
			then 	insert Staatus values ('Eksam', 'Vaade "v_must1"', 'ei ole olemas', 'VIGA', eksam_v_must1*0, eksam_v_must1, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_must1"', 'on olemas', 'OK', eksam_v_must1_olemasolu, eksam_v_must1_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must1"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must1*0, eksam_v_must1, eksam_jr);
			return;
		end catch;
		
		call check_column('v_must1', 'isikuandmed', eksam_v_must1_isikuandmed, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_must1')) = 1
			then 	insert Staatus values ('Eksam', 'Vaade "v_must1" veergude arv', 'on õige', 'OK', eksam_v_must1_veergude_arv, eksam_v_must1_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must1" veergude arv', 'on vale', 'VIGA', eksam_v_must1_veergude_arv*0, eksam_v_must1_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must1" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must1_veergude_arv*0, eksam_v_must1_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_must1) = 21
			then 	insert Staatus values ('Eksam', 'Vaade "v_must1" kirjete arv', 'on õige', 'OK', eksam_v_must1_kirjete_arv, eksam_v_must1_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must1" kirjete arv', 'on vale, peab olema 21', 'VIGA', eksam_v_must1_kirjete_arv*0, eksam_v_must1_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_must1" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must1_kirjete_arv*0, eksam_v_must1_kirjete_arv, eksam_jr);
		end catch;
		
		-- Maletäht: Hiid, Hiie
		begin try
			if 		exists (select * from v_must1 where isikuandmed = 'Maletäht: Hiid, Hiie')
			then 	insert Staatus values ('Eksam', 'Vaade "v_must1" Maletäht: Hiid, Hiie', 'on olemas', 'OK', eksam_v_must1_tulemus, eksam_v_must1_tulemus, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_must1"  Maletäht: Hiid, Hiie', 'ei ole olemas', 'VIGA', eksam_v_must1_tulemus*0, eksam_v_must1_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'isikuandmed' and table_id = find_table_id('v_must1'))
				then	insert Staatus values ('Eksam', 'Vaade "v_must1"  Maletäht: Hiid, Hiie', 'Veergu "isikuandmed" ei ole olemas', 'VIGA', eksam_v_must1_tulemus*0, eksam_v_must1_tulemus, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_must1"  Maletäht: Hiid, Hiie', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_must1_tulemus*0, eksam_v_must1_tulemus, eksam_jr);
			end;
		end catch;		
		
	end;
	
create procedure eksam_view_nimekiri_partiidest()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_nimekiri_partiidest')
			then 	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"', 'ei ole olemas', 'VIGA', eksam_v_nimekiri_partiidest*0, eksam_v_nimekiri_partiidest, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"', 'on olemas', 'OK', eksam_v_nimekiri_partiidest_olemasolu, eksam_v_nimekiri_partiidest_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_nimekiri_partiidest*0, eksam_v_nimekiri_partiidest, eksam_jr);
			return;
		end catch;
		
		call check_column('v_nimekiri_partiidest', 'partii_id', eksam_v_nimekiri_partiidest_partii_id, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_nimekiri_partiidest', 'valge_nimi', eksam_v_nimekiri_partiidest_valge_nimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_nimekiri_partiidest', 'musta_nimi', eksam_v_nimekiri_partiidest_musta_nimi, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_nimekiri_partiidest')) = 3
			then 	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" veergude arv', 'on õige', 'OK', eksam_v_nimekiri_partiidest_veergude_arv, eksam_v_nimekiri_partiidest_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" veergude arv', 'on vale', 'VIGA', eksam_v_nimekiri_partiidest_veergude_arv*0, eksam_v_nimekiri_partiidest_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_nimekiri_partiidest_veergude_arv*0, eksam_v_nimekiri_partiidest_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_nimekiri_partiidest) = 115
			then 	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" kirjete arv', 'on õige', 'OK', eksam_v_nimekiri_partiidest_kirjete_arv, eksam_v_nimekiri_partiidest_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" kirjete arv', 'on vale, peab olema 115', 'VIGA', eksam_v_nimekiri_partiidest_kirjete_arv*0, eksam_v_nimekiri_partiidest_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_nimekiri_partiidest_kirjete_arv*0, eksam_v_nimekiri_partiidest_kirjete_arv, eksam_jr);
		end catch;
		
		--
		begin try
			if 		exists (select * from v_nimekiri_partiidest where valge_nimi = 'Pustota, Pjotr' and musta_nimi = 'Umnik, Toomas')
			then 	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest" Maletäht: Hiid, Hiie', 'on olemas', 'OK', eksam_v_nimekiri_partiidest_tulemus, eksam_v_nimekiri_partiidest_tulemus, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"  Maletäht: Hiid, Hiie', 'ei ole olemas', 'VIGA', eksam_v_nimekiri_partiidest_tulemus*0, eksam_v_nimekiri_partiidest_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'valge_nimi' and table_id = find_table_id('v_nimekiri_partiidest'))
				then	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"  Maletäht: Hiid, Hiie', 'Veergu "valge_nimi" ei ole olemas', 'VIGA', eksam_v_nimekiri_partiidest_tulemus*0, eksam_v_nimekiri_partiidest_tulemus, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'musta_nimi' and table_id = find_table_id('v_nimekiri_partiidest'))
				then	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"  Maletäht: Hiid, Hiie', 'Veergu "musta_nimi" ei ole olemas', 'VIGA', eksam_v_nimekiri_partiidest_tulemus*0, eksam_v_nimekiri_partiidest_tulemus, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_nimekiri_partiidest"  Maletäht: Hiid, Hiie', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_nimekiri_partiidest_tulemus*0, eksam_v_nimekiri_partiidest_tulemus, eksam_jr);
			end;
		end catch;		
		
	end;

create procedure eksam_view_rohkem_kolmest()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_rohkem_kolmest')
			then 	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"', 'ei ole olemas', 'VIGA', eksam_v_rohkem_kolmest*0, eksam_v_rohkem_kolmest, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"', 'on olemas', 'OK', eksam_v_rohkem_kolmest_olemasolu, eksam_v_rohkem_kolmest_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_rohkem_kolmest*0, eksam_v_rohkem_kolmest, eksam_jr);
			return;
		end catch;
		
		call check_column('v_rohkem_kolmest', 'isikuandmed', eksam_v_rohkem_kolmest_isikuandmed, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_rohkem_kolmest')) = 1
			then 	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" veergude arv', 'on õige', 'OK', eksam_v_rohkem_kolmest_veergude_arv, eksam_v_rohkem_kolmest_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" veergude arv', 'on vale', 'VIGA', eksam_v_rohkem_kolmest_veergude_arv*0, eksam_v_rohkem_kolmest_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_rohkem_kolmest_veergude_arv*0, eksam_v_rohkem_kolmest_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_rohkem_kolmest) = 36
			then 	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" kirjete arv', 'on õige', 'OK', eksam_v_rohkem_kolmest_kirjete_arv, eksam_v_rohkem_kolmest_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" kirjete arv', 'on vale, peab olema 36', 'VIGA', eksam_v_rohkem_kolmest_kirjete_arv*0, eksam_v_rohkem_kolmest_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_rohkem_kolmest_kirjete_arv*0, eksam_v_rohkem_kolmest_kirjete_arv, eksam_jr);
		end catch;
		
		-- Puhasmaa, Nadja [Võitmatu Valge]
		begin try
			if 		exists (select * from v_rohkem_kolmest where isikuandmed = 'Puhasmaa, Nadja [Võitmatu Valge]')
			then 	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest" Puhasmaa, Nadja [Võitmatu Valge]', 'on olemas', 'OK', eksam_v_rohkem_kolmest_tulemus, eksam_v_rohkem_kolmest_tulemus, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"  Puhasmaa, Nadja [Võitmatu Valge]', 'ei ole olemas', 'VIGA', eksam_v_rohkem_kolmest_tulemus*0, eksam_v_rohkem_kolmest_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'isikuandmed' and table_id = find_table_id('v_rohkem_kolmest'))
				then	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"  Puhasmaa, Nadja [Võitmatu Valge]', 'Veergu "isikuandmed" ei ole olemas', 'VIGA', eksam_v_rohkem_kolmest_tulemus*0, eksam_v_rohkem_kolmest_tulemus, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_rohkem_kolmest"  Puhasmaa, Nadja [Võitmatu Valge]', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_rohkem_kolmest_tulemus*0, eksam_v_rohkem_kolmest_tulemus, eksam_jr);
			end;
		end catch;		
		
	end;
	
create procedure eksam_view_voit_must_valge()
	begin
		begin try
			if 		not exists (select * from systable where table_name = 'v_voit_must_valge')
			then 	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge"', 'ei ole olemas', 'VIGA', eksam_v_voit_must_valge*0, eksam_v_voit_must_valge, eksam_jr);
					return;
			else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge"', 'on olemas', 'OK', eksam_v_voit_must_valge_olemasolu, eksam_v_voit_must_valge_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge"', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_voit_must_valge*0, eksam_v_voit_must_valge, eksam_jr);
			return;
		end catch;
		
		call check_column('v_voit_must_valge', 'eesnimi', eksam_v_voit_must_valge_eesnimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_voit_must_valge', 'perenimi', eksam_v_voit_must_valge_perenimi, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_voit_must_valge', 'partiisid_mustadega', eksam_v_voit_must_valge_partiisid_mustadega, eksam_jr, 'Eksam', 'Vaade');
		call check_column('v_voit_must_valge', 'partiisid_valgetega', eksam_v_voit_must_valge_partiisid_valgetega, eksam_jr, 'Eksam', 'Vaade');
		
		-- vaate veergude arv 
		begin try
			if 		(select count(*) from syscolumn where table_id = find_table_id('v_voit_must_valge')) = 4
			then 	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" veergude arv', 'on õige', 'OK', eksam_v_voit_must_valge_veergude_arv, eksam_v_voit_must_valge_veergude_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" veergude arv', 'on vale', 'VIGA', eksam_v_voit_must_valge_veergude_arv*0, eksam_v_voit_must_valge_veergude_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" veergude arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_voit_must_valge_veergude_arv*0, eksam_v_voit_must_valge_veergude_arv, eksam_jr);
		end catch;
		
		-- vaate kirjete arv 
		begin try
			if 		(select count(*) from v_voit_must_valge) = 27
			then 	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" kirjete arv', 'on õige', 'OK', eksam_v_voit_must_valge_kirjete_arv, eksam_v_voit_must_valge_kirjete_arv, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" kirjete arv', 'on vale, peab olema 27', 'VIGA', eksam_v_voit_must_valge_kirjete_arv*0, eksam_v_voit_must_valge_kirjete_arv, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_voit_must_valge_kirjete_arv*0, eksam_v_voit_must_valge_kirjete_arv, eksam_jr);
		end catch;
		
		--
		begin try
			if 		exists (select * from v_voit_must_valge where eesnimi = 'Arvo' and perenimi = 'Mets' and partiisid_mustadega = 5 and partiisid_valgetega = 0)
			then 	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'on olemas', 'OK', eksam_v_voit_must_valge_arvo_mets, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'ei ole olemas', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'Veergu "eesnimi" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'Veergu "perenimi" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_mustadega' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'Veergu "partiisid_mustadega" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_valgetega' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'Veergu "partiisid_valgetega" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Arvo Mets partiid mustad 5 ja valged 0', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_voit_must_valge_arvo_mets*0, eksam_v_voit_must_valge_arvo_mets, eksam_jr);
			end;
		end catch;	

		begin try
			if 		exists (select * from v_voit_must_valge where eesnimi = 'Toomas' and perenimi = 'Umnik' and partiisid_mustadega = 4 and partiisid_valgetega = 2)
			then 	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'on olemas', 'OK', eksam_v_voit_must_valge_toomas_umnik, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
			else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'ei ole olemas', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
			endif;
		end try
		begin catch
			case
				when	not exists (select * from syscolumn where column_name = 'eesnimi' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'Veergu "eesnimi" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'perenimi' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'Veergu "perenimi" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_mustadega' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'Veergu "partiisid_mustadega" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
				when	not exists (select * from syscolumn where column_name = 'partiisid_valgetega' and table_id = find_table_id('v_voit_must_valge'))
				then	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'Veergu "partiisid_valgetega" ei ole olemas', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
				else	insert Staatus values ('Eksam', 'Vaade "v_voit_must_valge" Toomas Umnik partiid mustad 4 ja valged 2', 'Automaatkontrollis on viga!', 'VIGA', eksam_v_voit_must_valge_toomas_umnik*0, eksam_v_voit_must_valge_toomas_umnik, eksam_jr);
			end;
		end catch;	
		
	end;
	
create	procedure eksam_procedure_ei_manginud()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_ei_manginud') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_ei_manginud"', 'ei ole olemas', 'VIGA', eksam_sp_ei_manginud*0, eksam_sp_ei_manginud, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_ei_manginud"', 'on olemas', 'OK', eksam_sp_ei_manginud_olemasolu, eksam_sp_ei_manginud_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_ei_manginud*0, eksam_sp_ei_manginud, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Viljandi lahtised meistrivõistlused 2006';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Viljandi lahtised meistrivõistlused 2006';
		end catch;

		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100));
			unload 	select * from sp_ei_manginud(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Sander' and perenimi = 'Saabas')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, Sander Saabas', 'on olemas', 'OK', eksam_sp_ei_manginud_sander, eksam_sp_ei_manginud_sander, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, Sander Saabas', 'ei ole olemas', 'VIGA', eksam_sp_ei_manginud_sander*0, eksam_sp_ei_manginud_sander, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, Sander Saabas', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_ei_manginud_sander*0, eksam_sp_ei_manginud_sander, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) >= 18
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_ei_manginud_kirjete_arv44, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 18', 'VIGA', eksam_sp_ei_manginud_kirjete_arv44*0, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_ei_manginud_kirjete_arv44*0, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100));
			unload 	select * from sp_ei_manginud(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Tatjana' and perenimi = 'Umnaja')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, Tatjana Umnaja', 'on olemas', 'OK', eksam_sp_ei_manginud_tatjana, eksam_sp_ei_manginud_tatjana, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, Tatjana Umnaja', 'ei ole olemas', 'VIGA', eksam_sp_ei_manginud_tatjana*0, eksam_sp_ei_manginud_tatjana, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, Tatjana Umnaja', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_ei_manginud_tatjana*0, eksam_sp_ei_manginud_tatjana, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) >= 15
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'on õige', 'OK', eksam_sp_ei_manginud_kirjete_arv44, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'on vale, peab olema 18', 'VIGA', eksam_sp_ei_manginud_kirjete_arv44*0, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_ei_manginud" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_ei_manginud_kirjete_arv44*0, eksam_sp_ei_manginud_kirjete_arv44, eksam_jr);
		end catch;
	end;
	
	
create	procedure eksam_procedure_koige_rohkem_partiisid_turniiril()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_koige_rohkem_partiisid_turniiril') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril"', 'ei ole olemas', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril*0, eksam_sp_koige_rohkem_partiisid_turniiril, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril"', 'on olemas', 'OK', eksam_sp_koige_rohkem_partiisid_turniiril_olemasolu, eksam_sp_koige_rohkem_partiisid_turniiril_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril*0, eksam_sp_koige_rohkem_partiisid_turniiril, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Viljandi lahtised meistrivõistlused 2006';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Viljandi lahtised meistrivõistlused 2006';
		end catch;

		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), mangude_arv int);
			unload 	select * from sp_koige_rohkem_partiisid_turniiril(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Kalle' and perenimi = 'Kivine' and mangude_arv = 6)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'on olemas', 'OK', eksam_sp_koige_rohkem_partiisid_turniiril_kalle, eksam_sp_koige_rohkem_partiisid_turniiril_kalle, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'ei ole olemas', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kalle*0, eksam_sp_koige_rohkem_partiisid_turniiril_kalle, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kalle*0, eksam_sp_koige_rohkem_partiisid_turniiril_kalle, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 1
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44*0, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44*0, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), mangude_arv int);
			unload 	select * from sp_koige_rohkem_partiisid_turniiril(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Maari' and perenimi = 'Mustikas' and mangude_arv = 6)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, Maari Mustikas', 'on olemas', 'OK', eksam_sp_koige_rohkem_partiisid_turniiril_maari, eksam_sp_koige_rohkem_partiisid_turniiril_maari, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, Maari Mustikas', 'ei ole olemas', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_maari*0, eksam_sp_koige_rohkem_partiisid_turniiril_maari, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, Maari Mustikas', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_maari*0, eksam_sp_koige_rohkem_partiisid_turniiril_maari, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 1
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on õige', 'OK', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41*0, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_rohkem_partiisid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41*0, eksam_sp_koige_rohkem_partiisid_turniiril_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	
	
create	procedure eksam_procedure_koige_vahem_partiisid_turniiril()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_koige_vahem_partiisid_turniiril') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril"', 'ei ole olemas', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril*0, eksam_sp_koige_vahem_partiisid_turniiril, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril"', 'on olemas', 'OK', eksam_sp_koige_vahem_partiisid_turniiril_olemasolu, eksam_sp_koige_vahem_partiisid_turniiril_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril*0, eksam_sp_koige_vahem_partiisid_turniiril, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Viljandi lahtised meistrivõistlused 2006';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Viljandi lahtised meistrivõistlused 2006';
		end catch;

		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), mangude_arv int);
			unload 	select * from sp_koige_vahem_partiisid_turniiril(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Boriss' and perenimi = 'Borissov' and mangude_arv = 1)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Boriss Borissov', 'on olemas', 'OK', eksam_sp_koige_vahem_partiisid_turniiril_ere1, eksam_sp_koige_vahem_partiisid_turniiril_ere1, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Boriss Borissov', 'ei ole olemas', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_ere1*0, eksam_sp_koige_vahem_partiisid_turniiril_ere1, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, Boriss Borissov', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_ere1*0, eksam_sp_koige_vahem_partiisid_turniiril_ere1, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 1
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44*0, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44*0, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), mangude_arv int);
			unload 	select * from sp_koige_vahem_partiisid_turniiril(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where eesnimi = 'Mati' and perenimi = 'All' and mangude_arv = 1)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, Mati All', 'on olemas', 'OK', eksam_sp_koige_vahem_partiisid_turniiril_ere2, eksam_sp_koige_vahem_partiisid_turniiril_ere2, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, Mati All', 'ei ole olemas', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_ere2*0, eksam_sp_koige_vahem_partiisid_turniiril_ere2, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006,  Mati All', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_ere2*0, eksam_sp_koige_vahem_partiisid_turniiril_ere2, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 1
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'on õige', 'OK', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41*0, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_koige_vahem_partiisid_turniiril" turniiril: Viljandi lahtised meistrivõistlused 2006, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41*0, eksam_sp_koige_vahem_partiisid_turniiril_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	
	
create	procedure eksam_procedure_mustadega_mangija_partiid_turniiril()
	begin
		declare turniir1, turniir2, isik1, isik2, isik3 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_mustadega_mangija_partiid_turniiril') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril"', 'ei ole olemas', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril*0, eksam_sp_mustadega_mangija_partiid_turniiril, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril"', 'on olemas', 'OK', eksam_sp_mustadega_mangija_partiid_turniiril_olemasolu, eksam_sp_mustadega_mangija_partiid_turniiril_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril*0, eksam_sp_mustadega_mangija_partiid_turniiril, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into isik1 from isikud where eesnimi = 'Toomas' and perenimi = 'Umnik';
			select id into isik2 from isikud where eesnimi = 'Aljona' and perenimi = 'Aljas'; 
			select id into isik3 from isikud where eesnimi = 'Pjotr' and perenimi = 'Pustota';
		end try
		begin catch
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Kolme klubi kohtumine';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Kolme klubi kohtumine';
		end catch;

		begin try
			create	or replace table eksam (partii_id int, algushetk date, valge int, musta_tulemus int);
			unload 	select * from sp_mustadega_mangija_partiid_turniiril(isik1, turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where valge = isik2 and musta_tulemus = 2)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, partii: ' || isik1 ||', ' || isik2, 'on olemas', 'OK', eksam_sp_mustadega_mangija_partiid_turniiril_isik2, eksam_sp_mustadega_mangija_partiid_turniiril_isik2, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, partii: ' || isik1 ||', ' || isik2, 'ei ole olemas', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_isik2*0, eksam_sp_mustadega_mangija_partiid_turniiril_isik2, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, partii: ' || isik1 ||', ' || isik2, 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_isik2*0, eksam_sp_mustadega_mangija_partiid_turniiril_isik2, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 1
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 1', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44*0, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44*0, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (partii_id int, algushetk date, valge int, musta_tulemus int);
			unload 	select * from sp_mustadega_mangija_partiid_turniiril(isik1, turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt';

			if 		exists (select * from eksam where valge = isik3 and musta_tulemus = 1)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, partii: ' || isik1 ||', ' || isik3, 'on olemas', 'OK', eksam_sp_mustadega_mangija_partiid_turniiril_isik3, eksam_sp_mustadega_mangija_partiid_turniiril_isik3, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, partii: ' || isik1 ||', ' || isik3, 'ei ole olemas', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_isik3*0, eksam_sp_mustadega_mangija_partiid_turniiril_isik3, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, partii: ' || isik1 ||', ' || isik3, 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_isik3*0, eksam_sp_mustadega_mangija_partiid_turniiril_isik3, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 3
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on õige', 'OK', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on vale, peab olema 3', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41*0, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_mustadega_mangija_partiid_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41*0, eksam_sp_mustadega_mangija_partiid_turniiril_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	
	
create	procedure eksam_procedure_teine_kolmas()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_teine_kolmas') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_teine_kolmas"', 'ei ole olemas', 'VIGA', eksam_sp_teine_kolmas*0, eksam_sp_teine_kolmas, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_teine_kolmas"', 'on olemas', 'OK', eksam_sp_teine_kolmas_olemasolu, eksam_sp_teine_kolmas_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_teine_kolmas*0, eksam_sp_teine_kolmas, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Kolme klubi kohtumine';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Kolme klubi kohtumine';
		end catch;

		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), id int default autoincrement);
			unload 	select * from sp_teine_kolmas(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;
			
			if 		exists (select * from eksam where eesnimi = 'Kalle' and perenimi = 'Kivine')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'on olemas', 'OK', eksam_sp_teine_kolmas_kalle, eksam_sp_teine_kolmas_kalle, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'ei ole olemas', 'VIGA', eksam_sp_teine_kolmas_kalle*0, eksam_sp_teine_kolmas_kalle, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, Kalle Kivine', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_teine_kolmas_kalle*0, eksam_sp_teine_kolmas_kalle, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 2
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_teine_kolmas_kirjete_arv44, eksam_sp_teine_kolmas_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 2', 'VIGA', eksam_sp_teine_kolmas_kirjete_arv44*0, eksam_sp_teine_kolmas_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_teine_kolmas_kirjete_arv44*0, eksam_sp_teine_kolmas_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (eesnimi varchar(100), perenimi varchar(100), id int default autoincrement);
			unload 	select * from sp_teine_kolmas(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;

			if 		exists (select * from eksam where eesnimi = 'Toomas' and perenimi = 'Umnik')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, Toomas Umnik', 'on olemas', 'OK', eksam_sp_teine_kolmas_toomas, eksam_sp_teine_kolmas_toomas, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, Toomas Umnik', 'ei ole olemas', 'VIGA', eksam_sp_teine_kolmas_toomas*0, eksam_sp_teine_kolmas_toomas, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, Toomas Umnik', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_teine_kolmas_toomas*0, eksam_sp_teine_kolmas_toomas, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 2
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, kirjete arv', 'on õige', 'OK', eksam_sp_teine_kolmas_kirjete_arv41, eksam_sp_teine_kolmas_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, kirjete arv', 'on vale, peab olema 2', 'VIGA', eksam_sp_teine_kolmas_kirjete_arv41*0, eksam_sp_teine_kolmas_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_teine_kolmas" turniiril: Kolme klubi kohtumine, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_teine_kolmas_kirjete_arv41*0, eksam_sp_teine_kolmas_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	
	
create	procedure eksam_procedure_turniiri_kokkuvote()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_turniiri_kokkuvote') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote"', 'ei ole olemas', 'VIGA', eksam_sp_turniiri_kokkuvote*0, eksam_sp_turniiri_kokkuvote, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote"', 'on olemas', 'OK', eksam_sp_turniiri_kokkuvote_olemasolu, eksam_sp_turniiri_kokkuvote_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_turniiri_kokkuvote*0, eksam_sp_turniiri_kokkuvote, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Kolme klubi kohtumine';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Kolme klubi kohtumine';
		end catch;

		begin try
			create	or replace table eksam (mangija varchar(100), klubinimi varchar(100), punktid numeric);
			unload 	select * from sp_turniiri_kokkuvote(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;
			
			if 		exists (select * from eksam where mangija = 'Andrei, Sosnov' and klubinimi = 'Musta kivi kummardajad' and punktid = 13.0)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov', 'on olemas', 'OK', eksam_sp_turniiri_kokkuvote_andrei, eksam_sp_turniiri_kokkuvote_andrei, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov', 'ei ole olemas', 'VIGA', eksam_sp_turniiri_kokkuvote_andrei*0, eksam_sp_turniiri_kokkuvote_andrei, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_turniiri_kokkuvote_andrei*0, eksam_sp_turniiri_kokkuvote_andrei, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 72
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_turniiri_kokkuvote_kirjete_arv44, eksam_sp_turniiri_kokkuvote_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 72', 'VIGA', eksam_sp_turniiri_kokkuvote_kirjete_arv44*0, eksam_sp_turniiri_kokkuvote_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_turniiri_kokkuvote_kirjete_arv44*0, eksam_sp_turniiri_kokkuvote_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (mangija varchar(100), klubinimi varchar(100), punktid numeric);
			unload 	select * from sp_turniiri_kokkuvote(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;

			if 		exists (select * from eksam where mangija = 'Laine, Hari' and klubinimi = 'Areng' and punktid = 1.0)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, Laine Hari', 'on olemas', 'OK', eksam_sp_turniiri_kokkuvote_laine, eksam_sp_turniiri_kokkuvote_laine, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, Laine Hari', 'ei ole olemas', 'VIGA', eksam_sp_turniiri_kokkuvote_laine*0, eksam_sp_turniiri_kokkuvote_laine, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, Laine Hari', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_turniiri_kokkuvote_laine*0, eksam_sp_turniiri_kokkuvote_laine, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 72
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, kirjete arv', 'on õige', 'OK', eksam_sp_turniiri_kokkuvote_kirjete_arv41, eksam_sp_turniiri_kokkuvote_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, kirjete arv', 'on vale, peab olema 72', 'VIGA', eksam_sp_turniiri_kokkuvote_kirjete_arv41*0, eksam_sp_turniiri_kokkuvote_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_turniiri_kokkuvote" turniiril: Kolme klubi kohtumine, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_turniiri_kokkuvote_kirjete_arv41*0, eksam_sp_turniiri_kokkuvote_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	

create	procedure eksam_procedure_manguaeg_turniiril()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_manguaeg_turniiril') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril"', 'ei ole olemas', 'VIGA', eksam_sp_manguaeg_turniiril*0, eksam_sp_manguaeg_turniiril, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril"', 'on olemas', 'OK', eksam_sp_manguaeg_turniiril_olemasolu, eksam_sp_manguaeg_turniiril_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_manguaeg_turniiril*0, eksam_sp_manguaeg_turniiril, eksam_jr);
			return;
		end catch;
		
		begin try
			select id into turniir1 from turniirid where nimi = 'Eesti meistrivõistlused 2007';
		end try
		begin catch
			select id into turniir1 from turniirid where nimetus = 'Eesti meistrivõistlused 2007';
		end catch;
		
		begin try
			select id into turniir2 from turniirid where nimi = 'Kolme klubi kohtumine';
		end try
		begin catch
			select id into turniir2 from turniirid where nimetus = 'Kolme klubi kohtumine';
		end catch;

		begin try
			create	or replace table eksam (mangija varchar(100), aeg varchar(50));
			unload 	select * from sp_manguaeg_turniiril(turniir1) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;
			
			if 		exists (select * from eksam where mangija = 'Andrei Sosnov' and aeg = '3452')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov ajaga 3452s', 'on olemas', 'OK', eksam_sp_manguaeg_turniiril_andrei, eksam_sp_manguaeg_turniiril_andrei, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov ajaga 3452s', 'ei ole olemas', 'VIGA', eksam_sp_manguaeg_turniiril_andrei*0, eksam_sp_manguaeg_turniiril_andrei, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Andrei Sosnov ajaga 3452s', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_manguaeg_turniiril_andrei*0, eksam_sp_manguaeg_turniiril_andrei, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 63
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_manguaeg_turniiril_kirjete_arv44, eksam_sp_manguaeg_turniiril_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 63', 'VIGA', eksam_sp_manguaeg_turniiril_kirjete_arv44*0, eksam_sp_manguaeg_turniiril_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_manguaeg_turniiril_kirjete_arv44*0, eksam_sp_manguaeg_turniiril_kirjete_arv44, eksam_jr);
		end catch;
		
		begin try
			create	or replace table eksam (mangija varchar(100), aeg varchar(50));
			unload 	select * from sp_manguaeg_turniiril(turniir2) to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;

			if 		exists (select * from eksam where mangija = 'Anna Ristik' and aeg = '4735')
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, Anna Ristik ajaga 4735', 'on olemas', 'OK', eksam_sp_manguaeg_turniiril_laine, eksam_sp_manguaeg_turniiril_laine, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, Anna Ristik ajaga 4735', 'ei ole olemas', 'VIGA', eksam_sp_manguaeg_turniiril_laine*0, eksam_sp_manguaeg_turniiril_laine, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, Anna Ristik ajaga 4735', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_manguaeg_turniiril_laine*0, eksam_sp_manguaeg_turniiril_laine, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 11
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on õige', 'OK', eksam_sp_manguaeg_turniiril_kirjete_arv41, eksam_sp_manguaeg_turniiril_kirjete_arv41, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'on vale, peab olema 11', 'VIGA', eksam_sp_manguaeg_turniiril_kirjete_arv41*0, eksam_sp_manguaeg_turniiril_kirjete_arv41, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_manguaeg_turniiril" turniiril: Kolme klubi kohtumine, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_manguaeg_turniiril_kirjete_arv41*0, eksam_sp_manguaeg_turniiril_kirjete_arv41, eksam_jr);
		end catch;
		
	end;
	
	
create	procedure eksam_procedure_vordne_nime_pikkus()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'sp_vordne_nime_pikkus') 
			then	insert Staatus values('Eksam', 'Protseduur "sp_vordne_nime_pikkus"', 'ei ole olemas', 'VIGA', eksam_sp_vordne_nime_pikkus*0, eksam_sp_vordne_nime_pikkus, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "sp_vordne_nime_pikkus"', 'on olemas', 'OK', eksam_sp_vordne_nime_pikkus_olemasolu, eksam_sp_vordne_nime_pikkus_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_vordne_nime_pikkus"', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_vordne_nime_pikkus*0, eksam_sp_vordne_nime_pikkus, eksam_jr);
			return;
		end catch;

		begin try
			create	or replace table eksam (valgetega_mangija varchar(100), mustadega_mangija varchar(100), partii_id int, turniiri_id int);
			unload 	select * from sp_vordne_nime_pikkus() to 'C:\\TEMP\\eksam_check.txt' ENCODING 'UTF-8';
			load 	table eksam from 'C:\\TEMP\\eksam_check.txt' defaults on;
			
			if 		exists (select * from eksam where valgetega_mangija = 'Nadja, Puhasmaa' and mustadega_mangija = 'Malle, Maasikas' and turniiri_id = 41)
			then  	insert 	Staatus values('Eksam', 'Protseduur "sp_vordne_nime_pikkus" partii Nadja Puhasmaa ja Malle Maasikas', 'on olemas', 'OK', eksam_sp_vordne_nime_pikkus_andrei, eksam_sp_vordne_nime_pikkus_andrei, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "sp_vordne_nime_pikkus" partii Nadja Puhasmaa ja Malle Maasikas', 'ei ole olemas', 'VIGA', eksam_sp_vordne_nime_pikkus_andrei*0, eksam_sp_vordne_nime_pikkus_andrei, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "sp_vordne_nime_pikkus" turniiril: partii Nadja Puhasmaa ja Malle Maasikas', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_vordne_nime_pikkus_andrei*0, eksam_sp_vordne_nime_pikkus_andrei, eksam_jr)
		end catch;
		
		begin try
			if 		(select count(*) from eksam) = 33
			then 	insert Staatus values ('Eksam', 'Protseduur "sp_vordne_nime_pikkus" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on õige', 'OK', eksam_sp_vordne_nime_pikkus_kirjete_arv44, eksam_sp_vordne_nime_pikkus_kirjete_arv44, eksam_jr);
			else	insert Staatus values ('Eksam', 'Protseduur "sp_vordne_nime_pikkus" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'on vale, peab olema 33', 'VIGA', eksam_sp_vordne_nime_pikkus_kirjete_arv44*0, eksam_sp_vordne_nime_pikkus_kirjete_arv44, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "sp_vordne_nime_pikkus" turniiril: Eesti meistrivõistlused 2007, kirjete arv', 'Automaatkontrollis on viga!', 'VIGA', eksam_sp_vordne_nime_pikkus_kirjete_arv44*0, eksam_sp_vordne_nime_pikkus_kirjete_arv44, eksam_jr);
		end catch;
		
		
	end;
	
	
create	procedure eksam_function_must_viik_min()
	begin
		declare turniir1, turniir2 int;
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'f_must_viik_min') 
			then	insert Staatus values('Eksam', 'Protseduur "f_must_viik_min"', 'ei ole olemas', 'VIGA', eksam_f_must_viik_min*0, eksam_f_must_viik_min, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "f_must_viik_min"', 'on olemas', 'OK', eksam_f_must_viik_min_olemasolu, eksam_f_must_viik_min_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "f_must_viik_min"', 'Automaatkontrollis on viga!', 'VIGA', eksam_f_must_viik_min*0, eksam_f_must_viik_min, eksam_jr);
			return;
		end catch;

		begin try
			if 		(select f_must_viik_min()) = 'Hiie Hiid'
			then  	insert 	Staatus values('Eksam', 'Protseduur "f_must_viik_min" Hiie Hiid', 'on olemas', 'OK', eksam_f_must_viik_min_tulemus, eksam_f_must_viik_min_tulemus, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "f_must_viik_min" Hiie Hiid', 'ei ole olemas', 'VIGA', eksam_f_must_viik_min_tulemus*0, eksam_f_must_viik_min_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "f_must_viik_min" turniiril: Hiie Hiid', 'Automaatkontrollis on viga!', 'VIGA', eksam_f_must_viik_min_tulemus*0, eksam_f_must_viik_min_tulemus, eksam_jr)
		end catch;
		
	end;
	
create	procedure eksam_function_mangija_aeg_turniiril()
	begin
		begin try
			if 		not exists (select * from sysprocedure where proc_name = 'f_mangija_aeg_turniiril') 
			then	insert Staatus values('Eksam', 'Protseduur "f_mangija_aeg_turniiril"', 'ei ole olemas', 'VIGA', eksam_f_mangija_aeg_turniiril*0, eksam_f_mangija_aeg_turniiril, eksam_jr);
			return;
			else	insert Staatus values('Eksam', 'Protseduur "f_mangija_aeg_turniiril"', 'on olemas', 'OK', eksam_f_mangija_aeg_turniiril_olemasolu, eksam_f_mangija_aeg_turniiril_olemasolu, eksam_jr);
			endif;
		end try
		begin catch
			insert Staatus values ('Eksam', 'Protseduur "f_mangija_aeg_turniiril"', 'Automaatkontrollis on viga!', 'VIGA', eksam_f_mangija_aeg_turniiril*0, eksam_f_mangija_aeg_turniiril, eksam_jr);
			return;
		end catch;

		begin try
			if 		(select f_mangija_aeg_turniiril(92,44)) >= 22
			then  	insert 	Staatus values('Eksam', 'Protseduur "f_mangija_aeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Toomas Umniki aeg', 'on õige', 'OK', eksam_f_mangija_aeg_turniiril_tulemus, eksam_f_mangija_aeg_turniiril_tulemus, eksam_jr);
			else	insert 	Staatus values('Eksam', 'Protseduur "f_mangija_aeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Toomas Umniki aeg', 'on vale, peab olema vähemalt 22 min', 'VIGA', eksam_f_mangija_aeg_turniiril_tulemus*0, eksam_f_mangija_aeg_turniiril_tulemus, eksam_jr);
			endif;
		end try
		begin catch
			insert 	Staatus values('Eksam', 'Protseduur "f_mangija_aeg_turniiril" turniiril: Eesti meistrivõistlused 2007, Toomas Umniki aeg', 'Automaatkontrollis on viga!', 'VIGA', eksam_f_mangija_aeg_turniiril_tulemus*0, eksam_f_mangija_aeg_turniiril_tulemus, eksam_jr)
		end catch;
		
	end;
	
create procedure käivita(versioon int)
	begin
		declare aeg datetime;
		declare eksam_kord int = 0;
		if versioon >= 2 and versioon < 7 then
			call teine_praktikum();
			call teine_kodutöö();
		endif;
		
		if versioon >= 3 and versioon < 7 then
			call kolmas_praktikum();
			call kolmas_kodutöö();
		endif;
		
		if versioon >= 4 and versioon < 7 then
			call view_turniiripartiid();
			call view_klubipartiikogused();
			call view_keskminepartii();
			call mv_partiide_arv_valgetega();
		endif;

		if versioon >= 5 and versioon < 7 then
			call view_edetabelid();
			call view_punktid();
			call function_liida();
			call function_klubisuurus();
			call procedure_uus_isik();
			call procedure_top10();
		endif;
		
		if versioon = 6 then
			call kuues_kodutöö();
			call trigger_partiiaeg();
			call trigger_klubi_olemasolu();
		endif;
		
		if versioon = 7 then
			-- Eksam I vaated - 8/8 tehtud
			--if 	exists (select * from systable where table_name = 'v_eelnevussuhe') then set eksam_kord = eksam_kord+1; call eksam_view_eelnevussuhe(); endif;
			--if 	exists (select * from systable where table_name = 'v_kaotusi_rohkem_yhest') then set eksam_kord = eksam_kord+1; call eksam_kaotusi_rohkem_yhest(); endif;
			--if 	exists (select * from systable where table_name = 'v_kiirviik') then set eksam_kord = eksam_kord+1; call eksam_view_kiirviik(); endif;
			--if 	exists (select * from systable where table_name = 'v_klubisisesed_viigid') then set eksam_kord = eksam_kord+1; call eksam_view_klubisisesed_viigid(); endif;
			--if 	exists (select * from systable where table_name = 'v_Must1') then set eksam_kord = eksam_kord+1; call eksam_view_must1(); endif;
			--if 	exists (select * from systable where table_name = 'v_nimekiri_partiidest') then set eksam_kord = eksam_kord+1; call eksam_view_nimekiri_partiidest(); endif;
			--if 	exists (select * from systable where table_name = 'v_rohkem_kolmest') then set eksam_kord = eksam_kord+1; call eksam_view_rohkem_kolmest(); endif;
			--if 	exists (select * from systable where table_name = 'v_must_valge') then set eksam_kord = eksam_kord+1; call eksam_view_must_valge(); endif;
			
			--Eksam I funktsioonid ja protseduurid 4/12
			--if 	exists (select * from sysprocedure where proc_name = 'sp_ei_manginud') then set eksam_kord = eksam_kord+1; call eksam_procedure_ei_manginud(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_koige_rohkem_partiisid_turniiril') then set eksam_kord = eksam_kord+1; call eksam_procedure_koige_rohkem_partiisid_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_koige_vahem_partiisid_turniiril') then set eksam_kord = eksam_kord+1; call eksam_procedure_koige_vahem_partiisid_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_mustadega_mangija_partiid_turniiril') then set eksam_kord = eksam_kord+1; call eksam_procedure_mustadega_mangija_partiid_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_teine_kolmas') then set eksam_kord = eksam_kord+1; call eksam_procedure_teine_kolmas(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_turniiri_kokkuvote') then set eksam_kord = eksam_kord+1; call eksam_procedure_turniiri_kokkuvote(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_manguaeg_turniiril') then set eksam_kord = eksam_kord+1; call eksam_procedure_manguaeg_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_vordne_nime_pikkus') then set eksam_kord = eksam_kord+1; call eksam_procedure_vordne_nime_pikkus(); endif;
			
			--if 	exists (select * from sysprocedure where proc_name = 'f_must_viik_min') then set eksam_kord = eksam_kord+1; call eksam_function_must_viik_min(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'f_mangija_aeg_turniiril') then set eksam_kord = eksam_kord+1; call eksam_function_mangija_aeg_turniiril(); endif;
			if 	exists (select * from sysprocedure where proc_name = 'f_turniiril_kolmas') then set eksam_kord = eksam_kord+1; call eksam_function_turniiril_kolmas(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'f_voitja_punktid_turniiril') then set eksam_kord = eksam_kord+1; call eksam_function_voitja_punktid_turniiril(); endif;
			
			--Eksam II vaated 1/8 tehtud
			--if 	exists (select * from systable where table_name = 'v_voit_must_valge') then set eksam_kord = eksam_kord+1; call eksam_view_voit_must_valge(); endif;
			
			--if 	exists (select * from systable where table_name = 'v_rohkemkahestkaotusest') then set eksam_kord = eksam_kord+1; call eksam_view_rohkemkahestkaotusest(); endif;
			--if 	exists (select * from systable where table_name = 'v_samaeesnimi') then set eksam_kord = eksam_kord+1; call eksam_view_samaeesnimi(); endif;
			--if 	exists (select * from systable where table_name = 'v_sama_tahega_nimed') then set eksam_kord = eksam_kord+1; call eksam_view_sama_tahega_nimed(); endif;
			--if 	exists (select * from systable where table_name = 'v_tulemused') then set eksam_kord = eksam_kord+1; call eksam_view_tulemused(); endif;
			--if 	exists (select * from systable where table_name = 'v_valge1') then set eksam_kord = eksam_kord+1; call eksam_view_valge1(); endif;
			--if 	exists (select * from systable where table_name = 'v_vordne_summa') then set eksam_kord = eksam_kord+1; call eksam_view_vordne_summa(); endif;
			--if 	exists (select * from systable where table_name = 'v_vahemalt_kaks_viiki') then set eksam_kord = eksam_kord+1; call eksam_view_vahemalt_kaks_viiki(); endif;
			
			--Eksam II funktsioonid ja protseduurid 0/12
			--if 	exists (select * from sysprocedure where proc_name = 'sp_asula_viigid') then set eksam_kord = eksam_kord+1; call eksam_procedure_asula_viigid(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_pikima_partii_mangijad') then set eksam_kord = eksam_kord+1; call eksam_procedure_pikima_partii_mangijad(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_valgetega_parem') then set eksam_kord = eksam_kord+1; call eksam_procedure_valgetega_parem(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_must_viik') then set eksam_kord = eksam_kord+1; call eksam_procedure_must_viik(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_rohkem_kui_2') then set eksam_kord = eksam_kord+1; call eksam_procedure_rohkem_kui_2(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_manguaeg_valgetega_turniiril') then set eksam_kord = eksam_kord+1; call eksam_procedure_manguaeg_valgetega_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_viik_klubikaaslasega') then set eksam_kord = eksam_kord+1; call eksam_procedure_viik_klubikaaslasega(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'sp_vahem_kui_3') then set eksam_kord = eksam_kord+1; call eksam_procedure_vahem_kui_3(); endif;
			
			--if 	exists (select * from sysprocedure where proc_name = 'f_lyhema_partii_mangijad') then set eksam_kord = eksam_kord+1; call eksam_function_lyhema_partii_mangijad(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'f_viigimeister') then set eksam_kord = eksam_kord+1; call eksam_function_viigimeister(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'f_parim_klubimangija_turniiril') then set eksam_kord = eksam_kord+1; call eksam_function_parim_klubimangija_turniiril(); endif;
			--if 	exists (select * from sysprocedure where proc_name = 'f_eelviimane') then set eksam_kord = eksam_kord+1; call eksam_function_eelviimane(); endif;
			
		endif;
		call arvuta_punktid(versioon);
		begin try
			select min(sisestatud) into aeg from inimesed;
			insert into staatus values ('Tudeng', 	(select eesnimi from inimesed where sisestatud = aeg), 
													(select perenimi from inimesed where sisestatud = aeg), '-', praktikum_3*0, praktikum_3*0, tudengi_nimi);
		end try
		begin catch
			insert into staatus values ('Tudeng', 'Eesnimi puudub', 'Perenimi puudub', 'VIGA', praktikum_3*0, praktikum_3*0, tudengi_nimi);
		end catch;
	end;

call	käivita(versioon);

select  ylesanne, Kontroll, Tagasiside, Olek, Punktid, Max_punktid from staatus where Olek = 'VIGA' or Olek = 'Vead Kokku' or Olek = 'Õiged Kokku' or olek = 'Hindepunktid' or ylesanne = 'Tudeng'
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;
