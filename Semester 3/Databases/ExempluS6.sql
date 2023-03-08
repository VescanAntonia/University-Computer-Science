use exempluSem6Practic;
---1. Write an SQL script that creates the corresponding relational data model.
CREATE TABLE Trains(
	idT INT PRIMARY KEY,
	name VARCHAR(100),
	idTT INT REFERENCES TrainTypes(idTT)
);

CREATE TABLE TrainTypes(
	idTT INT PRIMARY KEY,
	name VARCHAR(100),
	description VARCHAR(130)
);

CREATE TABLE Stations(
	idS INT PRIMARY KEY,
	name VARCHAR(100) UNIQUE,
)

CREATE TABLE Routes(
	idR INT PRIMARY KEY,
	name VARCHAR(100) UNIQUE,
	idT INT REFERENCES Trains(idT)
)

CREATE TABLE RoutesStations(
	idR INT REFERENCES Routes(idR),
	idS INT REFERENCES Stations(idS),
	PRIMARY KEY(idR,idS),
	departure_time Time,
	arrival_time Time
)


INSERT INTO TrainTypes(idTT,name,description)VALUES (1,'type1','desc1'),(2,'type2','desc2')
INSERT INTO Trains(idT,name,idTT) VALUES (1,'train1',1),(2,'train2',2),(3,'train3',1)
INSERT INTO Routes(idR,name,idT) VALUES (1,'r1',2),(2,'r2',1),(3,'r3',3)
INSERT INTO Stations(idS,name) VALUES (1,'s1'),(2,'s2'),(3,'s3')
INSERT INTO RoutesStations(idR,idS,departure_time,arrival_time) VALUES 
(1,1,'9:00am','9:10am'),
(2,2,'9:15am','9:30am'),
(3,3,'10:00am','10:10am'),
(2,1,'9:00pm','9:10pm'),
(2,3,'5:00am','5:20am'),
(3,2,'7:00pm','7:10pm')
DELETE FROM RoutesStations
SELECT * FROM Trains
SELECT * FROM Stations
SELECT * FROM TrainTypes
SELECT * FROM Routes
SELECT * FROM RoutesStations

---2. Implement a stored procedure that receives a route, a station, arrival and departure times, and adds the station
---to the route. If the station is already on the route, the departure and arrival times are updated.
GO
CREATE OR ALTER PROCEDURE addStationToRoute(@route VARCHAR(100), @station VARCHAR(100),@arrival Time,@departure Time) AS
BEGIN
	DECLARE @idRoute INT= (SELECT idR FROM Routes WHERE name=@route)
	DECLARE @idStation INT = (SELECT idS FROM Stations WHERE name=@station)
	IF @idRoute IS NOT NULL AND @idStation IS NOT NULL
		if not EXISTS (select * from RoutesStations WHERE idR = @idRoute AND idS = @idStation)
			INSERT INTO RoutesStations 
			VALUES (@idRoute,@idStation,@departure,@arrival)
		ELSE 
			UPDATE RoutesStations
			SET arrival_time=@arrival, departure_time=@departure
			WHERE idR=@idRoute and idS=@idStation
	ELSE
		raiserror('Station or route does not exist',12,1)

END

SELECT * FROM RoutesStations

exec addStationToRoute @route = 'r1', @station = 's1', @arrival = '4:00pm', @departure = '5:00pm'

exec addStationToRoute @route = 'r2', @station = 's2', @arrival = '4:00pm', @departure = '5:00pm'

exec addStationToRoute @route = 'r0', @station = 's2', @arrival = '4:00pm', @departure = '5:00pm'

---3. Create a view that shows the names of the routes that pass through all the stations.
GO
CREATE OR ALTER VIEW routePassesThroughtAllStations 
AS
	SELECT R.name
	FROM Routes R
	WHERE R.idR IN(
		SELECT idR
		FROM RoutesStations
		GROUP BY idR
		HAVING COUNT(*) = (SELECT COUNT(*) FROM Stations)
	)

SELECT R.name
FROM Routes R
WHERE NOT EXISTS(
	SELECT S.idS
	FROM Stations S
	EXCEPT 
	SELECT RS.idS
	FROM RoutesStations RS
	WHERE RS.idR=R.idR
)

SELECT * FROM routePassesThroughtAllStations
SELECT * FROM RoutesStations
SELECT * FROM Stations

--another way
GO
CREATE OR ALTER VIEW viewVar2
AS
	SELECT R.name
	FROM Routes R
	INNER JOIN RoutesStations RS
	ON R.idR=RS.idR 
	INNER JOIN Stations S
	ON RS.idS=S.idS
	GROUP BY R.idR,R.name
	HAVING COUNT(*)=(SELECT COUNT(*) FROM Stations)

SELECT * FROM viewVar2

---4. Implement a function that lists the names of the stations with more than R routes, where R is a function
---parameter.
CREATE FUNCTION detStationsWithMoreThanGivenRoutes(@routeNr INT) 
RETURNS TABLE AS
RETURN
	SELECT S.name
	FROM Stations S
	WHERE S.idS IN(
		SELECT RS.idS
		FROM RoutesStations RS
		GROUP BY RS.idS
		HAVING COUNT(*)> @routeNr
	)


SELECT * FROM detStationsWithMoreThanGivenRoutes(1)
SELECT * FROM RoutesStations
SELECT * FROM Stations