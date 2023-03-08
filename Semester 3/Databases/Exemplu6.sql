use exemplu6;

-----Movie,Actors,Companies,CinemaProductions, StageDirectors

CREATE TABLE Companies(
	idC INT PRIMARY KEY,
	name VARCHAR(150),

)

CREATE TABLE StageDirectors(
	idSD INT PRIMARY KEY,
	name VARCHAR(150),
	nr_awards INT
)


CREATE TABLE Movies(
	idM INT PRIMARY KEY,
	name VARCHAR(150),
	release_date DATE,
	idSD INT REFERENCES StageDirectors(idSD),
	idC INT REFERENCES Companies(idC)

)

CREATE TABLE CinemaProduction(
	idCinema INT PRIMARY KEY,
	title VARCHAR(150),
	idM INT REFERENCES Movies(idM)
)

CREATE TABLE Actors(
	idA INT PRIMARY KEY,
	name VARCHAR(150),
	ranking INT
)

CREATE TABLE CinematicActors(
	idA INT REFERENCES Actors(idA),
	idCinema INT REFERENCES CinemaProduction(idCinema),
	entry_moment TIME
)

INSERT INTO Companies VALUES (1,'C1'),(2,'C2'),(3,'C3')
INSERT INTO StageDirectors VALUES (1,'SD1',10),(2,'SD2',5),(3,'SD3',6)
INSERT INTO Movies VALUES(1,'M1','2022-06-07',2,1),(2,'M2','2022-05-13',1,3),(3,'M3','2023-01-05',3,2)
INSERT INTO CinemaProduction VALUES (1,'CP1',1),(2,'CP2',3),(3,'CP3',2)
INSERT INTO Actors VALUES (1,'A1',95),(2,'A2',89),(3,'A3',91)
INSERT INTO CinematicActors VALUES (1,2,'01:00'),(2,2,'01:31'),(3,1,'01:02')
INSERT INTO CinematicActors VALUES (1,1,'00:05'),(1,3,'00:10')
INSERT INTO CinemaProduction VALUES (4,'CP4',1)

SELECT * FROM Companies
SELECT * FROM StageDirectors
SELECT * FROM Movies
SELECT * FROM CinemaProduction
SELECT * FROM Actors
SELECT * FROM CinematicActors

-----2 procedure that recieves an actor an entry moment and a cinema production and adds the new actor to the cinema production

GO
CREATE OR ALTER PROCEDURE addActor(@actorName VARCHAR(150),@actorRanking INT, @entryMom TIME, @cinemaTitle VARCHAR(150)) AS
BEGIN
	DECLARE @cinemaId INT=(SELECT idCinema FROM CinemaProduction WHERE title=@cinemaTitle)
	IF @cinemaId IS NOT NULL
	BEGIN	
		DECLARE @actorId INT=(SELECT idA FROM Actors WHERE name=@actorName)
		IF @actorId IS NULL
		BEGIN
			DECLARE @currentId INT=(SELECT COUNT(*) FROM Actors)+1
			INSERT INTO Actors VALUES (@currentId,@actorName,@actorRanking)
			INSERT INTO CinematicActors VALUES (@currentId,@cinemaId,@entryMom)
		END
		ELSE 
			raiserror('The actor already exists',16,2)
	END
	ELSE 
		raiserror('The cinema production does not exist',16,1)
END

SELECT * FROM Actors
SELECT * FROM CinematicActors
EXEC addActor 'A1',95,'00:15','CINEMA'
EXEC addActor 'A4',95,'00:15','CP1'

----3 view that shows the name of the actors that appear in all cinema production
GO
CREATE OR ALTER VIEW showActors
AS
	SELECT A.name
	FROM Actors A
	WHERE A.idA IN (SELECT CA.idA FROM CinematicActors CA GROUP BY idA HAVING COUNT(*)>=(SELECT COUNT(*) FROM CinemaProduction))

SELECT * FROM showActors

-----4 function that return all movies that have the release date after 2018-01-01 and have at least p productions where p given parametere

GO
CREATE OR ALTER FUNCTION returnMovies(@productionsNr INT)
RETURNS TABLE AS
RETURN
	SELECT M.name,M.release_date
	FROM Movies M
	WHERE M.release_date>'2018-01-01' AND M.idM IN (SELECT CP.idM FROM CinemaProduction CP GROUP BY CP.idM HAVING COUNT(*)>=@productionsNr)

SELECT * FROM returnMovies(2) 

SELECT * FROM Movies
SELECT * FROM CinemaProduction