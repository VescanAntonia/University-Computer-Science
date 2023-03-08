use PracticExSem6;

---TrainTypes -idTT,name,description
---Trains - idT,name,idTT from TrainTypes
---Routes - idR,name,idT from Trains
---Stations - idS,name(unique)
---RoutesStations - idR from Routes, idS from Stations,arrivalTime,departureTime
IF OBJECT_ID('RoutesStations','U') is NOT NULL
	DROP TABLE RoutesStations
IF OBJECT_ID('Stations','U') is NOT NULL
	DROP TABLE Stations
IF OBJECT_ID('Trains','U') is NOT NULL
	DROP TABLE Trains
IF OBJECT_ID('TrainTypes','U') is NOT NULL
	DROP TABLE TrainTypes
IF OBJECT_ID('Routes','U') is NOT NULL
	DROP TABLE Routes

CREATE TABLE TrainTypes(
	idTT INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(100),
	description VARCHAR(200),
)

CREATE TABLE Trains(
	idT INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(100),
	idTT INT REFERENCES TrainTypes(idTT)
)

CREATE TABLE Routes(
	idR INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(100) UNIQUE,
	idT INT REFERENCES Trains(idT)
)

CREATE TABLE Stations(
	idS INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(100) UNIQUE
)

CREATE TABLE RoutesStations(
	idR INT REFERENCES Routes(idR),
	idS INT REFERENCES Stations(idS),
	arrivalTime Time,
	departureTime Time,
)

INSERT INTO TrainTypes(name,description)VALUES ('type1','desc1'),('type2','desc2')
INSERT INTO Trains(name,idTT) VALUES ('train1',1),('train2',2),('train3',3)
INSERT INTO Routes(name,idT) VALUES ('r1',7),('r2',8),('r3',9)
INSERT INTO Stations(name) VALUES ('s1'),('s2'),('s3')
INSERT INTO RoutesStations(idR,idS,arrivalTime,departureTime) VALUES 
(6,1,'9:00am','9:10am'),
(6,2,'9:15am','9:30am'),
(6,3,'10:00am','10:10am'),
(7,1,'9:00pm','9:10pm'),
(7,3,'5:00am','5:20am'),
(8,2,'7:00pm','7:10pm')

SELECT * FROM Trains
SELECT * FROM Stations
SELECT * FROM TrainTypes
SELECT * FROM Routes
SELECT * FROM RoutesStations

---2.store procedure
GO
CREATE PROCEDURE uspUpdateAddStationOnRoute(@RouteName VARCHAR(100),
	@StationName VARCHAR(100),@arrival TIME,@departure TIME)
AS
BEGIN
	declare @idStation INT=(select idS from Stations WHERE name=@StationName)
	declare @idRoute INT=(SELECT idR FROM Routes WHERE name=@RouteName)
END

