// Kõikide tabelite kustutamine
if exists (select * from systable where table_name = 'klubid') then drop table klubid endif;
if exists (select * from systable where table_name = 'isikud') then drop table isikud endif;
if exists (select * from systable where table_name = 'turniirid') then drop table turniirid endif;
if exists (select * from systable where table_name = 'partiid') then drop table partiid endif;
if exists (select * from systable where table_name = 'inimesed') then drop table inimesed endif;

// Tabel Inimesed loomine, andmete lisamine
CREATE TABLE inimesed (eesnimi varchar(30) not null, 
perenimi varchar(100) not null, 
sugu char(1) not null check (sugu in ('m','n')),
synnipaev date not null,
sisestatud datetime not null default current timestamp,
isikukood varchar(11),
CONSTRAINT pk_inimesed PRIMARY KEY (isikukood));

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