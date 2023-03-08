use exemplu8;

---Zoos,animals,food,visitors and visits

CREATE TABLE Zoos(
	idZ INT PRIMARY KEY,
	administractor VARCHAR(150),
	name VARCHAR(150),

)

CREATE TABLE Food(
	idF INT PRIMARY KEY,
	name VARCHAR(150)
)

CREATE TABLE Animals(
	idA INT PRIMARY KEY,
	name VARCHAR(150),
	birth_date DATE,
	idZ INT REFERENCES Zoos(idZ)
)

CREATE TABLE AnimalsFood(
	idA INT REFERENCES Animals(idA),
	idF INT REFERENCES Food(idF),
	quatity INT
)


CREATE TABLE Visitors(
	idV INT PRIMARY KEY,
	name VARCHAR(150),
	age INT
)

CREATE TABLE VisitorZoos(
	idVisit INT PRIMARY KEY,
	idV INT REFERENCES Visitors(idV),
	idZ INT REFERENCES Zoos(idZ),
	v_day VARCHAR(150),
	PRICE int,
)

INSERT INTO Zoos VALUES (1,'a1','z1'),(2,'a2','z2'),(3,'a3','z3')
INSERT INTO Food VALUES (1,'bananas'),(2,'apples'),(3,'lettuce')
INSERT INTO Animals VALUES (1,'Animal1','2021-06-07',1),(2,'Animal2','2000-07-08',3)
INSERT INTO Animals VALUES (3,'Animal3','2022-05-02',1)
INSERT INTO AnimalsFood VALUES (1,2,2),(1,3,1),(2,1,4),(2,3,1)
INSERT INTO Visitors VALUES (1,'V1',15),(2,'V2',20),(3,'V3',30)
INSERT INTO VisitorZoos VALUES (1,1,1,'monday',15),(2,2,1,'tuesday',50)
INSERT INTO VisitorZoos VALUES (3,1,2,'F',10),(4,3,3,'S',25)

---2 procedure that receives an animal and deletes all the data about the food qutaa for that animal
GO
CREATE OR ALTER PROCEDURE removeFood(@animalName VARCHAR(150)) AS
BEGIN
	DECLARE @idAnimal INT = (SELECT idA FROM Animals WHERE name=@animalName)
	IF @idAnimal IS NOT NULL
		BEGIN
			DECLARE @rows INT= (SELECT COUNT(*) FROM AnimalsFood)
			WHILE @rows>0
			BEGIN
			DELETE FROM AnimalsFood WHERE idA=@idAnimal
			SET @rows=@rows-1
			END

		END
	ELSE
		raiserror('The animal does not exist.',16,1)
END

EXEC removeFood 'AN1'
EXEC removeFood 'Animal1'
SELECT * FROM Animals
SELECT * FROM AnimalsFood

----3 view - shows the ids of the zoos with the smalles number of visits
SELECT * FROM VisitorZoos

GO
CREATE OR ALTER VIEW zoosMinVisits
AS
	SELECT Z.idZ
	FROM Zoos Z
	WHERE Z.idZ IN (SELECT idZ FROM VisitorZoos GROUP BY idZ HAVING COUNT(*)=(SELECT MIN(mini) FROM (SELECT COUNT(*) AS mini FROM VisitorZoos GROUP BY idZ)R) )

SELECT * FROM zoosMinVisits

----4 list the ids the ids of the visitors who went to the zoos that have at leat N animals N>=1
GO
CREATE OR ALTER FUNCTION getVisitors(@N INT)
RETURNS TABLE AS
RETURN
	SELECT VZ.idV
	FROM VisitorZoos VZ
	WHERE VZ.idZ IN (SELECT idZ FROM Animals GROUP BY idZ HAVING COUNT(*)>=@N)

SELECT * FROM getVisitors(2)

SELECT * FROM VisitorZoos
SELECT * FROM Animals