// Tabeli Asulad loomine ja andmete lisamine
if exists (select * from systable where table_name = 'asulad') then drop table asulad endif;
create table Asulad( id integer default autoincrement primary key, nimi varchar(100) not null, Unique(nimi));
INSERT INTO asulad (nimi) VALUES ('Elva');
INSERT INTO asulad (nimi) VALUES ('Tartu');
INSERT INTO asulad (nimi) VALUES ('Kambja');
INSERT INTO asulad (nimi) VALUES ('Valga');

// Muutused klubid tabelis
begin try
alter table klubid drop Asula;
alter table klubid add Asula int;
update klubid set asula = (select id from asulad where asulad.nimi = klubid.asukoht);
end try
begin catch
alter table klubid add Asula int;
update klubid set asula = (select id from asulad where asulad.nimi = klubid.asukoht);
end catch;

begin try
alter table klubid drop constraint fk_klubi_2_asula;
alter table klubid add constraint fk_klubi_2_asula 
foreign key (asula) 
references Asulad (id) 
on delete restrict on update cascade;
end try
begin catch
alter table klubid add constraint fk_klubi_2_asula 
foreign key (asula) 
references Asulad (id) 
on delete restrict on update cascade;
end catch;

// Muutused turniirid tabelis
begin try
alter table turniirid drop Asula;
alter table turniirid add Asula int;
update turniirid set asula = (select id from asulad where asulad.nimi = turniirid.Toimumiskoht);
end try
begin catch
alter table turniirid add Asula int;
update turniirid set asula = (select id from asulad where asulad.nimi = turniirid.Toimumiskoht);
end catch;

begin try
alter table turniirid drop constraint fk_turniir_2_asula;
alter table turniirid add constraint fk_turniir_2_asula 
foreign key (Asula) 
references Asulad (id) on delete restrict on update cascade
end try
begin catch
alter table turniirid add constraint fk_turniir_2_asula 
foreign key (Asula) 
references Asulad (id) on delete restrict on update cascade;
end catch;

// Protseduurid
if exists (select * from sysprocedure where proc_name = 'sp_kustuta_klubi') then drop procedure sp_kustuta_klubi endif;
create procedure sp_kustuta_klubi(in klubinimi varchar(100)) begin delete from klubid where klubid.nimi = klubinimi; 
end;

// Triggerid
if exists (select * from systrigger where trigger_name = 'tg_lisa_klubi') then drop trigger tg_lisa_klubi endif;
create trigger "tg_lisa_klubi" after insert on klubid 
referencing new as uus 
for each row 
begin 
declare uus_id int; 
if (select count(*) from asulad where uus.asukoht = Asulad.nimi) > 0 
then set uus_id = (select id from asulad where uus.asukoht = Asulad.nimi) 
else insert into Asulad (nimi) values (uus.asukoht); 
set uus_id = (select id from asulad where uus.asukoht = Asulad.nimi) 
endif; 
update klubid set asula = uus_id where id = uus.id; 
end;

if exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi') then drop trigger tg_kustuta_klubi endif;
create trigger "tg_kustuta_klubi" after delete on klubid 
referencing old as vana 
for each row 
begin 
declare turniir_kogus, klubi_kogus int; 
select count(*) into turniir_kogus from turniirid where vana.asula = turniirid.asula; 
select count(*) into klubi_kogus from klubid where vana.asula = klubid.asula; 
if (turniir_kogus + klubi_kogus) = 0 then delete asulad where id = vana.asula endif; 
end;

if exists (select * from systrigger where trigger_name = 'tg_kustuta_klubi_isikutega') then drop trigger tg_kustuta_klubi_isikutega endif;
create trigger tg_kustuta_klubi_isikutega before delete on klubid 
referencing old as vana 
for each row 
begin 
delete isikud where klubi = vana.id; 
end;

// Vaadete loomine
if exists (select * from systable where table_name = 'v_asulaklubisid') then drop view v_asulaklubisid endif;
create view v_asulaklubisid (asula_id, asula_nimi, klubisid) as select id, nimi, (select count(*) from klubid where asula = asulad.id) from asulad; // group by asulad.nimi, asulad.id;

if exists (select * from systable where table_name = 'v_asulasuurus') then drop view v_asulasuurus endif;
create view v_asulasuurus (asula_id, asula_nimi, mangijaid) as select id, nimi, (select count(*) from Isikud join Klubid on Klubid.Id=Isikud.Klubi where Klubid.Asula = Asulad.Id) from asulad; // group by asulad.id, asulad.nimi;

// Vaated 1-12
if exists (select * from systable where table_name = 'V_1') then drop view V_1 endif;
create view V_1(eesnimi, perenimi) as 
select eesnimi, perenimi from isikud join klubid where isikud.klubi = klubid.id and klubid.nimi = 'Laudnikud' order by eesnimi asc;

if exists (select * from systable where table_name = 'V_2') then drop view V_2 endif;
create view V_2(Liikmed) as 
select count(*) from isikud join klubid where klubid.nimi = 'Laudnikud' and klubi = klubid.id;

if exists (select * from systable where table_name = 'V_3') then drop view V_3 endif;
create view V_3(perenimi) as
select perenimi from isikud join klubid
where klubid.id = isikud.klubi and klubid.nimi like 'V%' and isikud.eesnimi like 'M%';

if exists (select * from systable where table_name = 'V_4') then drop view V_4 endif;
create view V_4(algusaeg) as 
select min(algusaeg) from partiid;

if exists (select * from systable where table_name = 'V_5') then drop view V_5 endif;
create view V_5(valge, must) as
select valge, must from partiid
where algushetk between '2005-03-04 09:00' and '2005-03-04 11:00';

if exists (select * from systable where table_name = 'V_6') then drop view V_6 endif;
create view V_6(eesnimi, perenimi) as
select eesnimi, perenimi from isikud join partiid on isikud.id = partiid.valge
where datediff(minute, Algushetk, Lopphetk)>=9 
and datediff(minute, Algushetk, Lopphetk)<=11 
and valge_tulemus = 2;

if exists (select * from systable where table_name = 'V_7') then drop view V_7 endif;
create view V_7(perenimi) as
select perenimi from isikud group by perenimi
having count(*)>1;

if exists (select * from systable where table_name = 'V_8') then drop view V_8 endif;
create view V_8(nimi, liikmete_arv) as
select nimi, count(*) from isikud join klubid
where klubi = klubid.id
group by nimi
having count(*)<4;

if exists (select * from systable where table_name = 'V_9') then drop view V_9 endif;
create view V_9(arv) as
select count(*) from partiid join isikud on valge = isikud.id
where eesnimi = 'Arvo';

if exists (select * from systable where table_name = 'V_10') then drop view V_10 endif;
create view V_10(id, arv) as
select turniir, count(*) from partiid join isikud on valge = isikud.id
where eesnimi = 'Arvo'
group by turniir;

if exists (select * from systable where table_name = 'V_11') then drop view V_11 endif;
create view V_11(punktid) as
select sum(musta_tulemus)*0.5 from partiid join isikud on must = isikud.id
where eesnimi = 'Maria';

if exists (select * from systable where table_name = 'V_12') then drop view V_12 endif;
create view V_12(nimi, keskmine) as
select nimi, avg(datediff(minute, algushetk, lopphetk)) from turniirid join partiid 
where turniirid.id = turniir
group by nimi;