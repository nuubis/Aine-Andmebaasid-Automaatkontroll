// Kõikide tabelite kustutamine
if exists (select * from systable where table_name = 'klubid') then drop table klubid endif;
if exists (select * from systable where table_name = 'isikud') then drop table isikud endif;
if exists (select * from systable where table_name = 'turniirid') then drop table turniirid endif;
if exists (select * from systable where table_name = 'partiid') then drop table partiid endif;
if exists (select * from systable where table_name = 'inimesed') then drop table inimesed endif;

// Vaadete kustutamine
if exists (select * from systable where table_name = 'v_mangijad') then drop view v_mangijad endif;
if exists (select * from systable where table_name = 'v_partiid') then drop view v_partiid endif;
if exists (select * from systable where table_name = 'v_turniiripartiid') then drop view v_turniiripartiid endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused') then drop view v_klubipartiikogused endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused_1') then drop view v_klubipartiikogused_1 endif;
if exists (select * from systable where table_name = 'v_klubipartiikogused_2') then drop view v_klubipartiikogused_2 endif;
if exists (select * from systable where table_name = 'v_punktid') then drop view v_punktid endif;
if exists (select * from systable where table_name = 'v_edetabelid') then drop view v_edetabelid endif;

// Tabel Inimesed loomine, andmete lisamine
CREATE TABLE Inimesed (eesnimi varchar(30) not null, 
perenimi varchar(100) not null, 
sugu char(1) not null check (sugu in ('m','n')),
synnipaev date not null,
sisestatud datetime not null default current timestamp,
isikukood varchar(11),
CONSTRAINT pk_inimesed PRIMARY KEY (isikukood));
insert into inimesed (eesnimi, perenimi, sugu, synnipaev, isikukood) 
values('Martti', 'Kakk', 'm', '1995-01-17', 39501170270); 

// Tabel klubid loomine, andmete sisestamine
create table Klubid ( id integer not null default autoincrement primary key, Nimi varchar(100) not null unique);
INPUT INTO klubid FROM 'C:\TEMP\klubid.txt' FORMAT ASCII DELIMITED BY '\x09';
ALTER TABLE klubid ADD asukoht varchar(70) NOT NULL DEFAULT 'Tartu';

// Tabel isikud loomine ja andmete lisamine
create table Isikud ( id integer not null default autoincrement primary key, Eesnimi varchar(50) not null, Perenimi varchar(50) not null, Isikukood varchar(11), Klubi integer, Unique(eesnimi, perenimi));
INPUT INTO Isikud FROM 'C:\TEMP\isikud.txt' FORMAT ASCII DELIMITED BY '\x09' (id, eesnimi, perenimi, klubi);

// Tabel turniirid loomine ja andmete lisamine
create table Turniirid ( id integer not null default autoincrement primary key, Nimetus varchar(100) not null unique, Toimumiskoht varchar(100), Alguskuupaev date not null, Loppkuupaev date);
ALTER TABLE turniirid RENAME nimetus TO nimi;
INPUT INTO turniirid FROM 'C:\TEMP\turniirid.txt' FORMAT ASCII DELIMITED BY '\x09' (id, nimi, Toimumiskoht, Alguskuupaev, Loppkuupaev);

// Tabel partiid loomine ja andmete lisamine
create table Partiid ( id integer not null default autoincrement primary key, Turniir integer not null, Algushetk datetime not null default current timestamp, Lopphetk datetime, Valge integer not null, Must integer not null, Valge_tulemus smallint check (valge_tulemus in (0,1,2)), Musta_tulemus smallint check (musta_tulemus in (0,1,2)), Kokkuvote varchar(5000) );
ALTER TABLE partiid ADD CONSTRAINT vastavus CHECK (valge_tulemus + musta_tulemus = 2);
INPUT INTO partiid FROM 'C:\TEMP\partiid.txt' FORMAT ASCII DELIMITED BY '\x09' (Turniir, Algushetk, Lopphetk, Valge, Must, Valge_tulemus, Musta_tulemus, Kokkuvote);

// Välisvõtmete lisamine
// Isik -> klubi
ALTER TABLE isikud ADD CONSTRAINT fk_isik_2_klubi FOREIGN KEY (klubi) REFERENCES klubid (id) ON DELETE RESTRICT ON UPDATE CASCADE;
// Partii -> Turniir – nii, et turniiri kustutamisel kaoksid kõik selle turniiri partiid
ALTER TABLE partiid ADD CONSTRAINT fk_partii_2_turniir FOREIGN KEY (turniir) REFERENCES turniirid (id) ON DELETE CASCADE ON UPDATE CASCADE;
// Partii -> Isik (Valgetega mängija)
ALTER TABLE partiid ADD CONSTRAINT fk_partii_2_isik_valge FOREIGN KEY (valge) REFERENCES isikud (id) ON DELETE restrict ON UPDATE CASCADE;
// Partii -> Isik (Mustadega mängija)
ALTER TABLE partiid ADD CONSTRAINT fk_partii_2_isik_must FOREIGN KEY (must) REFERENCES isikud (id) ON DELETE restrict ON UPDATE CASCADE;

// Turniir muudatused
INSERT INTO turniirid (id, nimi, toimumiskoht, alguskuupaev, loppkuupaev) VALUES (47, 'Kuldkarikas 2010' , 'Elva', '2010-10-14' , '2010-10-14');
UPDATE turniirid SET nimi = 'Plekkkarikas 2010' WHERE id = 47;
// Partii muudatused
INSERT INTO partiid (turniir, algushetk, valge, must) SELECT turniirid.id, dateadd(minute,1+rand()*10, dateadd(hour, 8+rand()*10,turniirid.alguskuupaev)), v.id, m.id FROM turniirid , isikud v, isikud m WHERE turniirid.id = 47 AND v.id <> m.id AND v.klubi <> 57 AND m.klubi <> 57;
UPDATE partiid SET lopphetk = dateadd(second, 50+mod(id, 121), dateadd(minute, 19 + mod(id,18) + mod(id,3) - mod(id,13), algushetk)) WHERE turniir = 47;
UPDATE partiid set valge_tulemus = mod(id+valge-must+turniir, 3) WHERE turniir = 47;
UPDATE partiid SET musta_tulemus = 2 - valge_tulemus WHERE turniir = 47;
DELETE FROM partiid p WHERE EXISTS ( SELECT * FROM partiid q WHERE p.valge = q.must AND q.valge = p.must AND p.id < q.id AND turniir=47) AND turniir = 47;
DELETE FROM partiid p WHERE EXISTS ( SELECT * FROM partiid q WHERE p.algushetk>= q.algushetk AND p.algushetk <= q.lopphetk AND p.id <> q.id AND (p.valge = q.valge OR p.valge=q.must OR p.must=q.valge OR p.must=q.must) AND q.turniir = p.turniir ) AND turniir = 47;

// Vaadete loomine

CREATE VIEW v_mangijad (klubi_nimi, klubi_id, isik_nimi, isik_id) AS SELECT klubid.nimi, klubid.id, isikud.perenimi || ', ' || isikud.eesnimi, isikud.id FROM isikud JOIN klubid ON isikud.klubi = klubid.id;

CREATE VIEW v_partiid (id, turniir, algus, valge_nimi, valge_klubi, valge_punkt, must_nimi, must_klubi, must_punkt ) AS SELECT p.id, p.turniir, p.algushetk, v.isik_nimi, v.klubi_nimi, p.valge_tulemus / 2.0, m.isik_nimi, m.klubi_nimi, p.musta_tulemus / 2.0 FROM partiid as p, v_mangijad as v, v_mangijad as m WHERE p.valge = v.isik_id AND p.must = m.isik_id;

create view v_turniiripartiid (turniir_nimi, partii_id, partii_algus, partii_lopp) as select turniirid.nimi, partiid.id, partiid.algushetk, partiid.lopphetk from turniirid join partiid on partiid.turniir = turniirid.id;

create view v_klubipartiikogused (klubi_nimi, partiisid) as select klubid.nimi, count(*) from partiid join isikud on partiid.valge = isikud.id or partiid.must = isikud.id join klubid on isikud.klubi = klubid.id group by klubid.nimi;

create view v_klubipartiikogused_1 (klubi_nimi, partiisid) 
as select distinct k.nimi, count(distinct p.id)
from klubid AS k, partiid AS p, isikud AS i
WHERE i.id = p.valge AND i.klubi = k.id
OR i.id = p.must AND i.klubi = k.id
GROUP BY  k.nimi

create view v_klubipartiikogused_2 (klubi_nimi, partiisid) as select klubid.nimi, count(*) from partiid join isikud on partiid.valge = isikud.id or partiid.must = isikud.id join klubid on isikud.klubi = klubid.id group by klubid.nimi;

create view v_punktid (partii, turniir, mangija, varv, punkt) as select partiid.id, turniirid.id, valge, 'V', partiid.valge_tulemus*0.5 from partiid join turniirid on partiid.turniir = turniirid.id union select partiid.id, turniirid.id, must, 'M', partiid.musta_tulemus*0.5 from partiid join turniirid on partiid.turniir = turniirid.id;

create view v_edetabelid (mangija, turniir, punkte) 
as select v_mangijad.isik_nimi, turniir, sum(punkt) 
from v_punktid join v_mangijad on v_mangijad.isik_id = v_punktid.mangija 
group by isik_nimi, turniir;