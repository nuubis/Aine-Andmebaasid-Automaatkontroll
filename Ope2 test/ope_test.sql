/* Muutuja mis määrab, milline kodutöö käivitatakse, 3=kodutöö 3, 5=kodutöö 5, 6=kodutöö 6 ja 7=kodutöö 7*/
create or replace variable versioon int = 7;
/* Muutuja, mis määrab, millist õppeainet kontrollitakse. "A" = Andmebaasid, "AA" = Andmebaaside alused */
create or replace variable aine varchar(5) = 'A';
/* Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab */
if exists (select * from sysprocedure where proc_name = 'check_column') 						then drop function check_column 						endif;
if exists (select * from sysprocedure where proc_name = 'check_column_t2pit2ht')				then drop function check_column_t2pit2ht 				endif;
if exists (select * from sysprocedure where proc_name = 'check_turniir_columns') 				then drop function check_turniir_columns				endif;
if exists (select * from sysprocedure where proc_name = 'check_fk') 							then drop function check_fk 							endif;
if exists (select * from sysprocedure where proc_name = 'table_inimesed') 						then drop function table_inimesed 						endif;
if exists (select * from sysprocedure where proc_name = 'table_isikud') 						then drop function table_isikud 						endif;
if exists (select * from sysprocedure where proc_name = 'table_klubid') 						then drop function table_klubid 						endif;
if exists (select * from sysprocedure where proc_name = 'table_partiid') 						then drop function table_partiid 						endif;
if exists (select * from sysprocedure where proc_name = 'table_turniirid') 						then drop function table_turniirid 						endif;
if exists (select * from sysprocedure where proc_name = 'muud_elemendid') 						then drop function muud_elemendid 						endif;
if exists (select * from sysprocedure where proc_name = 'deleteS') 								then drop function deleteS 								endif;
if exists (select * from sysprocedure where proc_name = 'find_table_id') 						then drop function find_table_id 						endif;
if exists (select * from sysprocedure where proc_name = 'find_table_name') 						then drop function find_table_name 						endif;
if exists (select * from sysprocedure where proc_name = 'find_column_name') 					then drop function find_column_name 					endif;
if exists (select * from sysprocedure where proc_name = 'check_unique')							then drop function check_unique 						endif;
if exists (select * from sysprocedure where proc_name = 'check_check')							then drop function check_check							endif;
if exists (select * from sysprocedure where proc_name = 'check_foreign_key')					then drop function check_foreign_key					endif;
if exists (select * from sysprocedure where proc_name = 'output_tulemus_txt')					then drop function output_tulemus_txt					endif;
if exists (select * from sysprocedure where proc_name = 'output_tulemus_csv')					then drop function output_tulemus_csv					endif;
if exists (select * from sysprocedure where proc_name = 'check_column_for_view') 				then drop function check_column_for_view				endif;
if exists (select * from sysprocedure where proc_name = 'check_column_for_view_t2pit2ht') 		then drop function check_column_for_view_t2pit2ht		endif;
if exists (select * from sysprocedure where proc_name = 'view_klubipartiikogused') 				then drop function view_klubipartiikogused 				endif;
if exists (select * from sysprocedure where proc_name = 'view_klubipartiikogused_1') 			then drop function view_klubipartiikogused_1 			endif;
if exists (select * from sysprocedure where proc_name = 'view_klubipartiikogused_2') 			then drop function view_klubipartiikogused_2 			endif;
if exists (select * from sysprocedure where proc_name = 'view_edetabelid') 						then drop function view_edetabelid 						endif;
if exists (select * from sysprocedure where proc_name = 'view_mangijad') 						then drop function view_mangijad 						endif;
if exists (select * from sysprocedure where proc_name = 'view_partiid') 						then drop function view_partiid 						endif;
if exists (select * from sysprocedure where proc_name = 'view_punktid') 						then drop function view_punktid 						endif;
if exists (select * from sysprocedure where proc_name = 'view_turniiripartiid') 				then drop function view_turniiripartiid 				endif;
if exists (select * from sysprocedure where proc_name = 'view_kolmik') 							then drop function view_kolmik							endif;
if exists (select * from sysprocedure where proc_name = 'arvuta_punktid') 						then drop function arvuta_punktid		 				endif;
if exists (select * from sysprocedure where proc_name = 'käivita') 								then drop function käivita 								endif;
if exists (select * from sysprocedure where proc_name = 'function_klubisuurus') 				then drop function function_klubisuurus					endif;
if exists (select * from sysprocedure where proc_name = 'function_nimi') 						then drop function function_nimi						endif;
if exists (select * from sysprocedure where proc_name = 'function_mangija_koormus') 			then drop function function_mangija_koormus				endif;
if exists (select * from sysprocedure where proc_name = 'function_mangija_voite_turniiril') 	then drop function function_mangija_voite_turniiril		endif;
if exists (select * from sysprocedure where proc_name = 'function_mangija_punktid_turniiril') 	then drop function function_mangija_punktid_turniiril	endif;
if exists (select * from sysprocedure where proc_name = 'procedure_uus_isik') 					then drop function procedure_uus_isik					endif;
if exists (select * from sysprocedure where proc_name = 'procedure_infopump') 					then drop function procedure_infopump					endif;
if exists (select * from sysprocedure where proc_name = 'procedure_top10') 						then drop function procedure_top10						endif;
if exists (select * from sysprocedure where proc_name = 'procedure_voit_viik_kaotus') 			then drop function procedure_voit_viik_kaotus			endif;
if exists (select * from sysprocedure where proc_name = 'muud_indexid') 						then drop function muud_indexid							endif;
if exists (select * from sysprocedure where proc_name = 'view_V1') 								then drop function view_V1								endif;
if exists (select * from sysprocedure where proc_name = 'view_V2') 								then drop function view_V2								endif;
if exists (select * from sysprocedure where proc_name = 'view_V3') 								then drop function view_V3								endif;
if exists (select * from sysprocedure where proc_name = 'view_V4') 								then drop function view_V4								endif;
if exists (select * from sysprocedure where proc_name = 'view_V5') 								then drop function view_V5								endif;
if exists (select * from sysprocedure where proc_name = 'view_V6') 								then drop function view_V6								endif;
if exists (select * from sysprocedure where proc_name = 'view_V7') 								then drop function view_V7								endif;
if exists (select * from sysprocedure where proc_name = 'view_V8') 								then drop function view_V8								endif;
if exists (select * from sysprocedure where proc_name = 'view_V9') 								then drop function view_V9								endif;
if exists (select * from sysprocedure where proc_name = 'view_V10') 							then drop function view_V10								endif;
if exists (select * from sysprocedure where proc_name = 'view_V11') 							then drop function view_V11								endif;
if exists (select * from sysprocedure where proc_name = 'view_V12') 							then drop function view_V12								endif;
if exists (select * from sysprocedure where proc_name = 'view_asulaklubisid') 					then drop function view_asulaklubisid					endif;
if exists (select * from sysprocedure where proc_name = 'view_asulasuurus') 					then drop function view_asulasuurus						endif;
if exists (select * from sysprocedure where proc_name = 'table_asulad') 						then drop function table_asulad							endif;
if exists (select * from sysprocedure where proc_name = 'procedure_kustuta_klubi') 				then drop function procedure_kustuta_klubi				endif;
if exists (select * from sysprocedure where proc_name = 'trigger_kustuta_klubi') 				then drop function trigger_kustuta_klubi				endif;
if exists (select * from sysprocedure where proc_name = 'trigger_kustuta_klubi_isikutega') 		then drop function trigger_kustuta_klubi_isikutega		endif;
if exists (select * from sysprocedure where proc_name = 'trigger_lisa_klubi') 					then drop function trigger_lisa_klubi					endif;
if exists (select * from sysprocedure where proc_name = 'check_error') 							then drop function check_error							endif;
if exists (select * from sysprocedure where proc_name = 'check_error_paar') 					then drop function check_error_paar						endif;
if exists (select * from sysprocedure where proc_name = 'check_error_tapitaht') 				then drop function check_error_tapitaht					endif;


/* Kodutööde max punktid */
create 	or replace variable kodutöö_3							numeric = 100;
create 	or replace variable kodutöö_5							numeric = 132; // (100 + (kodutöö_3 punktid - kirjete_arvu punktid) * 0.5 = 32)
create 	or replace variable kodutöö_6							numeric = 157; // (100 + (kodutöö_5 punktid * 0.25 = 50) + (kodutöö_3 punktid - kirjete_arvu punktid) * 0.5 = 32) 
create 	or replace variable kodutöö_7							numeric = 182; // (100 + (kodutöö_6 punktid * 0.25 = 50) + (kodutöö_5 punktid * 0.25 = 50) + (kodutöö_3 punktid - kirjete_arvu punktid) * 0.5 = 32) 
/* Kodutööde punktide osakaalu muutujate loomine ja määramine */
create 	or replace variable kolmas_kodutöö 						numeric = 1.0;
create 	or replace variable viies_kodutöö 						numeric = 1.0;
create 	or replace variable kuues_kodutöö 						numeric = 1.0;
create 	or replace variable kolmas_kodutöö_kirjed 				numeric = 1.0;

/* Punktide osakaalu muutujate määramine kodutöö numbri alusel */
if 		versioon > 3 
then 	set kolmas_kodutöö = 0.5; 
		set kolmas_kodutöö_kirjed = 0.0
endif;

if 		versioon > 5	
then 	set viies_kodutöö = 0.25
endif;

if 		versioon > 6 
then 	set kuues_kodutöö = 0.25 
endif;

/*Kodutöö 3 punktid kokku = 100p */
/* Tabelite punktide muutujad - Hindeskaala punktid, iga kodutöö osa on 100p */
/* https://github.com/nuubis/Automaattestid-andmebaaside-ainele/wiki/Kodut%C3%B6%C3%B6--3-punktid */
/* Tabel inimesed punktid, kokku on 6p */
create or replace variable inimesed_tabel 								numeric = 6.0 * kolmas_kodutöö;
create or replace variable inimesed_veergude_arv 						numeric = 1.0 * kolmas_kodutöö;
create or replace variable inimesed_eesnimi 							numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_perenimi 							numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_sugu 								numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_sünnipäev 							numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_sisestatud 							numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_isikukood 							numeric = 0.5 * kolmas_kodutöö;
create or replace variable inimesed_check_sugu 							numeric = 2.0 * kolmas_kodutöö;
/* Tabel isikud, kokku on 20p */
create or replace variable isikud_tabel 								numeric = 20.0 * kolmas_kodutöö;
create or replace variable isikud_veergude_arv 							numeric = 1.0 * kolmas_kodutöö;
create or replace variable isikud_id 									numeric = 2.0 * kolmas_kodutöö; 	
create or replace variable isikud_eesnimi 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable isikud_perenimi 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable isikud_isikukood 							numeric = 1.0 * kolmas_kodutöö; 
create or replace variable isikud_klubi 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable isikud_unique_ees_pere 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable isikud_kirjete_arv 							numeric = 12.0 * kolmas_kodutöö_kirjed;
/* Tabel klubid, kokku on 10p */
create or replace variable klubid_tabel 								numeric = 10.0 * kolmas_kodutöö;
create or replace variable klubid_veergude_arv 							numeric = 1.0 * kolmas_kodutöö;
create or replace variable klubid_id 									numeric = 1.0 * kolmas_kodutöö; 		
create or replace variable klubid_nimi 									numeric = 1.0 * kolmas_kodutöö;
create or replace variable klubid_asukoht 								numeric = 1.0 * kolmas_kodutöö;
create or replace variable klubid_unique_nimi 							numeric = 1.0 * kolmas_kodutöö;
create or replace variable klubid_kirjete_arv 							numeric = 5.0 * kolmas_kodutöö_kirjed;
/* Tabel turniirid, kokku on 10p */
create or replace variable turniirid_tabel 								numeric = 10.0 * kolmas_kodutöö;
create or replace variable turniirid_veergude_arv 						numeric = 1.0 * kolmas_kodutöö;
create or replace variable turniirid_id 								numeric = 1.0 * kolmas_kodutöö; 	
create or replace variable turniirid_nimi 								numeric = 2.0 * kolmas_kodutöö; 
create or replace variable turniirid_toimumiskoht 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable turniirid_alguskuupäev 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable turniirid_lõppkuupäev 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable turniirid_unique_nimi 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable turniirid_kirjete_arv 						numeric = 2.0 * kolmas_kodutöö_kirjed;
/* Tabel partiid, kokku on 30p */
create or replace variable partiid_tabel 								numeric = 30.0 * kolmas_kodutöö;
create or replace variable partiid_veergude_arv 						numeric = 1.0 * kolmas_kodutöö;
create or replace variable partiid_id 									numeric = 1.0 * kolmas_kodutöö; 	
create or replace variable partiid_turniir 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_algushetk 							numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_lõpphetk 							numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_valge 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_must 								numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_valge_tulemus 						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_musta_tulemus						numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_kokkuvõte 							numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_check_valge_tulemus 					numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_check_musta_tulemus 					numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_check_valge_musta_tulemus 			numeric = 1.0 * kolmas_kodutöö; 
create or replace variable partiid_kirjete_arv 							numeric = 17.0 * kolmas_kodutöö_kirjed;
/* Välisvõtmed, kokku on 16p */
create or replace variable välisvõti_isik_2_klubi 						numeric = 4.0 * kolmas_kodutöö;
create or replace variable välisvõti_partii_2_isik_must 				numeric = 4.0 * kolmas_kodutöö;
create or replace variable välisvõti_partii_2_isik_valge 				numeric = 4.0 * kolmas_kodutöö;
create or replace variable välisvõti_partii_2_turniir 					numeric = 4.0 * kolmas_kodutöö;
/* Välisvõtmete triggerid, kokku on 8p */
create or replace variable trigger_cascade 								numeric = 4.0 * kolmas_kodutöö;
create or replace variable trigger_delete 								numeric = 4.0 * kolmas_kodutöö;

/*Kodutöö 5 punktid kokku = 100p */
/* Vaadete punktide muutujad */
/* https://github.com/nuubis/Automaattestid-andmebaaside-ainele/wiki/Kodut%C3%B6%C3%B6-4-punktid */
/* Vaade edetabelid, kokku on 30p */
create or replace variable v_edetabelid 								numeric = 30.0 * viies_kodutöö;
create or replace variable v_edetabelid_veergude_arv 					numeric = 1.0 * viies_kodutöö;
create or replace variable v_edetabelid_mängija 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_edetabelid_turniir 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_edetabelid_punkte 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_edetabelid_punkte_täiskohaga 				numeric = 4.0 * viies_kodutöö;
create or replace variable v_edetabelid_punkte_komakohaga 				numeric = 8.0 * viies_kodutöö;
create or replace variable v_edetabelid_kirjete_arv 					numeric = 14.0 * viies_kodutöö;
/* Vaade klubipartiikogused_1, kokku on 10p */
create or replace variable v_klubipartiikogused_1 						numeric = 10.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_1_veergude_arv 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_1_klubi_nimi 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_1_partiisid 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_1_partiide_arvu_summa 	numeric = 7.0 * viies_kodutöö;
/* Vaade klubipartiikogused_2, kokku on 5p */
create or replace variable v_klubipartiikogused_2 						numeric = 5.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_2_veergude_arv 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_2_klubi_nimi 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_2_partiisid 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_2_partiide_arvu_summa 	numeric = 2.0 * viies_kodutöö;
/* Vaade mängijad, kokku on 5p */
create or replace variable v_mangijad 									numeric = 5.0 * viies_kodutöö;
create or replace variable v_mangijad_veergude_arv 						numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_klubi_nimi 						numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_klubi_id 							numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_isik_nimi 						numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_isik_nimi_kuju 					numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_isik_id 							numeric = 0.5 * viies_kodutöö;
create or replace variable v_mangijad_kirjete_arv 						numeric = 2.0 * viies_kodutöö;
/* Vaade turniiripartiid, kokku on 10p */
create or replace variable v_turniiripartiid 							numeric = 10.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_veergude_arv 				numeric = 1.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_turniir_nimi 				numeric = 1.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_partii_id 					numeric = 1.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_partii_algus 				numeric = 1.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_partii_lõpp 				numeric = 1.0 * viies_kodutöö;
create or replace variable v_turniiripartiid_kirjete_arv 				numeric = 5.0 * viies_kodutöö;
/* Vaade punktid, kokku on 20p */
create or replace variable v_punktid 									numeric = 20.0 * viies_kodutöö;
create or replace variable v_punktid_veergude_arv 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_partii 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_turniir 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_mängija 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_värv 								numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_punkt 								numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_punkt_koma 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_punkt_täis 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_punktid_kirjete_arv 						numeric = 4.0 * viies_kodutöö;
create or replace variable v_punktid_punkti_summa 						numeric = 8.0 * viies_kodutöö;
/* Vaade partiid, kokku on 12p */
create or replace variable v_partiid 									numeric = 12.0 * viies_kodutöö;
create or replace variable v_partiid_veergude_arv 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_id 								numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_turniir 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_algus								numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_valge_nimi 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_valge_klubi 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_valge_punkt 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_must_nimi 							numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_must_klubi 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_must_punkt 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_kirjete_arv 						numeric = 1.0 * viies_kodutöö;
create or replace variable v_partiid_punkti_summa 						numeric = 1.0 * viies_kodutöö;
/* Vaade kolmik, kokku on 8p */
create or replace variable v_kolmik										numeric = 8.0 * viies_kodutöö;
create or replace variable v_kolmik_veergude_arv						numeric = 1.0 * viies_kodutöö;
create or replace variable v_kolmik_nimi								numeric = 0.5 * viies_kodutöö;
create or replace variable v_kolmik_punktid								numeric = 0.5 * viies_kodutöö;
create or replace variable v_kolmik_esimene_punktid						numeric = 1.0 * viies_kodutöö;
create or replace variable v_kolmik_kirjete_arv							numeric = 2.0 * viies_kodutöö;
create or replace variable v_kolmik_punkti_summa						numeric = 3.0 * viies_kodutöö;
/*Kodutöö 6 punktid kokku = 100p */
create or replace variable f_klubisuurus 								numeric = 10 * kuues_kodutöö;
create or replace variable f_nimi 										numeric = 10 * kuues_kodutöö;
create or replace variable f_nimi_lühike 								numeric = 5 * kuues_kodutöö;
create or replace variable f_nimi_pikk 									numeric = 5 * kuues_kodutöö;
create or replace variable f_mangija_koormus 							numeric = 10 * kuues_kodutöö;
create or replace variable f_mangija_voite_turniiril 					numeric = 10 * kuues_kodutöö;
create or replace variable f_mangija_punktid_turniiril 					numeric = 10 * kuues_kodutöö;
create or replace variable f_mangija_punktid_turniiril_täiskohaga 		numeric = 5 * kuues_kodutöö;
create or replace variable f_mangija_punktid_turniiril_komakohaga 		numeric = 5 * kuues_kodutöö;
create or replace variable sp_uus_isik 									numeric = 10 * kuues_kodutöö;
create or replace variable sp_infopump 									numeric = 10 * kuues_kodutöö;
create or replace variable sp_infopump_kirjete_arv 						numeric = 2 * kuues_kodutöö;
create or replace variable sp_infopump_turniir_arv 						numeric = 3 * kuues_kodutöö;
create or replace variable sp_infopump_klubi_järjekord 					numeric = 3 * kuues_kodutöö;
create or replace variable sp_infopump_isiku_järjekord 					numeric = 2 * kuues_kodutöö;
create or replace variable sp_top10 									numeric = 10 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus 							numeric = 10 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus_võidud 					numeric = 2 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus_viigid 					numeric = 2 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus_kaotused 				numeric = 2 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus_kirjete_arv 				numeric = 4 * kuues_kodutöö;
create or replace variable sp_voit_viik_kaotus_kontrollid 				numeric = 10 * kuues_kodutöö - sp_voit_viik_kaotus_kirjete_arv;
create or replace variable muud_indexid_partiid 						numeric = 5 * kuues_kodutöö;
create or replace variable muud_indexid_turniirid 						numeric = 5 * kuues_kodutöö;

/* Kodutöö 7 punktid kokku = 100p */
/* Tabel Asulad kokku on 16p*/
create or replace variable asulad_tabel 								numeric = 16.0;
create or replace variable asulad_veergude_arv 							numeric = 4.0;
create or replace variable asulad_id 									numeric = 4.0;
create or replace variable asulad_nimi 									numeric = 4.0;
create or replace variable asulad_unique_nimi 							numeric = 4.0;
/* Tabelite klubid ja turniirid veerg Asula, kokku 2p */
create or replace variable klubid_asula 								numeric = 1.0;
create or replace variable turniirid_asula 								numeric = 1.0;
/* Tabel inimesed kirjete arv */
if versioon = 7 then
create or replace variable inimesed_check_sugu 							numeric = 1.0 * kolmas_kodutöö; // algselt on 2p, aga siin läheb 1 maha kirjete jaoks PS! Ma ei arvesta siin multiplieri teksti sest idee jääb samaks
create or replace variable inimesed_kirjete_arv 						numeric = 1.0 * kolmas_kodutöö;
endif;
/* Välisvõtmed kokkku on 8p*/
create or replace variable välisvõti_klubi_2_asula 						numeric = 4.0;
create or replace variable välisvõti_turniir_2_asula 					numeric = 4.0;
/* Vaade asulaklubisid kokku on 6p */
create or replace variable v_asulaklubisid 								numeric = 6.0;
create or replace variable v_asulaklubisid_veergude_arv 				numeric = 1.0;
create or replace variable v_asulaklubisid_asula_id 					numeric = 1.0;
create or replace variable v_asulaklubisid_asula_nimi 					numeric = 1.0;
create or replace variable v_asulaklubisid_klubisid 					numeric = 1.0;
create or replace variable v_asulaklubisid_kirjete_arv 					numeric = 1.0;
create or replace variable v_asulaklubisid_kirje 						numeric = 1.0;
/* Vaade asulasuurus kokku on 6p */
create or replace variable v_asulasuurus 								numeric = 6.0;
create or replace variable v_asulasuurus_veergude_arv 					numeric = 1.0;
create or replace variable v_asulasuurus_asula_id 						numeric = 1.0;
create or replace variable v_asulasuurus_asula_nimi 					numeric = 1.0;
create or replace variable v_asulasuurus_mangijaid 						numeric = 1.0;
create or replace variable v_asulasuurus_kirjete_arv 					numeric = 1.0;
create or replace variable v_asulasuurus_kirje 							numeric = 1.0;
/* Protseduur sp_kustuta_klubi kokku on 9p*/
create or replace variable sp_kustuta_klubi 							numeric = 7.0;
/* Triggerite punktid kokku on 30p*/
create or replace variable tg_lisa_klubi 								numeric = 10.0;
create or replace variable tg_lisa_klubi_nimi 							numeric = 5.0;
create or replace variable tg_lisa_klubi_id 							numeric = 5.0;
create or replace variable tg_kustuta_klubi 							numeric = 10.0;
create or replace variable tg_kustuta_klubi_ei 							numeric = 5.0;
create or replace variable tg_kustuta_klubi_jah 						numeric = 5.0;
create or replace variable tg_kustuta_klubi_isikutega 					numeric = 10.0;
create or replace variable tg_kustuta_klubi_isikutega_jah 				numeric = 5.0;
create or replace variable tg_kustuta_klubi_isikutega_ei 				numeric = 5.0;
/* Vaated V1-V12 punktid kokku = 24p */
create or replace variable v_1 											numeric = 2.0;
create or replace variable v_1_veergude_arv 							numeric = 0.5;
create or replace variable v_1_eesnimi 									numeric = 0.5;
create or replace variable v_1_perenimi 								numeric = 0.5;
create or replace variable v_1_kirjete_arv 								numeric = 0.5;
create or replace variable v_2 											numeric = 2.0;
create or replace variable v_2_veergude_arv 							numeric = 0.5;
create or replace variable v_2_liikmete_arv 							numeric = 1.0;
create or replace variable v_2_kirjete_arv 								numeric = 0.5;
create or replace variable v_3											numeric = 2.0;
create or replace variable v_3_veergude_arv 							numeric = 0.5;
create or replace variable v_3_perenimi 								numeric = 0.5;
create or replace variable v_3_perenimi_m 								numeric = 0.5;
create or replace variable v_3_kirjete_arv 								numeric = 0.5;
create or replace variable v_4 											numeric = 2.0;
create or replace variable v_4_veergude_arv 							numeric = 0.5;
create or replace variable v_4_algushetk 								numeric = 0.5;
create or replace variable v_4_aeg 										numeric = 0.5;
create or replace variable v_4_kirjete_arv 								numeric = 0.5;
create or replace variable v_5 											numeric = 3.0;
create or replace variable v_5_veergude_arv 							numeric = 0.5;
create or replace variable v_5_valge 									numeric = 0.5;
create or replace variable v_5_must 									numeric = 0.5;
create or replace variable v_5_kirjete_arv 								numeric = 0.5;
create or replace variable v_5_partii 									numeric = 1.0;
create or replace variable v_6 											numeric = 2.0;
create or replace variable v_6_veergude_arv 							numeric = 0.5;
create or replace variable v_6_isik 									numeric = 1.0;
create or replace variable v_6_kirjete_arv 								numeric = 0.5;
create or replace variable v_7 											numeric = 2.0;
create or replace variable v_7_veergude_arv 							numeric = 0.5;
create or replace variable v_7_isik 									numeric = 1.0;
create or replace variable v_7_kirjete_arv 								numeric = 0.5;
create or replace variable v_8 											numeric = 2.0;
create or replace variable v_8_veergude_arv 							numeric = 1.0;
create or replace variable v_8_kirjete_arv 								numeric = 1.0;
create or replace variable v_9 											numeric = 2.0;
create or replace variable v_9_veergude_arv 							numeric = 0.5;
create or replace variable v_9_arvo 									numeric = 1.0;
create or replace variable v_9_kirjete_arv 								numeric = 0.5;
create or replace variable v_10 										numeric = 2.0;
create or replace variable v_10_veergude_arv 							numeric = 0.5;
create or replace variable v_10_arvo 									numeric = 1.0;
create or replace variable v_10_kirjete_arv 							numeric = 0.5;
create or replace variable v_11 										numeric = 2.0;
create or replace variable v_11_veergude_arv 							numeric = 0.5;
create or replace variable v_11_kirjete_arv 							numeric = 0.5;
create or replace variable v_11_maria 									numeric = 1.0;
create or replace variable v_12 										numeric = 2.0;
create or replace variable v_12_veergude_arv 							numeric = 0.5;
create or replace variable v_12_kirjete_arv 							numeric = 0.5;
create or replace variable v_12_punktid 								numeric = 1.0;

/* Aine "Sissejuhatus andmebaasidesse" punktide muutused ja lisamised */
/* Vaade klubipartiikogused, kokku on 10p */
create or replace variable v_klubipartiikogused 						numeric = 10.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_veergude_arv 			numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_klubi_nimi				numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_partiisid 				numeric = 1.0 * viies_kodutöö;
create or replace variable v_klubipartiikogused_partiide_arvu_summa 	numeric = 7.0 * viies_kodutöö;
/* 6nda kodutöö punktide lisamine, sest selles aines pole sp_infopump protseduuri */
if aine = 'S' then
	create or replace variable f_klubisuurus 								numeric = 11 * kuues_kodutöö;
	create or replace variable f_nimi 										numeric = 12 * kuues_kodutöö;
	create or replace variable f_nimi_lühike 								numeric = 6 * kuues_kodutöö;
	create or replace variable f_nimi_pikk 									numeric = 6 * kuues_kodutöö;
	create or replace variable f_mangija_koormus 							numeric = 11 * kuues_kodutöö;
	create or replace variable f_mangija_voite_turniiril 					numeric = 11 * kuues_kodutöö;
	create or replace variable f_mangija_punktid_turniiril 					numeric = 12 * kuues_kodutöö;
	create or replace variable f_mangija_punktid_turniiril_täiskohaga 		numeric = 6 * kuues_kodutöö;
	create or replace variable f_mangija_punktid_turniiril_komakohaga 		numeric = 6 * kuues_kodutöö;
	create or replace variable sp_uus_isik 									numeric = 11 * kuues_kodutöö;
	create or replace variable sp_top10 									numeric = 12 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus 							numeric = 10 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus_võidud 					numeric = 2 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus_viigid 					numeric = 2 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus_kaotused 				numeric = 2 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus_kirjete_arv				numeric = 4 * kuues_kodutöö;
	create or replace variable sp_voit_viik_kaotus_kontrollid 				numeric = (10 - sp_voit_viik_kaotus_kirjete_arv) * kuues_kodutöö;
	create or replace variable muud_indexid_partiid 						numeric = 5 * kuues_kodutöö;
	create or replace variable muud_indexid_turniirid 						numeric = 5 * kuues_kodutöö;
endif;

/* Veateadete järjekord */
/* Tabelitele jätan rohkem ruumi 1 - 5 */
create or replace variable tabelid_jr									int		= 1;
/* Välisvõtmed ja tg 6 - 10 */
create or replace variable välisvõtmed_jr								int		= 6;
create or replace variable välisvõtmed_tg_jr							int		= 7;
/* Trigerid 11 - 14 */
create or replace variable trigerid_jr									int		= 11;
/* Teade 15, igaksjuhuks jätan siia veel vaba ruumi kuni 20ni */
create or replace variable teade_jr										int		= 15;
/* Vaated 21 - 30, 10 vaatet on kokku*/
create or replace variable vaated_jr									int		= 21;
/* Funktsioonid 31 - 40, 5 funktsiooni */
create or replace variable funktsioonid_jr								int		= 31;
/* Protseduurid 41 - 50, 5 protseduuri */
create or replace variable protseduurid_jr								int		= 41;
/* Indeksid 51 - 55 */
create or replace variable indeksid_jr									int		= 51;
/* Vaated v1-12: 56 - 70, 12 vaatet */
create or replace variable vaated_1_12_jr								int		= 56;
/* Punktid ja hindepunktid ning tudengi nimi 80 - 90*/ 
create or replace variable max_punktid_jr								int		= 80;
create or replace variable hindepunktid_jr								int		= 81;
create or replace variable tudeng_jr									int		= 82;

/* Staatus tabeli loomine/kustutamine - kui tabel eksisteerib siis kustutatakse see ära ja siis luuakse uuesti */
if exists (select * from systable where table_name = 'Staatus') then drop table Staatus endif; // Punktid numeric(7,2)
create table Staatus(Nimi varchar(100) not null, Veerg varchar(100), Tagasiside varchar(1000), Olek varchar(100), Punktid numeric, Max_punktid numeric, Soovitus varchar(1000), Jr int default 100);
/* 
Staatus tabelis on siis: 
Nimi - tabeli, välivõtme, triggeri, vaate jne nimetus
Veerg - peamiselt tabeli veeru nimi, aga võib olla ka mingi muu kirjeldus
Tagasiside - mis on valesti, või '-' kui kõik on korras
Olek - veerg, mis näitab 'OK', 'VIGA', 'AEG', 'Kokku', 'Hindepunktid' märguandeid
Punktid - mitu punkti sai teatud ülesande osa eest
Max punktid - maksimum punktid, kui palju selle osa eest saab
Soovitus - soovitus, kust võib viga leida või kas sul on olemas X asi?
*/

/* delete staatus protseduur - protseduur, mis kustutab Staatus tabeli andmed */
create procedure deleteS()
begin
delete Staatus;
end;


/* Abifunktsioonid, et saada tabeli ID-st tabeli nimi, sissetulev muutujaks on tabeli ID süsteemis ja tagastus on tabeli nimi*/
create  function find_table_name(a_id int)
returns varchar(100)
begin 
declare t_name varchar(100);
select  table_name into t_name from systable
where   table_id = a_id;
return  t_name;
end;

/* Abifunktsioon, et saada tabeli nimest tabeli ID, sissetulev muutujaks on tabeli nimi süsteemis ja tagastus on tabeli ID */
create  function find_table_id(a_table_name varchar(100))
returns int
begin 
declare a_id int;
select  table_id into a_id from systable
where   upper(table_name) = upper(a_table_name);
return  a_id;
end;

/* Abifunktsioon, et saada tabeli ID-st ja tabeli nimest tudengi andmebaasi veeru nimi, sissetulev muutujaks on tabeli id ja veeru nimi süsteemis ja tagastus on andmebaasis oleva veeru nimi */
create  function find_column_name(a_table_id int, a_column_name varchar(100))
returns varchar(100)
begin 
declare c_name varchar(100);
select  column_name into c_name from syscolumn
where   table_id = a_table_id and upper(column_name) = upper(a_column_name);
return 	c_name;
end;

/* Veeru andmete kontrollimise protseduur - kontrollib ainult tabeli veeru atribuute 
Sissetulevad andmed: tabeli ID, 
veeru nimi, 
veeru "default" tingimus nt. null, autoincrement, datetime 
veeru "Pkey" tingimus ehk, kas see veerg on peavõti, [y/n]
veeru "Value" = p_nulls ehk, kas sellel veerul võib olla ka null väärtus või mitte [y/n]
veeru "Size" = p_width ehk, mis on selle veeru laius nt. varchar(250) ehk andmetüüp
punktid = muutuja mis on siis max punktide arv, mida saab selle veeru eest

Protseduuri sees loodavad muutujad: 
k1-k4 = kontroll tulemuste tagasiside; summa = punktide summa, mis on õigete tulemustega; max_sum = punktid, mis antakse protseduuri käivitamisel; 
p_def, p_key, p_nul, p_wid = iga tingimuse punktid, mille väätus on max punktidest 25%; t_name = antud veeru tabeli nimi, mida kasutatakse Staatus tabeli insertis.

Kõigepealt kontrollitakse, kas veerg on olemas, kui pole, siis lõpetatakse protseduur. Seejärel kontrollitakse veeru kõiki tingimusi ja muutujatesse k1-4 pannakse tagasiside.
Kui leidub vigu, siis antakse tagasiside, kui on korras, siis liidetakse tulemus summasse. Kõige lõpus lisatakse punktid Staatus tabelisse siis,
kui kõik on vale, siis kogu punktide arv 0, kui on osaliselt vale, siis on õigete summa ja kui kõik on õige siis saab max punktid.
Protseduur ei tagasta midagi.
*/

create  procedure check_column (p_table_id integer,     p_column_name varchar(30), 
                                p_default varchar(30),  p_pkey char(1), 
                                p_nulls char(1),        p_width integer, 
								punktid numeric,		Jr integer)
begin 
declare k1,k2,k3,k4 varchar (50);
declare summa, max_sum numeric;
declare p_def, p_key, p_nul, p_wid numeric(30,4) = punktid * 0.25;
declare c_name varchar(100) = '';
declare t_name varchar(50) = '';
set     t_name = find_table_name(p_table_id);
set 	summa = 0.00;
set 	max_sum = punktid;




if 		not exists (select * from syscolumn where upper(column_name) = upper(p_column_name) and table_id = p_table_id) 
then 	insert 	Staatus values ('Tabel "' || t_name || '"', 'Veergu "' || p_column_name || '" ei eksisteeri.', '-', 'VIGA', punktid*0, punktid, '', Jr);
return;
endif;

set c_name = find_column_name(p_table_id, p_column_name);

select  (if (isnull(upper("default"),upper('null')) = isnull(upper(p_default),upper('null'))) 
then    'ok' else 'Default tingimus vale.' endif) into k1 
from    syscolumn where table_id = p_table_id and column_name = c_name;

select  (if upper(pkey) = upper(p_pkey) then 'ok' else 'PKey on vale.' endif) into k2 
from    syscolumn where table_id = p_table_id and column_name = c_name;

select  (if upper("nulls") = isnull(upper(p_nulls), upper("nulls")) 
then    'ok' else 'Value tingimus on vale.' endif) into k3 
from    syscolumn where table_id = p_table_id and column_name = c_name;

select  (if width = p_width or width = (p_width + 1) then 'ok' else 'Andmetüüp on vale.' endif) into k4
from    syscolumn where table_id = p_table_id and column_name = c_name;

/* Special reegel, sest Tabelis Klubid, asukoht veeru default näitab alati et on vale */
if p_column_name = 'Asukoht' and exists (select * from syscolumn where column_name = c_name) then set k1 = 'ok' endif;

if k1   != 'ok' then insert Staatus values ('Tabel "' || t_name ||'"', p_column_name, k1,   'VIGA',	p_def*0, p_def, 	'Vaata, kas "default" tingimus on õige.', 	Jr) endif; 
if k2   != 'ok' then insert Staatus values ('Tabel "' || t_name ||'"', p_column_name, k2,   'VIGA',	p_key*0, p_key, 	'Vaata, kas Pkey on õige.', 				Jr) endif; 
if k3   != 'ok' then insert Staatus values ('Tabel "' || t_name ||'"', p_column_name, k3,   'VIGA',	p_nul*0, p_nul, 	'Vaata, kas on õige "Null" väärtus.', 		Jr) endif;
if k4   != 'ok' then insert Staatus values ('Tabel "' || t_name ||'"', p_column_name, k4,   'VIGA',	p_wid*0, p_wid, 	'', 										Jr) endif; 


if k1   = 'ok'  then set summa = summa + p_def endif; 
if k2   = 'ok'  then set summa = summa + p_key endif; 
if k3   = 'ok'  then set summa = summa + p_nul endif; 
if k4   = 'ok'  then set summa = summa + p_wid endif; 

if k1   != 'ok'  then set max_sum = max_sum - p_def endif; 
if k2   != 'ok'  then set max_sum = max_sum - p_key endif; 
if k3   != 'ok'  then set max_sum = max_sum - p_nul endif; 
if k4   != 'ok'  then set max_sum = max_sum - p_wid endif; 

if k1 	= 'ok' 	and k2 	= 'ok' and k3 = 'ok' and k4 = 'ok' then
insert 	Staatus values ('Tabel "' || t_name ||'"', p_column_name, '-',   'OK', punktid, punktid, '', Jr)
elseif 	k1 	!= 'ok' 	and k2 	!= 'ok' and k3 != 'ok' and k4 != 'ok' then 
create 	or replace variable boo int
else
insert 	Staatus values ('Tabel "' || t_name ||'"', p_column_name, '-',   'OK', summa, max_sum, '', Jr)
endif;
end;

/*
Veeru andmete kontroll ainult vaadetele
Sissetulevad andmed:
vaate id = p_table_id
vaate veerg = p_column_name
punktid - kui palju see veerg väärt punkte on

Protseduuri sisene muutuja: p_view_name = vaate nimi, mida kasutatakse tagasiside insertis.

See protseduur kontrollib ainult, kas antud veerg on olemas ja kui ei ole siis lisab vea staatusesse punktidega 0
ja kui on siis annab täispunktid.
Protseduur ei tagasta midagi.
*/
create 	procedure check_column_for_view (p_table_id int, p_column_name varchar(30), 
										 punktid numeric, Jr integer)

begin
declare p_view_name varchar(50);

set p_view_name = find_table_name(p_table_id);

if 		not exists (select * from syscolumn where upper(column_name) = upper(p_column_name) and table_id = p_table_id)
then 	insert Staatus values ('Vaade "' || p_view_name || '"', p_column_name, 'Veergu ei eksisteeri.', 'VIGA', punktid*0, punktid, '', Jr)
else 	insert Staatus values ('Vaade "' || p_view_name || '"', p_column_name, '-', 'OK', punktid, punktid, '', Jr)
endif;

end;



/* Täpitähtedega veeru andmete kontroll - see on ainult tabelite omale
Mõndades tabelites on võimalik kirjutada veerud täpitähtedega, 
see protseduur kontrollib, milline neist (kaks varianti) on olemas
ning siis selle olemasolevaga käivitab check_column protseduuri.
Kui pole mõlemat olemas, siis check_column protseduuri läheb ilma täpitähtedeta veerg, sest nii on materjalis kirjas.

Sissetulevad andmed on: täpitähteteta veeru nimi, täpitähtedega veeru nimi ja siis veeru atribuudid, 
mis olid check_column protseduuri juures põhjalikult seletatud.

Protseduuri sisesed muutujad: c1, c2 = veergude nimed.
See protseduur ei tagasta midagi.
*/
create	procedure check_column_t2pit2ht (ilma_t2pi varchar(50), t2pi varchar(30), 
									   v_table_id int, v_default varchar(30), 
									   v_pkey char(1), v_nulls char(1), 
									   v_width int, punktid numeric, Jr integer)
begin
declare c1,c2 varchar(50);

select  column_name into c1 from syscolumn where upper(column_name) = upper(t2pi) 			and table_id = v_table_id;
select  column_name into c2 from syscolumn where upper(column_name) = upper(ilma_t2pi) 		and table_id = v_table_id;

if      c1 is null and c2 is not null then 
call 	check_column(v_table_id, ilma_t2pi, v_default,               v_pkey, v_nulls, v_width, punktid, Jr)

elseif  c2 is null and c1 is not null then
call 	check_column(v_table_id, t2pi, 		v_default,               v_pkey, v_nulls, v_width, punktid, Jr)

elseif  c1 is null and c2 is null then 
call 	check_column(v_table_id, ilma_t2pi, v_default,               v_pkey, v_nulls, v_width, punktid, Jr)

else
call 	check_column(v_table_id, ilma_t2pi, v_default,               v_pkey, v_nulls, v_width, punktid, Jr)

endif;
end;

/*
Täpitähtedega veeru andmete kontroll ainult vaadetele
Mõndades vaadetes on võimalik kirjutada veerud täpitähtedega, 
see protseduur kontrollib, milline neist (kaks varianti) on olemas 
ning siis selle olemasolevaga käivitab check_column_for_view protseduuri.
Kui pole mõlemat olemas, siis check_column_for_view protseduuri läheb ilma täpitähtedeta veerg, sest nii on materjalis kirjas.

Sissetulevad andmed:
vaate id = p_table_id
vaate täpitähtedega veeru variant = t2pi
vaate täpitähtedeta veeru variant = ilma_t2pi
punktid - kui palju see veerg väärt punkte on

Protseduuri sisesed muutujad: c1, c2 = veergude nimed.
Protseduur ei tagasta midagi.
*/
create 	procedure check_column_for_view_t2pit2ht (p_table_id int, t2pi varchar(30), 
												  ilma_t2pi varchar(30), punktid numeric, Jr integer)

begin
declare c1,c2 varchar(50);

select  column_name into c1 from syscolumn where upper(column_name) = upper(t2pi) 			and table_id = p_table_id;
select  column_name into c2 from syscolumn where upper(column_name) = upper(ilma_t2pi) 		and table_id = p_table_id;

if      c1 is null and c2 is not null then 
call 	check_column_for_view(p_table_id, ilma_t2pi, punktid, Jr)

elseif  c2 is null and c1 is not null then
call 	check_column_for_view(p_table_id, t2pi, punktid, Jr)

elseif  c1 is null and c2 is null then 
call 	check_column_for_view(p_table_id, ilma_t2pi, punktid, Jr)

else
call 	check_column_for_view(p_table_id, ilma_t2pi, punktid, Jr)
endif;

end;

-- Protseduur, mis kontrollib turniirid tabeli veergusid (alguskuupaev, loppkuupaev) või (alguskuupäev, lõppkuupäev) paaridena, sest andmete sisestamisel on
-- tähtis, et need oleks paaridena korrektsed 
create procedure check_turniir_columns (algus varchar(50), lopp varchar(50),
										algus_t2pi varchar(50), lopp_t2pi varchar(50), 
										v_table_id int, v_default varchar(30), v_pkey char(1), 
										algus_v_nulls char(1), lopp_v_nulls char(1),
										v_width int, punktid numeric, Jr integer)
begin

if 		exists (select column_name from syscolumn where upper(column_name) = upper(algus) and table_id = v_table_id) 
and 	exists (select column_name from syscolumn where upper(column_name) = upper(lopp) and table_id = v_table_id)
then 	call check_column(v_table_id, algus, v_default, v_pkey, algus_v_nulls, v_width, punktid, Jr);
		call check_column(v_table_id, lopp, v_default, v_pkey, lopp_v_nulls, v_width, punktid, Jr)

elseif	exists (select column_name from syscolumn where upper(column_name) = upper(algus_t2pi) and table_id = v_table_id) 
and 	exists (select column_name from syscolumn where upper(column_name) = upper(lopp_t2pi) and table_id = v_table_id)
then 	call check_column(v_table_id, algus_t2pi, v_default, v_pkey, algus_v_nulls, v_width, punktid, Jr);
		call check_column(v_table_id, lopp_t2pi, v_default, v_pkey, lopp_v_nulls, v_width, punktid, Jr)

else	call check_column(v_table_id, algus_t2pi, v_default, v_pkey, algus_v_nulls, v_width, punktid, Jr);
		call check_column(v_table_id, lopp_t2pi, v_default, v_pkey, lopp_v_nulls, v_width, punktid, Jr)
endif;

end;

/*
--call 	check_column_t2pit2ht('Loppkuupaev', 'Lõppkuupäev', v_table_id, null, 'n', 'y', 4, turniirid_lõppkuupäev, tabelid_jr);
--call 	check_column_t2pit2ht('Alguskuupaev', 'Alguskuupäev', v_table_id, null, 'n', 'n', 4, turniirid_alguskuupäev, tabelid_jr);

call 	check_turniir_columns('Alguskuupaev', 'Loppkuupaev', 'Alguskuupäev' 'Lõppkuupäev', v_table_id, null, 'n', 'n', 'y', 4, turniirid_lõppkuupäev, tabelid_jr
*/
/* Süsteemsete välisvõtmete kontroll - kontrollib kas teatud tabelite ja veergude vahel on välisvõti olemas
Sissetulevad andmed: 
Peamine tabel = primary_table 
Võõrtabel = foreign_tabel 
Peamise tabeli veerg = primary_column, see veerg, millega välisvõti seotud on peamises tabelis
Võõrtabeli veerg = foreign_column, see veerg, millega välisvõti seotud on peamises tabelis
Punktid = punktide kogus, mis saab selle võtme õigsuse eest'

Protseduuri sisesed muutujad: primary_t_id, foreign_t_id, primary_c_id, foreign_c_id = kõikide tabelite ja nende veergude id muutujad;
f_key_id = välisvõtme id muutuja; count_f_key, count_fk = muutjad kuhu loetakse kokku, mitu välisvõtit vastab antud tingimustele.

See protseduur kõigepealt kontrollib, kas on olemas selline asi nagu "foreign_key_id", mille leiab "sysfkcol" tabelist, 
see ID leitakse võõrtabeli id, võõrtabeli veeru id ja peamise tabeli veeru id kaudu, kõigil välisvõtmetel on alati ÜKS "foreign_key_id", 
kui ei ole üks, siis sisestatakse Staatus tabelisse veateade ja punktideks 0, kui on üks siis muutuja "f_key_id" saab väärtuseks selle välisvõtme id.
Seejärel loetakse kokku tabelist "sysforeignkey", mitu välisvõtit on nende tabelite vahel, kus on siis see kindel "foregin_key_id" 
päringu tingimusteks on välistabeli id, peamise tabeli id ja "foreign_key_id", tulemuseks peab olema ÜKS, kui ei ole üks, siis sisestatakse Staatus tabelisse veateade ja punktideks 0
Kui kõik on korras, siis sisestataks OK ja punktide arv.
Protseduur ei tagasta midagi.
*/
create	procedure check_foreign_key(p_primary_table varchar(30), p_foreign_table varchar(30),
									p_primary_column varchar(30), p_foreign_column varchar(30),
									punktid numeric, Jr integer)
begin
declare primary_t_id, foreign_t_id, primary_c_id, foreign_c_id, f_key_id int;
declare count_f_key, count_fk int;

// Salvestan kõikide vajalike tabelite ja veergude ID-d ning samal ajal kontrollin, kas need on olemas
select 	table_id into primary_t_id 	from systable where upper(table_name) = upper(p_primary_table);

select 	column_id into primary_c_id from syscolumn where table_id = primary_t_id
and 	upper(column_name) 			= upper(p_primary_column);

select 	table_id into foreign_t_id 	from systable where table_name = p_foreign_table;

select 	column_id into foreign_c_id from syscolumn where table_id = foreign_t_id
and 	upper(column_name) 			= upper(p_foreign_column);

// Loen kokku mitu välisvõtit vastab nendele andmetele (peaks olema 1)
select 	count(foreign_key_id) 		into count_f_key from sysfkcol
where 	foreign_table_id = foreign_t_id 
and 	foreign_column_id = foreign_c_id
and 	primary_column_id = primary_c_id;



// Kui 	on rohkem kui üks, siis tagastan veateate
if 		count_f_key != 1 	then insert Staatus values ('Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"', 
														p_primary_column || ' <-> ' || p_foreign_column, 
														'Välisvõtit pole nende tabelite ja/või veergude vahel.',
														'VIGA', punktid*0, punktid, '', Jr)

else
select 	foreign_key_id 		into f_key_id 		from sysfkcol
where 	foreign_table_id 	= foreign_t_id 
and 	foreign_column_id 	= foreign_c_id
and 	primary_column_id 	= primary_c_id;
endif;

select 	count(*) 			into count_fk 		from sysforeignkey
where	foreign_table_id 	= foreign_t_id 
and 	primary_table_id 	= primary_t_id
and		foreign_key_id		= f_key_id;

if 		count_fk != 1 		and count_f_key = 1	then insert Staatus values ('Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"', 
																			p_primary_column || ' <-> ' || p_foreign_column, 
																			'Välisvõtit pole nende tabelite ja/või veergude vahel.',
																			'VIGA', punktid*0, punktid, '', Jr)
endif;

if		count_fk = 1		and count_f_key = 1 then insert Staatus values ('Välisvõti "' || p_primary_table || '" <-> "' || p_foreign_table || '"', 
																			p_primary_column || ' <-> ' || p_foreign_column, 
																			'-', 'OK', punktid, punktid, '', Jr)
endif;

end;

/* 
Protseduur, mis kontrollib, kas teatud tabelis on olemas vastav unique kitsendus 
Sissetulevad andmed:
tabeli nimi = table_name
veeru nimi = column_name
punktid, kui palju saab selle kitsenduse eest

Protseduuri sisene muutuja:  unique_count = unique kogus antud tingimustel.

Kõigepealt loetakse kokku tabelist "sysindex" mitu unique kitsendust on vastavalt sellele tabeli nimele, peab olema ÜKS
siis kontrollib kas väärtus on 1 või mitte.
Kui pole 1 siis lisatakse tabelisse Staatus veateade ja kui on korras siis lisatakse 'OK' 
*/
create 	procedure check_unique(p_table_name varchar(30), p_column_name varchar(100), punktid numeric, Jr integer)
begin
declare unique_count int;

select 	count(*) into unique_count 	from sysindex where creator = 1 and table_id = find_table_id(p_table_name) and "unique" = 'U';
if 		unique_count = 1		
then 	insert Staatus values ('Tabel "' || p_table_name || '" unique', p_column_name, '-', 																				'OK', 	punktid, 	punktid, '', Jr)
else 	insert Staatus values ('Tabel "' || p_table_name || '" unique', p_column_name, 'Tabelis ei ole unique kitsendust või on rohkem kui 1, hetkel on ' || unique_count, 	'VIGA', punktid*0, 	punktid, '', Jr)
endif;

end;

/* Protseduur, mis kontrollib, kas teatud tabelis on olemas vastav check kitsendus 
Sissetulevad andmed:
Check-i definitsioon = check_defn ehk see on selle checki kirjeldus süsteemis
tabeli nimi = table_name
veeru nimi = column_name

Protseduuri sisesne muutuja: check_count = check kogus antud tingimustel.

Kõigepealt loetakse kokku tabelist "syscheck" mitu check kitsendust on vastavalt sellele definitsioonile, peab olema ÜKS
seejärel kui tulemus ei ole 1 siis lisatakse veateade Staatus tabelisse ja kui on 1 siis lisatakse 'OK' Staatus tabelisse
*/
create 	procedure check_check(p_check_defn varchar(500), p_table_name varchar(30), p_column_name varchar(50), punktid numeric, Jr integer)
begin
declare check_count int;
declare soovitus varchar(5000);

if 		p_table_name = upper('Inimesed') 
then	set	soovitus = 'Kui sul on olemas Tabelis "Inimesed" check tingimus veerule "sugu", siis toimi järgmiselt. Ava inimesed tabel ja mine constraints tab-ile. Ava ASA80 properties ja mine definition tab-ile. Salvesta definitsioon nii, et kõik oleks ühel real.'
else	set soovitus = ''
endif;

select 	count(*) into check_count		from syscheck where check_defn = p_check_defn;
if 		check_count = 1				
then 	insert Staatus values ('Tabel "' || p_table_name || '" check', p_column_name, '-',  								'OK', 	punktid, 	punktid, soovitus, Jr)
else	insert Staatus values ('Tabel "' || p_table_name || '" check', p_column_name, 'Tabelis ei ole check kitsendust', 	'VIGA', punktid*0, 	punktid, soovitus, Jr)
endif;

end;


/*
Järmised 2 protseduuri on enamvähem samad. Üks neist kirjutab kõik vead, hoiatused ja punktide veerud Staatus tabelist tekst (txt) faili ja teine kirjutab need exceli (csv) faili, 
mille asukoht on C kettal TEMP kaustas.
Select on tingimusega "order by Nimi desc", sest read kus kasutatakse 'Kokku', 'Hindepunktid' ja 'Aeg' tingimust peavad olema kõige lõpus.
*/
create procedure output_tulemus_txt()
begin
unload
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr
to 'C:\TEMP\\tulemus.txt'
delimited by '\x09'
QUOTE '"'
with column names
format text;
end;

create procedure output_tulemus_csv()
begin
unload
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr
to 'C:\TEMP\\tulemus.csv'
delimited by '\x09'
QUOTE '"'
with column names
end;


/*
Protseduur, mis arvutab punktide summad kokku ning väljastab need uue reana Staatus tabelis
ning arvutab välja ka protsentuaalselt hinde, mille valem on siis (punktide summa / (max_summa) 
Sisestatud andmeks on kodutöö number, mis määrab max punktid.
kodutöö 3 = 100p
kodutöö 5 = 132p
kodutöö 6 = 182p
kodutöö 7 = 232p
Protseduuri sisesed muutujad: summa = kõik kokku liidetud punktid; max_summa = kodutööle vastav punktisumma, hindepunkt = tudengi hinne Moodle'is, max_hindepunkt = tudengi maksimum hindepunktid Moodle'is;
*/
create 	procedure arvuta_punktid(versioon int)
begin
declare summa, max_summa, hindepunkt, max_hindepunkt numeric;
set 	summa = 0.0;

if		versioon = 3 then set max_summa = kodutöö_3
elseif	versioon = 5 then set max_summa = kodutöö_5
elseif	versioon = 6 then set max_summa = kodutöö_6
elseif	versioon = 7 then set max_summa = kodutöö_7
else					  set max_summa = 1
endif;

/* Hindepunktide välja arvutamine */
select sum(punktid) into summa from Staatus where Olek = 'OK' or Olek = 'VIGA';
if 		versioon = 7 and aine = 'A'
then	
set 	hindepunkt = (summa / max_summa) * 2;
set		max_hindepunkt = 2.0 
else
set 	hindepunkt = (summa / max_summa);
set 	max_hindepunkt = 1.0
endif;

/* Punktide sisestamine */
insert into Staatus values ('-', '-', '-', 'Kokku', summa, max_summa, '', max_punktid_jr);
insert into Staatus values ('-', '-', '-', 'Hindepunktid', hindepunkt, max_hindepunkt, '', hindepunktid_jr);
end;


/* Tabelite kontrollid */
/*
Tabeli "Inimesed" kontroll, kus on siis veergude kontroll ja check tingimuse kontroll ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud.
Sisestatud andmeteks on versiooni nr, mis tähenab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "inimesed" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "inimesed", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil, mille
andmeteks on: tabeli "inimesed" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.
Selles tabelis on ka täpitähtedega veerg võimalik, kus siis lisatakse check_column_t2pit2ht protseduuri nii täpitähteteta versioon kui ka täpitähtedega
Tabelis toimub ka check tingimuse kontroll, ehk kas selles tabeli on olemas check tingimus, mis kontrollib kas "sugu" veeru andmeteks on "m" või "n"
Kui on 7nda kodutöö kontroll, siis toimub ka kirjete arvu kontroll, kus vaadatakse, kas selles tabelis on vähemalt ÜKS kirje.
*/


//Tabeli Inimesed kontroll
create  procedure table_inimesed(version int)
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('inimesed')) 
then 	insert Staatus values ('Tabel "Inimesed"', '-', 'Tabelit ei eksisteeri.', 'VIGA', inimesed_tabel*0, inimesed_tabel,	'', tabelid_jr);
return;  
endif;

set 	v_table_id = find_table_id('inimesed');

select count(column_name) into v_size from syscolumn where table_id = v_table_id;  

if      v_size != 6                 
then	insert Staatus values ('Tabel "Inimesed"', 'Veergude arv', 'On vale, peab olema 6, hetkel on ' || v_size, 'VIGA', inimesed_veergude_arv*0, inimesed_veergude_arv, '', tabelid_jr) 
else	insert Staatus values ('Tabel "Inimesed"', 'Veergude arv', '-', 'OK', inimesed_veergude_arv, inimesed_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Eesnimi',    null,                'n', 'n', 30, inimesed_eesnimi, tabelid_jr); 
call 	check_column(v_table_id, 'Perenimi',   null,                'n', 'n', 100, inimesed_perenimi, tabelid_jr); 
call 	check_column(v_table_id, 'Sugu',       null,                'n', 'n', 1, inimesed_sugu, tabelid_jr);

// kontrollin kas on täpitähtedega veerg või mitte
call 	check_column_t2pit2ht('Synnipaev', 'Sünnipäev', v_table_id, null, 'n', 'n', 4, inimesed_sünnipäev, tabelid_jr);

call 	check_column(v_table_id, 'Sisestatud', 'current timestamp', 'n', 'n', 8, inimesed_sisestatud, tabelid_jr);
call 	check_column(v_table_id, 'Isikukood',  null,                'y', 'n', 11, inimesed_isikukood, tabelid_jr);

// Check kitsenduse kontroll
call	check_check('check("sugu" in( ''m'',''n'' ) )', 'Inimesed', 'Sugu', inimesed_check_sugu, tabelid_jr);

// Kirjete arvu kontroll
select 	count(*) into kirje_count from inimesed;
if 		kirje_count >= 1 
then 	insert Staatus values ('Tabel "Inimesed"', 'Kirjete arv', '-', 																'OK', 	inimesed_kirjete_arv, 	inimesed_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Inimesed"', 'Kirjete arv', 'Kirjete arv peab olema vähemalt 1, hetkel on ' || kirje_count, 	'VIGA', inimesed_kirjete_arv*0, inimesed_kirjete_arv,	'', tabelid_jr)
endif;
end;



/*
Tabeli "Klubid" kontroll, kus on siis veergude kontroll ja unique tingimuse kontroll ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud.
Sisestatud andmeteks on versiooni nr, mis tähendab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "klubid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "klubid", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade. 7ndas kodutöös tuleb "Klubid" tabelile üks veerg juurde see pärast ka lisa tingimus version = 7.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil, mille
andmeteks on: tabeli "klubid" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.

Tabelis toimub ka unique tingimuse kontroll, ehk kas leidub veerul "Nimi" unique tingimus
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KUUS kirjet.
*/

//Tabeli Klubid kontroll
create 	procedure table_klubid(version int)
begin 
declare v_table_id, v_size, kirje_count int;


if 		not exists (select * from systable where upper(table_name) = upper('klubid')) 
then 	insert Staatus values ('Tabel "Klubid"', '-', 'Tabelit ei eksisteeri.', 'VIGA', klubid_tabel*0, klubid_tabel, '', tabelid_jr);
return;
endif;

set 	v_table_id = find_table_id('klubid');

select 	count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      version != 7  and   v_size != 3             
then 	insert Staatus values ('Tabel "Klubid"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', klubid_veergude_arv*0, klubid_veergude_arv, '', tabelid_jr)
elseif	version = 7 and v_size != 4
then	insert Staatus values ('Tabel "Klubid"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', klubid_veergude_arv*0, klubid_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Klubid"', 'Veergude arv', '-', 'OK', klubid_veergude_arv, klubid_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Id',       'autoincrement',    'y', 'n', 4, klubid_id, tabelid_jr); 
call 	check_column(v_table_id, 'Nimi',     null,               'n', 'n', 100, klubid_nimi, tabelid_jr); 
call 	check_column(v_table_id, 'Asukoht',  'Tartu',            'n', 'n', 70, klubid_asukoht, tabelid_jr);
if		version = 7 then
call	check_column(v_table_id, 'Asula',  null,            'n', 'y', 4, klubid_asula, tabelid_jr)
endif;

// Unique kitsenduse kontroll
call 	check_unique('Klubid', 'Nimi', klubid_unique_nimi, tabelid_jr);


// Kirjete arvu kontroll
select 	count(*) into kirje_count from klubid;
if 		kirje_count = 6
then 	insert Staatus values ('Tabel "Klubid"', 'Kirjete arv', '-', 												   	'OK',  	klubid_kirjete_arv, 	klubid_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Klubid"', 'Kirjete arv', 'Kirjete arv peab olema 6, hetkel on ' || kirje_count, 	'VIGA', klubid_kirjete_arv*0, 	klubid_kirjete_arv,	'', tabelid_jr)
endif;
end;


/*
Tabeli "Isikud" kontroll, kus on siis veergude kontroll ja unique tingimuse kontroll ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud.
Sisestatud andmeteks on versiooni nr, mis tähendab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "isikud" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "isikud", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil.
Andmeteks on siis: tabeli "isikud" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.

Tabelis toimub ka unique tingimuse kontroll, ehk kas veergudel "Eesnimi" ja "Perenimi" on olemas unique kitsendus
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKSKÜMMEND KOLM kirjet.
*/

//Tabeli Isikud kontroll
create 	procedure table_isikud(version int) 
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('isikud')) 
then 	insert Staatus values ('Tabel "Isikud"', '-', 'Tabelit ei eksisteeri.', 'VIGA', isikud_tabel*0, isikud_tabel, '', tabelid_jr);
return;
endif;

set 	v_table_id = find_table_id('isikud');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 5                 
then 	insert Staatus values ('Tabel "Isikud"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', isikud_veergude_arv*0, isikud_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Isikud"', 'Veergude arv', '-', 'OK', isikud_veergude_arv, isikud_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Id',          'autoincrement',    'y', 'n', 4, isikud_id, tabelid_jr); 
call 	check_column(v_table_id, 'Eesnimi',     null,               'n', 'n', 50, isikud_eesnimi, tabelid_jr); 
call 	check_column(v_table_id, 'Perenimi',    null,               'n', 'n', 50, isikud_perenimi, tabelid_jr); 
call 	check_column(v_table_id, 'Isikukood',   null,               'n', 'y', 11, isikud_isikukood, tabelid_jr); 
call 	check_column(v_table_id, 'Klubi',       null,               'n', 'y', 4, isikud_klubi, tabelid_jr);

// Unique kitsenduse kontroll
call 	check_unique('Isikud', 'Eesnimi, Perenimi', isikud_unique_ees_pere, tabelid_jr);

// Kirjete arvu kontroll
select 	count(*) into kirje_count from isikud;
if 		kirje_count = 23
then 	insert Staatus values ('Tabel "Isikud"', 'Kirjete arv', '-', 														'OK', 	isikud_kirjete_arv, 	isikud_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Isikud"', 'Kirjete arv', 'Kirjete arv peab olema 23, hetkel on ' || kirje_count, 	'VIGA', isikud_kirjete_arv*0, 	isikud_kirjete_arv,	'', tabelid_jr)
endif;
end;

/*
Tabeli "Turniirid" kontroll, kus on siis veergude kontroll ja unique tingimuse kontroll ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud.
Sisestatud andmeteks on versiooni nr, mis tähendab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "turniirid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "turniirid", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade. 7ndas kodutöös tuleb "Turniirid" tabelile üks veerg juurde see pärast ka lisa tingimus version = 7.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil.
Andmeteks on siis: tabeli "turniirid" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.
Selles tabelis on ka täpitähtedega veerg võimalik, kus siis lisatakse check_column_t2pit2ht protseduuri nii täpitähteteta versioon kui ka täpitähtedega, neid on 2 tükki.

Tabelis toimub ka unique tingimuse kontroll, ehk kas veergul "Nimi" on olemas unique kitsendus
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS kirjet.
*/

//Tabeli Turniirid kontrollimine
create  procedure table_turniirid(version int)
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('turniirid')) 
then 	insert Staatus values ('Tabel "Turniirid"', '-', 'Tabelit ei eksisteeri.', 'VIGA', turniirid_tabel*0, turniirid_tabel, '', tabelid_jr);
return;  
endif;

set 	v_table_id = find_table_id('turniirid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 6 and version = 7                
then 	insert Staatus values ('Tabel "Turniirid"', 'Veergude arv', 'On vale, peab olema 6, hetkel on ' || v_size, 'VIGA', turniirid_veergude_arv*0, turniirid_veergude_arv, '', tabelid_jr)
elseif 	v_size != 5 and version != 7
then	insert Staatus values ('Tabel "Turniirid"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', turniirid_veergude_arv*0, turniirid_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Turniirid"', 'Veergude arv', '-', 'OK', turniirid_veergude_arv, turniirid_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Id',              'autoincrement',    'y', 'n', 4, turniirid_id, tabelid_jr);
call 	check_column(v_table_id, 'Nimi',            null,               'n', 'n', 100, turniirid_nimi, tabelid_jr);
call 	check_column(v_table_id, 'Toimumiskoht',    null,               'n', 'y', 100, turniirid_toimumiskoht, tabelid_jr);
if 		version = 7 then
call	check_column(v_table_id, 'Asula', 			null,				'n', 'y', 4, turniirid_asula, tabelid_jr) 
endif;

// kontrollin kas on täpitähtedega veerg või mitte
--call 	check_column_t2pit2ht('Loppkuupaev', 'Lõppkuupäev', v_table_id, null, 'n', 'y', 4, turniirid_lõppkuupäev, tabelid_jr);
--call 	check_column_t2pit2ht('Alguskuupaev', 'Alguskuupäev', v_table_id, null, 'n', 'n', 4, turniirid_alguskuupäev, tabelid_jr);

/*algus varchar(50), lopp varchar(50),
										algus_t2pi varchar(50), lopp_t2pi varchar(50), 
										v_table_id int, v_default varchar(30), v_pkey char(1), 
										algus_v_nulls char(1), lopp_v_nulls char(1),
										v_width int, punktid numeric, Jr integer*/
										
call 	check_turniir_columns('Alguskuupaev', 'Loppkuupaev', 'Alguskuupäev', 'Lõppkuupäev', v_table_id, null, 'n', 'n', 'y', 4, turniirid_lõppkuupäev, tabelid_jr);
// Unique kitsenduse kontroll
call 	check_unique('Turniirid', 'Nimi', turniirid_unique_nimi, tabelid_jr);

// Kirjete arvu kontroll
select 	count(*) into kirje_count from turniirid;
if 		kirje_count = 2
then 	insert Staatus values ('Tabel "Turniirid"', 'Kirjete arv', '-', 													'OK', 	turniirid_kirjete_arv, 		turniirid_kirjete_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Turniirid"', 'Kirjete arv', 'Kirjete arv peab olema 2, hetkel on ' || kirje_count, 	'VIGA', turniirid_kirjete_arv*0, 	turniirid_kirjete_arv, '', tabelid_jr)
endif;
end;


/*
Tabeli "Partiid" kontroll, kus on siis veergude kontroll ja 3 check tingimuse kontrolli ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud
Sisestatud andmeteks on versiooni nr, mis tähendab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "partiid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "partiid", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil.
Andmeteks on siis: tabeli "partiid" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.
Selles tabelis on ka täpitähtedega veerg võimalik, kus siis lisatakse check_column_t2pit2ht protseduuri nii täpitähteteta versioon kui ka täpitähtedega, neid on 2 tükki.

Tabelis toimub check tingimuse kontroll, ehk kas veergul "Nimi" on olemas unique kitsendus
Tabelis toimub 3 check tingimuse kontrolli
1) kas selles tabelis on olemas check tingimus, mis kontrollib kas valge_tulemuse anmed vastavad arvudele 0, 1 või 2
2) check tingimus, mis kontrollib, kas musta_tulemuse anmed vastavad arvudele 0, 1 või 2
3) check tingimus, mis kontrollib, kas musta_tulemus + valge_tulemus = 2, sest alati on kas viik või keegi kaotab/võidab

Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT SADA KAHEKSA kirjet.
*/

//Tabeli Partiid kontroll
create  procedure table_partiid(version int) 
begin 
declare v_table_id, v_size, kirje_count int; 

if 		not exists (select * from systable where upper(table_name) = upper('partiid')) 
then 	insert Staatus values ('Tabel "Partiid"', '-', 'Tabelit ei eksisteeri.', 'VIGA', partiid_tabel*0, partiid_tabel, '', tabelid_jr);
return; 
endif;

set 	v_table_id = find_table_id('partiid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 9                 
then 	insert Staatus values ('Tabel "Partiid"', 'Veergude arv', 'On vale, peab olema 9, hetkel on ' || v_size, 'VIGA', partiid_veergude_arv*0, partiid_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Partiid"', 'Veergude arv', '-', 'OK', partiid_veergude_arv, partiid_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Id',            'autoincrement',       'y', 'n', 4, partiid_id, tabelid_jr); 
call 	check_column(v_table_id, 'Turniir',       null,                  'n', 'n', 4, partiid_turniir, tabelid_jr); 
call 	check_column(v_table_id, 'Algushetk',     'current timestamp',   'n', 'n', 8, partiid_algushetk, tabelid_jr); 
call 	check_column(v_table_id, 'Valge',         null,                  'n', 'n', 4, partiid_valge, tabelid_jr); 
call 	check_column(v_table_id, 'Must',          null,                  'n', 'n', 4, partiid_must, tabelid_jr); 
call 	check_column(v_table_id, 'Valge_tulemus', null,                  'n', 'y', 2, partiid_valge_tulemus, tabelid_jr); 
call 	check_column(v_table_id, 'Musta_tulemus', null,                  'n', 'y', 2, partiid_musta_tulemus, tabelid_jr); 
call 	check_column_t2pit2ht('Lopphetk', 'Lõpphetk', v_table_id, null,  'n', 'y', 8, partiid_lõpphetk, tabelid_jr);
call 	check_column_t2pit2ht('Kokkuvote', 'Kokkuvõte', v_table_id, null, 'n', 'y', 5000, partiid_kokkuvõte, tabelid_jr);

// Check kitsenduste kontroll
call 	check_check('check("valge_tulemus" in( 0,1,2 ) )', 'Partiid', 'Valge_tulemus', partiid_check_valge_tulemus, tabelid_jr);
call 	check_check('check("musta_tulemus" in( 0,1,2 ) )', 'Partiid', 'Musta_tulemus', partiid_check_musta_tulemus, tabelid_jr);
call 	check_check('check("valge_tulemus"+"musta_tulemus" = 2)', 'Partiid', 'Valge_tulemus + Musta_tulemus', partiid_check_valge_musta_tulemus, tabelid_jr);

// Kirjete arvu kontroll
select 	count(*) into kirje_count from partiid;
if 		kirje_count = 108
then 	insert Staatus values ('Tabel "Partiid"', 'Kirjete arv', '-',														'OK', 	partiid_kirjete_arv, 	partiid_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Partiid"', 'Kirjete arv', 'Kirjete arv peab olema 108, hetkel on ' || kirje_count, 	'VIGA', partiid_kirjete_arv*0, 	partiid_kirjete_arv,	'', tabelid_jr)
endif;

end;

/*
Tabeli "Asulad" kontroll, kus on siis veergude kontroll ja unique tingimuse kontroll.

Protseduuri sisesed muutujad: v_table_id = "asulad" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "asulad", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil.
Andmeteks on siis: tabeli "partiid" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.

Tabelis toimub unique tingimuse kontroll, ehk kas veergul "Nimi" on olemas unique kitsendus
Kirjete arvu ei ole mõtet kontrollida, sest need sisestatakse skripti poolt
*/
// Tabeli Asulad kontroll
create  procedure table_asulad() 
begin 
declare v_table_id, v_size int; 
       

if 		not exists (select * from systable where upper(table_name) = upper('asulad')) 
then 	insert Staatus values ('Tabel "Asulad"', '-', 'Tabelit ei eksisteeri.', 'VIGA', asulad_tabel*0, asulad_tabel, '', tabelid_jr);
return; 
endif;

set 	v_table_id = find_table_id('asulad');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 2                 
then 	insert Staatus values ('Tabel "Asulad"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', asulad_veergude_arv*0, asulad_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Asulad"', 'Veergude arv', '-', 'OK', asulad_veergude_arv, asulad_veergude_arv, '', tabelid_jr)
endif;

call	check_column(v_table_id, 'id', 'autoincrement', 'y', 'n', 4, asulad_id, tabelid_jr);
call	check_column(v_table_id, 'nimi', null, 'n', 'n', 100, asulad_nimi, tabelid_jr);

// Unique kitsendus
call 	check_unique('Asulad', 'Nimi', asulad_unique_nimi, tabelid_jr);

end;


/*
Protseduur, mis kutsub välja välisvõtmete ja triggerite kontrollid
Sisestatud andmeteks on versiooni nr, mis tähenb siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb muid tingimusi juurde. 

Välisvõtme kontrolliks kasutatakse protseduuri "check_foreign_key", mille andmeteks on:
Peamine tabel, võõrtabel, peamise tabeli veerg, võõrtabeli veerg ning punktide arv, kui palju saab selle välisvõtme eest.
Muidu on 4 välisvõtit, aga 7ndas tuleb 2 juurde.

Süsteemsete triggerite kontroll loeb kokku kas on cascade/update triggereid kokku 4 ja delete triggereid 1, kui on 7s kodutöö siis update triggereid on 6.
Mõnel tudengil võib olla ka tekkinud tabel "maint_name", kui see on olemas, siis delete triggerite arv saadakse 2, 
aga kuna tegelik arv on ikkagi 1, siis lihtsalt lahutatakse üks kui eksisteerib "maint_name" ja/või "maint_plan" tabel.
*/
// Protseduur, mis kontrollib välisvõtmeid ja triggereid
create  procedure muud_elemendid(version int)
begin
declare trigger_count_C, trigger_count_D int;

// Välisvõtmete kontroll
call	check_foreign_key('Klubid',       'Isikud',        'id', 'klubi', välisvõti_isik_2_klubi, välisvõtmed_jr);
call  	check_foreign_key('Isikud',       'Partiid',       'id', 'valge', välisvõti_partii_2_isik_valge, välisvõtmed_jr);
call	check_foreign_key('Isikud',       'Partiid',       'id', 'must',  välisvõti_partii_2_isik_must, välisvõtmed_jr);
call	check_foreign_key('Turniirid',    'Partiid',       'id', 'turniir', välisvõti_partii_2_turniir, välisvõtmed_jr);
if		version = 7 then
call	check_foreign_key('Asulad', 'Klubid', 'id', 'asula', välisvõti_klubi_2_asula, välisvõtmed_jr);
call	check_foreign_key('Asulad', 'Turniirid', 'id', 'asula', välisvõti_turniir_2_asula, välisvõtmed_jr);
endif;


// Süsteemsete triggerite kontroll välisvõtmete juures
if 		version < 7
then	select 	count(*) into trigger_count_C		from systrigger
		where	event = 'C' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
		if 		trigger_count_C = 4				
		then 	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', '-',	'OK', trigger_cascade, trigger_cascade, '', välisvõtmed_tg_jr)
		else 	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on puudu.',  	'VIGA', trigger_cascade*0, trigger_cascade, '', välisvõtmed_tg_jr)
		endif
				
else	select 	count(*) into trigger_count_C		from systrigger
		where	event = 'C' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
		if 		trigger_count_C = 6				
		then 	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', '-',	'OK', trigger_cascade, trigger_cascade, '', välisvõtmed_tg_jr)
		else 	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on puudu.',  	'VIGA', trigger_cascade*0, trigger_cascade, 
										'kui välisvõti on tehtud siis kontrollida kas on lisatud on update cascade', välisvõtmed_tg_jr)
		endif			
endif;

select 	count(*) into trigger_count_D		from systrigger
where	event = 'D' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
if 		(trigger_count_D = 1) or (trigger_count_D = 2 and exists (select * from systable where table_name = 'maint_name') or exists (select * from systable where table_name = 'maint_plan'))				
then 	insert Staatus values ('Välisvõtme tingimus "ON DELETE CASCADE"', '-', '-',	'OK', trigger_delete, trigger_delete, '', välisvõtmed_tg_jr)
else 	insert Staatus values ('Välisvõtme tingimus "ON DELETE CASCADE"', '-', 'Ühe välisvõtme "ON DELETE CASCADE" tingimus on puudu.', 
								'VIGA', trigger_delete*0, trigger_delete, '', välisvõtmed_tg_jr)
endif;

end;


/* Vaadete kontrollid */

/*
Vaate "v_edetabelid" kontroll, kus on siis veergude kontroll, vaate kirjete arvu kontroll ja punktide kontrollid.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_edetabelid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas vaade "v_edetabelid" kui ei ole, siis lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_edetabelid" id, veeru nimi ja punktide arv, mis saab selle veeru olemasolu eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KOLMKÜMMEND NELI kirjet.
Seejärel tuleb punktide kontrollid.
1) Ühes kontrollitakse, kas turniiril 41, mängijal "Kivine, Kalle" on punktide arv 2.5
2) Teises kontrollitakse, kas turniiril 42, mängijal "Kivine, Kalle" on punktide arv 2.0
Sest tihti tudengid ei jaga 2.0ga või korruta läbi 0.5ga punktide arvu.
*/
// Vaate v_edetabelid kontroll
create  procedure view_edetabelid()
begin 
declare v_table_id, v_size, kirje_count int;
       
if 		not exists (select * from systable where upper(table_name) = upper('v_edetabelid')) 
then 	insert Staatus values ('Vaade "v_edetabelid"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_edetabelid*0, v_edetabelid, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_edetabelid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 3 
then 	insert Staatus values ('Vaade "v_edetabelid"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', v_edetabelid_veergude_arv*0, v_edetabelid_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_edetabelid"', 'Veergude arv', '-', 'OK', v_edetabelid_veergude_arv, v_edetabelid_veergude_arv, '', vaated_jr)
endif;

call 	check_column_for_view_t2pit2ht(v_table_id, 'Mängija', 'Mangija', v_edetabelid_mängija, vaated_jr);
call	check_column_for_view(v_table_id, 'Turniir', v_edetabelid_turniir, vaated_jr);
call	check_column_for_view(v_table_id, 'Punkte', v_edetabelid_punkte, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_edetabelid;
	if		kirje_count > 34
	then	insert Staatus values('Vaade "v_edetabelid"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_edetabelid_kirjete_arv*0, v_edetabelid_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 34
	then	insert Staatus values('Vaade "v_edetabelid"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_edetabelid_kirjete_arv*0, v_edetabelid_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_edetabelid"', 'Kirjete arv', '-', 														'OK', 	v_edetabelid_kirjete_arv, 	v_edetabelid_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_edetabelid"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_edetabelid_kirjete_arv*0, v_edetabelid_kirjete_arv, '', vaated_jr)
end catch;

// Punktide kontrollid
begin try
	if (select punkte from v_edetabelid where turniir = 41 and mangija = 'Kivine, Kalle') > 2.49 and (select punkte from v_edetabelid where turniir = 41 and mangija = 'Kivine, Kalle') < 2.51
	then insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 41 punktid', '-', 'OK', 	v_edetabelid_punkte_komakohaga, 	v_edetabelid_punkte_komakohaga, '', vaated_jr)
	else insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 41 punktid', 'Punktide arv pole õige, peab olema 2.5', 'VIGA', 	v_edetabelid_punkte_komakohaga*0, 	v_edetabelid_punkte_komakohaga, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if (select punkte from v_edetabelid where turniir = 41 and mängija = 'Kivine, Kalle') > 2.49 and (select punkte from v_edetabelid where turniir = 41 and mängija = 'Kivine, Kalle') < 2.51
		then insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 41 punktid', '-', 'OK', 	v_edetabelid_punkte_komakohaga, 	v_edetabelid_punkte_komakohaga, '', vaated_jr)
		else insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 41 punktid', 'Punktide arv pole õige, peab olema 2.5', 'VIGA', 	v_edetabelid_punkte_komakohaga*0, 	v_edetabelid_punkte_komakohaga, '', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, tuniir 41 punktid', 'Ei kompileeru', 'VIGA', 	v_edetabelid_punkte_komakohaga*0, 	v_edetabelid_punkte_komakohaga, 'Kas on "perenimi, eesnimi" või veeru nimi "mangija"?', vaated_jr)
	end catch;
end catch;

begin try
	if (select punkte from v_edetabelid where turniir = 42 and mangija = 'Kivine, Kalle') > 1.99 and (select punkte from v_edetabelid where turniir = 42 and mangija = 'Kivine, Kalle') < 2.01
	then insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', '-', 'OK', 	v_edetabelid_punkte_täiskohaga, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
	else insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', 'Punktide arv pole õige, peab olema 2.0', 'VIGA', 	v_edetabelid_punkte_täiskohaga*0, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if (select punkte from v_edetabelid where turniir = 42 and mängija = 'Kivine, Kalle') > 1.99 and (select punkte from v_edetabelid where turniir = 42 and mängija = 'Kivine, Kalle') < 2.01
		then insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', '-', 'OK', 	v_edetabelid_punkte_täiskohaga, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
		else insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', 'Punktide arv pole õige, peab olema 2.0', 'VIGA', 	v_edetabelid_punkte_täiskohaga*0, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, tuniir 42 punktid', 'Ei kompileeru', 'VIGA', 	v_edetabelid_punkte_täiskohaga*0, 	v_edetabelid_punkte_täiskohaga, 'Kas on "perenimi, eesnimi" või veeru nimi "mangija"?', vaated_jr)
	end catch;
end catch;
end;


/* 
Vaate "v_klubipartiikogused_1" kontroll, kus on siis veergude kontroll ja veeru "partiisid" summa kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_klubipartiikogused_1" tabeli id; v_size = antud tabelis veergude arv; partii_summa = veeru "partiisid" summa;

Kõigepealt kontrollitakse, kas on olemas vaade "v_klubipartiikogused_1" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_klubipartiikogused_1" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on veeru "partiisid" summa kontroll ehk arvutatakse kokku kõikide veergude andmetest kokku mitu partiid on kirjas. Peab olema TÄPSELT KAKS SADA! 
*/

// Vaade v_klubipartiikogused_1 kontroll
create  procedure view_klubipartiikogused_1()
begin 
declare v_table_id, v_size, partii_summa int;

if 		not exists (select * from systable where upper(table_name) = upper('v_klubipartiikogused_1')) 
then 	insert Staatus values ('Vaade "v_klubipartiikogused_1"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_klubipartiikogused_1*0, v_klubipartiikogused_1, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_klubipartiikogused_1');

select count(column_name) into v_size from syscolumn  where table_id = v_table_id;

if      v_size != 2 
then 	insert Staatus values ('Vaade "v_klubipartiikogused_1"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_klubipartiikogused_1_veergude_arv*0, v_klubipartiikogused_1_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_klubipartiikogused_1"', 'Veergude arv', '-', 'OK', v_klubipartiikogused_1_veergude_arv, v_klubipartiikogused_1_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Klubi_nimi', v_klubipartiikogused_1_klubi_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Partiisid', v_klubipartiikogused_1_partiisid, vaated_jr);

// Partii veeru summa kontroll, partii_summa peab võrduma TÄPSELT KAKS SADA
begin try
	if 		exists (select * from syscolumn where column_name = 'partiisid' and table_id = find_table_id('v_klubipartiikogused_1'))
	then	select 	sum(partiisid) into partii_summa from v_klubipartiikogused_1;
			if 		partii_summa = 200
			then	insert Staatus values('Vaade "v_klubipartiikogused_1"', 'Partiide summa', '-', 														 	'OK', 	v_klubipartiikogused_1_partiide_arvu_summa, 	v_klubipartiikogused_1_partiide_arvu_summa, '', vaated_jr)
			else	insert Staatus values('Vaade "v_klubipartiikogused_1"', 'Partiide summa', 'Partiide summa peab olema 200, praegu on ' || partii_summa, 	'VIGA', v_klubipartiikogused_1_partiide_arvu_summa*0, 	v_klubipartiikogused_1_partiide_arvu_summa, '', vaated_jr)
			endif;
	else			insert Staatus values('Vaade "v_klubipartiikogused_1"', 'Partiide summa', 'Partiide summa peab olema 200, praegu on 0', 				'VIGA', v_klubipartiikogused_1_partiide_arvu_summa*0, 	v_klubipartiikogused_1_partiide_arvu_summa, 'Ei leia veergu "partiisid"', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_klubipartiikogused_1"', 'Partiide summa', 'Ei kompileeru', 	'VIGA', v_klubipartiikogused_1_partiide_arvu_summa*0, v_klubipartiikogused_1_partiide_arvu_summa, '', vaated_jr)
end catch;
end;


/* 
Vaate "v_klubipartiikogused_2" kontroll, kus on siis veergude kontroll ja veeru "partiisid" summa kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_klubipartiikogused_2" tabeli id; v_size = antud tabelis veergude arv; partii_summa = veeru "partiisid" summa;

Kõigepealt kontrollitakse, kas on olemas vaade "v_klubipartiikogused_2" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_klubipartiikogused_2" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on veeru "partiisid" summa kontroll ehk arvutatakse kokku kõikide veergude andmetest kokku mitu partiid on kirjas. Peab olema TÄPSELT KAKS SADA KUUSTEIST! 
*/

// Vaade v_klubipartiikogused_2 kontroll
create  procedure view_klubipartiikogused_2()
begin 
declare v_table_id, v_size, partii_summa int;

if 		not exists (select * from systable where upper(table_name) = upper('v_klubipartiikogused_2')) 
then 	insert Staatus values ('Vaade "v_klubipartiikogused_2"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_klubipartiikogused_2*0, v_klubipartiikogused_2, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_klubipartiikogused_2');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 2                 
then 	insert Staatus values ('Vaade "v_klubipartiikogused_2"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_klubipartiikogused_2_veergude_arv*0, v_klubipartiikogused_2_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_klubipartiikogused_2"', 'Veergude arv', '-', 'OK', v_klubipartiikogused_2_veergude_arv, v_klubipartiikogused_2_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Klubi_nimi', v_klubipartiikogused_2_klubi_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Partiisid', v_klubipartiikogused_2_partiisid, vaated_jr);

// Partii veeru summa kontroll, partii_summa peab võrduma TÄPSELT KAKS SADA
begin try
	if 		exists (select * from syscolumn where column_name = 'partiisid' and table_id = find_table_id('v_klubipartiikogused_2'))
	then	select 	sum(partiisid) into partii_summa from v_klubipartiikogused_2;
			if 		partii_summa = 216
			then	insert Staatus values('Vaade "v_klubipartiikogused_2"', 'Partiide summa', '-', 															'OK', 	v_klubipartiikogused_2_partiide_arvu_summa, 	v_klubipartiikogused_2_partiide_arvu_summa, '', vaated_jr)
			else	insert Staatus values('Vaade "v_klubipartiikogused_2"', 'Partiide summa', 'Partiide summa peab olema 216, praegu on ' || partii_summa, 	'VIGA', v_klubipartiikogused_2_partiide_arvu_summa*0, 	v_klubipartiikogused_2_partiide_arvu_summa, '', vaated_jr)
			endif;
	else			insert Staatus values('Vaade "v_klubipartiikogused_2"', 'Partiide summa', 'Partiide summa peab olema 200, praegu on 0', 				'VIGA', v_klubipartiikogused_2_partiide_arvu_summa*0, 	v_klubipartiikogused_2_partiide_arvu_summa, 'Ei leia veergu "partiisid"', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_klubipartiikogused_2"', 'Partiide summa', 'Ei kompileeru', 	'VIGA', v_klubipartiikogused_2_partiide_arvu_summa*0, v_klubipartiikogused_2_partiide_arvu_summa, '', vaated_jr)
end catch;

end;


/* 
Selle vaate kontroll toimub ainult siis kui muutuja aine = "S", sest see vaade on ainult "Sissejuhatus andmebaasidesse" aines.

Vaate "v_klubipartiikogused" kontroll, kus on siis veergude kontroll ja veeru "partiisid" summa kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_klubipartiikogused" tabeli id; v_size = antud tabelis veergude arv; partii_summa = veeru "partiisid" summa;

Kõigepealt kontrollitakse, kas on olemas vaade "v_klubipartiikogused" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_klubipartiikogused" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on veeru "partiisid" summa kontroll ehk arvutatakse kokku kõikide veergude andmetest kokku mitu partiid on kirjas. Peab olema TÄPSELT KAKS SADA KUUSTEIST! 
*/

// Vaade v_klubipartiikogused kontroll
create  procedure view_klubipartiikogused()
begin 
declare v_table_id, v_size, partii_summa int;

if 		not exists (select * from systable where upper(table_name) = upper('v_klubipartiikogused')) 
then 	insert Staatus values ('Vaade "v_klubipartiikogused"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_klubipartiikogused*0, v_klubipartiikogused, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_klubipartiikogused');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 2                 
then 	insert Staatus values ('Vaade "v_klubipartiikogused"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_klubipartiikogused_veergude_arv*0, v_klubipartiikogused_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_klubipartiikogused"', 'Veergude arv', '-', 'OK', v_klubipartiikogused_veergude_arv, v_klubipartiikogused_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Klubi_nimi', v_klubipartiikogused_klubi_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Partiisid', v_klubipartiikogused_partiisid, vaated_jr);

// Partii veeru summa kontroll, partii_summa peab võrduma TÄPSELT KAKS SADA
begin try
	if 		exists (select * from syscolumn where column_name = 'partiisid' and table_id = find_table_id('v_klubipartiikogused'))
	then	select 	sum(partiisid) into partii_summa from v_klubipartiikogused;
			if 		partii_summa = 216
			then	insert Staatus values('Vaade "v_klubipartiikogused"', 'Partiide summa', '-', 															'OK', 	v_klubipartiikogused_partiide_arvu_summa, 	v_klubipartiikogused_partiide_arvu_summa, '', vaated_jr)
			else	insert Staatus values('Vaade "v_klubipartiikogused"', 'Partiide summa', 'Partiide summa peab olema 216, praegu on ' || partii_summa, 	'VIGA', v_klubipartiikogused_partiide_arvu_summa*0, 	v_klubipartiikogused_partiide_arvu_summa, '', vaated_jr)
			endif;
	else			insert Staatus values('Vaade "v_klubipartiikogused"', 'Partiide summa', 'Partiide summa peab olema 216, praegu on 0', 				'VIGA', v_klubipartiikogused_partiide_arvu_summa*0, 	v_klubipartiikogused_partiide_arvu_summa, 'Ei leia veergu "partiisid"', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_klubipartiikogused"', 'Partiide summa', 'Ei kompileeru', 	'VIGA', v_klubipartiikogused_partiide_arvu_summa*0, v_klubipartiikogused_partiide_arvu_summa, '', vaated_jr)
end catch;

end;


/* 
Vaate "v_mangijad" kontroll, kus on siis veergude kontroll, kirjete arvu kontroll ja isiku nime kirjapildi kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_mangijad" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "v_mangijad" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_mangijad" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus kirjete arvu peab olema TÄPSELT KAKSKÜMMEND KOLM ehk sama kogus "Isikud" tabeliga.
Seejärel on isiku nime kirjapildi kontroll, kus isiku kirjapilt peab olema kujul: "perenimi, eesnimi".
*/

// Vaate v_mangijad/v_mängijad kontroll
create  procedure view_mangijad()
begin 
declare v_table_id, v_size, kirje_count int;
declare v_table_name varchar(100);

if 		not exists (select * from systable where upper(table_name) = upper('v_mangijad') or upper(table_name) = upper('v_mängijad'))
then 	insert Staatus values ('Vaade "v_mangijad"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_mangijad*0, v_mangijad, '', vaated_jr);
return; 
endif;

if 		exists (select * from systable where upper(table_name) = upper('v_mangijad') )
then set 	v_table_id = find_table_id('v_mangijad')
else set 	v_table_id = find_table_id('v_mängijad');
endif;

// Selleks, et saaks kontrollide tagasisides kasutada õiget vaate nime
set v_table_name = find_table_name(v_table_id);

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 4                 
then 	insert Staatus values ('Vaade "' + v_table_name + '"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', v_mangijad_veergude_arv*0, v_mangijad_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "' + v_table_name + '"', 'Veergude arv', '-', 'OK', v_mangijad_veergude_arv, v_mangijad_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Klubi_nimi', v_mangijad_klubi_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Klubi_id', v_mangijad_klubi_id, vaated_jr);
call	check_column_for_view(v_table_id, 'Isik_nimi', v_mangijad_isik_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Isik_id', v_mangijad_isik_id, vaated_jr);

// Kirjete kontroll
begin try
	if 		exists (select * from systable where upper(table_name) = upper('v_mangijad') )
    then
    select 	count(*) into kirje_count from v_mangijad
    else 
    select 	count(*) into kirje_count from v_mängijad
    endif;
	
	if		kirje_count > 23
	then	insert Staatus values('Vaade "' + v_table_name + '"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mangijad_kirjete_arv*0, 	v_mangijad_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 23
	then	insert Staatus values('Vaade "' + v_table_name + '"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mangijad_kirjete_arv*0, 	v_mangijad_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "' + v_table_name + '"', 'Kirjete arv', '-', 													'OK', 	v_mangijad_kirjete_arv, 	v_mangijad_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "' + v_table_name + '"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_mangijad_kirjete_arv*0, v_mangijad_kirjete_arv, '', vaated_jr)
end catch;

// Isiku nime kirjapilt
begin try
	if 		exists (select * from systable where upper(table_name) = upper('v_mangijad') )
    then
	if 		(select isik_nimi from v_mangijad where isik_id = 71) = 'Mets, Arvo'
	then	insert Staatus values('Vaade "' + v_table_name + '"', 'Isiku nimi', '-', 'OK', 	v_mangijad_isik_nimi_kuju, 	v_mangijad_isik_nimi_kuju, '', vaated_jr)
	else	insert Staatus values('Vaade "' + v_table_name + '"', 'Isiku nimi', 'Isiku nime kirjapilt on vale.', 'VIGA', 	v_mangijad_isik_nimi_kuju*0, 	v_mangijad_isik_nimi_kuju, 'Kas on "perenimi, eesnimi"?', vaated_jr)
	endif;
    else
    if 		(select isik_nimi from v_mängijad where isik_id = 71) = 'Mets, Arvo' 
	then	insert Staatus values('Vaade "' + v_table_name + '"', 'Isiku nimi', '-', 'OK', 	v_mangijad_isik_nimi_kuju, 	v_mangijad_isik_nimi_kuju, '', vaated_jr)
	else	insert Staatus values('Vaade "' + v_table_name + '"', 'Isiku nimi', 'Isiku nime kirjapilt on vale.', 'VIGA', 	v_mangijad_isik_nimi_kuju*0, 	v_mangijad_isik_nimi_kuju, 'Kas on "perenimi, eesnimi"?', vaated_jr)
	endif;
    endif
end try
begin catch
	insert Staatus values('Vaade "' + v_table_name + '"', 'Isik_nimi', 'Ei kompileeru', 'VIGA', 	v_mangijad_isik_nimi_kuju*0, 	v_mangijad_isik_nimi_kuju, '', vaated_jr)
end catch;

end;


/* 
Vaate "v_turniiripartiid" kontroll, kus on siis veergude kontroll ja kirjete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_turniiripartiid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "v_turniiripartiid" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_turniiripartiid" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus kirjete arvu peab olema TÄPSELT SADA KAHEKSA ehk sama kogus "Partiid" tabeliga 
*/

// Vaate v_turniiripartiid kontroll
create  procedure view_turniiripartiid()
begin 
declare v_table_id, v_size, kirje_count int;
       
if 		not exists (select * from systable where upper(table_name) = upper('v_turniiripartiid'))
then 	insert Staatus values ('Vaade "v_turniiripartiid"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_turniiripartiid*0, v_turniiripartiid, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_turniiripartiid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 4                 
then 	insert Staatus values ('Vaade "v_turniiripartiid"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', v_turniiripartiid_veergude_arv*0, v_turniiripartiid_veergude_arv, '', vaated_jr) 
else	insert Staatus values ('Tabel "v_turniiripartiid"', 'Veergude arv', '-', 'OK', v_turniiripartiid_veergude_arv, v_turniiripartiid_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Turniir_nimi', v_turniiripartiid_turniir_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Partii_id', v_turniiripartiid_partii_id, vaated_jr);
call	check_column_for_view(v_table_id, 'Partii_algus', v_turniiripartiid_partii_algus, vaated_jr);
call	check_column_for_view_t2pit2ht(v_table_id, 'Partii_lõpp', 'Partii_lopp', v_turniiripartiid_partii_lõpp, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_turniiripartiid;
	if		kirje_count > 108
	then	insert Staatus values('Vaade "v_turniiripartiid"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_turniiripartiid_kirjete_arv*0, 	v_turniiripartiid_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 108
	then	insert Staatus values('Vaade "v_turniiripartiid"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_turniiripartiid_kirjete_arv*0, 	v_turniiripartiid_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_turniiripartiid"', 'Kirjete arv', '-', 														'OK', 	v_turniiripartiid_kirjete_arv, 		v_turniiripartiid_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_turniiripartiid"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_turniiripartiid_kirjete_arv*0, v_turniiripartiid_kirjete_arv, '', vaated_jr)
end catch;

end;


/* 
Vaate "v_punktid" kontroll, kus on siis veergude kontroll, vaate kirjete arvu kontroll ja veeru "punkt" summa kontroll ning veeru punkt täiskoha ja komakoha kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_punktid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis; punkti_summa = veeru "punkt" summa;

Kõigepealt kontrollitakse, kas on olemas tabel "v_punktid" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_punktid" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS SADA KUUSTEIST kirjet. 
Seejärel on veeru "punkt" summa kontroll ehk arvutatakse kokku kõikide veergude andmetest kokku mitu punkti on kirjas. Peab olema TÄPSELT SADA KAHEKSA!
Seejärel on veeru "punkt" täiskoha ja komakoha kontroll:
1) Komakohaga - turniir 42, mängija 72, punkt peab olema 0.5
1) Täiskohaga - turniir 41, mängija 77, punkt peab olema 1.0
*/

// Vaate v_punktid kontroll
create  procedure view_punktid()
begin 
declare v_table_id, v_size, kirje_count, punkti_summa int;       

if 		not exists (select * from systable where upper(table_name) = upper('v_punktid'))
then 	insert Staatus values ('Vaade "v_punktid"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_punktid*0, v_punktid, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_punktid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 5                 
then 	insert Staatus values ('Vaade "v_punktid"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', v_punktid_veergude_arv*0, v_punktid_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_punktid"', 'Veergude arv', '-', 'OK', v_punktid_veergude_arv, v_punktid_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Partii', v_punktid_partii, vaated_jr);
call	check_column_for_view(v_table_id, 'Turniir', v_punktid_turniir, vaated_jr);
call	check_column_for_view_t2pit2ht(v_table_id, 'Mängija', 'Mangija', v_punktid_mängija, vaated_jr);
call	check_column_for_view_t2pit2ht(v_table_id, 'Värv', 'Varv', v_punktid_värv, vaated_jr);
call	check_column_for_view(v_table_id, 'Punkt', v_punktid_punkt, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_punktid;
	if		kirje_count > 216
	then	insert Staatus values('Vaade "v_punktid"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_punktid_kirjete_arv*0, 	v_punktid_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 216
	then 	insert Staatus values('Vaade "v_punktid"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_punktid_kirjete_arv*0, 	v_punktid_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_punktid"', 'Kirjete arv', '-', 														'OK', 	v_punktid_kirjete_arv, 		v_punktid_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_punktid"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_punktid_kirjete_arv*0, v_punktid_kirjete_arv, '', vaated_jr)
end catch;

// Veeru punkt summa kontroll
begin try
	if 		exists (select * from syscolumn where column_name = 'punkt' and table_id = find_table_id('v_punktid'))
	then	select 	sum(punkt) into punkti_summa from v_punktid;
			if 		punkti_summa = 108
			then 	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punktide summa', '-', 														'OK', 	v_punktid_punkti_summa, 	v_punktid_punkti_summa, '', vaated_jr)
			else	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punktide summa', 'Punktide summa peab olema 108, praegu on ' || punkti_summa, 'VIGA', v_punktid_punkti_summa*0, 	v_partiid_punkti_summa, '', vaated_jr)
			endif;
	else			insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punktide summa', 'Punktide summa peab olema 108, praegu on 0', 				'VIGA', v_punktid_punkti_summa*0, 	v_partiid_punkti_summa, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punktide summa', 'Ei kompileeru', 	'VIGA', v_punktid_punkti_summa*0, v_punktid_punkti_summa, '', vaated_jr)
end catch;

// Veeru punkt koma ja täiskoha kontroll
begin try
	if 		(select punkt from v_punktid where turniir = 42 and mangija = 72 and punkt = 0.5) = 0.5
	then	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', '-', 	'OK', v_punktid_punkt_koma, v_punktid_punkt_koma, '', vaated_jr)
	else	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Punkt pole õige.', 	'VIGA', v_punktid_punkt_koma*0, v_punktid_punkt_koma, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if 		(select punkt from v_punktid where turniir = 42 and mängija = 72 and punkt = 0.5) = 0.5
		then	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', '-', 	'OK', v_punktid_punkt_koma, v_punktid_punkt_koma, '', vaated_jr)
		else	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Punkt pole õige.', 	'VIGA', v_punktid_punkt_koma*0, v_punktid_punkt_koma, '', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Ei kompileeru', 	'VIGA', v_punktid_punkt_koma*0, v_punktid_punkt_koma, '', vaated_jr)
	end catch;
end catch;

begin try
	if 		(select punkt from v_punktid where turniir = 41 and mangija = 77 and punkt = 1.0) = 1.0
	then	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', '-', 	'OK', v_punktid_punkt_täis, v_punktid_punkt_täis, '', vaated_jr)
	else	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Punkt pole õige', 	'VIGA', v_punktid_punkt_täis*0, v_punktid_punkt_täis, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if 		(select punkt from v_punktid where turniir = 41 and mängija = 77 and punkt = 1.0) = 1.0
		then	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', '-', 	'OK', v_punktid_punkt_täis, v_punktid_punkt_täis, '', vaated_jr)
		else	insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Punkt pole õige', 	'VIGA', v_punktid_punkt_täis*0, v_punktid_punkt_täis, '', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Vaade "v_punktid"', 'Veeru "punkt" punkti kontroll', 'Ei kompileeru', 	'VIGA', v_punktid_punkt_täis*0, v_punktid_punkt_täis, '', vaated_jr)
	end catch;
end catch;

end;


/*
Vaate "v_partiid" kontroll, veergude "valge_punkt" ja "must_punkt" summa kontroll ning vaate kirjete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_partiid" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis; punkti_summa = veeru "must_punkt" ja "valge_punkt" summa;

Kõigepealt kontrollitakse, kas on olemas tabel "v_partiid" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_partiid" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT SADA KAHEKSA kirjet.
Seejärel on veergude "valge_punkt" ja "must_punkt" summa kontroll ehk arvutatakse kokku kõikide "must_punkt" veergude ja "valge_punkt" veergude andmetest kokku mitu punkti on kirjas. 
Peab olema TÄPSELT SADA KAHEKSA!
*/

// Vaate v_partiid kontroll
create  procedure view_partiid()
begin 
declare v_table_id, v_size, kirje_count, punkti_summa int;   

if 		not exists (select * from systable where upper(table_name) = upper('v_partiid'))
then 	insert Staatus values ('Vaade "v_partiid"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_partiid*0, v_partiid, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_partiid');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 9                 
then 	insert Staatus values ('Vaade "v_partiid"', 'Veergude arv', 'On vale, peab olema 9, hetkel on ' || v_size, 'VIGA', v_partiid_veergude_arv*0, v_partiid_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_partiid"', 'Veergude arv', '-', 'OK', v_partiid_veergude_arv, v_partiid_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Id', v_partiid_id, vaated_jr);
call	check_column_for_view(v_table_id, 'Turniir', v_partiid_turniir, vaated_jr);
call	check_column_for_view(v_table_id, 'Algus', v_partiid_algus, vaated_jr);
call	check_column_for_view(v_table_id, 'Valge_nimi', v_partiid_valge_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Valge_klubi', v_partiid_valge_klubi, vaated_jr);
call	check_column_for_view(v_table_id, 'Valge_punkt', v_partiid_valge_punkt, vaated_jr);
call	check_column_for_view(v_table_id, 'Must_nimi', v_partiid_must_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Must_klubi', v_partiid_must_klubi, vaated_jr);
call	check_column_for_view(v_table_id, 'Must_punkt', v_partiid_must_punkt, vaated_jr);

begin try
	// Kirjete kontroll
	select 	count(*) into kirje_count from v_partiid;
	if		kirje_count > 108
	then	insert Staatus values('Vaade "v_partiid"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_partiid_kirjete_arv*0, 	v_partiid_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 108
	then	insert Staatus values('Vaade "v_partiid"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_partiid_kirjete_arv*0, 	v_partiid_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_partiid"', 'Kirjete arv', '-', 														'OK', 	v_partiid_kirjete_arv, 		v_partiid_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
insert Staatus values('Vaade "v_partiid"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', 	v_partiid_kirjete_arv*0, 		v_partiid_kirjete_arv, '', vaated_jr)
end catch;

begin try
// Veergude must_punkt ja valge_punkt summa kontroll
if 		exists (select * from syscolumn where column_name = 'valge_punkt' and table_id = find_table_id('v_partiid')) 
and 	exists (select * from syscolumn where column_name = 'must_punkt' and table_id = find_table_id('v_partiid'))
then	select 	sum(valge_punkt) + sum(must_punkt) into punkti_summa from v_partiid;
		if 		punkti_summa = 108
		then 	insert Staatus values('Vaade "v_partiid"', 'Mustade ja valgete punktide summa', '-', 															'OK', 	v_partiid_punkti_summa, 	v_partiid_punkti_summa, '', vaated_jr)
		else	insert Staatus values('Vaade "v_partiid"', 'Mustade ja valgete punktide summa', 'Punktide summa peab olema 108, praegu on ' || punkti_summa, 	'VIGA', v_partiid_punkti_summa*0, 	v_partiid_punkti_summa, '', vaated_jr)
		endif;
else			insert Staatus values('Vaade "v_partiid"', 'Mustade ja valgete punktide summa', 'Punktide summa peab olema 108, praegu on 0', 					'VIGA', v_partiid_punkti_summa*0, 	v_partiid_punkti_summa, '', vaated_jr)
		endif;
end try
begin catch
insert Staatus values('Vaade "v_partiid"', 'Mustade ja valgete punktide summa', 'Ei kompileeru', 'VIGA', 	v_partiid_punkti_summa*0, 		v_partiid_punkti_summa, '', vaated_jr)
end catch;

end;


/*
Vaate "v_kolmik" kontroll, esimese koha punktid kontroll, veeru "punktid" kogu summa kontroll ning vaate kirjete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_kolmik" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis; punkti_summa = veeru "punktid" summa;

Kõigepealt kontrollitakse, kas on olemas tabel "v_kolmik" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_kolmik" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KOLM kirjet.
Seejärel luuakse TEMP tabel, sest mõnel tudengil võivad veeru nimed olla valesti, selle välitmiseks loob skript temp tabeli soovitud veeru nimedega
Seejärel on veeru "punktid" summa kontroll ehk arvutatakse kokku kõikide punktide summa 
Peab olema TÄPSELT 11.0!
Järgmisena toimub igakjuhuks ka esimese koha kontroll ehk kontrollitakse, kas esimesel kohal oleval isikul on 4.5 punkti.
Selle kontrolliks luuakse Temp tabel, sest veerul "järjekorra_number" võib tudengitel olla erinevad nimed 
ja see annab errori kui see nimi pole õige, seega Temp tabelis on selle veeru nimi "Nr".
*/
create procedure view_kolmik()
begin
declare v_table_id, v_size, kirje_count, punkti_summa int;   

if 		not exists (select * from systable where upper(table_name) = upper('v_kolmik'))
then 	insert Staatus values ('Vaade "v_kolmik"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_kolmik*0, v_kolmik, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_kolmik');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 3                 
then 	insert Staatus values ('Vaade "v_kolmik"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', v_kolmik_veergude_arv*0, v_kolmik_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_kolmik"', 'Veergude arv', '-', 'OK', v_kolmik_veergude_arv, v_kolmik_veergude_arv, '', vaated_jr)
endif;

// call	check_column_for_view(v_table_id, 'Järjekorra_number', v_kolmik_nr, vaated_jr);
call	check_column_for_view(v_table_id, 'Nimi', v_kolmik_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Punktid', v_kolmik_punktid, vaated_jr);

begin try
	// Kirjete kontroll
	select 	count(*) into kirje_count from v_kolmik;
	if		kirje_count > 3
	then	insert Staatus values('Vaade "v_kolmik"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_kolmik_kirjete_arv*0, 	v_kolmik_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 3
	then	insert Staatus values('Vaade "v_kolmik"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_kolmik_kirjete_arv*0, 	v_kolmik_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_kolmik"', 'Kirjete arv', '-', 														'OK', 	v_kolmik_kirjete_arv, 		v_kolmik_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_kolmik"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', 	v_kolmik_kirjete_arv*0, 		v_kolmik_kirjete_arv, '', vaated_jr)
end catch;
    
begin try
if 	exists (select * from syscolumn where column_name = 'punktid' and table_id = v_table_id) then
	select 	sum(punktid) into punkti_summa from v_kolmik;
	if 		punkti_summa = 11
	then 	insert Staatus values('Vaade "v_kolmik"', 'Punktide summa kokku', '-', 															'OK', 	v_kolmik_punkti_summa, 	v_kolmik_punkti_summa, '', vaated_jr)
	else	insert Staatus values('Vaade "v_kolmik"', 'Punktide summa kokku', 'Punktide summa peab olema 11.0, praegu on ' || punkti_summa, 	'VIGA', v_kolmik_punkti_summa*0, 	v_kolmik_punkti_summa, '', vaated_jr)
	endif;
else
	create	table #Temp(nr int, nimi varchar(102), punktid numeric); 
	unload	select * from v_kolmik to 'C:\\TEMP\\kodutoo_check.txt' encoding 'UTF-8';
	load	table #Temp (nr, nimi, punktid) from 'C:\\TEMP\\kodutoo_check.txt' defaults on;
	insert Staatus values('Test', 'Test', 'Temp on olemas','VIGA',0,0,'',vaated_jr);
	
	select 	sum(punktid) into punkti_summa from #Temp;
	if 		punkti_summa = 11
	then 	insert Staatus values('Vaade "v_kolmik"', 'Punktide summa kokku', '-', 															'OK', 	v_kolmik_punkti_summa, 	v_kolmik_punkti_summa, '', vaated_jr)
	else	insert Staatus values('Vaade "v_kolmik"', 'Punktide summa kokku', 'Punktide summa peab olema 11.0, praegu on ' || punkti_summa, 	'VIGA', v_kolmik_punkti_summa*0, 	v_kolmik_punkti_summa, '', vaated_jr)
	endif;
endif;
end try
begin catch
	insert Staatus values('Vaade "v_kolmik"', 'Punktide summa kokku', 'Ei kompileeru', 'VIGA', 	v_kolmik_punkti_summa*0, 		v_kolmik_punkti_summa, '', vaated_jr)
end catch;

begin try
	create	table #Temp(nr int, nimi varchar(102), punktid numeric); 
	unload	select * from v_kolmik to 'C:\\TEMP\\kodutoo_check.txt' encoding 'UTF-8';
	load	table #Temp (nr, nimi, punktid) from 'C:\\TEMP\\kodutoo_check.txt' defaults on;
	
	if		(select punktid from #Temp where nr = 1) = 4.5	
	then	insert Staatus values('Vaade "v_kolmik"', 'Esimese koha punktid', '-', 														'OK', 	v_kolmik_esimene_punktid, 		v_kolmik_esimene_punktid, '', vaated_jr)
	else	insert Staatus values('Vaade "v_kolmik"', 'Esimese koha punktid', 'Esimese koha punktid peavad olema 4.5, praegu on ' || (select punktid from #Temp where nr = 1), 	'VIGA', v_kolmik_esimene_punktid*0, 	v_kolmik_esimene_punktid, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if		(select punktid from v_kolmik where nimi = 'Maasikas, Malle') = 4.5	
		then	insert Staatus values('Vaade "v_kolmik"', 'Esimese koha punktid', '-', 														'OK', 	v_kolmik_esimene_punktid, 		v_kolmik_esimene_punktid, '', vaated_jr)
		else	insert Staatus values('Vaade "v_kolmik"', 'Esimese koha punktid', 'Esimese koha punktid peavad olema 4.5', 	'VIGA', v_kolmik_esimene_punktid*0, 	v_kolmik_esimene_punktid, 'Kas on "perenimi, eesnimi"?', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Vaade "v_kolmik"', 'Esimese koha punktid', 'Ei kompileeru', 	'VIGA', v_kolmik_esimene_punktid*0, 	v_kolmik_esimene_punktid, 'Kas on "perenimi, eesnimi"?', vaated_jr);
	end catch;
end catch;

end;



/* 7nda kodutöö vaated asulaklubisid, asulasuurus ja V1-V12 */

/*
Vaate "v_asulaklubisid" kontroll, vaate kirjete arvu kontroll ja kahe kirje klubide arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_asulaklubisid" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "v_asulaklubisid" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_asulaklubisid" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT NELI kirjet.
Seejärel on kirjete "Tartu" ning "Elva" klubide arvu kontroll. Tartul peab olema 6 ja Elval 0.
*/

create procedure view_asulaklubisid()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_asulaklubisid'))
then 	insert Staatus values ('Vaade "v_asulaklubisid"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_asulaklubisid*0, v_asulaklubisid, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_asulaklubisid');

select 	count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 3                 
then 	insert Staatus values ('Vaade "v_asulaklubisid"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', v_asulaklubisid_veergude_arv*0, v_asulaklubisid_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_asulaklubisid"', 'Veergude arv', '-', 'OK', v_asulaklubisid_veergude_arv, v_asulaklubisid_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'asula_id', v_asulaklubisid_asula_id, vaated_jr);
call	check_column_for_view(v_table_id, 'asula_nimi', v_asulaklubisid_asula_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'klubisid', v_asulaklubisid_klubisid, vaated_jr);

// Kirjete arvu kontroll
begin try
	select 	count(*) into kirje_count from v_asulaklubisid;
	if 		kirje_count > 4
	then	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_asulaklubisid_kirjete_arv*0, v_asulaklubisid_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 4
	then	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_asulaklubisid_kirjete_arv*0, v_asulaklubisid_kirjete_arv, '', vaated_jr)
	else	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirjete arv', '-', 'OK', v_asulaklubisid_kirjete_arv, v_asulaklubisid_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', v_asulaklubisid_kirjete_arv*0, v_asulaklubisid_kirjete_arv, '', vaated_jr)
end catch;

// Kirjete Tartu ja Elva klubide arvu kontroll
begin try
	if 		(select klubisid from v_asulaklubisid where asula_nimi = 'Tartu') = 6 and (select klubisid from v_asulaklubisid where asula_nimi = 'Elva') = 0
	then	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirje kontroll', '-', 'OK', v_asulaklubisid_kirje, v_asulaklubisid_kirje, '', vaated_jr)
	else	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirje kontroll', 'Tartus või Elvas on vale arv klubisid', 'VIGA', v_asulaklubisid_kirje*0, v_asulaklubisid_kirje, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values ('Vaade "v_asulaklubisid"', 'Kirje kontroll', 'Ei kompileeru', 'VIGA', v_asulaklubisid_kirje*0, v_asulaklubisid_kirje, '', vaated_jr)
end catch;

end;


/*
Vaate "v_asulasuurus" kontroll, vaate kirjete arvu kontroll ja kahe kirje isikute arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "v_asulasuurus" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "v_asulasuurus" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "v_asulasuurus" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT NELI kirjet.
Seejärel on kirjete "Tartu" ning "Elva" isikute arvu kontroll. Tartul peab olema 23 ja Elval 0.
*/

create procedure view_asulasuurus()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_asulasuurus'))
then 	insert Staatus values ('Vaade "v_asulasuurus"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_asulasuurus*0, v_asulasuurus, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_asulasuurus');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 3                 
then	insert Staatus values ('Vaade "v_asulasuurus"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', v_asulasuurus_veergude_arv*0, v_asulasuurus_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_asulasuurus"', 'Veergude arv', '-', 'OK', v_asulasuurus_veergude_arv, v_asulasuurus_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'asula_id', v_asulasuurus_asula_id, vaated_jr);
call	check_column_for_view(v_table_id, 'asula_nimi', v_asulasuurus_asula_nimi, vaated_jr);
call	check_column_for_view_t2pit2ht(v_table_id, 'mängijaid', 'mangijaid', v_asulasuurus_mangijaid, vaated_jr);

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from v_asulasuurus;
	if 		kirje_count > 4
	then	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_asulasuurus_kirjete_arv*0, v_asulasuurus_kirjete_arv, '', vaated_jr)
	elseif 	kirje_count < 4
	then	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_asulasuurus_kirjete_arv*0, v_asulasuurus_kirjete_arv, '', vaated_jr)
	else	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirjete arv', '-', 'OK', v_asulasuurus_kirjete_arv, v_asulasuurus_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', v_asulasuurus_kirjete_arv*0, v_asulasuurus_kirjete_arv, '', vaated_jr)
end catch;

// Kirjete Tartu ja Elva isikute arvu kontroll
begin try
	if 		(select mangijaid from v_asulasuurus where asula_nimi = 'Tartu') = 23 and (select mangijaid from v_asulasuurus where asula_nimi = 'Elva') = 0
	then	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirje kontroll', '-', 'OK', v_asulasuurus_kirje, v_asulasuurus_kirje, '', vaated_jr)
	else	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirje kontroll', 'Tartus või Elvas on vale arv isikuid.', 'VIGA', v_asulasuurus_kirje*0, v_asulasuurus_kirje, '', vaated_jr)
	endif;
end try
begin catch
	begin try
		if 		(select mängijaid from v_asulasuurus where asula_nimi = 'Tartu') = 23 and (select mängijaid from v_asulasuurus where asula_nimi = 'Elva') = 0
		then	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirje kontroll', '-', 'OK', v_asulasuurus_kirje, v_asulasuurus_kirje, '', vaated_jr)
		else	insert Staatus values ('Vaade "v_asulasuurus"', 'Kirje kontroll', 'Tartus või Elvas on vale arv isikuid.', 'VIGA', v_asulasuurus_kirje*0, v_asulasuurus_kirje, '', vaated_jr)
		endif;
	end try
	begin catch
		insert Staatus values ('Vaade "v_asulasuurus"', 'Kirje kontroll', 'Ei kompileeru', 'VIGA', v_asulasuurus_kirje*0, v_asulasuurus_kirje, '', vaated_jr)
	end catch;
end catch;
	
end;


/* 7nda kodutöö vaated V1-V12 */

/*
Vaate "V_1" kontroll, vaate kirjete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_1" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_1" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "V_1" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KOLM kirjet.
*/

create procedure view_V1()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_1'))
then 	insert Staatus values ('Vaade "V_1"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_1*0, v_1, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_1');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_1"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_1_veergude_arv*0, v_1_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_1"', 'Veergude arv', '-', 'OK', v_1_veergude_arv, v_1_veergude_arv, '', vaated_1_12_jr)
endif;

call 	check_column_for_view(v_table_id, 'eesnimi', v_1_eesnimi, vaated_1_12_jr);
call 	check_column_for_view(v_table_id, 'perenimi', v_1_perenimi, vaated_1_12_jr);

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_1;
	if 		kirje_count > 3
	then 	insert Staatus values ('Vaade "V_1"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_1_kirjete_arv*0, v_1_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 3
	then 	insert Staatus values ('Vaade "V_1"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_1_kirjete_arv*0, v_1_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_1"', 'Kirjete arv', '-', 'OK', v_1_kirjete_arv, v_1_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_1"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_1_kirjete_arv*0, v_1_kirjete_arv, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_2" kontroll, vaate kirjete arvu kontroll ja kirje liikmete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_2" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_2" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel liikmete arvu kontroll, kus kõigepealt vaadatakse, et oleks ainult 1 veerg ja 1 kirje kui on, siis liikmete arvuks on KOLM.
*/

create procedure view_V2()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_2'))
then 	insert Staatus values ('Vaade "V_2"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_2*0, v_2, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_2');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_2"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_2_veergude_arv*0, v_2_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_2"', 'Veergude arv', '-', 'OK', v_2_veergude_arv, v_2_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) kirje_count from V_2;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_2"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_2_kirjete_arv*0, v_2_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 1
	then 	insert Staatus values ('Vaade "V_2"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_2_kirjete_arv*0, v_2_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_2"', 'Kirjete arv', '-', 'OK', v_2_kirjete_arv, v_2_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_2"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_2_kirjete_arv*0, v_2_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Liikmete arvu kontroll
begin try
	if 			v_size != 1 and (select count(*) from V_2) = 1
    then 		insert Staatus values ('Vaade "V_2"', 'Liikmete arv', 'Oodati ainult ühte veergu', 'VIGA', v_2_liikmete_arv*0, v_2_liikmete_arv, '', vaated_1_12_jr)
    else
		if		(select * from V_2) = 3
		then 	insert Staatus values ('Vaade "V_2"', 'Liikmete arv', '-', 'OK', v_2_liikmete_arv, v_2_liikmete_arv, '', vaated_1_12_jr)
		else	insert Staatus values ('Vaade "V_2"', 'Liikmete arv', 'Vale liikmete arv. Peab olema 3, hetkel on ' || (select * from V_2), 'VIGA', v_2_liikmete_arv*0, v_2_liikmete_arv, '', vaated_1_12_jr)
		endif;
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_2"', 'Liikmete arv', 'Ei kompileeru', 	'VIGA', v_2_liikmete_arv*0, v_2_liikmete_arv, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_3" kontroll, vaate kirjete arvu kontroll ja ühe kirje olemasolu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_3" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_3" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "V_3" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS kirjet.
Seejärel loetakse kokku mitu kirjet vastab tingimusele "Maasikas", peab olema ÜKS.
*/

create procedure view_V3()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_3'))
then 	insert Staatus values ('Vaade "V_3"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_3*0, v_3, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_3');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_3"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_3_veergude_arv*0, v_3_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_3"', 'Veergude arv', '-', 'OK', v_3_veergude_arv, v_3_veergude_arv, '', vaated_1_12_jr)
endif;

call 	check_column_for_view(v_table_id, 'perenimi', v_3_perenimi, vaated_1_12_jr);

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_3;
	if 		kirje_count > 2
	then 	insert Staatus values ('Vaade "V_3"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_3_kirjete_arv*0, v_3_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 2
	then 	insert Staatus values ('Vaade "V_3"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_3_kirjete_arv*0, v_3_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_3"', 'Kirjete arv', '-', 'OK', v_3_kirjete_arv, v_3_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_3"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_3_kirjete_arv*0, v_3_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje "Maasikas" olemasolu kontroll
begin try
	if 		(select count(*) from V_3 where perenimi = 'Maasikas') = 1
	then 	insert Staatus values ('Vaade "V_3"', 'Isiku kontroll', '-', 'OK', v_3_perenimi_m, v_3_perenimi_m, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_3"', 'Isiku kontroll', 'Ei leia õiget isikut.', 'VIGA', v_3_perenimi_m*0, v_3_perenimi_m, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_3"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_3_perenimi_m*0, v_3_perenimi_m, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_4" kontroll, vaate kirjete arvu kontroll ja ühe kirje kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_4" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_4" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "V_4" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel vaadatakse, kas vaate ainus kirje on õige kuupäevaga ehk "2005-01-12 08:02:00.000".
*/

create procedure view_V4()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_4'))
then 	insert Staatus values ('Vaade "V_4"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_4*0, v_4, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_4');
select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_4"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_4_veergude_arv*0, v_4_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_4"', 'Veergude arv', '-', 'OK', v_4_veergude_arv, v_4_veergude_arv, '', vaated_1_12_jr)
endif;

/*if 		exists (select * from syscolumn where table_id = v_table_id and column_name = 'algusaeg') 
then	call check_column_for_view(v_table_id, 'algusaeg', v_4_algushetk, vaated_1_12_jr)
else	call check_column_for_view(v_table_id, 'algushetk', v_4_algushetk, vaated_1_12_jr)
endif;*/

call 	check_column_for_view_t2pit2ht(v_table_id, 'algusaeg', 'algushetk', v_4_algushetk, vaated_1_12_jr);

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_4;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_4"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_4_kirjete_arv*0, v_4_kirjete_arv, '', vaated_1_12_jr)
	elseif 	kirje_count < 1
	then 	insert Staatus values ('Vaade "V_4"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_4_kirjete_arv*0, v_4_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_4"', 'Kirjete arv', '-', 'OK', v_4_kirjete_arv, v_4_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_4"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_4_kirjete_arv*0, v_4_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje kontroll
begin try
	if		(select * from V_4) = '2005-01-12 08:02:00.000'
	then 	insert Staatus values ('Vaade "V_4"', 'Algusaeg', '-', 'OK', v_4_aeg, v_4_aeg, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_4"', 'Algusaeg', 'Vale algusaeg', 'VIGA', v_4_aeg, v_4_aeg, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_4"', 'Algusaeg', 'Ei kompileeru', 	'VIGA', v_4_aeg*0, v_4_aeg, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_5" kontroll, vaate kirjete arvu kontroll ja partii olemasolu kontroll kahe isiku vahel.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_5" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_5" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude olemasolu kontroll check_column_for_view abil.
Andmeteks on siis: tabeli "V_5" id, veeru nimi ja punktide arv, mis saab selle veeru korras oleku eest.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT NELITEIST kirjet.
Seejärel kontrollitakse, kas leidub partii valge isiku id-ga 78, kui musta isiku id = 75 ja vastupidi.
*/

create procedure view_V5()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_5'))
then 	insert Staatus values ('Vaade "V_5"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_5*0, v_5, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_5');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_5"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_5_veergude_arv*0, v_5_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_5"', 'Veergude arv', '-', 'OK', v_5_veergude_arv, v_5_veergude_arv, '', vaated_1_12_jr)
endif;

call	check_column_for_view(v_table_id, 'valge', v_5_valge, vaated_1_12_jr);
call	check_column_for_view(v_table_id, 'must', v_5_must, vaated_1_12_jr);

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_5;
	if 		kirje_count > 14
	then 	insert Staatus values ('Vaade "V_5"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_5_kirjete_arv*0, v_5_kirjete_arv, 'Veerud peavad olema must ja valge.', vaated_1_12_jr)
	elseif	kirje_count < 14
	then 	insert Staatus values ('Vaade "V_5"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_5_kirjete_arv*0, v_5_kirjete_arv, 'Veerud peavad olema must ja valge.', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_5"', 'Kirjete arv', '-', 'OK', v_5_kirjete_arv, v_5_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_5"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_5_kirjete_arv*0, v_5_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Partii olemasolu kontroll kahe isiku vahel
begin try
	if 		(select valge from V_5 where must = 75) = 78
	and		(select must from V_5 where valge = 78) = 75
	then 	insert Staatus values ('Vaade "V_5"', 'Partii 78-75 vahel', '-', 'OK', v_5_partii, v_5_partii, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_5"', 'Partii 78-75 vahel', 'Ei leia seda partiid', 'VIGA', v_5_partii*0, v_5_partii, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_5"', 'Partii 78-75 vahel', 'Ei kompileeru', 	'VIGA', v_5_partii*0, v_5_partii, 'Ei leidu kirjet kujul 78 75', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_6" kontroll, vaate kirjete arvu kontroll ja kirje olemasolu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_6" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_6" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel kontrollitakse, kas leidub eesnimi "Maari".
*/

create procedure view_V6()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_6'))
then 	insert Staatus values ('Vaade "V_6"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_6*0, v_6, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_6');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_6"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_6_veergude_arv*0, v_6_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_6"', 'Veergude arv', '-', 'OK', v_6_veergude_arv, v_6_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_6;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_6"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_6_kirjete_arv*0, v_6_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 1
	then 	insert Staatus values ('Vaade "V_6"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_6_kirjete_arv*0, v_6_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_6"', 'Kirjete arv', '-', 'OK', v_6_kirjete_arv, v_6_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_6"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_6_kirjete_arv*0, v_6_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje olemasolu kontroll
begin try
	if		(select eesnimi from V_6) = 'Maari'
	then 	insert Staatus values ('Vaade "V_6"', 'Isik "Maari"', '-', 'OK', v_6_isik, v_6_isik, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_6"', 'Isik "Maari"', 'Ei leia teda', 'VIGA', v_6_isik*0, v_6_isik, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_6"', 'Isik "Maari"', 'Ei kompileeru', 	'VIGA', v_6_isik*0, v_6_isik, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_7" kontroll, vaate kirjete arvu kontroll ja kirje olemasolu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_7" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_7" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel kontrollitakse, kas leidub perenimi "Hiis".
*/

create procedure view_V7()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_7'))
then 	insert Staatus values ('Vaade "V_7"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_7*0, v_7, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_7');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_7"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_7_veergude_arv*0, v_7_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_7"', 'Veergude arv', '-', 'OK', v_7_veergude_arv, v_7_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_7;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_7"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_7_kirjete_arv*0, v_7_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 1
	then 	insert Staatus values ('Vaade "V_7"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_7_kirjete_arv*0, v_7_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_7"', 'Kirjete arv', '-', 'OK', v_7_kirjete_arv, v_7_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_7"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_7_kirjete_arv*0, v_7_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje olemasolu kontroll
begin try
	if		(select perenimi from V_7) = 'Hiis'
	then 	insert Staatus values ('Vaade "V_7"', 'Isik "Hiis"', '-', 'OK', v_7_isik, v_7_isik, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_7"', 'Isik "Hiis"', 'Ei leia teda', 'VIGA', v_7_isik*0, v_7_isik, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_7"', 'Isik "Hiis"', 'Ei kompileeru', 	'VIGA', v_7_isik*0, v_7_isik, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_8" kontroll, vaate kirjete arvu kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_8" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_8" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Järgnev kontroll on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS kirjet.
*/

create procedure view_V8()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_8'))
then 	insert Staatus values ('Vaade "V_8"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_8*0, v_8, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_8');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_8"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_8_veergude_arv*0, v_8_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_8"', 'Veergude arv', '-', 'OK', v_8_veergude_arv, v_8_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_8;
	if 		kirje_count > 2
	then 	insert Staatus values ('Vaade "V_8"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_8_kirjete_arv*0, v_8_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 2
	then 	insert Staatus values ('Vaade "V_8"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_8_kirjete_arv*0, v_8_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_8"', 'Kirjete arv', '-', 'OK', v_8_kirjete_arv, v_8_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_8"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_8_kirjete_arv*0, v_8_kirjete_arv, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_9" kontroll, vaate kirjete arvu kontroll ja kirje kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_9" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_9" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel kontrollitakse, kas on 1 veerg ja 1 kirje ning siis vaadatakse kas selle ühe kirje väärtus on ÜHEKSA.
*/

create procedure view_V9()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_9'))
then 	insert Staatus values ('Vaade "V_9"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_9*0, v_9, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_9');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_9"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_9_veergude_arv*0, v_9_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_9"', 'Veergude arv', '-', 'OK', v_9_veergude_arv, v_9_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_9;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_9"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_9_kirjete_arv*0, v_9_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count	< 1
	then 	insert Staatus values ('Vaade "V_9"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_9_kirjete_arv*0, v_9_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_9"', 'Kirjete arv', '-', 'OK', v_9_kirjete_arv, v_9_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_9"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_9_kirjete_arv*0, v_9_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje kontroll 
begin try
	if 			v_size != 1 and (select count(*) from V_9) = 1
    then 		insert Staatus values ('Vaade "V_9"', 'Arvo partiide arv valgetena', 'Oodati ainult ühte veergu ja ühte kirjet.', 'VIGA', v_9_arvo*0, v_9_arvo, '', vaated_1_12_jr)
    else
		if		(select * from V_9) = 9
		then	insert Staatus values ('Vaade "V_9"', 'Arvo partiide arv valgetena', '-', 'OK', v_9_arvo, v_9_arvo, '', vaated_1_12_jr)
		else	insert Staatus values ('Vaade "V_9"', 'Arvo partiide arv valgetena', 'Peab olema 9', 'VIGA', v_9_arvo*0, v_9_arvo, '', vaated_1_12_jr)
		endif;
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_9"', 'Arvo partiide arv valgetena', 'Ei kompileeru', 	'VIGA', v_9_arvo*0, v_9_arvo, '', vaated_1_12_jr)
end catch;
end;


/*
Vaate "V_10" kontroll, vaate kirjete arvu kontroll ja kirje kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_10" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_10" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS kirjet.
Seejärel luuakse Temp (id, arv) tabel. Laetakse vaatest V_10 andmed txt faili ning siis laetakse andmed äsja loodud tabelisse. 
Põhjus on selles, et tudengitele pole öeldud, mis on veergude nimed. Temp tabeli loomisel saan kasutada, misiganes veeru nimesid mul vaja on.
Seejärel kontrollitakse, kas id = 42 korral on arvuks KUUS.
*/

create procedure view_V10()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_10'))
then 	insert Staatus values ('Vaade "V_10"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_10*0, v_10, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_10');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_10"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_10_veergude_arv*0, v_10_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_10"', 'Veergude arv', '-', 'OK', v_10_veergude_arv, v_10_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_10;
	if 		kirje_count > 2
	then 	insert Staatus values ('Vaade "V_10"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_10_kirjete_arv*0, v_10_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 2
	then 	insert Staatus values ('Vaade "V_10"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_10_kirjete_arv*0, v_10_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_10"', 'Kirjete arv', '-', 'OK', v_10_kirjete_arv, v_10_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_10"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_10_kirjete_arv*0, v_10_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje kontroll
begin try
	create	table #Temp(id int, arv int); 
	unload	select * from V_10 to 'C:\\TEMP\\kodutöö7_check.txt' encoding 'UTF-8';
	load	table #Temp (id, arv) from 'C:\\TEMP\\kodutöö7_check.txt' defaults on;

	if		(select arv from #Temp where id = 42) = 6
	then	insert Staatus values ('Vaade "V_10"', 'Arvo partiide arv valgetena turniiril 42', '-', 'OK', v_10_arvo, v_10_arvo, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_10"', 'Arvo partiide arv valgetena turniiril 42', 'Peab olema 6', 'VIGA', v_10_arvo*0, v_10_arvo, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_10"', 'Arvo partiide arv valgetena turniiril 42', 'Ei kompileeru', 	'VIGA', v_10_arvo*0, v_10_arvo, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_11" kontroll, vaate kirjete arvu kontroll ja kirje kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_11" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_11" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT ÜKS kirje.
Seejärel kontrollitakse kas on ainult 1 veerg ja 1 kirje ning siis kas selle ühe kirje väärtus on "5.0".
*/

create procedure view_V11()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_11'))
then 	insert Staatus values ('Vaade "V_11"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_11*0, v_11, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_11');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 1                 
then 	insert Staatus values ('Vaade "V_11"', 'Veergude arv', 'On vale, peab olema 1, hetkel on ' || v_size, 'VIGA', v_11_veergude_arv*0, v_11_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_11"', 'Veergude arv', '-', 'OK', v_11_veergude_arv, v_11_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_11;
	if 		kirje_count > 1
	then 	insert Staatus values ('Vaade "V_11"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_11_kirjete_arv*0, v_11_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 1
	then 	insert Staatus values ('Vaade "V_11"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_11_kirjete_arv*0, v_11_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_11"', 'Kirjete arv', '-', 'OK', v_11_kirjete_arv, v_11_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_11"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_11_kirjete_arv*0, v_11_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje kontroll
begin try
	if 			v_size != 1 and (select count(*) from V_11) = 1
	then 		insert Staatus values ('Vaade "V_11"', 'Maria punktid mustana', 'Oodati ainult ühte veergu ja ühte kirjet.', 'VIGA', v_11_maria*0, v_11_maria, '', vaated_1_12_jr)
	else
		if		(select * from V_11) = 5.0
		then	insert Staatus values ('Vaade "V_11"', 'Maria punktid mustana', '-', 'OK', v_11_maria, v_11_maria, '', vaated_1_12_jr)
		else	insert Staatus values ('Vaade "V_11"', 'Maria punktid mustana', 'Peab olema 5.0 punkti', 'VIGA', v_11_maria*0, v_11_maria, '', vaated_1_12_jr)
		endif;
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_11"', 'Maria punktid mustana', 'Ei kompileeru', 	'VIGA', v_11_maria*0, v_11_maria, '', vaated_1_12_jr)
end catch;

end;


/*
Vaate "V_12" kontroll, vaate kirjete arvu kontroll ja kirje kontroll.
Sissetulevaid andmeid ei ole.

Protseduuri sisesed muutujad: v_table_id = "V_12" tabeli id; v_size = antud tabelis veergude arv;

Kõigepealt kontrollitakse, kas on olemas tabel "V_12" kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Selles vaates ei toimu veeru olemasolu kontrolli, sest pole konkreetselt öeldud, mis on veeru nimi.

Kõik järgnevad kontrollid on try/catch vahel, sest võib juhtuda, et mingil põhjusel vaadet ei ole võimalik vaadata.
Seejärel on kirjete arvu kontroll, kus vaadatakse kas selles tabelis on TÄPSELT KAKS kirjet.
Seejärel luuakse Temp (nimi, keskmine) tabel. Laetakse vaatest V_12 andmed txt faili ning siis laetakse andmed äsja loodud tabelisse. 
Põhjus on selles, et tudengitele pole öeldud, mis on veergude nimed. Temp tabeli loomisel saan kasutada, misiganes veeru nimesid mul vaja on.
Seejärel kontrollitakse, kas nimi = "Kolme klubi kohtumine" korral on keskmine arv 23.039 ja 23.041 vahel.
*/

create procedure view_V12()
begin
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('V_12'))
then 	insert Staatus values ('Vaade "V_12"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_12*0, v_12, '', vaated_1_12_jr);
return; 
endif;

set 	v_table_id = find_table_id('V_12');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 2                 
then 	insert Staatus values ('Vaade "V_12"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_12_veergude_arv*0, v_12_veergude_arv, '', vaated_1_12_jr)
else	insert Staatus values ('Tabel "V_12"', 'Veergude arv', '-', 'OK', v_12_veergude_arv, v_12_veergude_arv, '', vaated_1_12_jr)
endif;

// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from V_12;
	if 		kirje_count > 2
	then 	insert Staatus values ('Vaade "V_12"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_12_kirjete_arv*0, v_12_kirjete_arv, '', vaated_1_12_jr)
	elseif	kirje_count < 2
	then 	insert Staatus values ('Vaade "V_12"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, hetkel on ' || kirje_count, 'VIGA', v_12_kirjete_arv*0, v_12_kirjete_arv, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_12"', 'Kirjete arv', '-', 'OK', v_12_kirjete_arv, v_12_kirjete_arv, '', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_12"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_12_kirjete_arv*0, v_12_kirjete_arv, '', vaated_1_12_jr)
end catch;

// Kirje kontroll
begin try
	create	table #Temp(nimi varchar(100), keskmine float); 
	unload	select * from V_12 to 'C:\\TEMP\\kodutöö7_check.txt' encoding 'UTF-8';
	load	table #Temp (nimi, keskmine) from 'C:\\TEMP\\kodutöö7_check.txt' defaults on;

	if		(select keskmine from #Temp where nimi = 'Kolme klubi kohtumine') > 23.039 and (select keskmine from #Temp where nimi = 'Kolme klubi kohtumine') < 23.041
	then	insert Staatus values ('Vaade "V_12"', 'Punktide keskmine arv', '-', 'OK', v_12_punktid, v_12_punktid, '', vaated_1_12_jr)
	else	insert Staatus values ('Vaade "V_12"', 'Punktide keskmine arv', 'Peab olema 23.040000', 'VIGA', v_12_punktid*0, v_12_punktid, 'Kas vaates on ikka turniiri nimi? Või veerud on vales järjekorras.', vaated_1_12_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "V_12"', 'Punktide keskmine arv', 'Ei kompileeru', 	'VIGA', v_12_punktid*0, v_12_punktid, '', vaated_1_12_jr)
end catch;

end;



/* Funktsioonide ja protseduuride kontrollid*/

/* 
Funktsiooni "f_klubisuurus" kontroll, mis kontrollib funktsiooni olemasolu ja funktsiooni töötamist.
Kõik funktsiooni töötamise testid on try/catch vahel, sest funktsioonidega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.".
Selle funktsiooni sisestavateks andmeteks on klubi ID, seejärel funktsioon loeb kokku mitu liiget andtud ID-ga klubis.

Kõigepealt kontrollitakse, kas funktsioon "f_klubisuurus" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel kontrollitakse, kas klubis ID-ga 51 on olemas täpselt KOLM liiget.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create 	procedure function_klubisuurus()
begin

if 		not exists (select * from sysprocedure where proc_name = 'f_klubisuurus') 
then	insert Staatus values('Funktsioon "f_klubisuurus"', '-', 'Funktsiooni ei eksisteeri', 'VIGA', f_klubisuurus*0, f_klubisuurus, '', funktsioonid_jr);
return;
endif;

begin try
	if 		f_klubisuurus(51) = 3
	then	insert Staatus values ('Funktsioon "f_klubisuurus"', '-', '-', 'OK', f_klubisuurus, f_klubisuurus, '', funktsioonid_jr)
	else	insert Staatus values ('Funktsioon "f_klubisuurus"', '-', 'Funktsioon on vigane', 'VIGA', f_klubisuurus*0, f_klubisuurus, 'Kas on ikka count(*) tabelist isikud?', funktsioonid_jr)
	endif;
end try
begin catch
	insert Staatus values ('Funktsioon "f_klubisuurus"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.', 'VIGA', f_klubisuurus*0, f_klubisuurus, 'Kas on ikka count(*) tabelist isikud?', funktsioonid_jr);
end catch;
/* Klubide Id-d ja nende klubiliikmete arv: 51 = 3, 54 = 4, 55 = 3, 57 = 4, 58 = 5, 59 = 4 */
end;


/* 
Funktsiooni "f_nimi" kontroll, mis kontrollib funktsiooni olemasolu ja funktsiooni töötamist.
Kõik funktsiooni töötamise testid on try/catch vahel, sest funktsioonidega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.".
Selle funktsiooni sisestavateks andmeteks on 2 varchar(50) suurusega sõne.

Kõigepealt kontrollitakse, kas funktsioon "f_nimi" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Ühes kontrollis vaadatakse, kas funktsiooni töötab lühikeste sõnede parameetritega. "tere" ja "vanakere" tulemuseks on "vanakere, tere".
Siin kohal koma ja tühiku olemasolu on väga tähtis, sest teine kontroll vaatab antud funktsiooni maksimum väärtust ehk varchar(50) + 1 koma + 1 tühik + varchar(50) = returns varchar(102).
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create	procedure function_nimi()
begin

if 		not exists (select * from sysprocedure where proc_name = 'f_nimi') 
then	insert Staatus values('Funktsioon "f_nimi"', '-', 'Funktsiooni ei eksisteeri', 'VIGA', f_nimi*0, f_nimi, '', funktsioonid_jr);
return;
endif;

// Kahe lühema suurusega varchari kontroll
begin try
	if		f_nimi('tere', 'vanakere') = 'vanakere, tere'
	then 	insert Staatus values('Funktsioon "f_nimi"', 'Lühike varchar', '-', 'OK', f_nimi_lühike, f_nimi_lühike, '', funktsioonid_jr)
	else	insert Staatus values('Funktsioon "f_nimi"', 'Lühike varchar', 'Funktsioon on vigane', 'VIGA', f_nimi_lühike*0, f_nimi_lühike, 'Kas sa koma ja tühiku lisasid?', funktsioonid_jr)
	endif;
end try
begin catch
	insert Staatus values('Funktsioon "f_nimi"', 'Lühike varchar', 'Ei saanud kontrolli teostada! Kas varchar suurus on piisav?', 'VIGA', f_nimi_lühike*0, f_nimi_lühike, 'Kas sinu sisestatud andmeteks on ikka 2 varchar-i?', funktsioonid_jr);
end catch;

// Kahe max varchar suurusega kontroll
begin try
	if		f_nimi('Pika nime test on vajalik, sest selle funk max pea', 'b olema eesnimi pluss perenimi pluss koma ja tuhik') = 'b olema eesnimi pluss perenimi pluss koma ja tuhik, Pika nime test on vajalik, sest selle funk max pea'
	then 	insert Staatus values('Funktsioon "f_nimi"', 'Pikk varchar', '-', 'OK', f_nimi_pikk, f_nimi_pikk, '', funktsioonid_jr)
    else	insert Staatus values('Funktsioon "f_nimi"', 'Pikk varchar', 'Funktsioon on vigane', 'VIGA', f_nimi_pikk*0, f_nimi_pikk, '', funktsioonid_jr)
	endif;
end try
begin catch
	insert Staatus values('Funktsioon "f_nimi"', 'Pikk varchar', 'Ei saanud kontrolli teostada! Kas varchar suurus on piisav?', 'VIGA', f_nimi_pikk*0, f_nimi_pikk, 'Kas sa koma ja tühiku varchar-i suurust arvestasid?', funktsioonid_jr)
end catch; 
/* Funktsiooni muutujateks on 2 stringi suurusega 50, välja tuleb max 102 */
end;


/* 
Funktsiooni "f_mangija_koormus" kontroll, mis kontrollib funktsiooni olemasolu ja funktsiooni töötamist.
Kõik funktsiooni töötamise testid on try/catch vahel, sest funktsioonidega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.".
Selle funktsiooni sisestavateks andmeteks on isiku ID, seejärel funktsioon loeb kokku mitu mängu antud isikul oli nii mustana ja ka valgena.

Kõigepealt kontrollitakse, kas funktsioon "f_mangija_koormus" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel kontrollitakse kas isikul ID-ga 71 on 8 mängu.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create 	procedure function_mangija_koormus()
begin

if 		not exists (select * from sysprocedure where proc_name = 'f_mangija_koormus' or proc_name = 'f_mängija_koormus') 
then	insert Staatus values('Funktsioon "f_mangija_koormus"', '-', 'Funktsiooni ei eksisteeri', 'VIGA', f_mangija_koormus*0, f_mangija_koormus, '', funktsioonid_jr);
return;
endif;

begin try
	if		f_mangija_koormus(71) = 8
	then	insert Staatus values('Funktsioon "f_mangija_koormus"', '-', '-', 'OK', f_mangija_koormus, f_mangija_koormus, '', funktsioonid_jr)
	else	insert Staatus values('Funktsioon "f_mangija_koormus"', '-', 'Funktsioon on vigane', 'VIGA', f_mangija_koormus*0, f_mangija_koormus, 'Kas liidad nii mustana kui ka valgena mängud kokku?', funktsioonid_jr)
	endif;
end try
begin catch
	begin try
		if		f_mängija_koormus(71) = 8
		then	insert Staatus values('Funktsioon "f_mängija_koormus"', '-', '-', 'OK', f_mangija_koormus, f_mangija_koormus, '', funktsioonid_jr)
		else	insert Staatus values('Funktsioon "f_mängija_koormus"', '-', 'Funktsioon on vigane', 'VIGA', f_mangija_koormus*0, f_mangija_koormus, 'Kas liidad nii mustana kui ka valgena mängud kokku?', funktsioonid_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Funktsioon "f_mangija_koormus"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.', 'VIGA', f_mangija_koormus*0, f_mangija_koormus, 'Kas sa oma funktsiooni testisid?', funktsioonid_jr);
	end catch;
end catch;
/* funktsiooni muutuja on isikud tabeli ID */
end;


/* 
Funktsiooni "f_mangija_voite_turniiril" kontroll, mis kontrollib funktsiooni olemasolu ja funktsiooni töötamist.
Kõik funktsiooni töötamise testid on try/catch vahel, sest funktsioonidega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.".
Selle funktsiooni sisestavateks andmeteks on 2 integeri, isiku ID ja turniiri ID, seejärel funktsioon loeb kokku kui mitu võitu oli antud mängijal sellel turniiril.

Kõigepealt kontrollitakse, kas funktsioon "f_mangija_voite_turniiril" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel kontrollitakse kas mängijal isiku ID-ga 71 ja turniiril ID-ga 42 oli 2 võitu.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create	procedure function_mangija_voite_turniiril()
begin

if 		not exists (select * from sysprocedure where proc_name = 'f_mangija_voite_turniiril' or proc_name = 'f_mängija_võite_turniiril') 
then	insert Staatus values('Funktsioon "f_mangija_voite_turniiril"', '-', 'Funktsiooni ei eksisteeri', 'VIGA', f_mangija_voite_turniiril*0, f_mangija_voite_turniiril, '', funktsioonid_jr);
return;
endif;

begin try
	if		f_mangija_voite_turniiril(71, 42) = 2
	then	insert Staatus values('Funktsioon "f_mangija_voite_turniiril"', '-', '-', 'OK', f_mangija_voite_turniiril, f_mangija_voite_turniiril, '', funktsioonid_jr)
	else	insert Staatus values('Funktsioon "f_mangija_voite_turniiril"', '-', 'Kõiki võite ei ole arvestatud.', 'VIGA', f_mangija_voite_turniiril*0, f_mangija_voite_turniiril, 'Kas sa arvestasid mustana kui ka valgena võite?', funktsioonid_jr)
	endif;
end try
begin catch
	begin try
		if		f_mängija_võite_turniiril(71, 42) = 2
		then	insert Staatus values('Funktsioon "f_mängija_võite_turniiril"', '-', '-', 'OK', f_mangija_voite_turniiril, f_mangija_voite_turniiril, '', funktsioonid_jr)
		else	insert Staatus values('Funktsioon "f_mängija_võite_turniiril"', '-', 'Kõiki võite ei ole arvestatud.', 'VIGA', f_mangija_voite_turniiril*0, f_mangija_voite_turniiril, 'Kas sa arvestasid mustana kui ka valgena võite?', funktsioonid_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Funktsioon "f_mangija_voite_turniiril"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.', 'VIGA', f_mangija_voite_turniiril*0, f_mangija_voite_turniiril, 'Kas sa oma funktsiooni testisid kahe parameetriga?', funktsioonid_jr);
	end catch;
end catch;
/* funktsiooni muutujad on isik_id ja turniir_id*/
end;


/* 
Funktsiooni "f_mangija_punktid_turniiril" kontroll, mis kontrollib funktsiooni olemasolu ja funktsiooni töötamist.
Kõik funktsiooni töötamise testid on try/catch vahel, sest funktsioonidega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.".
Selle funktsiooni sisestavateks andmeteks on 2 integeri, isiku ID ja turniir ID, seejärel funktsioon loeb kokku kõik punktid ning korrutab/jagab selle summa 2.0/0.5-ga.

Kõigepealt kontrollitakse, kas funktsioon "f_mangija_punktid_turniiril" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel esimesene kontrollitakse mängijal isiku ID-ga 80 ja turniiril ID-ga 42 oli 1.0 punkti.
Teisena kontrollitakse mängijal isiku ID-ga 80 ja turniiril ID-ga 41 oli 2.5 punkti.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create 	procedure function_mangija_punktid_turniiril()
begin

if 		not exists (select * from sysprocedure where proc_name = 'f_mangija_punktid_turniiril' or proc_name = 'f_mängija_punktid_turniiril') 
then	insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', '-', 'Funktsiooni ei eksisteeri', 'VIGA', f_mangija_punktid_turniiril*0, f_mangija_punktid_turniiril, '', funktsioonid_jr);
return;
endif;

begin try
	if		f_mangija_punktid_turniiril(80, 42) = 1.0
	then	insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 42) =  punktid (1.0)', '-', 'OK', f_mangija_punktid_turniiril_täiskohaga, f_mangija_punktid_turniiril_täiskohaga, '', funktsioonid_jr)
	else	insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 42) =  punktid (1.0)', 'Punktid pole õigesti arvutatud.', 'VIGA', f_mangija_punktid_turniiril_täiskohaga*0, f_mangija_punktid_turniiril_täiskohaga, 'Kas sa tulemuse jagasid 2.0-ga või tagastasid double väärtuse?', funktsioonid_jr)
	endif;
end try
begin catch
	begin try
		if		f_mängija_punktid_turniiril(80, 42) = 1.0
		then	insert Staatus values('Funktsioon "f_mängija_punktid_turniiril"', 'f_mängija_punktid_turniiril(80, 42) =  punktid (1.0)', '-', 'OK', f_mangija_punktid_turniiril_täiskohaga, f_mangija_punktid_turniiril_täiskohaga, '', funktsioonid_jr)
		else	insert Staatus values('Funktsioon "f_mängija_punktid_turniiril"', 'f_mängija_punktid_turniiril(80, 42) =  punktid (1.0)', 'Punktid pole õigesti arvutatud.', 'VIGA', f_mangija_punktid_turniiril_täiskohaga*0, f_mangija_punktid_turniiril_täiskohaga, 'Kas sa tulemuse jagasid 2.0-ga või tagastasid double väärtuse?', funktsioonid_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 42) =  punktid (1.0)', 'Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.', 'VIGA', f_mangija_punktid_turniiril_täiskohaga*0, f_mangija_punktid_turniiril_täiskohaga, 'Kas sa oma funktsiooni testisid?', funktsioonid_jr);
	end catch;
end catch;

begin try
	if		f_mangija_punktid_turniiril(80, 41) = 2.5
	then	insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 41) = punktid (2.5)', '-', 'OK', f_mangija_punktid_turniiril_komakohaga, f_mangija_punktid_turniiril_komakohaga, '', funktsioonid_jr)
	else	insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 41) = punktid (2.5)', 'Punktid pole õigesti arvutatud.', 'VIGA', f_mangija_punktid_turniiril_komakohaga*0, f_mangija_punktid_turniiril_komakohaga, 'Kas sa tulemuse jagasid 2.0-ga või tagastasid double väärtuse?', funktsioonid_jr)
	endif;
end try
begin catch
	begin try
		if		f_mängija_punktid_turniiril(80, 41) = 2.5
		then	insert Staatus values('Funktsioon "f_mängija_punktid_turniiril"', 'f_mängija_punktid_turniiril(80, 41) = punktid (2.5)', '-', 'OK', f_mangija_punktid_turniiril_komakohaga, f_mangija_punktid_turniiril_komakohaga, '', funktsioonid_jr)
		else	insert Staatus values('Funktsioon "f_mängija_punktid_turniiril"', 'f_mängija_punktid_turniiril(80, 41) = punktid (2.5)', 'Punktid pole õigesti arvutatud.', 'VIGA', f_mangija_punktid_turniiril_komakohaga*0, f_mangija_punktid_turniiril_komakohaga, 'Kas sa tulemuse jagasid 2.0-ga või tagastasid double väärtuse?', funktsioonid_jr)
		endif;
	end try
	begin catch
		insert Staatus values('Funktsioon "f_mangija_punktid_turniiril"', 'f_mangija_punktid_turniiril(80, 41) = punktid (2.5)', 'Ei saanud kontrolli teostada! Palun kontrolli funktsiooni.', 'VIGA', f_mangija_punktid_turniiril_komakohaga*0, f_mangija_punktid_turniiril_komakohaga, 'Kas sa oma funktsiooni testisid?', funktsioonid_jr)
	end catch;
end catch;

end;


/* 
Protseduuri "sp_uus_isik" kontroll, mis kontrollib protseduuri olemasolu ja protseduuri töötamist.
Kõik protseduuri töötamise testid on try/catch vahel, sest protseduuridega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli protseduuri.".

Kõigepealt kontrollitakse, kas protseduur "sp_uus_isik" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Selle protseduuri sisestavateks andmeteks on eesnimi, perenimi, klubi id, isiku_id (variable), seejärel protseduur lisab uue isiku ja kontrollitakse, kas lisatud isik on olemas, 
Peale kontrolli isik kustutatakse tabelist.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create 	procedure procedure_uus_isik()
begin
declare nimi varchar(50);

if 		not exists (select * from sysprocedure where proc_name = 'sp_uus_isik') 
then	insert Staatus values('Protseduur "sp_uus_isik"', '-', 'Protseduuri ei eksisteeri', 'VIGA', sp_uus_isik*0, sp_uus_isik, '', protseduurid_jr);
return;
endif;

// Eesnimi, perenimi, klubi_id
begin try
	create or replace variable isiku_id int;
	call 	sp_uus_isik('Test_ees', 'Test_pere', 51, isiku_id);
	select 	eesnimi into nimi from isikud where eesnimi = 'Test_ees';
	if 		upper(nimi) = upper('Test_ees')
	then	insert Staatus values('Protseduur "sp_uus_isik"', '-', '-', 'OK', sp_uus_isik, sp_uus_isik, '', protseduurid_jr)
	else	insert Staatus values('Protseduur "sp_uus_isik"', '-', 'Protseduur on vigane', 'VIGA', sp_uus_isik*0, sp_uus_isik, '', protseduurid_jr)
	endif;
end try
begin catch
	insert Staatus values('Protseduur "sp_uus_isik"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli protseduuri.', 'VIGA', sp_uus_isik*0, sp_uus_isik, 'Kas käivitasid protseduuri nelja parameetriga?', protseduurid_jr)
end catch;

delete	from isikud where eesnimi = 'Test_ees';

end;


/* 
sp_infopump protseduuri kirjeldus:
Protseduur väljastab 2 veergu (RESULT võtmesõna kasutades): nimi ja arv/suurus ja need järjestatakse kolmanda veeru järgi, mida ei näidata ja lisaks igas grupis järjestatakse nime järgi. 
Gruppideks on turniirid, klubid, isikud.

Protseduuri "sp_infopump" kontroll, mis kontrollib protseduuri olemasolu ja protseduuri töötamist.
Kõik protseduuri töötamise testid on try/catch vahel, sest protseduuridega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli protseduuri.".
Sellel protseduuril pole sisestatavaid andmeid.

Protseduuri sisesed muutujad: select_õnnestus int - selle väärtuseks saab kas NULL või ÜKS, see näitab kas "select * from sp_infopump()" töötas või mitte.

Kõigepealt kontrollitakse, kas protseduur "sp_infopump" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.

Seejärel toimub kontrolli eelne ettevalmistus.
Kui select_õnnestus = 1, siis luuakse vaade sp_info_view kuhu pannakse select * from sp_infopump() tulemus. 
Seejärel kontrollitakse, kas selles vaates on 2 või 3 veergu. 
Kui on 2 veergu, siis luuakse tabel sp_info (id, nimi, arv) ja andmed loetakse sinna sisse.
Kui on 3 veergu, siis liiakse tabel sp_info (id, osa, nimi, arv) ja andmed loetakse sinna sisse.
See kontroll on selleks, et kui tudeng tegi 2 veeruga infopumba, aga ta ei kasutanud RESULT viisi, siis saab andmed õigesti loetud sp_info tabelisse
ja kui tudeng tegi 3 veeruga infopumba, et saaks järjestuse paika panna, siis saab luua natukene teistsuguse tabeli, 
sest põhimõtteliselt tudeng on töö ära teinud ja 10p kaotada sellepärast on nõme.
Juhul kui "select_õnnestus = 0", siis luuakse sp_info tabel ja lihtsalt laetakse andmed sinna, sest see eeldab, et tudeng tegi kõik õigesti ja kasutas RESULT-i

Seejärel selle protseduuriga tehakse 4 kontrolli.
1) Kas kirjete arv on 31 ehk klubide arv + turniiride arv + isikute arv.
2) Kas turniir nimega "Kolme klubi kohtumine" on õiges järjekorras ning kas selle suurus on 25.
3) Kas klubi "Valge Mask" on õiges järjekorras.
4) Kas isik "Mets, Arvo" on õiges järjekorras. 
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create	procedure procedure_infopump()
begin
declare select_õnnestus, tabel, kirje_count int;

if 		not exists (select * from sysprocedure where proc_name = 'sp_infopump') 
then	insert Staatus values('Protseduur "sp_infopump"', '-', 'Protseduuri ei eksisteeri', 'VIGA', sp_infopump*0, sp_infopump, '', protseduurid_jr);
return;
endif;

// Ettevalmistus töö ehk õige sp_info tabeli loomine
begin try
	select * from sp_infopump();
    set select_õnnestus = 1;
end try
begin catch
	set select_õnnestus = 0;
end catch;

if select_õnnestus = 1 then 
	if 	exists (select * from systable where table_name = 'sp_info_view') then drop view sp_info_view endif;
	create view sp_info_view as select * from sp_infopump(); 
    
	if 		(select count(column_name) from syscolumn where table_id = find_table_id('sp_info_view')) = 2 then
			if 		exists (select * from systable where table_name = 'sp_info') then drop table sp_info endif;
			create 	table sp_info (id int default autoincrement, nimi varchar(102), arv int);
			load 	table sp_info (nimi, arv) from 'C:\\TEMP\\info.txt' defaults on delimited by ',';
            
	elseif (select count(column_name) from syscolumn where table_id = find_table_id('sp_info_view')) = 3 then
			if 		exists (select * from systable where table_name = 'sp_info') then drop table sp_info endif;
			create 	table sp_info (id int default autoincrement, osa int, nimi varchar(102), arv int);
			load 	table sp_info (osa, nimi, arv) from 'C:\\TEMP\\info.txt' defaults on delimited by ',';
	endif;
    
else
	if 		exists (select * from systable where table_name = 'sp_info') then drop table sp_info endif;
	create 	table sp_info (id int default autoincrement, nimi varchar(102), arv int);
	begin try
		load 	table sp_info (nimi, arv) from 'C:\\TEMP\\info.txt' defaults on delimited by ',';
		set tabel = 1;
	end try
	begin catch
		insert 	Staatus values('Protseduur "sp_infopump"', '-', 'Ei kompileeru', 'VIGA', sp_infopump*0, sp_infopump, '', protseduurid_jr);
		set tabel = 0;
	end catch;
endif;
if 		tabel = 0 then return; endif;
// Kirjete arvu kontroll
begin try
	select count(*) into kirje_count from sp_info;
	if		kirje_count > 31
	then	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja.', 'VIGA', sp_infopump_kirjete_arv*0, sp_infopump_kirjete_arv, 'Klubid + turniirid + isikud?', protseduurid_jr)
	elseif	kirje_count < 31
	then	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja.', 'VIGA', sp_infopump_kirjete_arv*0, sp_infopump_kirjete_arv, 'Klubid + turniirid + isikud?', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', '-', 'OK', sp_infopump_kirjete_arv, sp_infopump_kirjete_arv, '', protseduurid_jr)
	endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', sp_infopump_kirjete_arv*0, sp_infopump_kirjete_arv, '', protseduurid_jr)
end catch;

// Turniiri "Kolme klubi kohtumine" järjekorra kontroll
begin try
if 		(select nimi from sp_info where id = 7) = 'Kolme klubi kohtumine'
then	insert 	Staatus values('Protseduur "sp_infopump"', 'Turniiri "Kolme klubi kohtumine" järjekord', '-', 'OK', sp_infopump_turniir_arv, sp_infopump_turniir_arv, '', protseduurid_jr)
else	insert 	Staatus values('Protseduur "sp_infopump"', 'Turniiri "Kolme klubi kohtumine" järjekord', 'Järjestus pole õige', 'VIGA', sp_infopump_turniir_arv*0, sp_infopump_turniir_arv, '', protseduurid_jr)
endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', sp_infopump_turniir_arv*0, sp_infopump_turniir_arv, '', protseduurid_jr)
end catch;

// Klubi "Valge Mask" jäjekorra kontroll
begin try
if		(select nimi from sp_info where id = 5) = 'Valge Mask'
then	insert 	Staatus values('Protseduur "sp_infopump"', 'Klubi "Valge mask" järjekord', '-', 'OK', sp_infopump_klubi_järjekord, sp_infopump_klubi_järjekord, '', protseduurid_jr)
else	insert 	Staatus values('Protseduur "sp_infopump"', 'Klubi "Valge mask" järjekord', 'Järjestus pole õige', 'VIGA', sp_infopump_klubi_järjekord*0, sp_infopump_klubi_järjekord, '', protseduurid_jr)
endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', sp_infopump_klubi_järjekord*0, sp_infopump_klubi_järjekord, '', protseduurid_jr)
end catch;

// Isiku "Mets, Arvo" järjekorra või nime kirjapildi kontroll
begin try
if		(select nimi from sp_info where id = 16) = 'Mets, Arvo'
then	insert 	Staatus values('Protseduur "sp_infopump"', 'Isiku "Mets, Arvo" järjekord', '-', 'OK', sp_infopump_isiku_järjekord, sp_infopump_isiku_järjekord, '', protseduurid_jr)
else	insert 	Staatus values('Protseduur "sp_infopump"', 'Isiku "Mets, Arvo" järjekord', 'Järjestus pole õige või nime kirjapilt', 'VIGA', sp_infopump_isiku_järjekord*0, sp_infopump_isiku_järjekord, '', protseduurid_jr)
endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_infopump"', 'Kirjete arv', 'Ei kompileeru', 'VIGA', sp_infopump_isiku_järjekord*0, sp_infopump_isiku_järjekord, '', protseduurid_jr)
end catch;

end;


/* 
Protseduuri "sp_top10" kontroll, mis kontrollib protseduuri olemasolu ja protseduuri töötamist.
Kõik protseduuri töötamise testid on try/catch vahel, sest protseduuridega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli protseduuri.".
Sellel protseduuril on sisestavaks andmeks turniiri ID.

Protseduur "sp_top10" väljastab 2 veergu: mangija ja punkte. 
Kõigepealt kontrollitakse, kas protseduur "sp_top10" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel luuakse Temp (id, mangija, punkte) tabel. Loetakse andmed turniiriga 41 sp_top10-st txt faili ja sealt Temp tabelisse.
Seejärel kontrollitakse, kas turniiril ID-ga 41 oli kõige suuremate punktidega mangija "Maasikas, Malle"
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create	procedure procedure_top10()
begin

if 		not exists (select * from sysprocedure where proc_name = 'sp_top10') 
then	insert Staatus values('Protseduur "sp_top10"', '-', 'Protseduuri ei eksisteeri', 'VIGA', sp_top10*0, sp_top10, '', protseduurid_jr);
return;
endif;

begin try
	create	table #Temp (id integer not null default autoincrement, mangija varchar(102), punkte numeric(5,1));
	unload 	select * from sp_top10(41) to 'C:\\TEMP\\kodutoo_check.txt' ENCODING 'UTF-8';
	load 	table #Temp (mangija, punkte) from 'C:\\TEMP\\kodutoo_check.txt' defaults on;

	if 		(select mangija from #Temp where id = 1) = 'Maasikas, Malle' 
	then  	insert 	Staatus values('Protseduur "sp_top10"', 'sp_top10(41), esimene koht = Maasikas, Malle', '-', 'OK', sp_top10, sp_top10, '', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_top10"', 'sp_top10(41), esimene koht = Maasikas, Malle', 'Kirjete või veergude järjestus on vale.', 'VIGA', sp_top10*0, sp_top10, 'Kas nime kirjapilt õige?', protseduurid_jr)
	endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_top10"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli protseduuri.', 'VIGA', sp_top10*0, sp_top10, '', protseduurid_jr)
end catch;
end;


/* 
Protseduuri "sp_voit_viik_kaotus" kontroll, mis kontrollib protseduuri olemasolu ja protseduuri töötamist.
Kõik protseduuri töötamise testid on try/catch vahel, sest protseduuridega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli protseduuri.".
Sellel protseduuril on sisestavaks andmeks turniiri ID.

Protseduur "sp_voit_viik_kaotus" väljastab 6 veergu: mängija id, eesnimi, perenimi, voite, viike, kaotusi.
Kõigepealt kontrollitakse, kas protseduur "sp_voit_viik_kaotus" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel kontrollitakse, kas turrniiril id-ga 41 on 11 kirjet.
Seejärel luuakse Temp (id, eesnimi, perenimi, võite, viike, kaotusi) tabel. Loetakse andmed turniiriga 41 sp_voit_viik_kaotus-st txt faili ja sealt Temp tabelisse.
Seejärel kontrollitakse, kas turniiril ID-ga 41 oli mängijal ID-ga 75, 6 võitu, 1 viik ja 0 kaotust.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create	procedure procedure_voit_viik_kaotus()
begin

if 		not exists (select * from sysprocedure where proc_name = 'sp_voit_viik_kaotus' or proc_name = 'sp_võit_viik_kaotus') 
then	insert Staatus values('Protseduur "sp_voit_viik_kaotus"', '-', 'Protseduuri ei eksisteeri', 'VIGA', sp_voit_viik_kaotus*0, sp_voit_viik_kaotus, '', protseduurid_jr);
return;
endif;

// Kirjete arvu kontroll
begin try
	if		(select count(*) from sp_voit_viik_kaotus(41)) > 11
	then	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Kirjete arv turniiril 41', 'Kirjeid on ROHKEM kui vaja.', 'VIGA', sp_voit_viik_kaotus_kirjete_arv*0, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
	elseif	(select count(*) from sp_voit_viik_kaotus(41)) < 11
	then	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Kirjete arv turniiril 41', 'Kirjeid on VÄHEM kui vaja.', 'VIGA', sp_voit_viik_kaotus_kirjete_arv*0, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Kirjete arv turniiril 41', '-', 'OK', sp_voit_viik_kaotus_kirjete_arv, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
	endif;
end try
begin catch
	begin try
		if		(select count(*) from sp_võit_viik_kaotus(41)) > 11
		then	insert 	Staatus values('Protseduur "sp_võit_viik_kaotus"', 'Kirjete arv turniiril 41', 'Kirjeid on ROHKEM kui vaja.', 'VIGA', sp_voit_viik_kaotus_kirjete_arv*0, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
		elseif	(select count(*) from sp_võit_viik_kaotus(41)) < 11
		then	insert 	Staatus values('Protseduur "sp_võit_viik_kaotus"', 'Kirjete arv turniiril 41', 'Kirjeid on VÄHEM kui vaja.', 'VIGA', sp_voit_viik_kaotus_kirjete_arv*0, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
		else	insert 	Staatus values('Protseduur "sp_võit_viik_kaotus"', 'Kirjete arv turniiril 41', '-', 'OK', sp_voit_viik_kaotus_kirjete_arv, sp_voit_viik_kaotus_kirjete_arv, '', protseduurid_jr)
		endif;
	end try
	begin catch
		insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', '-', 'Ei saanud kontrolli teostada! Palun kontrolli protseduuri.', 'VIGA', 
		sp_voit_viik_kaotus_kirjete_arv*0, sp_voit_viik_kaotus_kirjete_arv, 'Kas käivitasid protseduuri ühe parameetriga?', protseduurid_jr);
	end catch;
end catch;

begin try
	create	table #Temp (id integer, eesnimi varchar(50), perenimi varchar(50), võite int, viike int, kaotusi int);
	
	begin try
		unload 	select * from sp_voit_viik_kaotus(41) to 'C:\\TEMP\\kodutoo_check.txt' ENCODING 'UTF-8';
	end try
	begin catch
		unload 	select * from sp_võit_viik_kaotus(41) to 'C:\\TEMP\\kodutoo_check.txt' ENCODING 'UTF-8';
	end catch;
	
	load 	table #Temp from 'C:\\TEMP\\kodutoo_check.txt' defaults on;
    
	if		(select võite from #Temp where id = 75) = 4
    then	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Võitude arv, id 75, turniir 41', '-', 'OK', sp_voit_viik_kaotus_võidud, sp_voit_viik_kaotus_võidud, '', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Võitude arv, id 75, turniir 41', 'Tulemus on vale', 'VIGA', sp_voit_viik_kaotus_võidud*0, sp_voit_viik_kaotus_võidud, '', protseduurid_jr)
    endif;
    
	if		(select viike from #Temp where id = 75) = 1
    then	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Viikide arv, id 75, turniir 41', '-', 'OK', sp_voit_viik_kaotus_viigid, sp_voit_viik_kaotus_viigid, '', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Viikide arv, id 75, turniir 41', 'Tulemus on vale', 'VIGA', sp_voit_viik_kaotus_viigid*0, sp_voit_viik_kaotus_viigid, '', protseduurid_jr)
    endif;
    
	if		(select kaotusi from #Temp where id = 75) = 0
	then	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Kaotuste arv, id 75, turniir 41', '-', 'OK', sp_voit_viik_kaotus_kaotused, sp_voit_viik_kaotus_kaotused, '', protseduurid_jr)
	else	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Kaotuste arv, id 75, turniir 41', 'Tulemus on vale', 'VIGA', sp_voit_viik_kaotus_kaotused*0, sp_voit_viik_kaotus_kaotused, '', protseduurid_jr)
	endif;
end try
begin catch
	insert 	Staatus values('Protseduur "sp_voit_viik_kaotus"', 'Võitude/Viikide/Kaotuste arv, id 75', 'Ei saanud kontrolli teostada! Palun kontrolli protseduuri.', 'VIGA', sp_voit_viik_kaotus_kontrollid*0, sp_voit_viik_kaotus_kontrollid, 'Kas käivitasid protseduuri ühe parameetriga?', protseduurid_jr);
end catch;

end;


/* 
Protseduuri "sp_kustuta_klubi" kontroll, mis kontrollib protseduuri olemasolu ja protseduuri töötamist.
Kõik protseduuri töötamise testid on try/catch vahel, sest protseduuridega on võimalus, et tudeng sai ülesandest valesti aru ning parameetrid on valed või tekib mingi muu error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei saanud kontrolli teostada! Palun kontrolli protseduuri.".
Sellel protseduuril on sisestavaks andmeks turniiri ID.

Kõigepealt kontrollitakse, kas protseduur "sp_kustuta_klubi" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel lisatakse "Klubid" tabelisse uus klubi, siis kasutatakse sp_kustuta_klubi protseduuri, et kustutada äsja lisatud klubi.
Kui ei kustu ära, siis on protseduur vigane.

Peale kontrolli igaksjuhuks toimub Klubi ja klubi asukoha eraldi kustutamine.
*/
create	procedure procedure_kustuta_klubi()
begin

if 		not exists (select * from sysprocedure where proc_name = 'sp_kustuta_klubi') 
then	insert Staatus values('Protseduur "sp_kustuta_klubi"', '-', 'Protseduuri ei eksisteeri', 'VIGA', sp_kustuta_klubi*0, sp_kustuta_klubi, '', protseduurid_jr);
return;
endif;


begin try
	insert 	into klubid (nimi, asukoht) values ('Kiire Aju', 'Viljandi');
	call	sp_kustuta_klubi('Kiire Aju');
	if		not exists (select * from klubid where nimi = 'Kiire Aju')
	then	insert Staatus values('Protseduur "sp_kustuta_klubi"', 'Klubi kustutamine', '-', 'OK', sp_kustuta_klubi, sp_kustuta_klubi, '', protseduurid_jr)
	else	insert Staatus values('Protseduur "sp_kustuta_klubi"', 'Klubi kustutamine', 'Protseduur ei tööta', 'VIGA', sp_kustuta_klubi*0, sp_kustuta_klubi, '', protseduurid_jr)
	endif;
end try
begin catch
	insert Staatus values('Protseduur "sp_kustuta_klubi"', 'Klubi kustutamine', 'Ei kompileeru', 'VIGA', sp_kustuta_klubi*0, sp_kustuta_klubi, '', protseduurid_jr)
end catch;

begin try
	delete from klubid where nimi = 'Kiire Aju';
	delete from asulad where nimi = 'Viljandi';
end try
begin catch
end catch;

end;

/*
Indeksite "turniir_algus", "partii_must_indeks" ja "partii_valge_indeks" olemasolu kontroll.
Kuna "Partiid" tabelisse lisatakse 2 uut indeksit, siis kontroll loeb kokku, kas seal on 2 indeksit olemas.
Kuna "Turniirid" tabelisse lisatakse 1 uus indeks, siis kontroll loeb kokku, kas seal on 1 indeks olemas.
See protseduur lihtsalt vaatab kas need indeksid on olemas. Muud pole vaja.
Kontroll protseduuril pole sissetulevaid andmeid ega väljuvaid andmeid.
*/
create 	procedure muud_indexid()
begin

if 		(select count(*) from sysindex where creator = 1 and "unique" = 'N' and index_name != 'ix_algus' and table_id = find_table_id('Partiid')) = 2
then	insert Staatus values('Kodutöö 6 indeksid', 'Partii tabel', '-', 'OK', muud_indexid_partiid, muud_indexid_partiid, '', indeksid_jr)
else	insert Staatus values('Kodutöö 6 indeksid', 'Partii tabel', 'Indeksite arv pole õige. Peab olema 2. Hetkel on ' || 
		(select count(*) from sysindex where creator = 1 and "unique" = 'N' and index_name != 'ix_algus' and table_id = find_table_id('Partiid')), 
		'VIGA', muud_indexid_partiid*0, muud_indexid_partiid, 'Kas sa tegid valge ja musta indeksid eraldi?', indeksid_jr)
endif;

if		(select count(*) from sysindex where creator = 1 and "unique" = 'N' and table_id = find_table_id('Turniirid')) = 1
then	insert Staatus values('Kodutöö 6 indeksid', 'Turniirid tabel', '-', 'OK', muud_indexid_turniirid, muud_indexid_turniirid, '', indeksid_jr)
else	insert Staatus values('Kodutöö 6 indeksid', 'Turniirid tabel', 'Indeksite arv pole õige. Peab olema 1. Hetkel on ' || 
		(select count(*) from sysindex where creator = 1 and "unique" = 'N' and table_id = find_table_id('Turniirid')), 
		'VIGA', muud_indexid_turniirid*0, muud_indexid_turniirid, '', indeksid_jr)
endif;
end;


/* Triggerite kontrollid */

/* 
Trigeri "tg_lisa_klubi" kontroll, mis kontrollib trigeri olemasolu ja trigeri töötamist.
Kõik trigeri töötamise testid on try/catch vahel, sest trigeritega on võimalus, et tudeng sai ülesandest valesti aru ning tekib mõni error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei kompileeru".

Kõigepealt kontrollitakse, kas triger "tg_lisa_klubi" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel lisatakse "Klubid" tabelisse uus klubi, ('Kiire Aju', 'Viljandi'), siis vaadatakse, kas triger lisas asukoha "Viljandi" Asulad tabelisse.
Kui ei lisanud, siis veateade. Peale kontrolli kustutatakse klubi ja asula eraldi vastavatest tabelitest.

Seejärel lisatakse kaks klubi "Klubid" tabelisse: ('Kiire Aju', 'Viljandi') ja ('Kambja Kibe', 'Viljandi').
Kontrolli idee on kontrollida, kas triger lisab asula id klubid tabelis asula veergu.
 
Peale kontrolli toimub klubide ja klubi asukoha eraldi kustutamine.
*/
create procedure trigger_lisa_klubi()
begin
declare asula_id int;

if 		not exists (select * from systrigger where trigger_name = 'tg_lisa_klubi') 
then	insert Staatus values('Trigger "tg_lisa_klubi"', '-', 'Triggerit ei eksisteeri', 'VIGA', tg_lisa_klubi*0, tg_lisa_klubi, '', trigerid_jr);
return;
endif;

// Asukoha kontroll klubi lisamisel
begin try
	insert 	into klubid (nimi, asukoht) values ('Kiire Aju', 'Viljandi');
	if		exists (select * from asulad where nimi = 'Viljandi') and (select asula from klubid where nimi = 'Kiire Aju') = (select id from asulad where nimi = 'Viljandi')
	then	insert Staatus values('Trigger "tg_lisa_klubi"', 'Asula lisamine koos klubiga', '-', 'OK', tg_lisa_klubi_nimi, tg_lisa_klubi_nimi, '', trigerid_jr)
	else	insert Staatus values('Trigger "tg_lisa_klubi"', 'Asula lisamine koos klubiga', 'Kas Asulat ei lisatud või puudub viide asulale klubi tabelis', 'VIGA', tg_lisa_klubi_nimi*0, tg_lisa_klubi_nimi, '', trigerid_jr)
	endif;
end try
begin catch
	insert Staatus values('Trigger "tg_lisa_klubi"', 'Asula lisamine koos klubiga', 'Triger töötab valesti', 'VIGA', tg_lisa_klubi_nimi*0, tg_lisa_klubi_nimi, '', trigerid_jr);
end catch;

begin try
	delete from klubid where nimi = 'Kiire Aju';
	delete from asulad where nimi = 'Viljandi';
end try
begin catch
end catch;

// Asukoha id kontroll "Klubid" tabelis klubide lisamisel
begin try
	insert 	into klubid (nimi, asukoht) values ('Kiire Aju', 'Viljandi');
	insert 	into klubid (nimi, asukoht) values ('Kambja Kibe', 'Viljandi');
	select 	id into asula_id from asulad where nimi = 'Viljandi';
	
	if		(select asula from klubid where nimi = 'Kiire Aju') = asula_id and (select asula from klubid where nimi = 'Kambja Kibe') = asula_id
	then	insert Staatus values('Trigger "tg_lisa_klubi"', 'Kahe lisatud klubi asula id', '-', 'OK', tg_lisa_klubi_id, tg_lisa_klubi_id, '', trigerid_jr)
	else	insert Staatus values('Trigger "tg_lisa_klubi"', 'Kahe lisatud klubi asula id', 'Klubi(de)le ei lisatud asula id-d', 'VIGA', tg_lisa_klubi_id*0, tg_lisa_klubi_id, '', trigerid_jr)
	endif;
end try
begin catch
	insert Staatus values('Trigger "tg_lisa_klubi"', 'Kahe lisatud klubi asula id', 'Triger töötab valesti', 'VIGA', tg_lisa_klubi_id*0, tg_lisa_klubi_id, '', trigerid_jr);
end catch;

begin try
	delete from klubid where nimi = 'Kiire Aju';
	delete from klubid where nimi = 'Kambja Kibe';
	delete from asulad where nimi = 'Viljandi';
end try
begin catch
end catch;
end;


/* 
Trigeri "tg_kustuta_klubi" kontroll, mis kontrollib trigeri olemasolu ja trigeri töötamist.
Kõik trigeri töötamise testid on try/catch vahel, sest trigeritega on võimalus, et tudeng sai ülesandest valesti aru ning tekib mõni error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei kompileeru".

Kõigepealt kontrollitakse, kas triger "tg_kustuta_klubi" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel lisatakse "Klubid" tabelisse uus klubi, ('Kiire Aju', 'Viljandi'), siis vaadatakse, kas triger lisas asukoha "Viljandi" Asulad tabelisse, kui ei lisanud, siis lisatakse asukoht manuaalselt.
Seejärel lisatakse teine klubi ('Kambja Kibe', 'Viljandi').
Järgmisena kustutatakse ära üks lisatud klubidest. Kontrollitakse, kas asula "Viljandi" on alles. Kui ei ole alles, siis on veateade. Ei tohi olla, sest ühel klubil on asukoht veel kasutuses.
Järgmsiena kustutatakse ka teine klubi ära. Nüüd kontrollitakse, kas "Viljandi" kustutati ära või mitte. Kui ei kustutatud ära, siis on viga.
 
Peale kontrolli toimub klubide ja klubi asukoha eraldi kustutamine.
*/

create procedure trigger_kustuta_klubi()
begin

if 		not exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi') 
then	insert Staatus values('Trigger "tg_kustuta_klubi"', '-', 'Triggerit ei eksisteeri', 'VIGA', tg_kustuta_klubi*0, tg_kustuta_klubi, '', trigerid_jr);
return;
endif;

begin try
	insert 	into klubid (nimi, asukoht) values ('Kiire Aju', 'Viljandi');
    if 		not exists (select * from asulad where nimi = 'Viljandi') then insert asulad values('Viljandi') endif;
    insert 	into klubid (nimi, asukoht) values ('Kambja Kibe', 'Viljandi');
    
	delete	from klubid where nimi = 'Kiire Aju';
	if		exists (select * from asulad where nimi = 'Viljandi')
	then	insert Staatus values('Trigger "tg_kustuta_klubi"', 'Asula kustutamine, millel on 2 klubi', '-', 'OK', tg_kustuta_klubi_ei, tg_kustuta_klubi_ei, '', trigerid_jr)
	else	insert Staatus values('Trigger "tg_kustuta_klubi"', 'Asula kustutamine, millel on 2 klubi', 'Asula kustutati', 'VIGA', tg_kustuta_klubi_ei*0, tg_kustuta_klubi_ei, 'Triger on vigane', trigerid_jr)
	endif;
    
    delete	from klubid where nimi = 'Kambja Kibe';
    if		not exists (select * from asulad where nimi = 'Viljandi')
	then	insert Staatus values('Trigger "tg_kustuta_klubi"', 'Asula kustutamine, millel on 1 klubi', '-', 'OK', tg_kustuta_klubi_jah, tg_kustuta_klubi_jah, '', trigerid_jr)
	else	insert Staatus values('Trigger "tg_kustuta_klubi"', 'Asula kustutamine, millel on 1 klubi', 'Asulat ei kustutatud', 'VIGA', tg_kustuta_klubi_jah*0, tg_kustuta_klubi_jah, 'Triger on vigane', trigerid_jr)
	endif;
    
end try
begin catch
	insert Staatus values('Trigger "tg_kustuta_klubi"', 'Asula kustutamine koos klubiga', 'Triger töötab valesti', 'VIGA', tg_kustuta_klubi*0, tg_kustuta_klubi, '', trigerid_jr);
end catch;

begin try
	delete from klubid where nimi = 'Kiire Aju';
    delete	from klubid where nimi = 'Kambja Kibe';
	delete from asulad where nimi = 'Viljandi';
end try
begin catch
end catch;

end;


/* 
Trigeri "tg_kustuta_klubi_isikutega" kontroll, mis kontrollib trigeri olemasolu ja trigeri töötamist.
Kõik trigeri töötamise testid on try/catch vahel, sest trigeritega on võimalus, et tudeng sai ülesandest valesti aru ning tekib mõni error.
Kui catch osa aktiveerub siis tagasiside on see, et "Ei kompileeru".

Kõigepealt kontrollitakse, kas triger "tg_kustuta_klubi_isikutega" on olemas, puudumisel veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Seejärel lisatakse "Klubid" tabelisse uus klubi, ('SQL klubi', 'Tartu'), 
siis lisatakse uus isik, kelle klubi_id-ks on just äsja lisatud klubi ('Martti', 'Kakk', (select id from klubid where nimi = 'SQL klubi')).
Seejärel kustutatakse klubi. Kui ei õnnestu klubi kustutada, siis veateade. Peab kustuma, sest uuel isikul pole mitte ühtegi partiid.
Peale seda kustutakse igaksjuhuks uuesti lisatud isik ja klubi.
Eejärel proovitakse kustutada klubi "Laudnikud", ei tohiks õnnestuda, sest selle klubi liikmetel on partiid. Kui õnnestub, siis veateade.
*/

create procedure trigger_kustuta_klubi_isikutega()
begin

if 		not exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi_isikutega') 
then	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', '-', 'Triggerit ei eksisteeri', 'VIGA', tg_kustuta_klubi_isikutega*0, tg_kustuta_klubi_isikutega, '', trigerid_jr);
return;
endif;

// Klubi kustutamine koos isikuga, kellel pole partiisid
begin try
	insert 	into klubid (nimi, asukoht) values ('SQL klubi', 'Tartu');
	insert 	into isikud (eesnimi, perenimi, klubi) values ('Martti', 'Kakk', (select id from klubid where nimi = 'SQL klubi'));
	delete 	from klubid where nimi = 'SQL klubi';
	if 		not exists (select * from klubid where nimi = 'SQL klubi')
	then	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', 'Klubi kustutamine koos isikuga', '-', 'OK', tg_kustuta_klubi_isikutega_jah, tg_kustuta_klubi_isikutega_jah, '', trigerid_jr)
	else	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', 'Klubi kustutamine koos isikuga', 'Klubi ei kustutatud', 'VIGA', tg_kustuta_klubi_isikutega_jah*0, tg_kustuta_klubi_isikutega_jah, '', trigerid_jr)
	endif;
end try
begin catch
	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', 'Isiku kustutamine koos klubiga', 'Triger töötab valesti', 'VIGA', tg_kustuta_klubi_isikutega_jah*0, tg_kustuta_klubi_isikutega_jah, '', trigerid_jr)
end catch;

begin try
	delete from isikud where eesnimi = 'Martti Kakk';
    delete 	from klubid where nimi = 'SQL klubi';
end try
begin catch
end catch;

// Klubi kustutamise proovimine
begin try
	delete from klubid where nimi = 'Laudnikud';
	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', 'Klubi "Laudnikud" kustutamine', 'Puudub kustutamise keeluga välisvõti', 'VIGA', tg_kustuta_klubi_isikutega_ei*0, tg_kustuta_klubi_isikutega_ei, '', trigerid_jr);
end try
begin catch
	insert Staatus values('Trigger "tg_kustuta_klubi_isikutega"', 'Klubi "Laudnikud" kustutamine', 'Ei õnnestunud', 'OK', tg_kustuta_klubi_isikutega_ei, tg_kustuta_klubi_isikutega_ei, '', trigerid_jr);
end catch;

end;



/*
Protseduur käivita, mis siis käivitab vajaliku kodutöö kontrolli
Sisestatav muutuja on kodutöö nr, mis määrab ära siis, milliseid kodutöö osi hinnatakse
Kodutöid on 4.

Kodutöö 3 kontrollitavad osad on: tabelid - inimesed, isikud, klubid, turniirid, partiid ning muud elemendid.

Kodutöö 5 kontrollitavad osad on need, mis olid juba kolmandas kontrollitud ning juurde tulevad erinevad vaated:
edetabelid, klubipartiikogused, 1 ja 2, mängijad, vaade partiid, punktid, turniiripartiid ja kolmik.
5ndas kodutöös on 3 erinevat klubipartiikogused vaate kontrolli. Ilma numbrita on ainult "Sissejuhatus andmebaasidesse" aine korral, 1 ja 2 on "Andmebaasid" aine korral.

Kodutöö 6 kontrollitavad osad on funktsioonid - klubisuurus, nimi, mangija_koormus, mangija_voite_turniiril, mangija_punktid_turniiril
protseduurid - uus_isik, infopump, top10, voit_viik_kaotus ja indexid.

Kodutöö 7 kontrollitavad osad on tabel - asulad, vaated - asulaklubisid, asulasuurus ja V1-V12, protseduur - kustuta_klubi, trigerid - lisa_klub, kustuta_klubi ja kustuta_klubi_isikutega.
Peale 7nda kodutöö osade kontrolli tuleb ka kirje "Aeg" lisamine, mis lisab Staatus tabeli viimasesse ritta siis Tudengi eesnime, perenime ja millal see on lisatud "Inimesed" tabelisse.
See on selleks, et kontrollida, kas tudeng tegi oma andmebaasi ikka ise või mitte.

Järgmisena käivitub protseduur arvuta_punktid, mis arvutab välja kui palju tudeng punkte saab oma esitatud kodutöö eest. 

Selle protseduuris on ka väike kirjete arvu kontroll. Kui mõnes põhitabelis ei ole kirjeid, siis tuleb teade, et järgnevad probleemid võivad olla sellest, et tabelites pole andmeid. 
See teade tuleb ainult 5-7 kodutöö korral.
*/

create 	procedure käivita(kodutöö int)
begin
declare aja_muutuja date;
declare aeg datetime;
if		kodutöö >= 3 then
		call table_inimesed(kodutöö);
		call table_klubid(kodutöö);
		call table_turniirid(kodutöö);
		call table_isikud(kodutöö);
		call table_partiid(kodutöö);
		call muud_elemendid(kodutöö);
endif;
if 		kodutöö >= 5 then
		call view_edetabelid();
		call view_klubipartiikogused_1();
		call view_klubipartiikogused_2();
		call view_mangijad();
		call view_partiid();
		call view_punktid();
		call view_turniiripartiid();
		call view_kolmik();
endif;
if		kodutöö >= 6 then
		call function_klubisuurus();
		call function_nimi();
		call function_mangija_koormus();
		call function_mangija_voite_turniiril();
		call function_mangija_punktid_turniiril();
		call procedure_uus_isik();
		call procedure_top10();
		call procedure_voit_viik_kaotus();
		call muud_indexid();
endif;
if		kodutöö = 7 then
		call table_asulad();
		call trigger_lisa_klubi();
		call trigger_kustuta_klubi();
		call trigger_kustuta_klubi_isikutega();
endif;
if		kodutöö = 7 then
		call view_asulaklubisid();
		call view_asulasuurus();
		call procedure_kustuta_klubi();
		call view_V1();
		call view_V2();
		call view_V3();
		call view_V4();
		call view_V5();
		call view_V6();
		call view_V7();
		call view_V8();
		call view_V9();
		call view_V10();
		call view_V11();
		call view_V12();
endif;
if		kodutöö = 5 or kodutöö = 6 then
		begin try 
				if		((select count(*) from isikud) = 0 or (select count(*) from klubid) = 0 or (select count(*) from turniirid) = 0 or (select count(*) from partiid) = 0) then
						insert Staatus values('JÄRGNEVAD VEAD VÕIVAD ESINEDA', 'SEST ANDMEID POLE MÕNINGATES TABELITES', 'SEST TABELITES ON VEERUD VALESTI VÕI TRIGERID ON VIGASED', 'VIGA', 0, 0, '', teade_jr)
				endif; /*or (select count(*) from asulad) = 0*/
		end try
		begin catch
		end catch;
elseif	kodutöö = 7 then
		begin try 
				if		((select count(*) from isikud) = 0 or (select count(*) from klubid) = 0 or (select count(*) from turniirid) = 0 or (select count(*) from partiid) = 0 or (select count(*) from asulad) = 0) then
						insert Staatus values('JÄRGNEVAD VEAD VÕIVAD ESINEDA', 'SEST ANDMEID POLE MÕNINGATES TABELITES', 'SEST TABELITES ON VEERUD VALESTI VÕI TRIGERID ON VIGASED', 'VIGA', 0, 0, '', teade_jr)
				endif;
		end try
		begin catch
		end catch;
endif;

begin try
	select max(sisestatud) into aeg from inimesed;
	set aja_muutuja = aeg;
	begin try
		insert into Staatus values ('-', (select eesnimi from inimesed where sisestatud = aeg) || ', ' || (select perenimi from inimesed where sisestatud = aeg), aja_muutuja, 'Aeg', 0, 0, '', tudeng_jr);
	end try
	begin catch
	end catch;
end try
begin catch
end catch;

call arvuta_punktid(versioon);
end;

/* See option lülitab välja trigerite akitverimise kirjete kustutamise ja siestamise ajaks, sest 7ndas kodutöös on trigerid tihti valesti tehtud. */
set option continue_after_raiserror = 'off';

/* Protseduurid errori kirjutamsieks, need errori teated on õppejõule, et ta saaks teada, miks kirjeid ei sisestatud tabelitesse */
create procedure check_error(Tabel varchar(100), Veerg varchar(100))
begin
	if 		not exists (select * from syscolumn where upper(column_name) = upper(Veerg) and table_id = find_table_id(Tabel))
	then 	raiserror 17000 'Ei saa lisada andmeid tabelisse "' + Tabel + '"! Puudub veerg "'+ Veerg +'"!'
	endif;
end;

create procedure check_error_paar(Tabel varchar(100), Veerg_1 varchar(100), Veerg_2 varchar(100))
begin
	if 		not exists (select * from syscolumn where upper(column_name) = upper(Veerg_1) and table_id = find_table_id(Tabel))
	or		not exists (select * from syscolumn where upper(column_name) = upper(Veerg_2) and table_id = find_table_id(Tabel))
	then 	raiserror 17000 'Ei saa lisada andmeid tabelisse "' + Tabel + '"! Puudub veeru paar "'+ Veerg_1 +'"/"'+ Veerg_2 +'"!'
	endif;
end;

create procedure check_error_tapitaht(Tabel varchar(100), Veerg_1 varchar(100), Veerg_2 varchar(100))
begin
	if 		not exists (select * from syscolumn where upper(column_name) = upper(Veerg_1) and table_id = find_table_id(Tabel))
	and		not exists (select * from syscolumn where upper(column_name) = upper(Veerg_2) and table_id = find_table_id(Tabel))
	then 	raiserror 17000 'Ei saa lisada andmeid tabelisse "' + Tabel + '"! Puudub veerg "'+ Veerg_1 +'" või "'+ Veerg_2 +'"!'
	endif;
end;
/* 
Siit algab andmete sisselugemine. 
Kolmandas kodutöös kontrollitakse, kas tudeng sai sellega ise hakkama. Peale kolmandat, skript lisab ise andmed.
Kõigepealt kustutatakse kõik andmed tabelistest ja siis lisatakse uuesti.
Kõik delete "tabeli nimi" on try/catch sees, sest võib tekkida probleeme, kui tekib siis tuleb errori teade. 
Klubid tabelil on kaks kustutamise viisi, ühel proovitakse kõike korraga kustutada ja teine on see, et kustutatakse üks haaval.
*/
set option fire_triggers = 'off';

if 	versioon > 3 then
	begin try
		delete 	partiid;
	end try
	begin catch
		raiserror 17000 ('Ei saanud kustutada tabeli "Partiid" kirjeid!')
	end catch;
	
	begin try
		delete 	turniirid;
	end try
	begin catch
		raiserror 17000 ('Ei saanud kustutada tabeli "Turniirid" kirjeid!')
	end catch;
	
	begin try
		delete 	isikud;
	end try
	begin catch
		raiserror 17000 ('Ei saanud kustutada tabeli "Isikud" kirjeid!')
	end catch;
	
	begin try
		delete 	klubid;
	end try
	begin catch
		begin try
			delete klubid where id = 51 or nimi = 'Laudnikud';
			delete klubid where id = 54 or nimi = 'Ajurebend';
			delete klubid where id = 55 or nimi = 'Ruudu Liine';
			delete klubid where id = 57 or nimi = 'Võitmatu Valge ';
			delete klubid where id = 58 or nimi = 'Valge Mask';
			delete klubid where nimi = 'Valga Valge';
			delete klubid where id = 59 or nimi = 'Musta kivi kummardajad';
			
		end try
		begin catch
			if versioon = 7 then
				raiserror 17000 ('Ei saa kustutada tabeli "Klubid" kirjeid. Kontrollida trigerite definitsioone! Teha parandused vajadusel ja skript uuesti käivitada.')
			endif;
		end catch;
	end catch;
	
	
	/* Klubid tabeli andmete lisamine */
	begin try
		load 	table Klubid (id, nimi) from 'C:\\TEMP\\klubid.txt' FORMAT ASCII DELIMITED BY '\x09';
	end try
	begin catch
		//raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Klubid"!');
		if	(select count(*) from Klubid) = 0 then
			call 	check_error('Klubid','Id');
			call 	check_error('Klubid','Nimi');
		endif;
	end catch;
	
	/* Isikud tabeli andmete lisamine */
	begin try
		load 	table Isikud (id, eesnimi, perenimi, klubi) from 'C:\TEMP\isikud.txt' FORMAT ASCII DELIMITED BY '\x09' ;
	end try
	begin catch
		if	(select count(*) from Isikud) = 0 then
			call 	check_error('Isikud','Id');
			call 	check_error('Isikud','Eesnimi');
			call 	check_error('Isikud','Perenimi');
			call 	check_error('Isikud','Klubi');
			raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Isikud"!');
		endif;
	end catch;
	
	/* Turniirid tabeli andmete lisamine, veeru nimi/nimetus on erinev tudengitel */
	begin try
		load 	table Turniirid (id, nimi, Toimumiskoht, Alguskuupaev, Loppkuupaev) from 'C:\TEMP\turniirid.txt' FORMAT ASCII DELIMITED BY '\x09' ;
	end try
	begin catch
		begin try
			load 	table Turniirid (id, nimetus, Toimumiskoht, Alguskuupaev, Loppkuupaev) from 'C:\TEMP\turniirid.txt' FORMAT ASCII DELIMITED BY '\x09' ;
		end try
		begin catch
			begin try
				load 	table Turniirid (id, nimi, Toimumiskoht, Alguskuupäev, Lõppkuupäev) from 'C:\TEMP\turniirid.txt' FORMAT ASCII DELIMITED BY '\x09' ;
			end try
			begin catch
				begin try
					load 	table Turniirid (id, nimetus, Toimumiskoht, Alguskuupäev, Lõppkuupäev) from 'C:\TEMP\turniirid.txt' FORMAT ASCII DELIMITED BY '\x09' ;
				end try
				begin catch
					if	(select count(*) from Turniirid) = 0 then
						call 	check_error('Turniirid','Id');
						if 		not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'nimetus') then
								call 	check_error('Turniirid','Nimi');
						elseif	not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'nimi') then
								call 	check_error('Turniirid','Nimetus');
						endif;
						call 	check_error('Turniirid','Toimumiskoht');
						
						/* Ei oska seda hetkel lahendada
						if		not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'Alguskuupäev') and  
								not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'Lõppkuupäev')
						then		call 	check_error_paar('Turniirid','Alguskuupaev','Loppkuupaev');
						endif;
						
						if		not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'Alguskuupaev') and  
								not exists (select * from syscolumn where table_id = find_table_id('Turniirid') and column_name = 'Loppkuupaev')
						then		call 	check_error_paar('Turniirid','Alguskuupäev','Lõppkuupäev');
						endif;*/
						
						raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Turniirid"! Kontrollida Välisvõtmeid.');
					endif;
				end catch;
			end catch;
		end catch;
	end catch;
	
	/* Partiid tabeli andmete lisamine */
	begin try
		load 	table Partiid (Turniir, Algushetk, Lopphetk, Valge, Must, Valge_tulemus, Musta_tulemus) from 'C:\TEMP\partiid.txt' defaults on FORMAT ASCII DELIMITED BY  '\x09' ;
	end try
	begin catch
		begin try
			load 	table Partiid (Turniir, Algushetk, Lõpphetk, Valge, Must, Valge_tulemus, Musta_tulemus) from 'C:\TEMP\partiid.txt' defaults on FORMAT ASCII DELIMITED BY  '\x09' ;
		end try
		begin catch
			//raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Partiid"!');
			if	(select count(*) from Turniirid) = 0 then
				call 	check_error('Partiid','Turniir');
				call 	check_error_tapitaht('Partiid','Lopphetk','Lõpphetk');
				call 	check_error('Partiid','Valge');
				call 	check_error('Partiid','Must');
				call 	check_error('Partiid','Valge_tulemus');
				call 	check_error('Partiid','Musta_tulemus');
				raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Turniirid"! Välisvõtme tõttu ei saanud lisada.');
			endif;
		end catch;
	end catch;
	
	/* Asulad tabeli andmete lisamine */
	begin try
		if versioon = 7 then
		begin try
			delete asulad;
		end try
		begin catch
			raiserror 17000 ('Ei saanud kustutada kirjeid tabelis "Asulad". Kontrollida trigerite definitsioone! Teha vajadusel parandused ja skript uuesti käivitada.');
		end catch;
		
		load table Asulad (nimi) from 'C:\TEMP\asulad.txt' defaults on;
		update klubid set asukoht = 'Tartu';
		update klubid set asula = (select id from asulad where asulad.nimi = klubid.asukoht);
		update turniirid set asula = (select id from asulad where asulad.nimi = turniirid.Toimumiskoht);
		endif;
	end try
	begin catch
		raiserror 17000 ('Ei saanud lisada andmeid tabelisse "Asulad"!');
	end catch;
	
endif;
set option fire_triggers = 'on';

/*
Skripti alguses on muutuja, mis määrab ära, millist kodutööd kontrollitakse. 
Kui on kodutöö 6 või 7 ja aine = 'A', siis kontrollitakse kas on olemas protseduur sp_infopump ning siis käivitatakse see.
Seejärel saadud tulemus kirjutatakse info.txt faili OUTPUT abil.
Siin on tüüpiline error sest tihti tudengitel pole sp_infopump olemas ja siis OUTPUT annab errori et pole midagi kirjutada faili. Kui see tekib, siis vajuta continue.
*/

begin try
	if 		versioon >= 6 and exists (select * from sysprocedure where proc_name = 'sp_infopump') 
	then 	call sp_infopump() endif;
end try
begin catch
end catch;

output 	to 'c:\\temp\\info.txt' delimited by ',' format	text;


/*
Siis käivitatakse protseduur deleteS, mis kustutab kõik andmed Staatus tabelist selleks, et saaks skripti korduvalt käivitada ilma, et ei peaks iSQL igakord kinni panema.
Kui on kodutöö 6 või 7 ja aine = 'A', siis käivitatakse protseduuri "sp_infopump" kontroll.
Seejärel käivitatakse antud versiooniga protseduur "käivita", mis siis käivitab kõik vajalikud protseduurid teatud kodutöö kontrolliks.
*/
call 	deleteS();
if 		versioon >= 6 then call procedure_infopump() endif;
call 	käivita(versioon);




/* Staatus tabel andmete kogumiseks vajalikul kujul */
if exists (select * from systable where table_name = 'Vead') then drop table Vead endif; 
create table Vead
AS (id integer autoincrement,
select password_creation_time as AB_key, (eesnimi || ', ' || perenimi) as Nimi 
from sysuser, inimesed 
where user_name = 'DBA'
and inimesed.sisestatud = (select max(sisestatud) into aeg from inimesed)
)
select * from Vead;
output to 'C:\TEMP\Vead.sql' append format sql;


select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
output to 'C:\TEMP\Vead.sql' append format sql;

/* Nende andmete kogumine on vajalik Martti Kakk magistritöö andmete kogumiseks ja analüüsimiseks
Andmebaasi loomise kuupäev ja tudengi nimi */
if exists (select * from systable where table_name = 'AB') then drop table AB endif; 
create table AB 
AS (id integer autoincrement,
select password_creation_time as AB_key, (eesnimi || ', ' || perenimi) as Nimi 
from sysuser, inimesed 
where user_name = 'DBA'
and inimesed.sisestatud = (select max(sisestatud) into aeg from inimesed)
)
select * from AB;
output to 'C:\TEMP\AB.sql' append format sql;

/* See tabel seob tabeli Vead ja AB*/
if exists (select * from systable where table_name = 'Vead_AB') then drop table Vead_AB endif; 
create table Vead_AB 
AS (id integer autoincrement,
select password_creation_time_utc as Viga_ID, (eesnimi || ', ' || perenimi) as Nimi 
from sysuser, inimesed 
where user_name = 'DBA'
and inimesed.sisestatud = (select max(sisestatud) into aeg from inimesed)
)
select * from Vead_AB;
output to 'C:\TEMP\Vead_AB.sql' append format sql;

/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;
output to 'C:\TEMP\tulemus.txt' format text;