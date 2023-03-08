use Exemplu3var2;

----Courses, Instructors,Topics,Lectures,Resouces
---3:40
IF OBJECT_ID('Instructors','U') is NOT NULL
	DROP TABLE Instructors
IF OBJECT_ID('Topics','U') is NOT NULL
	DROP TABLE Topics
IF OBJECT_ID('Courses','U') is NOT NULL
	DROP TABLE Courses
IF OBJECT_ID('Resources','U') is NOT NULL
	DROP TABLE Resources
IF OBJECT_ID('Lectures','U') is NOT NULL
	DROP TABLE Lectures

CREATE TABLE Instructors(
	last_name VARCHAR(150),
	first_name VARCHAR(150),
	experience INT,
	PRIMARY KEY (last_name,first_name)
)

CREATE TABLE Topics(
	idT INT PRIMARY KEY,
	name VARCHAR(150),

)

CREATE TABLE Courses(
	idC INT PRIMARY KEY,
	title VARCHAR(150),
	language VARCHAR(150),
	price INT,
	discount INT,
	number_of_lectures INT,
	first_name VARCHAR(150),
	last_name varchar(150),
	FOREIGN KEY (first_name,last_name) REFERENCES Instructors,
	CONSTRAINT checkDiscount CHECK (discount >= 0)
)


CREATE TABLE Resources(
	idR INT PRIMARY KEY,
	url_res VARCHAR(150)
)

CREATE TABLE Lectures(
	idL INT PRIMARY KEY,
	title VARCHAR(150),
	idR INT REFERENCES Resources(idR),
	idC INT REFERENCES Courses(idC)
)


CREATE TABLE CoursesTopics(
	idC INT REFERENCES Courses(idC),
	idT INT REFERENCES Topics(idT)
)

INSERT INTO Instructors VALUES ('Mary','A',5),('Antonia','Vsc',6),('Elena','Pop',7),('Adam','H',2)
INSERT INTO Instructors VALUES ('A','Mary',5)
INSERT INTO Topics VALUES (1,'Deep Learning'),(2,'Java'),(4,'Python'),(5,'AI')
INSERT INTO Courses VALUES (1,'Learning deep learning','English',500,100,14,'Antonia','Vsc'),(2,'Learning AI','French',450,0,15,'Elena','Pop'),(3,'Learning Python','German',700,150,20,'Mary','A')
INSERT INTO Courses VALUES (4,'JJJJ','E',145,10,14,'Mary','A')
INSERT INTO Courses VALUES (3,'Learning Python','German',700,150,20,'Mary','A')
INSERT INTO Resources VALUES (1,'wwwsdd'),(2,'asdeaf'),(3,'efea')
INSERT INTO Lectures values (1,'First',1,1),(2,'First',2,2),(3,'Second',2,2)
INSERT INTO CoursesTopics VALUES (1,1),(1,2),(2,2),(3,4)
INSERT INTO CoursesTopics VALUES (3,1),(4,1)



SELECT * FROM Instructors
SELECT * FROM Topics 
SELECT * FROM Courses
SELECT * FROM Resources
SELECT * FROM Lectures
SELECT * FROM CoursesTopics

----2
GO
CREATE OR ALTER PROCEDURE deleteCourses(@first VARCHAR(150),@last VARCHAR(150)) AS
BEGIN
	DECLARE @experience INT=(SELECT experience FROM Instructors WHERE first_name=@first AND last_name=@last)
	IF @experience IS NOT NULL
		BEGIN
		DECLARE @Rows INT= (SELECT COUNT(*) FROM Instructors)
		WHILE @Rows>0
		BEGIN
			DECLARE @id INT =(SELECT TOP 1 idC FROM Courses where first_name=@first and last_name=@last)
			DECLARE @Rows2 INT= (SELECT COUNT(*) FROM CoursesTopics)
			WHILE @Rows2>0
			BEGIN
				DELETE FROM CoursesTopics
				WHERE idC=@id
				SET @Rows2=@Rows2-1
			END

			DELETE FROM Courses
			WHERE first_name=@first and last_name=@last
			SET @Rows=@Rows-1
		END
		END
	ELSE 
		raiserror('The instructor does not exist',16,1)
END

SELECT * FROM Courses
SELECT * FROM CoursesTopics
EXEC deleteCourses 'Mary','A' 

----3

GO
CREATE VIEW showInstructors
AS
	SELECT C.first_name, C.last_name
	FROM Courses C
	WHERE first_name IN (SELECT first_name FROM Courses WHERE (idT) Group by topic having count(*)>3)