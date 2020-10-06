/* Muutuja mis määrab, milline kodutöö käivitatakse, 3=kodutöö 3, 5=kodutöö 5, 6=kodutöö 6 ja 7=kodutöö 7*/
create or replace variable versioon int = 7;
/* Muutuja, mis määrab, millist õppeainet kontrollitakse. "A" = Andmebaasid, "S" = Sissejuhatus andmebaasidesse */
create or replace variable aine varchar(5) = 'A';
/* Protseduuride kustutamine - kõigepealt otsib kas see funktsioon/protseduur on olemas ja kui on siis kustutab */
if exists (select * from sysprocedure where proc_name = 'check_column') 						then drop function check_column 						endif;
if exists (select * from sysprocedure where proc_name = 'check_column_t2pit2ht')				then drop function check_column_t2pit2ht 				endif;
if exists (select * from sysprocedure where proc_name = 'check_fk') 							then drop function check_fk 							endif;
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
if exists (select * from sysprocedure where proc_name = 'arvuta_punktid') 						then drop function arvuta_punktid		 				endif;
if exists (select * from sysprocedure where proc_name = 'käivita') 								then drop function käivita 								endif;
if exists (select * from sysprocedure where proc_name = 'check_error') 							then drop function check_error							endif;
if exists (select * from sysprocedure where proc_name = 'check_error_paar') 					then drop function check_error_paar						endif;
if exists (select * from sysprocedure where proc_name = 'check_error_tapitaht') 				then drop function check_error_tapitaht					endif;

if exists (select * from sysprocedure where proc_name = 'table_institutes') 					then drop function table_institutes						endif;
if exists (select * from sysprocedure where proc_name = 'table_persons') 						then drop function table_persons						endif;
if exists (select * from sysprocedure where proc_name = 'table_registrations') 					then drop function table_registrations					endif;
if exists (select * from sysprocedure where proc_name = 'table_lecturers') 						then drop function table_lecturers						endif;
if exists (select * from sysprocedure where proc_name = 'table_courses') 						then drop function table_courses						endif;
if exists (select * from sysprocedure where proc_name = 'view_persons_atleast_4eap') 			then drop function view_persons_atleast_4eap			endif;
if exists (select * from sysprocedure where proc_name = 'view_mostA') 							then drop function view_mostA							endif;
if exists (select * from sysprocedure where proc_name = 'view_andmebaasideTeooria') 			then drop function view_andmebaasideTeooria				endif;
if exists (select * from sysprocedure where proc_name = 'view_top40A') 							then drop function view_top40A							endif;
if exists (select * from sysprocedure where proc_name = 'view_top30Students') 					then drop function view_top30Students					endif;




/* Kodutööde max punktid */
create 	or replace variable kodutöö							numeric = 100;


/*Kodutöö 3 punktid kokku = 100p */
/* Tabelite punktide muutujad - Hindeskaala punktid, iga kodutöö osa on 100p */
/* https://github.com/nuubis/Automaattestid-andmebaaside-ainele/wiki/Kodut%C3%B6%C3%B6--3-punktid */
/* Tabel institutes punktid, kokku on 5p */
create or replace variable institutes_tabel 								numeric = 5.0;
create or replace variable institutes_veergude_arv 							numeric = 1.0;
create or replace variable institutes_id 									numeric = 0.5;
create or replace variable institutes_name 									numeric = 0.5;
create or replace variable institutes_address 								numeric = 0.5;
create or replace variable institutes_deanid 								numeric = 0.5;
create or replace variable institutes_vicedeanid 							numeric = 0.5;
create or replace variable institutes_unique_nimi 							numeric = 0.5;
create or replace variable institutes_kirjete_arv 							numeric = 1.0;
/* Tabel inimesed punktid, kokku on 5p */
create or replace variable persons_tabel 									numeric = 5.0;
create or replace variable persons_veergude_arv 							numeric = 1.0;
create or replace variable persons_id 										numeric = 0.5;
create or replace variable persons_firstname 								numeric = 0.5;
create or replace variable persons_lastname 								numeric = 0.5;
create or replace variable persons_instituteid 								numeric = 0.5;
create or replace variable persons_ssn 										numeric = 0.5;
create or replace variable persons_unique_nimi 								numeric = 0.5;
create or replace variable persons_kirjete_arv 								numeric = 1.0;
/* Tabel inimesed punktid, kokku on 5p */
create or replace variable registrations_tabel 								numeric = 4.0;
create or replace variable registrations_veergude_arv 						numeric = 1.0;
create or replace variable registrations_id 								numeric = 0.5;
create or replace variable registrations_courseid 							numeric = 0.5;
create or replace variable registrations_personid 							numeric = 0.5;
create or replace variable registrations_finalgrade 						numeric = 0.5;
create or replace variable registrations_kirjete_arv 						numeric = 1.0;
/* Välisvõtmete triggerid, kokku on 8p */
/*create or replace variable trigger_cascade 								numeric = 4.0;
create or replace variable trigger_delete 								numeric = 4.0;*/
/* Vaade edetabelid, kokku on 30p */
/*create or replace variable v_edetabelid 								numeric = 30.0;
create or replace variable v_edetabelid_veergude_arv 					numeric = 1.0;
create or replace variable v_edetabelid_mängija 						numeric = 1.0;
create or replace variable v_edetabelid_turniir 						numeric = 1.0;
create or replace variable v_edetabelid_punkte 							numeric = 1.0;
create or replace variable v_edetabelid_punkte_täiskohaga 				numeric = 4.0;
create or replace variable v_edetabelid_punkte_komakohaga 				numeric = 8.0;
create or replace variable v_edetabelid_kirjete_arv 					numeric = 14.0;*/


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
Jr - vigade järjekord, kui näidatakse lõpus tulemust
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

/* Abifunktsioon, et saada tabeli ID-st ja tabeli nimest tudengi andmebaasi veeru nimi, 
sissetulev muutujaks on tabeli id ja veeru nimi süsteemis ja tagastus on andmebaasis oleva veeru nimi */
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
create 	procedure arvuta_punktid()
begin
declare summa, max_summa, hindepunkt, max_hindepunkt numeric;
set 	summa = 0.0;

set		max_summa = kodutöö;

/* Hindepunktide välja arvutamine */
select sum(punktid) into summa from Staatus where Olek = 'OK' or Olek = 'VIGA';

set 	hindepunkt = (summa / max_summa);
set 	max_hindepunkt = 1.0;


//Punktide sisestamine 
insert into Staatus values ('-', '-', '-', 'Kokku', summa, max_summa, '', max_punktid_jr);
insert into Staatus values ('-', '-', '-', 'Hindepunktid', hindepunkt, max_hindepunkt, '', hindepunktid_jr);
end;


/* Tabelite kontrollid */
/*
Tabeli "Institutes" kontroll, kus on siis veergude kontroll ja check tingimuse kontroll ning tabeli kirjete arvu kontroll ehk kas andmed on õigesti sisestatud.
Sisestatud andmeteks on versiooni nr, mis tähenab siis seda, et mitmes kodutöö on, sest hilisemates kodutöödes tuleb veergusid või muid tingimusi juurde. 

Protseduuri sisesed muutujad: v_table_id = "Institutes" tabeli id; v_size = antud tabelis veergude arv; kirje_count = kirjete arv antud tabelis;

Kõigepealt kontrollitakse, kas on olemas tabel "Institutes", kui ei ole lisatakse veateade Staatus tabelisse ning protseduuri töö lõpetatakse.
Kui on korras, siis loetakse kokku mitu veergu on selles tabelis, kui ei ole õige arv siis veateade.
Seejärel tuleb tabeli veergude ja nende atribuutide kontroll check_column protseduuri abil, mille
andmeteks on: tabeli "Institutes" id, veeru nimi, veeru default tingimus, primary key tingimus, value tingimus, veeru suurus (ehk varchar(30)) 
ning siis punktide arv, mis saab selle veeru korras oleku eest.
Selles tabelis on ka täpitähtedega veerg võimalik, kus siis lisatakse check_column_t2pit2ht protseduuri nii täpitähteteta versioon kui ka täpitähtedega
Tabelis toimub ka check tingimuse kontroll, ehk kas selles tabeli on olemas check tingimus, mis kontrollib kas "sugu" veeru andmeteks on "m" või "n"
Kui on 7nda kodutöö kontroll, siis toimub ka kirjete arvu kontroll, kus vaadatakse, kas selles tabelis on vähemalt ÜKS kirje. */


//Tabeli Institutes kontroll
create  procedure table_institutes()
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('institutes')) 
then 	insert Staatus values ('Tabel "institutes"', '-', 'Tabelit ei eksisteeri.', 'VIGA', institutes_tabel*0, institutes_tabel,	'', tabelid_jr);
return;  
endif;

set 	v_table_id = find_table_id('institutes');

select count(column_name) into v_size from syscolumn where table_id = v_table_id;  

if      v_size != 5                 
then	insert Staatus values ('Tabel "Institutes"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', institutes_veergude_arv*0, institutes_veergude_arv, '', tabelid_jr) 
else	insert Staatus values ('Tabel "Institutes"', 'Veergude arv', '-', 'OK', institutes_veergude_arv, institutes_veergude_arv, '', tabelid_jr)
endif;
								
call 	check_column(v_table_id, 'Id',    'autoincrement',                'y', 'n', 4, institutes_id, tabelid_jr); 
call 	check_column(v_table_id, 'Name',   null,                'n', 'n', 50, institutes_name, tabelid_jr); 
call 	check_column(v_table_id, 'Address',       null,                'n', 'y', 30, institutes_address, tabelid_jr);
call 	check_column(v_table_id, 'DeanId',       null,                'n', 'y', 4, institutes_deanid, tabelid_jr);
call 	check_column(v_table_id, 'ViceDeanId',       null,                'n', 'y', 4, institutes_vicedeanid, tabelid_jr);


// Unique kitsenduse kontroll
call 	check_unique('Institutes', 'Name', institutes_unique_nimi, tabelid_jr);

// Kirjete arvu kontroll

select 	count(*) into kirje_count from Institutes;
if 		kirje_count >= 10 
then 	insert Staatus values ('Tabel "Institutes"', 'Kirjete arv', '-', 																'OK', 	institutes_kirjete_arv, 	institutes_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Institutes"', 'Kirjete arv', 'Kirjete arv peab olema vähemalt 1, hetkel on ' || kirje_count, 	'VIGA', institutes_kirjete_arv*0, institutes_kirjete_arv,	'', tabelid_jr)
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

//Tabeli Persons kontroll
create 	procedure table_persons()
begin 
declare v_table_id, v_size, kirje_count int;


if 		not exists (select * from systable where upper(table_name) = upper('persons')) 
then 	insert Staatus values ('Tabel "Persons"', '-', 'Tabelit ei eksisteeri.', 'VIGA', persons_tabel*0, persons_tabel, '', tabelid_jr);
return;
endif;

set 	v_table_id = find_table_id('persons');

select 	count(column_name) into v_size from syscolumn where table_id = v_table_id; 
if      v_size != 5                 
then	insert Staatus values ('Tabel "Persons"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', persons_veergude_arv*0, persons_veergude_arv, '', tabelid_jr) 
else	insert Staatus values ('Tabel "Persons"', 'Veergude arv', '-', 'OK', persons_veergude_arv, persons_veergude_arv, '', tabelid_jr)
endif;
/* select * from syscolumn where table_id = find_table_id('institutes') and column_name = 'vicedeanid'
 p_table_id integer,     p_column_name varchar(30), 
                                p_default varchar(30),  p_pkey char(1), 
                                p_nulls char(1),        p_width integer, 
								punktid numeric,		Jr integer */
								
call 	check_column(v_table_id, 'Id',       'autoincrement',    'y', 'n', 4, persons_id, tabelid_jr); 
call 	check_column(v_table_id, 'FirstName',     null,               'n', 'n', 30, persons_firstname, tabelid_jr); 
call 	check_column(v_table_id, 'LastName',     null,               'n', 'n', 30, persons_lastname, tabelid_jr);
call 	check_column(v_table_id, 'InstituteId',  null,            'n', 'n', 4, persons_instituteid, tabelid_jr);
call 	check_column(v_table_id, 'SSN',  		null,            'n', 'y', 11, persons_ssn, tabelid_jr);

// Unique kitsenduse kontroll
call 	check_unique('Persons', 'FirstName, LastName', persons_unique_nimi, tabelid_jr);


// Kirjete arvu kontroll
select 	count(*) into kirje_count from Persons;
if 		kirje_count = 300
then 	insert Staatus values ('Tabel "Persons"', 'Kirjete arv', '-', 												   	'OK',  	persons_kirjete_arv, 	persons_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Persons"', 'Kirjete arv', 'Kirjete arv peab olema 300, hetkel on ' || kirje_count, 	'VIGA', persons_kirjete_arv*0, 	persons_kirjete_arv,	'', tabelid_jr)
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

//Tabeli Registrations kontroll
create 	procedure table_registrations() 
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('registrations')) 
then 	insert Staatus values ('Tabel "Registrations"', '-', 'Tabelit ei eksisteeri.', 'VIGA', registrations_tabel*0, registrations_tabel, '', tabelid_jr);
return;
endif;

set 	v_table_id = find_table_id('registrations');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 4                 
then 	insert Staatus values ('Tabel "Registrations"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', registrations_veergude_arv*0, registrations_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Registrations"', 'Veergude arv', '-', 'OK', registrations_veergude_arv, registrations_veergude_arv, '', tabelid_jr)
endif;

call 	check_column(v_table_id, 'Id',          'autoincrement',    'y', 'n', 4, registrations_id, tabelid_jr); 
call 	check_column(v_table_id, 'CourseId',     null,               'n', 'n', 4, registrations_courseid, tabelid_jr); 
call 	check_column(v_table_id, 'PersonId',    null,               'n', 'n', 4, registrations_personid, tabelid_jr); 
call 	check_column(v_table_id, 'FinalGrade',   null,               'n', 'y', 1, registrations_finalgrade, tabelid_jr); 

// Kirjete arvu kontroll
select 	count(*) into kirje_count from registrations; // 1230 või 1198
if 		kirje_count = 1230
then 	insert Staatus values ('Tabel "Registrations"', 'Kirjete arv', '-', 														'OK', 	registrations_kirjete_arv, 	registrations_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Registrations"', 'Kirjete arv', 'Kirjete arv peab olema 23, hetkel on ' || kirje_count, 	'VIGA', registrations_kirjete_arv*0, 	registrations_kirjete_arv,	'', tabelid_jr)
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
create  procedure table_lecturers()
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
call 	check_column_t2pit2ht('Loppkuupaev', 'Lõppkuupäev', v_table_id, null, 'n', 'y', 4, turniirid_lõppkuupäev, tabelid_jr);
call 	check_column_t2pit2ht('Alguskuupaev', 'Alguskuupäev', v_table_id, null, 'n', 'n', 4, turniirid_alguskuupäev, tabelid_jr);

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
create  procedure table_courses() 
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
		then 	insert Staatus values ('Välisvõtme update tingimuse kogus', '-', '-',	'OK', trigger_cascade, trigger_cascade, '', välisvõtmed_tg_jr)
		else 	insert Staatus values ('Välisvõtme update tingimuse kogus', '-', 'Välisvõtme update tinigmuste arv on vale. Olemas on ' || trigger_count_C || ', peab olema 4.',  	'VIGA', trigger_cascade*0, trigger_cascade, '', välisvõtmed_tg_jr)
		endif
				
else	select 	count(*) into trigger_count_C		from systrigger
		where	event = 'C' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
		if 		trigger_count_C = 6				
		then 	insert Staatus values ('Välisvõtme update tingimuse kogus', '-', '-',	'OK', trigger_cascade, trigger_cascade, '', välisvõtmed_tg_jr)
		else 	insert Staatus values ('Välisvõtme update tingimuse kogus', '-', 'Välisvõtme update tinigmuste arv on vale. Olemas on ' || trigger_count_C || ', peab olema 6.',  	'VIGA', trigger_cascade*0, trigger_cascade, 
										'kui välisvõti on tehtud siis kontrollida kas on lisatud on update cascade', välisvõtmed_tg_jr)
		endif			
endif;

select 	count(*) into trigger_count_D		from systrigger
where	event = 'D' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
if 		(trigger_count_D = 1) or (trigger_count_D = 2 and exists (select * from systable where table_name = 'maint_name') or exists (select * from systable where table_name = 'maint_plan'))				
then 	insert Staatus values ('Välisvõtme delete tingimuse kogus', '-', '-',	'OK', trigger_delete, trigger_delete, '', välisvõtmed_tg_jr)
else 	insert Staatus values ('Välisvõtme delete tingimuse kogus', '-', 'Välisvõtme delete tingimuste arv on vale. Olemas on ' || trigger_count_D || ', peab olema 1.', 
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
create  procedure view_persons_atleast_4eap()
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
	insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, tuniir 41 punktid', 'Ei kompileeru', 'VIGA', 	v_edetabelid_punkte_komakohaga*0, 	v_edetabelid_punkte_komakohaga, 'Kas on "perenimi, eesnimi" või veeru nimi "mangija"?', vaated_jr)
end catch;

begin try
	if (select punkte from v_edetabelid where turniir = 42 and mangija = 'Kivine, Kalle') > 1.99 and (select punkte from v_edetabelid where turniir = 42 and mangija = 'Kivine, Kalle') < 2.01
	then insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', '-', 'OK', 	v_edetabelid_punkte_täiskohaga, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
	else insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, turniir 42 punktid', 'Punktide arv pole õige, peab olema 2.0', 'VIGA', 	v_edetabelid_punkte_täiskohaga*0, 	v_edetabelid_punkte_täiskohaga, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_edetabelid"', 'Kivine Kalle, tuniir 42 punktid', 'Ei kompileeru', 'VIGA', 	v_edetabelid_punkte_täiskohaga*0, 	v_edetabelid_punkte_täiskohaga, 'Kas on "perenimi, eesnimi" või veeru nimi "mangija"?', vaated_jr)
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

// Vaade v_mostA kontroll
create  procedure view_mostA()
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

// Vaade v_andmebaasideTeooria kontroll
create  procedure view_andmebaasideTeooria()
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

// Vaade v_top40A kontroll
create  procedure view_top40A()
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

// Vaate v_top30Students kontroll
create  procedure view_top30Students()
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_mangijad'))
then 	insert Staatus values ('Vaade "v_mangijad"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_mangijad*0, v_mangijad, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_mangijad');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 4                 
then 	insert Staatus values ('Vaade "v_mangijad"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', v_mangijad_veergude_arv*0, v_mangijad_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_mangijad"', 'Veergude arv', '-', 'OK', v_mangijad_veergude_arv, v_mangijad_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'Klubi_nimi', v_mangijad_klubi_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Klubi_id', v_mangijad_klubi_id, vaated_jr);
call	check_column_for_view(v_table_id, 'Isik_nimi', v_mangijad_isik_nimi, vaated_jr);
call	check_column_for_view(v_table_id, 'Isik_id', v_mangijad_isik_id, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_mangijad;
	if		kirje_count > 23
	then	insert Staatus values('Vaade "v_mangijad"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mangijad_kirjete_arv*0, 	v_mangijad_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 23
	then	insert Staatus values('Vaade "v_mangijad"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mangijad_kirjete_arv*0, 	v_mangijad_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_mangijad"', 'Kirjete arv', '-', 													'OK', 	v_mangijad_kirjete_arv, 	v_mangijad_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_mangijad"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_mangijad_kirjete_arv*0, v_mangijad_kirjete_arv, '', vaated_jr)
end catch;

// Isiku nime kirjapilt
begin try
	if 		(select isik_nimi from v_mangijad where isik_id = 71) = 'Mets, Arvo'
	then	insert Staatus values('Vaade "v_mangijad"', 'Isiku nimi', '-', 'OK', 	v_mangijad_isik_nimi_kuju, 	v_mangijad_isik_nimi_kuju, '', vaated_jr)
	else	insert Staatus values('Vaade "v_mangijad"', 'Isiku nimi', 'Isiku nime kirjapilt on vale.', 'VIGA', 	v_mangijad_isik_nimi_kuju*0, 	v_mangijad_isik_nimi_kuju, 'Kas on "perenimi, eesnimi"?', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_mangijad"', 'Isik_nimi', 'Ei kompileeru', 'VIGA', 	v_mangijad_isik_nimi_kuju*0, 	v_mangijad_isik_nimi_kuju, '', vaated_jr)
end catch;

end;


/*
Protseduur käivita, mis siis käivitab kodutöö kontrolli

Selle protseduuris on ka väike kirjete arvu kontroll. Kui mõnes põhitabelis ei ole kirjeid, siis tuleb teade, et järgnevad probleemid võivad olla sellest, et tabelites pole andmeid. 
See teade tuleb ainult 5-7 kodutöö korral.
*/

create 	procedure käivita()
begin
declare aja_muutuja date;
declare aeg datetime;


call table_institutes();
call table_persons();
call table_registrations();
/*call table_lecturers();
call table_courses();
call muud_elemendid();
call view_persons_atleast_4eap();
call view_mostA();
call view_andmebaasideTeooria();
call view_top40A();
call view_top30Students();*/


/*begin try
	if		kodutöö = 7 then
			select max(sisestatud) into aeg from inimesed;
			set aja_muutuja = aeg;
			begin try
				insert into Staatus values ('-', (select eesnimi from inimesed where sisestatud = aeg) || ', ' || (select perenimi from inimesed where sisestatud = aeg), aja_muutuja, 'Aeg', 0, 0, '', tudeng_jr);
			end try
			begin catch
			end catch;
	endif;
end try
begin catch
end catch;*/

call arvuta_punktid();
end;

/* See option lülitab välja trigerite akitverimise kirjete kustutamise ja siestamise ajaks, sest 7ndas kodutöös on trigerid tihti valesti tehtud. 
set option continue_after_raiserror = 'off';*/

/* Protseduurid errori kirjutamsieks, need errori teated on õppejõule, et ta saaks teada, miks kirjeid ei sisestatud tabelitesse 
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
end;*/




/*
Siis käivitatakse protseduur deleteS, mis kustutab kõik andmed Staatus tabelist selleks, et saaks skripti korduvalt käivitada ilma, et ei peaks iSQL igakord kinni panema.
Kui on kodutöö 6 või 7 ja aine = 'A', siis käivitatakse protseduuri "sp_infopump" kontroll.
Seejärel käivitatakse antud versiooniga protseduur "käivita", mis siis käivitab kõik vajalikud protseduurid teatud kodutöö kontrolliks.
*/
call 	deleteS();
call 	käivita();

/* Tulemuste väljastamine ekraanile ning kirjutamine txt ja csv failidesse */
select  Nimi, Veerg, Tagasiside, Olek, Punktid, Max_punktid, Soovitus from staatus where Olek = 'VIGA' or Olek = 'Kokku' or Olek = 'Hindepunktid' 
//order by Jr;
/*output to 'C:\TEMP\tulemus.csv' format excel;
output to 'C:\TEMP\tulemus.txt' format text;*/