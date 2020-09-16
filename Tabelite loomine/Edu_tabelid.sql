// Delete if exists
// Tabelid
if exists (select * from systable where table_name = 'Faculty') 							then drop table faculty endif;
if exists (select * from systable where table_name = 'Person') 								then drop table person endif;
if exists (select * from systable where table_name = 'Registration') 						then drop table registration endif;
if exists (select * from systable where table_name = 'Lecturer') 							then drop table Lecturer endif;
if exists (select * from systable where table_name = 'Course') 								then drop table course endif;
// Vaated
if exists (select * from systable where table_name = 'v_oigusteaduskonna_inimesed') 		then drop view v_oigusteaduskonna_inimesed endif;
if exists (select * from systable where table_name = 'v_oigusteaduskonna_inimesed_mini') 	then drop view v_oigusteaduskonna_inimesed_mini endif;
if exists (select * from systable where table_name = 'v_persons_faculty') 					then drop view v_persons_faculty endif;
if exists (select * from systable where table_name = 'v_faculty_deans') 					then drop view v_faculty_deans endif;
if exists (select * from systable where table_name = 'v_faculty_deans') 					then drop view v_faculty_deans endif;
if exists (select * from systable where table_name = 'v_persons_atleast_4eap') 				then drop view v_persons_atleast_4eap endif;
if exists (select * from systable where table_name = 'v_mostA') 							then drop view v_mostA endif;
if exists (select * from systable where table_name = 'v_andmebaasideTeooria') 				then drop view v_andmebaasideTeooria endif;
if exists (select * from systable where table_name = 'v_top40A') 							then drop view v_top40A endif;
if exists (select * from systable where table_name = 'v_top30Students') 					then drop view v_top30Students endif;
// Tabelite loomine (antud)
CREATE TABLE Faculty(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Address VARCHAR(30),
DeanId INTEGER,
ViceDeanId INTEGER,
UNIQUE(Name)
);

CREATE TABLE Person(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
FacultyId INTEGER NOT NULL,
SSN VARCHAR(11),
UNIQUE(FirstName,LastName));

CREATE TABLE Registration(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
CourseId INTEGER NOT NULL,
PersonId INTEGER NOT NULL,
FinalGrade VARCHAR(1));

CREATE TABLE Lecturer(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
CoursesId INTEGER,
PersonsId INTEGER NOT NULL,
Responsible SMALLINT);

CREATE TABLE Course(
Id INTEGER NOT NULL DEFAULT
AUTOINCREMENT PRIMARY KEY,
FacultyId INTEGER NOT NULL,
Name VARCHAR(50) NOT NULL,
Code VARCHAR(20),
EAP INTEGER,
GradeType VARCHAR(8));

// Andmete sisestamine (antud)
INPUT INTO Person FROM 'C:\TEMP\person.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Faculty FROM 'C:\TEMP\faculty.txt' FORMAT ASCII DELIMITED BY '\x09';

-- Ise
INPUT INTO Registration FROM 'C:\TEMP\registrations.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Lecturer FROM 'C:\TEMP\lecturers.txt' FORMAT ASCII DELIMITED BY '\x09';

INPUT INTO Course FROM 'C:\TEMP\course.txt' FORMAT ASCII DELIMITED BY '\x09';

// Andmete sisestus vol2
INSERT INTO Course VALUES (101,9,'Sissejuhatusinformaatikasse','MTAT.05.074',3,'Arvestus');

INSERT INTO registration
(CourseId,PersonId,FinalGrade)
SELECT 101, p.id, NULL
FROM Course as c
JOIN Registration as r ON (c.Id = r.CourseId)
JOIN Person as p ON (r.PersonId = p.Id)
WHERE c.Name = 'Sissejuhatus ettevõttemajandusse';

//andmete sisestus (ise)
insert into course (FacultyId, Name, Code, EAP, GradeType) values(9,'Andmebaaside teooria', 'MTAT.03.998',6 ,'Arvestus');

INSERT INTO registration
(CourseId,PersonId,FinalGrade)
SELECT c.id, p.id, r.FinalGrade
FROM Course as c
JOIN Registration as r ON (c.Id = r.CourseId)
JOIN Person as p ON (r.PersonId = p.Id)
WHERE c.Name = 'Andmebaasid'
and r.FinalGrade = 'A';

// Välisvõtmete loomine (antud)
ALTER TABLE Registration ADD CONSTRAINT
fk_registration_person FOREIGN KEY (PersonId)
REFERENCES Person (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Faculty ADD CONSTRAINT
fk_faculty_person_dean FOREIGN KEY (DeanId)
REFERENCES Person (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

-- Ise
ALTER TABLE Registration ADD CONSTRAINT
fk_registration_course FOREIGN KEY (CourseId)
REFERENCES Course (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Lecturer ADD CONSTRAINT
fk_lecturer_person FOREIGN KEY (PersonsId)
REFERENCES Person (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Lecturer ADD CONSTRAINT
fk_lecturer_course FOREIGN KEY (CoursesId)
REFERENCES Course (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

ALTER TABLE Course ADD CONSTRAINT
fk_course_faculty FOREIGN KEY (FacultyId)
REFERENCES Faculty (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Faculty ADD CONSTRAINT
fk_faculty_person_vice_dean FOREIGN KEY (ViceDeanId)
REFERENCES Person (Id) ON DELETE 
SET NULL
ON UPDATE CASCADE;

ALTER TABLE Person ADD CONSTRAINT
fk_person_faculty FOREIGN KEY (FacultyId)
REFERENCES Faculty (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

// Vaadete loomine (antud)
CREATE VIEW v_oigusteaduskonna_inimesed AS
SELECT * FROM person WHERE facultyId = 2;

CREATE VIEW v_oigusteaduskonna_inimesed_mini
(eesnimi,perenimi) AS
SELECT FirstName, LastName
FROM person WHERE facultyId = 2;

CREATE VIEW v_persons_faculty AS
SELECT p.FirstName, p.LastName, f.Name as FacultyName,
f.Address as FacultyAddress
FROM person as p JOIN faculty as f ON (p.facultyId = f.id);

CREATE VIEW v_faculty_deans (FacultyName,
DeanName, ViceDeanName) AS
SELECT f.Name, d.FirstName+' '+d.LastName as
deanName, v.FirstName+' '+v.LastName as
viceDeanName
FROM Faculty as f
JOIN Person as d ON (f.deanId = d.id)
JOIN Person as v ON (f.viceDeanId = v.id)
ORDER BY f.Name;


// Vaadete loomine (ise)
create view v_persons_atleast_4eap (FirstName, LastName) as
select distinct FirstName, LastName from person, course, faculty, registration 
where Person.FacultyId = faculty.id
and registration.courseid = course.id
and personid = person.id
and Course.FacultyId = faculty.id 
and faculty.name = 'Matemaatika-informaatikateaduskond'
and course.eap > 3;

create view v_mostA(FirstName, LastName, NrOfA) as
select distinct FirstName, LastName, count(*) as NrOfA
from Person join Faculty on Person.facultyId = Faculty.id
join Course on Course.FacultyId = Faculty.id
join Registration on Registration.CourseId = Course.id
where FinalGrade = 'A'
and Registration.PersonId = Person.id
and Faculty.Name = 'Matemaatika-informaatikateaduskond'
and Course.GradeType = 'Eksam'
group by FirstName, LastName;

create view v_andmebaasideTeooria(PersonId, FirstName, LastName) as
select distinct person.id, FirstName, LastName from Person
join faculty on person.facultyId = faculty.id
join registration on registration.PersonId = Person.Id
join course on course.facultyId = faculty.id
where course.name = 'Andmebaaside teooria';

create view v_top40A(FirstName, LastName, nrOfA) as
select TOP 40 FirstName, LastName, count(*) as NrOfA from Person
key join registration
where FinalGrade = 'A'
group by FirstName, LastName
order by NrOfA desc;

create view v_top30Students(FirstName, LastName, AverageGrade) as
select top 30 FirstName, LastName, 
avg(case FinalGrade 
    when 'A' then 5
    when 'B' then 4
    when 'C' then 3
    when 'D' then 2
    when 'E' then 1
end) as AverageGrade from Person
join registration on person.id = registration.personId
join course on course.id = registration.courseId
where course.GradeType = 'Eksam'
group by FirstName, LastName
order by AverageGrade desc, Firstname asc, Lastname asc;