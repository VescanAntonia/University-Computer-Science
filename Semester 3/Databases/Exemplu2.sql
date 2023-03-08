use Exemplu2;

---users,externalAwards, internalCompetitions,Poems, Judges

CREATE TABLE Userr(
	idU INT PRIMARY KEY,
	name VARCHAR(150),
	pen_name VARCHAR(150) UNIQUE,
	year_of_birth INT,

)
----SET OF AWARDS

CREATE TABLE ExternalAwards(
	idAw INT PRIMARY KEY,
	name VARCHAR(150),
	idU INT REFERENCES Userr(idU)
)
CREATE TABLE InternalCompetitions(
	idC INT PRIMARY KEY,
	year_or INT,
	week_nr INT,
	UNIQUE (year_or,week_nr)
)
---STORE DATA ABOUT POEMS SUBMITTED BY USERS AND POINTS
CREATE TABLE Poems(
	idP INT PRIMARY KEY IDENTITY (1,1),
	title VARCHAR(150),
	text VARCHAR(500),
	idU INT REFERENCES Userr(idU),
	idC INT REFERENCES InternalCompetitions(idC),

)
---USER CAN SUBMIT SEVERAL POEMS TO SAME COMPETITION


CREATE TABLE Judges(
	idJ int primary key,
	name VARCHAR(150)
)

CREATE TABLE Evaluation(
	idP INT REFERENCES Poems(idP),
	idJ INT REFERENCES Judges(idJ),
	score INT,
	PRIMARY KEY (idP,idJ),

)

INSERT INTO Userr VALUES (1,'Anto','Vescan',2002),(2,'Maria','VS',2003),(3,'Anto','Vsc',2004)
INSERT INTO ExternalAwards VALUES (1,'a',1),(2,'b',1),(3,'c',2)
INSERT INTO InternalCompetitions VALUES (1,2022,1),(2,2022,4),(3,2022,5),(4,2022,6)
INSERT INTO Poems VALUES ('A','BBBB',1,2),('B','abdsb',1,1),('C','AADD',2,1),('D','ahdbha',2,3)
INSERT INTO Poems VALUES ('aa','aaad',1,1),('ajbjha','asb',2,1),('amama','ajaja',2,1),('aa','aaa',3,1),('sasa','aas',1,1),('makmlka','amama',1,1),('amkaoi','audd',2,1),('abhjs','maidi',2,1)
INSERT INTO Judges VALUES (1,'J1'),(2,'J2'),(3,'J3')
INSERT INTO Judges VALUES (4,'J1')
INSERT INTO Evaluation VALUES (2,1,8),(3,1,9),(2,2,10),(4,1,8)
INSERT INTO Evaluation VALUES (3,4,9)

SELECT * FROM Userr
SELECT * FROM ExternalAwards
SELECT * FROM InternalCompetitions
SELECT * FROM Poems
SELECT * FROM Judges
SELECT * FROM Evaluation

---2 DELETE ALL JUDGES GIVEN NAME AND THEIR EVALUATION FROM THE DATABASE
GO
CREATE OR ALTER PROCEDURE deleteJudgesAndEval(@judgeName VARCHAR(100)) AS
BEGIN
	DECLARE @judge_id INT = (SELECT TOP 1 idJ FROM Judges WHERE name=@judgeName)
	IF @judge_id IS NOT NULL
	BEGIN
		DECLARE @Rows INT= (SELECT COUNT(*) FROM Judges)
		WHILE @Rows>0
			BEGIN
			DECLARE @current_id INT = (SELECT TOP 1 idJ FROM Judges WHERE name=@judgeName)
			DELETE FROM Evaluation 
			WHERE idJ=@current_id
			DELETE FROM Judges
			WHERE idJ=@current_id
			SET @Rows=@Rows-1
			END
	END
	ELSE	
		raiserror('There is not judge with the given name',16,1)
END

EXEC deleteJudgesAndEval 'J1'

SELECT idJ FROM Judges WHERE name='J1'


---C show the competitions year and week nr with at least 10 submitted poems that satisfy consition C(if the poem recieved less than 5 points on each evaluation)
GO
CREATE OR ALTER VIEW listCompetitions
AS
	SELECT C.year_or,C.week_nr
	FROM InternalCompetitions C
	WHERE C.idC IN (SELECT idC FROM Poems GROUP BY idC HAVING COUNT(*)>=10  INTERSECT SELECT p.idC FROM Poems p WHERE p.idP NOT IN (SELECT E.idP FROM Evaluation E WHERE score>=5))

SELECT * FROM listCompetitions

---d) a function that lists the users(name and penname) with at least P submitted poems 
GO
CREATE FUNCTION listUsers(@nr_of_poems_submitted INT)
RETURNS TABLE AS
RETURN 
	SELECT name,pen_name
	FROM Userr
	WHERE idU IN (SELECT idU FROM Poems GROUP BY idU HAVING COUNT(*)>@nr_of_poems_submitted)

SELECT * FROM listUsers(2)
SELECT * FROM Userr
SELECT * FROM Poems