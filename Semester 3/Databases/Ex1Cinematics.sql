---1. You must create a database that manages cinematics from different games. The purpose of the database is to
---contain all the information about the cinematics of all games and some details about the heroes that appear in cinematics.
--	A) The entities of interest for the problem domani are: Heroes, Cinematics, Games and Companies.
--	B) Each game has a name, a release date and belongs to a company. The company has a name, a description and a website.
--	C) Each cinematic has a name, an associated game and a list of heroes with an entry moment for each hero.
--The entry moment is represented as an hour/minute/second pair (ex: a hero appears at 00:02:33). Every hero
	--has a name, a description and an importance.

--1) Write a SQL script to create a relational data model in order to represent the required data. (4 points)

CREATE TABLE Company(
	idC INT PRIMARY KEY,
	name VARCHAR(100),
	description VARCHAR(150),
	website VARCHAR(100)
)
CREATE TABLE Game(
	idG INT PRIMARY KEY,
	name VARCHAR(100),
	release_date DATE,
	idC INT REFERENCES Company(idC)
	)

CREATE TABLE Hero(
	idH INT PRIMARY KEY,
	name VARCHAR(100),
	description VARCHAR(150),
	importance VARCHAR(100)
)

CREATE TABLE Cinematics(
	idCin INT PRIMARY KEY,
	name VARCHAR(100),
	idG INT REFERENCES Game(idG),
)

CREATE TABLE CinematicsHeroes(
	idCin INT REFERENCES Cinematics(idCin),
	idH INT REFERENCES Hero(idH),
	PRIMARY KEY(idCin,idH),
	entry_moment Time
)

INSERT INTO Company(idC,name,description,website) VALUES (1,'Company1','very good','www.company1.com'),(2,'Company2','bad','www.company2.com'),(3,'Company3','ok','www.company3.com')
INSERT INTO Game(idG,name,release_date,idC) VALUES (1,'Game1','2020-06-19T00:00:00',1),(2,'Game2','2022-02-06T00:34:09',2),(3,'Game3','2019-09-10T00:00:00',1)
INSERT INTO Hero(idH,name,description,importance) VALUES (1,'Hero1','very good','main'),(2,'Hero2','not so good','second')
INSERT INTO Cinematics(idCin, name,idG) VALUES (1,'Cinematics1',2),(2,'Cinematics2',1),(3,'Cinematics3',2)
INSERT INTO Cinematics VALUES (4,'Cinematics4',5)
INSERT INTO CinematicsHeroes(idCin,idH,entry_moment) VALUES (1,1,'2:00am'),(1,2,'1:20am'),(2,2,'1:00am')
INSERT INTO Game VALUES (4,'Game4','2020-12-02',2)
INSERT INTO Game VALUES (5,'Game5','2001-12-02',3)
SELECT * FROM Company
SELECT * FROM Game
SELECT * FROM Hero
SELECT * FROM Cinematics
SELECT * FROM CinematicsHeroes

---2) Create a store procedure that receives a hero, a cinematic, and an entry moment and adds the new cinematic to
---the hero. If the cinematic already exists, the entry moment is updated. (2 points)
GO
CREATE OR ALTER PROCEDURE addCinematicIfNotExists(@heroName VARCHAR(100),@cinematicName VARCHAR(100),@entry_mom Time) 
AS
BEGIN
	DECLARE @heroId INT=(SELECT idH FROM Hero WHERE name=@heroName)
	DECLARE @cinematicId INT =(SELECT idCin FROM Cinematics WHERE name=@cinematicName)
	IF @heroId is not null and @cinematicId is not null
		IF EXISTS (SELECT * FROM CinematicsHeroes WHERE idCin=@cinematicId and idH=@heroId)
			UPDATE CinematicsHeroes
			SET entry_moment=@entry_mom
			WHERE @heroId=idH and @cinematicId=idCin
		ELSE 
			INSERT INTO CinematicsHeroes VALUES (@cinematicId,@heroId,@entry_mom)
	ELSE
		raiserror('Hero or Cinematic does not exist',12,1)
END

EXEC addCinematicIfNotExists @heroName='Hero1',@cinematicName='Cinematics1',@entry_mom='5:00am'
SELECT * FROM  Cinematics
SELECT * FROM CinematicsHeroes
EXEC addCinematicIfNotExists @heroName='Hero2',@cinematicName='Cinematics1',@entry_mom='1:20am'
EXEC addCinematicIfNotExists @heroName='Hero3',@cinematicName='Cinematics1',@entry_mom='5:00am'
EXEC addCinematicIfNotExists @heroName='Hero1',@cinematicName='Cinematics3',@entry_mom='7:00pm'

---3) Create a view that shows the name and the importance of all heroes that appear in all cinematics. (1 point)

GO
CREATE OR ALTER VIEW showHeroesFromAllCinematics AS
	SELECT H.name,H.importance
	FROM Hero H
	WHERE H.idH IN (
		SELECT CS.idH
		FROM CinematicsHeroes CS
		GROUP BY CS.idH
		HAVING COUNT(*) = (SELECT COUNT(*) FROM Cinematics)
	)

SELECT * FROM showHeroesFromAllCinematics 



----4) Create a function that lists the name of the company, the name of the game and the title of the cinematic for all 
---games that have the release date greater than or equal to '2000-12-02' and less than or equal to '2016-01-01'. (2 points)

CREATE OR ALTER FUNCTION getDataForGreaterOrEqualThanGiven()
RETURNS TABLE AS
RETURN 
	SELECT DISTINCT C.name as CompaniesName, G.name as GameName, CG.name as CinematicName, G.release_date
	from Game G
	inner join Company C on G.idC = C.idC
	inner join Cinematics CG on CG.idG = G.idG
	where G.release_date >= '2000-12-02' and G.release_date <= '2016-01-01'
	
SELECT * FROM getDataForGreaterOrEqualThanGiven()
SELECT * FROM Game WHERE release_date>= '2000-12-02' and release_date <= '2016-01-01'
SELECT * FROM Game
SELECT * FROM Company
SELECT * FROM Cinematics
SELECT DISTINCT C.name , G.name, CG.name , G.release_date from Game G, Cinematics CG,Company C
	where G.release_date >= '2000-12-02' and G.release_date <= '2016-01-01'