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
if exists (select * from sysprocedure where proc_name = 'find_column_id')						then drop function find_column_id 						endif;
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
create 	or replace variable kodutöö										numeric = 100;


/*Kodutöö punktid kokku = 100p */
/* Tabel institutes punktid, kokku on 5p */
create or replace variable institutes_tabel 							numeric = 5.0;
create or replace variable institutes_veergude_arv 						numeric = 1.0;
create or replace variable institutes_id 								numeric = 0.5;
create or replace variable institutes_name 								numeric = 0.5;
create or replace variable institutes_address 							numeric = 0.5;
create or replace variable institutes_deanid 							numeric = 0.5;
create or replace variable institutes_vicedeanid 						numeric = 0.5;
create or replace variable institutes_unique_nimi 						numeric = 0.5;
create or replace variable institutes_kirjete_arv 						numeric = 1.0;
/* Tabel persons punktid, kokku on 5p */
create or replace variable persons_tabel 								numeric = 5.0;
create or replace variable persons_veergude_arv 						numeric = 1.0;
create or replace variable persons_id 									numeric = 0.5;
create or replace variable persons_firstname 							numeric = 0.5;
create or replace variable persons_lastname 							numeric = 0.5;
create or replace variable persons_instituteid 							numeric = 0.5;
create or replace variable persons_ssn 									numeric = 0.5;
create or replace variable persons_unique_nimi 							numeric = 0.5;
create or replace variable persons_kirjete_arv 							numeric = 1.0;
/* Tabel registrations punktid, kokku on 5p */
create or replace variable registrations_tabel 							numeric = 4.0;
create or replace variable registrations_veergude_arv 					numeric = 1.0;
create or replace variable registrations_id 							numeric = 0.5;
create or replace variable registrations_courseid 						numeric = 0.5;
create or replace variable registrations_personid 						numeric = 0.5;
create or replace variable registrations_finalgrade 					numeric = 0.5;
create or replace variable registrations_kirjete_arv 					numeric = 1.0;
/* Tabel lecturers punktid, kokku on 5p */
create or replace variable lecturers_tabel 								numeric = 4.0;
create or replace variable lecturers_veergude_arv 						numeric = 1.0;
create or replace variable lecturers_id 								numeric = 0.5;
create or replace variable lecturers_courseid 							numeric = 0.5;
create or replace variable lecturers_personid 							numeric = 0.5;
create or replace variable lecturers_responsible 						numeric = 0.5;
create or replace variable lecturers_kirjete_arv 						numeric = 1.0;
/* Tabel courses punktid, kokku on 5p */
create or replace variable courses_tabel 								numeric = 5.0;
create or replace variable courses_veergude_arv 						numeric = 1.0;
create or replace variable courses_id 									numeric = 0.5;
create or replace variable courses_instituteid 							numeric = 0.5;
create or replace variable courses_name 								numeric = 0.5;
create or replace variable courses_code 								numeric = 0.5;
create or replace variable courses_eap 									numeric = 0.5;
create or replace variable courses_gradetype 							numeric = 0.5;
create or replace variable courses_kirjete_arv 							numeric = 1.0;
/* Välisvõtmete punktid */
create or replace variable välisvõti_registration_person				numeric = 3.0;
create or replace variable välisvõti_institute_person_dean				numeric = 3.0;
create or replace variable välisvõti_registration_course				numeric = 3.0;
create or replace variable välisvõti_lecturer_person					numeric = 3.0;
create or replace variable välisvõti_lecturer_course					numeric = 3.0;
create or replace variable välisvõti_course_institute					numeric = 3.0;
create or replace variable välisvõti_institute_person_vice_dean			numeric = 3.0;
create or replace variable välisvõti_person_institute					numeric = 3.0;
/* Välisvõtmed */
/* Välisvõtmete triggerid, kokku on 8p */
create or replace variable trigger_cascade 								numeric = 3.0;
create or replace variable trigger_delete_cascade 						numeric = 4.0;
create or replace variable trigger_delete_null 							numeric = 4.0;
/* Vaade persons_atleast_4eap, kokku on 4p */
create or replace variable v_persons_atleast_4eap 						numeric = 4.0;
create or replace variable v_persons_atleast_4eap_veergude_arv 			numeric = 1.0;
create or replace variable v_persons_atleast_4eap_firstname				numeric = 1.0;
create or replace variable v_persons_atleast_4eap_lastname				numeric = 1.0;
create or replace variable v_persons_atleast_4eap_kirjete_arv 			numeric = 1.0;
/* Vaated */
/* Vaade mostA, kokku on 6p */
create or replace variable v_mostA 										numeric = 9.0;
create or replace variable v_mostA_veergude_arv 						numeric = 1.0;
create or replace variable v_mostA_firstname							numeric = 1.0;
create or replace variable v_mostA_lastname								numeric = 1.0;
create or replace variable v_mostA_nrofa								numeric = 1.0;
create or replace variable v_mostA_kirje_max 							numeric = 2.0;
create or replace variable v_mostA_kirjete_arv 							numeric = 3.0;
/* Vaade andmebaasideTeooria, kokku on 6p */
create or replace variable v_andmebaasideTeooria 						numeric = 9.0;
create or replace variable v_andmebaasideTeooria_veergude_arv 			numeric = 1.0;
create or replace variable v_andmebaasideTeooria_personid				numeric = 1.0;
create or replace variable v_andmebaasideTeooria_firstname				numeric = 1.0;
create or replace variable v_andmebaasideTeooria_lastname				numeric = 1.0;
create or replace variable v_andmebaasideTeooria_kirjete_arv 			numeric = 4.0;
/* Vaade top40A, kokku on 6p */
create or replace variable v_top40A 									numeric = 9.0;
create or replace variable v_top40A_veergude_arv 						numeric = 1.0;
create or replace variable v_top40A_firstname							numeric = 1.0;
create or replace variable v_top40A_lastname							numeric = 1.0;
create or replace variable v_top40A_nrofa								numeric = 1.0;
create or replace variable v_top40A_kirje_max 							numeric = 2.0; 
create or replace variable v_top40A_kirje_min 							numeric = 2.0; 
create or replace variable v_top40A_kirjete_arv 						numeric = 2.0;
/* Vaade top30Students, kokku on 6p */
create or replace variable v_top30Students 								numeric = 9.0;
create or replace variable v_top30Students_veergude_arv 				numeric = 1.0;
create or replace variable v_top30Students_firstname					numeric = 1.0;
create or replace variable v_top30Students_lastname						numeric = 1.0;
create or replace variable v_top30Students_averagegrade					numeric = 2.0;
create or replace variable v_top30Students_min							numeric = 2.0; 
create or replace variable v_top30Students_max							numeric = 2.0; 
create or replace variable v_top30Students_kirjete_arv 					numeric = 2.0;

/* Tabelid kokku = 23p, 
Välisvõtmed kokku = 24p, 
triggerid kokku = 8p, 
vaated kokku = 45p?
Kokku = 100p*/


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

/* Abifunktsioon, et saada tabeli ID-st ja tabeli veeru nimest - tabeli veeru ID*/
create function find_column_id(a_table_id int, a_column_name varchar(100))
returns int
begin
declare c_id int;
select 	column_id into c_id from syscolumn
where 	table_id = a_table_id and upper(column_name) = upper(a_column_name);
return c_id;
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


create	procedure check_foreign_key(p_primary_table varchar(30), p_primary_column varchar(30),
									p_foreign_table varchar(30), p_foreign_column varchar(30),
									punktid numeric, Jr integer)
begin
declare primary_t_id, foreign_t_id, primary_c_id, foreign_c_id, f_key_id int;
declare count_f_key, count_fk int;

set primary_t_id = find_table_id(p_primary_table);
set primary_c_id = find_column_id(primary_t_id, p_primary_column);
set foreign_t_id = find_table_id(p_foreign_table);
set foreign_c_id = find_column_id(foreign_t_id, p_foreign_column);

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
declare kordaja int;

set 	summa = 0.0;
set		max_summa = kodutöö;
set 	kordaja = 4;

if 		aine = 'S' then set kordaja = 9 endif;

/* Hindepunktide välja arvutamine */
select sum(punktid) into summa from Staatus where Olek = 'OK' or Olek = 'VIGA';

set 	hindepunkt = (summa / max_summa) * kordaja;
set 	max_hindepunkt = 1.0 * kordaja;


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
else	insert Staatus values ('Tabel "Institutes"', 'Kirjete arv', 'Kirjete arv peab olema vähemalt 10, hetkel on ' || kirje_count, 	'VIGA', institutes_kirjete_arv*0, institutes_kirjete_arv,	'', tabelid_jr)
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
else	insert Staatus values ('Tabel "Registrations"', 'Kirjete arv', 'Kirjete arv peab olema 1230, hetkel on ' || kirje_count, 	'VIGA', registrations_kirjete_arv*0, 	registrations_kirjete_arv,	'', tabelid_jr)
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

//Tabeli Lecturers kontrollimine
create  procedure table_lecturers()
begin 
declare v_table_id, v_size, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('lecturers')) 
then 	insert Staatus values ('Tabel "Lecturers"', '-', 'Tabelit ei eksisteeri.', 'VIGA', lecturers_tabel*0, lecturers_tabel, '', tabelid_jr);
return;  
endif;

set 	v_table_id = find_table_id('lecturers');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if 	v_size != 4
then	insert Staatus values ('Tabel "Lecturers"', 'Veergude arv', 'On vale, peab olema 5, hetkel on ' || v_size, 'VIGA', lecturers_veergude_arv*0, lecturers_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Lecturers"', 'Veergude arv', '-', 'OK', lecturers_veergude_arv, lecturers_veergude_arv, '', tabelid_jr)
endif;
								
call 	check_column(v_table_id, 'Id',              'autoincrement',    'y', 'n', 4, lecturers_id, tabelid_jr);
call 	check_column(v_table_id, 'CourseId',            null,               'n', 'y', 4, lecturers_courseid, tabelid_jr);
call 	check_column(v_table_id, 'PersonId',    null,               'n', 'n', 4, lecturers_personid, tabelid_jr);
call 	check_column(v_table_id, 'Responsible',    null,               'n', 'y', 2, lecturers_responsible, tabelid_jr);


// Kirjete arvu kontroll
select 	count(*) into kirje_count from lecturers;
if 		kirje_count = 149
then 	insert Staatus values ('Tabel "Lecturers"', 'Kirjete arv', '-', 													'OK', 	lecturers_kirjete_arv, 		lecturers_kirjete_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Lecturers"', 'Kirjete arv', 'Kirjete arv peab olema 149, hetkel on ' || kirje_count, 	'VIGA', lecturers_kirjete_arv*0, 	lecturers_kirjete_arv, '', tabelid_jr)
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

//Tabeli Courses kontroll
create  procedure table_courses() 
begin 
declare v_table_id, v_size, kirje_count int; 

if 		not exists (select * from systable where upper(table_name) = upper('courses')) 
then 	insert Staatus values ('Tabel "Courses"', '-', 'Tabelit ei eksisteeri.', 'VIGA', courses_tabel*0, courses_tabel, '', tabelid_jr);
return; 
endif;

set 	v_table_id = find_table_id('courses');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 6                 
then 	insert Staatus values ('Tabel "Courses"', 'Veergude arv', 'On vale, peab olema 6, hetkel on ' || v_size, 'VIGA', courses_veergude_arv*0, courses_veergude_arv, '', tabelid_jr)
else	insert Staatus values ('Tabel "Courses"', 'Veergude arv', '-', 'OK', courses_veergude_arv, courses_veergude_arv, '', tabelid_jr)
endif;

/* select * from syscolumn where table_id = find_table_id('institutes') and column_name = 'vicedeanid'
 p_table_id integer,     p_column_name varchar(30), 
                                p_default varchar(30),  p_pkey char(1), 
                                p_nulls char(1),        p_width integer, 
								punktid numeric,		Jr integer */
call 	check_column(v_table_id, 'Id',            'autoincrement',       'y', 'n', 4, courses_id, tabelid_jr); 
call 	check_column(v_table_id, 'InstituteId',       null,                  'n', 'n', 4, courses_instituteid, tabelid_jr); 
call 	check_column(v_table_id, 'Name',     		null,   			'n', 'n', 50, courses_name, tabelid_jr); 
call 	check_column(v_table_id, 'Code',         	null,                  'n', 'y', 20, courses_code, tabelid_jr); 
call 	check_column(v_table_id, 'EAP',          	null,                  'n', 'y', 4, courses_eap, tabelid_jr); 
call 	check_column(v_table_id, 'GradeType', 	null,                  'n', 'y', 8, courses_gradetype, tabelid_jr); 


// Kirjete arvu kontroll
select 	count(*) into kirje_count from courses; //100 või 101 või 102
if 		kirje_count = 102
then 	insert Staatus values ('Tabel "Courses"', 'Kirjete arv', '-',														'OK', 	courses_kirjete_arv, 	courses_kirjete_arv,	'', tabelid_jr)
else	insert Staatus values ('Tabel "Courses"', 'Kirjete arv', 'Kirjete arv peab olema 102, hetkel on ' || kirje_count, 	'VIGA', courses_kirjete_arv*0, 	courses_kirjete_arv,	'', tabelid_jr)
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
create  procedure muud_elemendid()
begin
declare trigger_count_C, trigger_count_DC, trigger_count_DN int;

/* p_primary_table varchar(30), p_primary_column varchar(30), p_foreign_table varchar(30), p_foreign_column varchar(30), punktid numeric, Jr integer) */
// Välisvõtmete kontroll
call	check_foreign_key('Persons', 'Id', 'Registrations', 'PersonId',	välisvõti_registration_person, 		välisvõtmed_jr);
call  	check_foreign_key('Persons', 'Id', 'Institutes', 'DeanId', välisvõti_institute_person_dean, 		välisvõtmed_jr);
call	check_foreign_key('Courses', 'Id', 'Registrations', 'CourseId',	 välisvõti_registration_course, 		välisvõtmed_jr);
call	check_foreign_key('Persons', 'Id', 'Lecturers', 'PersonId',	välisvõti_lecturer_person, 			välisvõtmed_jr);
call	check_foreign_key('Courses', 'Id', 'Lecturers', 'CourseId',		 välisvõti_lecturer_course, 			välisvõtmed_jr);
call	check_foreign_key('Institutes', 'Id', 'Courses', 'InstituteId', 	 välisvõti_course_institute, 			välisvõtmed_jr);
call	check_foreign_key('Persons', 'Id',  'Institutes', 'ViceDeanId', 		 välisvõti_institute_person_vice_dean, välisvõtmed_jr);
call	check_foreign_key('Institutes', 'Id', 'Persons', 'InstituteId', 	 välisvõti_person_institute, 			välisvõtmed_jr);



// Süsteemsete triggerite kontroll välisvõtmete juures
		
select 	count(*) into trigger_count_C		from systrigger
where	event = 'C' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
if 		trigger_count_C = 8				
then 	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', '-',	'OK', trigger_cascade, trigger_cascade, '', välisvõtmed_tg_jr)
elseif trigger_count_C > 8	
then	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on ÜLE.',  	
								'VIGA', trigger_cascade*0, trigger_cascade, '', välisvõtmed_tg_jr)
else	insert Staatus values ('Välisvõtme tingimus "ON UPDATE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON UPDATE CASCADE" tingimus on PUUDU.',  	
								'VIGA', trigger_cascade*0, trigger_cascade, '', välisvõtmed_tg_jr)								
endif;

/* Kahe järgneva delete triggerite kontrollide vahe on see, et ühe tingimus kustutamisel on CASCADE ja teisel on NULL*/
select 	count(*) into trigger_count_DC		from systrigger
where	event = 'D' and trigger_time = 'A' 	and referential_action = 'C' and trigger_name is null;
if 		(trigger_count_DC = 5) or (trigger_count_DC = 6 and exists (select * from systable where table_name = 'maint_name') or exists (select * from systable where table_name = 'maint_plan'))				
then 	insert Staatus values ('Välisvõtme tingimus "ON DELETE CASCADE"', '-', '-',	'OK', trigger_delete_cascade, trigger_delete_cascade, '', välisvõtmed_tg_jr)
elseif trigger_count_DC > 5	
then	insert Staatus values ('Välisvõtme tingimus "ON DELETE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON DELETE CASCADE" tingimus on ÜLE.', 
								'VIGA', trigger_delete_cascade*0, trigger_delete_cascade, '', välisvõtmed_tg_jr)
else	insert Staatus values ('Välisvõtme tingimus "ON DELETE CASCADE"', '-', 'Vähemalt ühe välisvõtme "ON DELETE CASCADE" tingimus on PUUDU.', 
								'VIGA', trigger_delete_cascade*0, trigger_delete_cascade, '', välisvõtmed_tg_jr)
endif;

select 	count(*) into trigger_count_DN		from systrigger
where	event = 'D' and trigger_time = 'A' 	and referential_action = 'N' and trigger_name is null;
if 		(trigger_count_DN = 3) or (trigger_count_DN = 4 and exists (select * from systable where table_name = 'maint_name') or exists (select * from systable where table_name = 'maint_plan'))				
then 	insert Staatus values ('Välisvõtme tingimus "ON DELETE SET NULL"', '-', '-',	'OK', trigger_delete_null, trigger_delete_null, '', välisvõtmed_tg_jr)
elseif trigger_count_DN > 3
then	insert Staatus values ('Välisvõtme tingimus "ON DELETE SET NULL"', '-', 'Vähemalt ühe välisvõtme "ON DELETE SET NULL" tingimus on ÜLE.', 
								'VIGA', trigger_delete_null*0, trigger_delete_null, '', välisvõtmed_tg_jr)
else 	insert Staatus values ('Välisvõtme tingimus "ON DELETE SET NULL"', '-', 'Vähemalt ühe välisvõtme "ON DELETE SET NULL" tingimus on PUUDU.', 
								'VIGA', trigger_delete_null*0, trigger_delete_null, '', välisvõtmed_tg_jr)
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
// Vaate v_persons_atleast_4eap kontroll
create  procedure view_persons_atleast_4eap()
begin 
declare v_table_id, v_size, kirje_count int;
       
if 		not exists (select * from systable where upper(table_name) = upper('v_persons_atleast_4eap')) 
then 	insert Staatus values ('Vaade "v_persons_atleast_4eap"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_persons_atleast_4eap*0, v_persons_atleast_4eap, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_persons_atleast_4eap');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 2 
then 	insert Staatus values ('Vaade "v_persons_atleast_4eap"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_persons_atleast_4eap_veergude_arv*0, v_persons_atleast_4eap_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_persons_atleast_4eap"', 'Veergude arv', '-', 'OK', v_persons_atleast_4eap_veergude_arv, v_persons_atleast_4eap_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'FirstName', v_persons_atleast_4eap_firstname, vaated_jr);
call	check_column_for_view(v_table_id, 'LastName', v_persons_atleast_4eap_lastname, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_persons_atleast_4eap;
	if		kirje_count > 17
	then	insert Staatus values('Vaade "v_persons_atleast_4eap"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_persons_atleast_4eap_kirjete_arv*0, v_persons_atleast_4eap_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 17
	then	insert Staatus values('Vaade "v_persons_atleast_4eap"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_persons_atleast_4eap_kirjete_arv*0, v_persons_atleast_4eap_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_persons_atleast_4eap"', 'Kirjete arv', '-', 														'OK', 	v_persons_atleast_4eap_kirjete_arv, 	v_persons_atleast_4eap_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_persons_atleast_4eap"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_persons_atleast_4eap_kirjete_arv*0, v_persons_atleast_4eap_kirjete_arv, '', vaated_jr)
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
declare v_table_id, v_size, kirje_max, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_mostA')) 
then 	insert Staatus values ('Vaade "v_mostA"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_mostA*0, v_mostA, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_mostA');

select count(column_name) into v_size from syscolumn  where table_id = v_table_id;

if      v_size != 3 
then 	insert Staatus values ('Vaade "v_mostA"', 'Veergude arv', 'On vale, peab olema 3, hetkel on ' || v_size, 'VIGA', v_mostA_veergude_arv*0, v_mostA_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_mostA"', 'Veergude arv', '-', 'OK', v_mostA_veergude_arv, v_mostA_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'FirstName', v_mostA_firstname, vaated_jr);
call	check_column_for_view(v_table_id, 'LastName', v_mostA_lastname, vaated_jr);
call	check_column_for_view(v_table_id, 'NrOfA', v_mostA_nrofa, vaated_jr);

// Veeru NrOfA maksimumi kontroll
begin try
	select 	max(NrOfA) into kirje_max from v_mostA;
	if		kirje_max > 2
	then	insert Staatus values('Vaade "v_mostA"', 'Veeru NrOfA maksimum', 'Maksimum on SUUREM kui vaja, praegu on ' || kirje_max, 	'VIGA', v_mostA_kirje_max*0, v_mostA_kirje_max, '', vaated_jr)
	else	insert Staatus values('Vaade "v_mostA"', 'Veeru NrOfA maksimum', '-', 														'OK', 	v_mostA_kirje_max, 	v_mostA_kirje_max, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_mostA"', 'Kirje A maksimum', 'Ei kompileeru', 	'VIGA', v_mostA_kirje_max*0, v_mostA_kirje_max, '', vaated_jr)
end catch;

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_mostA;
	if		kirje_count > 16
	then	insert Staatus values('Vaade "v_mostA"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mostA_kirjete_arv*0, v_mostA_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 16
	then	insert Staatus values('Vaade "v_mostA"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_mostA_kirjete_arv*0, v_mostA_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_mostA"', 'Kirjete arv', '-', 														'OK', 	v_mostA_kirjete_arv, 	v_mostA_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_mostA"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_mostA_kirjete_arv*0, v_mostA_kirjete_arv, '', vaated_jr)
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
declare v_table_id, v_size,kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_andmebaasideTeooria')) 
then 	insert Staatus values ('Vaade "v_andmebaasideTeooria"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_andmebaasideTeooria*0, v_andmebaasideTeooria, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_andmebaasideTeooria');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 3                 
then 	insert Staatus values ('Vaade "v_andmebaasideTeooria"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_andmebaasideTeooria_veergude_arv*0, v_andmebaasideTeooria_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_andmebaasideTeooria"', 'Veergude arv', '-', 'OK', v_andmebaasideTeooria_veergude_arv, v_andmebaasideTeooria_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'PersonId', v_andmebaasideTeooria_personid, vaated_jr);
call	check_column_for_view(v_table_id, 'FirstName', v_andmebaasideTeooria_firstname, vaated_jr);
call	check_column_for_view(v_table_id, 'LastName', v_andmebaasideTeooria_lastname, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_andmebaasideTeooria;
	if		kirje_count > 17
	then	insert Staatus values('Vaade "v_andmebaasideTeooria"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_andmebaasideTeooria_kirjete_arv*0, v_andmebaasideTeooria_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 17
	then	insert Staatus values('Vaade "v_andmebaasideTeooria"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_andmebaasideTeooria_kirjete_arv*0, v_andmebaasideTeooria_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_andmebaasideTeooria"', 'Kirjete arv', '-', 														'OK', 	v_andmebaasideTeooria_kirjete_arv, 	v_andmebaasideTeooria_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_andmebaasideTeooria"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_andmebaasideTeooria_kirjete_arv*0, v_andmebaasideTeooria_kirjete_arv, '', vaated_jr)
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
declare v_table_id, v_size, kirje_max, kirje_min, kirje_count int;

if 		not exists (select * from systable where upper(table_name) = upper('v_top40A')) 
then 	insert Staatus values ('Vaade "v_top40A"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_top40A*0, v_top40A, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_top40A');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 3                 
then 	insert Staatus values ('Vaade "v_top40A"', 'Veergude arv', 'On vale, peab olema 2, hetkel on ' || v_size, 'VIGA', v_top40A_veergude_arv*0, v_top40A_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_top40A"', 'Veergude arv', '-', 'OK', v_top40A_veergude_arv, v_top40A_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'FirstName', v_top40A_firstname, vaated_jr);
call	check_column_for_view(v_table_id, 'LastName', v_top40A_lastname, vaated_jr);
call	check_column_for_view(v_table_id, 'NrOfA', v_top40A_nrofa, vaated_jr);

// Veeru NrOfA maksimumi kontroll
begin try
	select 	max(NrOfA) into kirje_max from v_top40A;
	if		kirje_max > 6
	then	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA maksimum', 'Maksimum on SUUREM kui vaja, praegu on ' || kirje_max, 	'VIGA', v_top40A_kirje_max*0, v_top40A_kirje_max, '', vaated_jr)
	elseif	kirje_count < 6
	then	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA maksimum', 'Maksimum on VÄIKSEM kui vaja, praegu on ' || kirje_max, 	'VIGA', v_top40A_kirje_max*0, v_top40A_kirje_max, '', vaated_jr)
	else	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA maksimum', '-', 														'OK', 	v_top40A_kirje_max, 	v_top40A_kirje_max, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top40A"', 'Kirje A maksimum', 'Ei kompileeru', 	'VIGA', v_top40A_kirje_max*0, v_top40A_kirje_max, '', vaated_jr)
end catch;

// Veeru NrOfA miinimum kontroll
begin try
	select 	min(NrOfA) into kirje_min from v_top40A;
	if		kirje_min > 4
	then	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA miinimum', 'Miinimum on SUUREM kui vaja, praegu on ' || kirje_min, 	'VIGA', v_top40A_kirje_min*0, v_top40A_kirje_min, '', vaated_jr)
	elseif	kirje_count < 4
	then	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA miinimum', 'Miinimum on VÄIKSEM kui vaja, praegu on ' || kirje_min, 	'VIGA', v_top40A_kirje_min*0, v_top40A_kirje_min, '', vaated_jr)
	else	insert Staatus values('Vaade "v_top40A"', 'Veeru NrOfA miinimum', '-', 														'OK', 	v_top40A_kirje_min, 	v_top40A_kirje_min, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top40A"', 'Kirje A miinimum', 'Ei kompileeru', 	'VIGA', v_top40A_kirje_min*0, v_top40A_kirje_min, '', vaated_jr)
end catch;

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_top40A;
	if		kirje_count > 40
	then	insert Staatus values('Vaade "v_top40A"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_top40A_kirjete_arv*0, v_top40A_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 40
	then	insert Staatus values('Vaade "v_top40A"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_top40A_kirjete_arv*0, v_top40A_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_top40A"', 'Kirjete arv', '-', 														'OK', 	v_top40A_kirjete_arv, 	v_top40A_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top40A"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_top40A_kirjete_arv*0, v_top40A_kirjete_arv, '', vaated_jr)
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
declare kirje_min, kirje_max double;

if 		not exists (select * from systable where upper(table_name) = upper('v_top30Students'))
then 	insert Staatus values ('Vaade "v_top30Students"', '-', 'Vaadet ei eksisteeri.', 'VIGA', v_top30Students*0, v_top30Students, '', vaated_jr);
return; 
endif;

set 	v_table_id = find_table_id('v_top30Students');

select count(column_name) into v_size from syscolumn where table_id = v_table_id; 

if      v_size != 3                 
then 	insert Staatus values ('Vaade "v_top30Students"', 'Veergude arv', 'On vale, peab olema 4, hetkel on ' || v_size, 'VIGA', v_top30Students_veergude_arv*0, v_top30Students_veergude_arv, '', vaated_jr)
else	insert Staatus values ('Tabel "v_top30Students"', 'Veergude arv', '-', 'OK', v_top30Students_veergude_arv, v_top30Students_veergude_arv, '', vaated_jr)
endif;

call	check_column_for_view(v_table_id, 'FirstName', v_top30Students_firstname, vaated_jr);
call	check_column_for_view(v_table_id, 'LastName', v_top30Students_lastname, vaated_jr);
call	check_column_for_view(v_table_id, 'AverageGrade', v_top30Students_averagegrade, vaated_jr);

// Kirjete kontroll
begin try
	select 	count(*) into kirje_count from v_top30Students;
	if		kirje_count > 30
	then	insert Staatus values('Vaade "v_top30Students"', 'Kirjete arv', 'Kirjeid on ROHKEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_top30Students_kirjete_arv*0, 	v_top30Students_kirjete_arv, '', vaated_jr)
	elseif	kirje_count < 30
	then	insert Staatus values('Vaade "v_top30Students"', 'Kirjete arv', 'Kirjeid on VÄHEM kui vaja, praegu on ' || kirje_count, 	'VIGA', v_top30Students_kirjete_arv*0, 	v_top30Students_kirjete_arv, '', vaated_jr)
	else	insert Staatus values('Vaade "v_top30Students"', 'Kirjete arv', '-', 													'OK', 	v_top30Students_kirjete_arv, 	v_top30Students_kirjete_arv, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top30Students"', 'Kirjete arv', 'Ei kompileeru', 	'VIGA', v_top30Students_kirjete_arv*0, v_top30Students_kirjete_arv, '', vaated_jr)
end catch;

// Veeru Average maksimum
begin try
	select max(averageGrade) into kirje_max from v_top30Students;
	if 		kirje_max > 4.0 
	then	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" maksimum', 'Maksimum on SUUREM kui vaja, praegu on ' || kirje_max || ', ' || kirje_min, 	'VIGA', v_top30Students_max*0, 	v_top30Students_max, '', vaated_jr)
	elseif	kirje_max < 4.0
	then	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" maksimum', 'Maksimum on VÄHEM kui vaja, praegu on ' || kirje_max, 	'VIGA', v_top30Students_max*0, 	v_top30Students_max, '', vaated_jr)
	else 	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" maksimum', '-', 'OK', v_top30Students_max, 	v_top30Students_max, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" maksimum', 'Ei kompileeru', 	'VIGA', v_top30Students_max*0, v_top30Students_max, '', vaated_jr)
end catch;

// Veeru Average miinimum
begin try
	select min(averageGrade) into kirje_min from v_top30Students;
	if 		kirje_min > 3.6
	then	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" miinimum', 'Miinimum on SUUREM kui vaja, praegu on:' || kirje_min || ', ' || kirje_min, 	'VIGA', v_top30Students_min*0, 	v_top30Students_min, '', vaated_jr)
	elseif	kirje_min < 3.6
	then	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" miinimum', 'Miinimum on VÄHEM kui vaja, praegu on ' || kirje_min, 	'VIGA', v_top30Students_min*0, 	v_top30Students_min, '', vaated_jr)
	else 	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" miinimum', '-', 'OK', v_top30Students_min, 	v_top30Students_min, '', vaated_jr)
	endif;
end try
begin catch
	insert Staatus values('Vaade "v_top30Students"', 'Veeru "AverageGrade" miinimum', 'Ei kompileeru', 	'VIGA', v_top30Students_min*0, v_top30Students_min, '', vaated_jr)
end catch;
end;


/*
Protseduur käivita, mis siis käivitab kodutöö kontrolli

Selle protseduuris on ka väike kirjete arvu kontroll. Kui mõnes põhitabelis ei ole kirjeid, siis tuleb teade, et järgnevad probleemid võivad olla sellest, et tabelites pole andmeid. 
See teade tuleb ainult 5-7 kodutöö korral.
*/

create 	procedure käivita()
begin

call table_institutes();
call table_persons();
call table_registrations();
call table_lecturers();
call table_courses();
call muud_elemendid();
call view_persons_atleast_4eap();
call view_mostA();
call view_andmebaasideTeooria();
call view_top40A();
call view_top30Students();

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
order by Jr;
output to 'C:\TEMP\tulemus.csv' format excel;
output to 'C:\TEMP\tulemus.txt' format text;