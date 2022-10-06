/* Tabeli ja vaadete olemasolu kontroll*/
select * from information_schema.tables where table_schema ='public'; 

/* Veeru olemasolu kontroll */
select * from information_schema.columns where table_schema = 'public';
-- klubid asukoht varchar pikkus 
select * from information_schema.columns where table_name = 'klubid' and character_maximum_length =70;


-- Moodle test: 
-- https://demovpl.dis.ulpgc.es/mod/vpl/forms/executionfiles.php?id=582
-- https://demovpl.dis.ulpgc.es/mod/vpl/views/checkjailservers.php?id=275

-- Problem? https://moodle.org/mod/forum/discuss.php?d=432700

/* Muutujate puudus on probleem
Lahendused:
* Muutujate tabel, kust saab queryda hindeid - kõik on csv-s, kust saab kõiki muuta/lisada
* iga testi sees on hinded - kõik on ühes skriptis, aga peab iga testi juures kontrollima. VB mõistlik, kuihidamine ei ole skaleeritud.
* Moodle variandis ei olegi üldse test skripti kasutuses, vaid on sql päringud.


*/