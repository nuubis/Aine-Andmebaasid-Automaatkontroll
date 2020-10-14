// Delete if exists
// Tabelid
if exists (select * from systable where table_name = 'Institutes') 							then drop table Institutes endif;
if exists (select * from systable where table_name = 'Persons') 								then drop table Persons endif;
if exists (select * from systable where table_name = 'Registrations') 						then drop table Registrations endif;
if exists (select * from systable where table_name = 'Lecturers') 							then drop table Lecturers endif;
if exists (select * from systable where table_name = 'Courses') 								then drop table Courses endif;
// Vaated
if exists (select * from systable where table_name = 'v_oigusteaduskonna_inimesed') 		then drop view v_oigusteaduskonna_inimesed endif;
if exists (select * from systable where table_name = 'v_oigusteaduskonna_inimesed_mini') 	then drop view v_oigusteaduskonna_inimesed_mini endif;
if exists (select * from systable where table_name = 'v_persons_Institute') 					then drop view v_persons_Institute endif;
if exists (select * from systable where table_name = 'v_Institute_deans') 					then drop view v_Institute_deans endif;
if exists (select * from systable where table_name = 'v_Institute_deans') 					then drop view v_Institute_deans endif;
if exists (select * from systable where table_name = 'v_persons_atleast_4eap') 				then drop view v_persons_atleast_4eap endif;
if exists (select * from systable where table_name = 'v_mostA') 							then drop view v_mostA endif;
if exists (select * from systable where table_name = 'v_andmebaasideTeooria') 				then drop view v_andmebaasideTeooria endif;
if exists (select * from systable where table_name = 'v_top40A') 							then drop view v_top40A endif;
if exists (select * from systable where table_name = 'v_top30Students') 					then drop view v_top30Students endif;

// Tabelite loomine (antud)
CREATE TABLE Institutes(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Address VARCHAR(30),
DeanId INTEGER,
ViceDeanId INTEGER,
UNIQUE(Name)
);

CREATE TABLE Persons(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
InstituteId INTEGER NOT NULL,
SSN VARCHAR(11),
UNIQUE(FirstName,LastName));

CREATE TABLE Registrations(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
CourseId INTEGER NOT NULL,
PersonId INTEGER NOT NULL,
FinalGrade VARCHAR(1));

CREATE TABLE Lecturers(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
CourseId INTEGER,
PersonId INTEGER NOT NULL,
Responsible SMALLINT);

CREATE TABLE Courses(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
InstituteId INTEGER NOT NULL,
Name VARCHAR(50) NOT NULL,
Code VARCHAR(20),
EAP INTEGER,
GradeType VARCHAR(8));

// Andmete sisestamine (antud)
INPUT INTO Persons FROM 'C:\TEMP\Persons.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Institutes FROM 'C:\TEMP\Institutes.txt' FORMAT ASCII DELIMITED BY '\x09';

-- Ise
INPUT INTO Registrations FROM 'C:\TEMP\registrations.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Lecturers FROM 'C:\TEMP\lecturers.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Courses FROM 'C:\TEMP\Courses.txt' FORMAT ASCII DELIMITED BY '\x09';

// Andmete sisestus vol2
INSERT INTO Courses VALUES (101,9,'Sissejuhatus informaatikasse','MTAT.05.074',3,'Arvestus');

insert into Registrations (CourseId, PersonId, FinalGrade)
select 101, p.id, NULL from Courses as c
join Registrations as r on c.id = r.courseid
join Persons as p on r.PersonId = p.id
where c.name = 'Sissejuhatus ettevõttemajandusse';

//andmete sisestus (ise)
insert into Courses (InstituteId, Name, Code, EAP, GradeType) values(9,'Andmebaaside teooria', 'MTAT.03.998',6 ,'Arvestus');

INSERT INTO Registrations
(CourseId,PersonId,FinalGrade)
SELECT c.id, p.id, null
FROM Courses as c
JOIN Registrations as r ON (c.Id = r.CourseId)
JOIN Persons as p ON (r.PersonId = p.Id)
WHERE c.Name = 'Andmebaasid';

// Foreign_table = Registrations, foreign_column = PersonId, Primary_table = Persons, primary_column = Id
// Välisvõtmete loomine (antud)
ALTER TABLE Registrations ADD CONSTRAINT
fk_registration_person FOREIGN KEY (PersonId)
REFERENCES Persons (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Institutes ADD CONSTRAINT
fk_institute_person_dean FOREIGN KEY (DeanId)
REFERENCES Persons (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

-- Ise
ALTER TABLE Registrations ADD CONSTRAINT
fk_registration_course FOREIGN KEY (CourseId)
REFERENCES Courses (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Lecturers ADD CONSTRAINT
fk_lecturer_person FOREIGN KEY (PersonId)
REFERENCES Persons (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Lecturers ADD CONSTRAINT
fk_lecturer_course FOREIGN KEY (CourseId)
REFERENCES Courses (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

ALTER TABLE Courses ADD CONSTRAINT
fk_course_institute FOREIGN KEY (InstituteId)
REFERENCES Institutes (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Institutes ADD CONSTRAINT
fk_institute_person_vice_dean FOREIGN KEY (ViceDeanId)
REFERENCES Persons (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

ALTER TABLE Persons ADD CONSTRAINT
fk_person_institute FOREIGN KEY (InstituteId)
REFERENCES Institutes (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

// Vaadete loomine (antud)
CREATE VIEW v_oigusteaduskonna_inimesed AS
SELECT * FROM Persons WHERE InstituteId = 2;

CREATE VIEW v_oigusteaduskonna_inimesed_mini
/* Created by Martti Kakk */
(eesnimi,perenimi) AS
SELECT FirstName, LastName
FROM Persons WHERE InstituteId = 2;

CREATE VIEW v_persons_institute AS
SELECT p.FirstName, p.LastName, i.Name as InstituteName,
i.Address as InstituteAddress
FROM Persons as p JOIN Institutes as i ON (p.InstituteId = i.id);

CREATE VIEW v_Institute_deans (InstituteName,
DeanName, ViceDeanName) AS
SELECT i.Name, d.FirstName+' '+d.LastName as
deanName, v.FirstName+' '+v.LastName as
viceDeanName
FROM Institutes as i
JOIN Persons as d ON (i.deanId = d.id)
JOIN Persons as v ON (i.viceDeanId = v.id)
ORDER BY i.Name;


// Vaadete loomine (ise)
create view v_persons_atleast_4eap (FirstName, LastName) as
/* Created by Martti Kakk */
select distinct FirstName, LastName from Persons, Courses, Institutes, Registrations 
where Persons.InstituteId = Institutes.id
and Registrations.courseid = Courses.id
and PersonId = Persons.id
and Courses.InstituteId = Institutes.id 
and Institutes.name = 'Matemaatika-informaatikateaduskond'
and Courses.eap > 3;

create view v_mostA(FirstName, LastName, NrOfA) as
/* Created by Martti Kakk */
select distinct FirstName, LastName, count(*) as NrOfA
from Persons join Institutes on Persons.InstituteId = Institutes.id
join Courses on Courses.InstituteId = Institutes.id
join Registrations on Registrations.CourseId = Courses.id
where FinalGrade = 'A'
and Registrations.PersonId = Persons.id
and Institutes.Name = 'Matemaatika-informaatikateaduskond'
and Courses.GradeType = 'Eksam'
group by FirstName, LastName;

create view v_andmebaasideTeooria(PersonId, FirstName, LastName) as
/* Created by Martti Kakk */
select distinct Persons.id, FirstName, LastName from Persons
join Institutes on Persons.InstituteId = Institutes.id
join Registrations on Registrations.PersonId = Persons.Id
join Courses on Courses.InstituteId = Institutes.id
where Courses.name = 'Andmebaaside teooria';

create view v_top40A(FirstName, LastName, nrOfA) as
/* Created by Martti Kakk */
select TOP 40 FirstName, LastName, count(*) as NrOfA from Persons
key join Registrations
where FinalGrade = 'A'
group by FirstName, LastName
order by NrOfA desc;

create view v_top30Students(FirstName, LastName, AverageGrade) as
/* Created by Martti Kakk */
select top 30 FirstName, LastName, 
avg(case FinalGrade 
    when 'A' then 5
    when 'B' then 4
    when 'C' then 3
    when 'D' then 2
    when 'E' then 1
end) as AverageGrade from Persons
join Registrations on Persons.id = Registrations.PersonId
join Courses on Courses.id = Registrations.courseId
where Courses.GradeType = 'Eksam'
group by FirstName, LastName
order by AverageGrade desc, Firstname asc, Lastname asc;