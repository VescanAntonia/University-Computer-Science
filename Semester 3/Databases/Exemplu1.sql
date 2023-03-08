use exemplu1;

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

CREATE TABLE Airplanes(
	idA INT PRIMARY KEY,
	model_nr INT,
	registration_nr INT UNIQUE,
	capacity INT
)
CREATE TABLE Flights(
	idF INT PRIMARY KEY,
	flight_nr INT UNIQUE,
	departure_airport VARCHAR(150),
	destination_airport VARCHAR(150),
	departure_date_time DATETIME,
	arrival_date_time DATETIME,
	idA INT REFERENCES Airplanes(idA)
)

CREATE TABLE Passengers(
	idP INT PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	email_address VARCHAR(150) UNIQUE,

)

CREATE TABLE Payments(
	idPay INT PRIMARY KEY,
	amount INT,
	payment_date_time DATETIME,
	type VARCHAR(150)
)

CREATE TABLE Reservations(
	idR INT PRIMARY KEY,
	idP INT REFERENCES Passengers(idP),
	idF INT REFERENCES Flights(idF),
	idPay INT REFERENCES Payments(idPay)
)

INSERT INTO Airplanes(idA,model_nr,registration_nr,capacity) VALUES (1,1255,145,200),(2,13,125,250),(3,158,160,189)
INSERT INTO Flights(idF,flight_nr,departure_airport,destination_airport,departure_date_time,arrival_date_time,idA)VALUES(1,11,'Madrid','Liverpool','2020-06-19T02:00:00','2020-06-19T02:50:00',1),(2,12,'Bucharest','Madrid','2022-06-19T00:00:00','2022-06-19T02:00:00',2)
INSERT INTO Passengers VALUES (1,'Mary','Jane','mary@gmail.com'),(2,'Tom','Jim','tom@gmail.com')
INSERT INTO Payments VALUES (1,150,'2022-06-19T12:00:00','card'),(2,200,'2022-07-19T13:00:00','cash')
INSERT INTO Reservations VALUES (1,1,1,2),(2,2,1,null)
INSERT INTO Passengers VALUES (3,'Anto','Vescan','anto@gmail.com')
INSERT INTO Reservations VALUES (3,3,2,1)
DELETE FROM Reservations
SELECT * FROM Airplanes
SELECT * FROM Flights
SELECT * FROM Passengers
SELECT * FROM Payments
SELECT * FROM Reservations
----2
GO
CREATE OR ALTER PROCEDURE insertPayment(@amount INT, @payment_date_time DATETIME, @type VARCHAR(150), @id_reservation INT)
AS 
BEGIN
	IF @id_reservation IN (SELECT idR FROM Reservations)
	BEGIN
		DECLARE @payment_id INT = (SELECT idPay FROM Reservations WHERE @id_reservation=idR)
		IF @payment_id IS NULL
		BEGIN
			INSERT INTO Payments VALUES (3,@amount,@payment_date_time,@type)
			DECLARE @payment_id2 INT=(SELECT TOP 1 idPay 
						 FROM dbo.Payments
						 ORDER BY idPay DESC)
			UPDATE Reservations
			SET idPay=@payment_id2 WHERE idR=@id_reservation
		END
		ELSE 
			raiserror('Payment is already in reservations',16,1)
	END
	ELSE
		raiserror('The given id is not in the reservations.',16,2)
END

EXEC insertPayment 200,'2021-07-12T08:00:00','cash',1
SELECT * FROM Reservations
SELECT * FROM Payments

EXEC insertPayment 200,'2021-07-12T08:00:00','cash',2


----3 
GO
CREATE OR ALTER VIEW viewPassengers
AS
	SELECT P.first_name	
	FROM Passengers P
	WHERE P.idP IN (SELECT R.idP FROM Reservations R WHERE R.idF IN (SELECT F.idF FROM Flights F WHERE F.departure_airport='Madrid') )

SELECT * FROM viewPassengers

----4 valid(reservation if therre is a payment associated to it) during a period of time
GO
CREATE FUNCTION listFlights(@reservations_nr INT,@start DATETIME, @end DATETIME)
RETURNS TABLE AS
RETURN
	SELECT F.idF,F.flight_nr
	FROM Flights F
	WHERE F.idF IN (SELECT R.idF FROM Reservations R WHERE R.idPay IS NOT NULL GROUP BY R.idF HAVING COUNT(*)>@reservations_nr) AND F.arrival_date_time<=@end AND F.departure_date_time>=@start
	
SELECT * FROM listFlights(1,'2020-06-19T02:00:00','2020-06-19T02:50:00')