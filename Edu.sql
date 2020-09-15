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
INPUT INTO Person FROM 'person.txt' FORMAT ASCII DELIMITED BY '\x09'

INPUT INTO Faculty FROM 'faculty.txt' FORMAT ASCII DELIMITED BY '\x09'

-- Ise
INPUT INTO Registration FROM 'registrations.txt' FORMAT ASCII DELIMITED BY '\x09'

INPUT INTO Lecturer FROM 'lecturers.txt' FORMAT ASCII DELIMITED BY '\x09'

INPUT INTO Course FROM 'course.txt' FORMAT ASCII DELIMITED BY '\x09'


// Välisvõtmete loomine (antud)
ALTER TABLE Registration ADD CONSTRAINT
fk_registration_person FOREIGN KEY (PersonId)
REFERENCES Person (Id) ON DELETE
CASCADE
ON UPDATE CASCADE;

ALTER TABLE Faculty ADD CONSTRAINT
fk_faculty_person_dean FOREIGN KEY (DeanId)
REFERENCES Person (Id) ON DELETE SET
NULL
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
/*
• Lecturer → Person
• Lecturer → Course (tühista seos)
• Course → Faculty
• Faculty (ViceDeanId) → Person (tühista seos)
• Person → Faculty*/

// Vaadete loomine (antud)
CREATE VIEW v_oigusteaduskonna_inimesed AS
SELECT * FROM person WHERE facultyId = 2

CREATE VIEW v_oigusteaduskonna_inimesed_mini
(eesnimi,perenimi) AS
SELECT FirstName, LastName
FROM person WHERE facultyId = 2

CREATE VIEW v_persons_faculty AS
SELECT p.FirstName, p.LastName, f.Name as FacultyName,
f.Address as FacultyAddress
FROM person as p JOIN faculty as f ON (p.facultyId = f.id)

CREATE VIEW v_faculty_deans (FacultyName,
DeanName, ViceDeanName) AS
SELECT f.Name, d.FirstName+' '+d.LastName as
deanName, v.FirstName+' '+v.LastName as
viceDeanName
FROM Faculty as f
JOIN Person as d ON (f.deanId = d.id)
JOIN Person as v ON (f.viceDeanId = v.id)
ORDER BY f.Name

// Andmete sisestus vol2

INSERT INTO Course VALUES (101,9,'Sissejuhatusinformaatikasse','MTAT.05.074',3,'Arvestus')

INSERT INTO registration
(CourseId,PersonId,FinalGrade)
SELECT 101, p.id, NULL
FROM Course as c
JOIN Registration as r ON (c.Id = r.CourseId)
JOIN Person as p ON (r.PersonId = p.Id)
WHERE c.Name = 'Sissejuhatus
ettevõttemajandusse'


// Vaadete loomine (ise)
create view v_persons_atleast_4eap (FirstName, LastName) as
select distinct FirstName, LastName from person, course, faculty, registration 
where Person.FacultyId = faculty.id
and registration.courseid = course.id
and personid = person.id
and Course.FacultyId = faculty.id 
and faculty.name = 'Matemaatika-informaatikateaduskond'
and course.eap > 3
