 /* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'Tabel "Asulad"','-','Tabelit ei eksisteeri.','VIGA',0,000000,16,000000,''
'Tabel "Klubid"','Veergude arv','On vale, peab olema 4, hetkel on 3','VIGA',0,000000,0,500000,''
'Tabel "klubid"','Veergu "Asula" ei eksisteeri.','-','VIGA',0,000000,1,000000,''
'Tabel "Turniirid"','Veergude arv','On vale, peab olema 6, hetkel on 5','VIGA',0,000000,0,500000,''
'Tabel "turniirid"','Veergu "Asula" ei eksisteeri.','-','VIGA',0,000000,1,000000,''
'Välisvõti "Asulad" <-> "Klubid"','id <-> asula','Välisvõtit pole nende tabelite ja/või veergude vahel.','VIGA',0,000000,4,000000,''
'Välisvõti "Asulad" <-> "Turniirid"','id <-> asula','Välisvõtit pole nende tabelite ja/või veergude vahel.','VIGA',0,000000,4,000000,''
'Välisvõtme tingimus "ON DELETE CASCADE"','-','Ühe välisvõtme "ON DELETE CASCADE" tingimus on puudu.','VIGA',0,000000,2,000000,''
'Välisvõtme tingimus "ON UPDATE CASCADE"','-','Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on puudu.','VIGA',0,000000,2,000000,'kui välisvõti on tehtud siis kontrollida kas on lisatud on update cascade'
'Trigger "tg_lisa_klubi"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Trigger "tg_kustuta_klubi"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Trigger "tg_kustuta_klubi_isikutega"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Vaade "v_kolmik"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "v_edetabelid"','-','Vaadet ei eksisteeri.','VIGA',0,000000,7,500000,''
'Vaade "v_asulasuurus"','-','Vaadet ei eksisteeri.','VIGA',0,000000,6,000000,''
'Vaade "v_asulaklubisid"','-','Vaadet ei eksisteeri.','VIGA',0,000000,6,000000,''
'Vaade "v_turniiripartiid"','Kirjete arv','Kirjeid on VÄHEM kui vaja, praegu on 0','VIGA',0,000000,1,250000,''
'Vaade "v_klubipartiikogused_1"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,500000,''
'Funktsioon "f_nimi"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_klubisuurus"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_koormus"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_voite_turniiril"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_punktid_turniiril"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_top10"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_infopump"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_uus_isik"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_kustuta_klubi"','-','Protseduuri ei eksisteeri','VIGA',0,000000,7,000000,''
'Protseduur "sp_voit_viik_kaotus"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Kodutöö 6 indeksid','Partii tabel','Indeksite arv pole õige. Peab olema 2. Hetkel on 0','VIGA',0,000000,1,250000,'Kas sa tegid valge ja musta indeksid eraldi?'
'Kodutöö 6 indeksid','Turniirid tabel','Indeksite arv pole õige. Peab olema 1. Hetkel on 0','VIGA',0,000000,1,250000,''
'Vaade "V_1"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_2"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_3"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_4"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_5"','-','Vaadet ei eksisteeri.','VIGA',0,000000,3,000000,''
'Vaade "V_6"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_7"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_8"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_9"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_10"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_11"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_12"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'-','-','-','Kokku',38,750000,182,000000,''
'-','-','-','Hindepunktid',0,425824,2,000000,''
'-','Juku, Mets','2021-09-10','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'Tabel "Partiid"';'Veergude arv';'On vale, peab olema 9, hetkel on 11';'VIGA';0,000000;0,500000;''
'Tabel "Partiid" check';'Valge_tulemus + Musta_tulemus';'Tabelis ei ole check kitsendust';'VIGA';0,000000;0,500000;''
'Välisvõtme tingimus "ON UPDATE CASCADE"';'-';'Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on puudu.';'VIGA';0,000000;2,000000;''
'Test';'Test';'Temp on olemas';'VIGA';0,000000;0,000000;''
'Vaade "v_kolmik"';'Nimi';'Veergu ei eksisteeri.';'VIGA';0,000000;0,500000;''
'Vaade "v_kolmik"';'Punktid';'Veergu ei eksisteeri.';'VIGA';0,000000;0,500000;''
'Vaade "v_kolmik"';'Veergude arv';'On vale, peab olema 3, hetkel on 2';'VIGA';0,000000;1,000000;''
'Vaade "v_kolmik"';'Esimese koha punktid';'Esimese koha punktid peavad olema 4.5, praegu on ';'VIGA';0,000000;1,000000;''
'Vaade "v_kolmik"';'Punktide summa kokku';'Punktide summa peab olema 11.0, praegu on ';'VIGA';0,000000;3,000000;''
'Vaade "v_punktid"';'Punkt';'Veergu ei eksisteeri.';'VIGA';0,000000;1,000000;''
'Vaade "v_punktid"';'Veeru "punkt" punktide summa';'Punktide summa peab olema 108, praegu on 0';'VIGA';0,000000;1,000000;''
'Vaade "v_punktid"';'Veeru "punkt" punkti kontroll';'Ei kompileeru';'VIGA';0,000000;1,000000;''
'Vaade "v_punktid"';'Veeru "punkt" punkti kontroll';'Ei kompileeru';'VIGA';0,000000;1,000000;''
'Vaade "v_turniiripartiid"';'Kirjete arv';'Kirjeid on ROHKEM kui vaja, praegu on 216';'VIGA';0,000000;5,000000;''
'-';'-';'-';'Kokku';107,000000;132,000000;''
'-';'-';'-';'Hindepunktid';0,810606;1,000000;''
'-';'Annika, Kutti';'2021-09-24';'Aeg';0,000000;0,000000;''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'Tabel "Asulad"','-','Tabelit ei eksisteeri.','VIGA',0,000000,16,000000,''
'Tabel "Klubid"','Veergude arv','On vale, peab olema 4, hetkel on 3','VIGA',0,000000,0,500000,''
'Tabel "klubid"','Veergu "Asula" ei eksisteeri.','-','VIGA',0,000000,1,000000,''
'Tabel "Turniirid"','Veergude arv','On vale, peab olema 6, hetkel on 5','VIGA',0,000000,0,500000,''
'Tabel "turniirid"','Veergu "Asula" ei eksisteeri.','-','VIGA',0,000000,1,000000,''
'Välisvõti "Asulad" <-> "Klubid"','id <-> asula','Välisvõtit pole nende tabelite ja/või veergude vahel.','VIGA',0,000000,4,000000,''
'Välisvõti "Asulad" <-> "Turniirid"','id <-> asula','Välisvõtit pole nende tabelite ja/või veergude vahel.','VIGA',0,000000,4,000000,''
'Välisvõtme tingimus "ON DELETE CASCADE"','-','Ühe välisvõtme "ON DELETE CASCADE" tingimus on puudu.','VIGA',0,000000,2,000000,''
'Välisvõtme tingimus "ON UPDATE CASCADE"','-','Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on puudu.','VIGA',0,000000,2,000000,'kui välisvõti on tehtud siis kontrollida kas on lisatud on update cascade'
'Trigger "tg_lisa_klubi"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Trigger "tg_kustuta_klubi"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Trigger "tg_kustuta_klubi_isikutega"','-','Triggerit ei eksisteeri','VIGA',0,000000,10,000000,''
'Vaade "v_kolmik"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "v_edetabelid"','-','Vaadet ei eksisteeri.','VIGA',0,000000,7,500000,''
'Vaade "v_asulasuurus"','-','Vaadet ei eksisteeri.','VIGA',0,000000,6,000000,''
'Vaade "v_asulaklubisid"','-','Vaadet ei eksisteeri.','VIGA',0,000000,6,000000,''
'Vaade "v_turniiripartiid"','Kirjete arv','Kirjeid on VÄHEM kui vaja, praegu on 0','VIGA',0,000000,1,250000,''
'Vaade "v_klubipartiikogused_1"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,500000,''
'Funktsioon "f_nimi"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_klubisuurus"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_koormus"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_voite_turniiril"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Funktsioon "f_mangija_punktid_turniiril"','-','Funktsiooni ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_top10"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_infopump"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_uus_isik"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Protseduur "sp_kustuta_klubi"','-','Protseduuri ei eksisteeri','VIGA',0,000000,7,000000,''
'Protseduur "sp_voit_viik_kaotus"','-','Protseduuri ei eksisteeri','VIGA',0,000000,2,500000,''
'Kodutöö 6 indeksid','Partii tabel','Indeksite arv pole õige. Peab olema 2. Hetkel on 0','VIGA',0,000000,1,250000,'Kas sa tegid valge ja musta indeksid eraldi?'
'Kodutöö 6 indeksid','Turniirid tabel','Indeksite arv pole õige. Peab olema 1. Hetkel on 0','VIGA',0,000000,1,250000,''
'Vaade "V_1"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_2"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_3"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_4"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_5"','-','Vaadet ei eksisteeri.','VIGA',0,000000,3,000000,''
'Vaade "V_6"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_7"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_8"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_9"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_10"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_11"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'Vaade "V_12"','-','Vaadet ei eksisteeri.','VIGA',0,000000,2,000000,''
'-','-','-','Kokku',38,750000,182,000000,''
'-','-','-','Hindepunktid',0,425824,2,000000,''
'-','Juku, Mets','2021-09-10','Aeg',0,000000,0,000000,''
END
/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' or Olek = 'Aeg' 
order by Jr;
input format sql;
'-','-','-','Kokku',182,000000,182,000000,''
'-','-','-','Hindepunktid',2,000000,2,000000,''
'-','Martti, Kakk','2021-03-19','Aeg',0,000000,0,000000,''
END
