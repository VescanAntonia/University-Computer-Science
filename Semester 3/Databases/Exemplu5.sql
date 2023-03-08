use Exemplu5;
---customers,bank accounts,cards,ATMs,transactions
---5:10

CREATE TABLE Customer(
	idC INT PRIMARY KEY,
	name VARCHAR(150),
	date_of_birth DATE,

)

CREATE TABLE BankAcc(
	idB INT PRIMARY KEY,
	codIban VARCHAR(150),
	current_balance INT,
	holder VARCHAR(150),

	idC INT REFERENCES Customer(idC)
)

CREATE TABLE Cards(
	idCard INT PRIMARY KEY,
	number INT,
	CVV INT,
	idB INT REFERENCES BankAcc(idB)
)

CREATE TABLE ATMs(
	idA INT PRIMARY KEY,
	address VARCHAR(150),

)

CREATE TABLE Transactions(
	idT INT PRIMARY KEY,
	idA INT REFERENCES ATMs(idA),
	money_sum INT ,
	idC INT REFERENCES Cards(idCard),
	time DATETIME
)

INSERT INTO Customer VALUES (1,'Maria','2000-07-08'),(2,'Antonia','2002-06-10'),(3,'Nicoleta','2001-05-02'),(4,'Luca','1999-07-12')
INSERT INTO BankAcc VALUES (1,'152S2SRO',1200,'BT',1),(2,'151d5f5e3s',10000,'BT',2),(3,'abhg455',1500,'BRD',3),(4,'s55ds5d32',1000,'BRD',2)
INSERT INTO Cards VALUES (1,12554,554,1),(2,14587,587,2),(3,85965,965,3)
INSERT INTO ATMs VALUES (1,'str a'),(2,'str b'),(3,'str b')
INSERT INTO Transactions VALUES (1,1,200,1,'2021-07-20T12:00:00'),(2,2,100,2,'2021-06-20T08:00:00'),(3,3,500,3,'2021-05-21T09:00:00'),(4,1,100,1,'2022-07-20T07:00:00')
INSERT INTO Transactions VALUES (5,1,100,2,'2021-06-20T08:00:00'),(6,3,10,2,'2021-06-20T05:00:00')
INSERT INTO Transactions VALUES (7,1,10,1,'2021-06-20T08:00:00')
INSERT INTO Transactions VALUES (8,2,1000,1,'2022-07-09T09:00:00'),(9,3,900,1,'2023-01-03T09:30:00'),(10,2,1900,2,'2021-07-09T08:00:00')


SELECT * FROM Customer
SELECT * FROM BankAcc
SELECT * FROM Cards
SELECT * FROM ATMs
SELECT * FROM Transactions

----2 delete all the transactions from a given card
GO
CREATE OR ALTER PROCEDURE deleteTransactions(@number INT, @cvv INT)
AS
BEGIN
	DECLARE @card_id int=(SELECT idCard FROM Cards WHERE number=@number and CVV=@cvv)
	IF @card_id IS NOT NULL
		BEGIN
		DECLARE @rows INT=(SELECT COUNT(*) FROM Transactions)
			WHILE @rows>0
			BEGIN
				DELETE FROM Transactions
				WHERE idC=@card_id
				SET @rows=@rows-1
			END
		END
	ELSE
		raiserror('The card does not exist',16,1)
END

EXEC deleteTransactions 12554,554
SELECT * FROM Transactions

-----3 shows the card nrs which were used in transactions in all the atms
go
create view showCardNrs
as
	SELECT C.number
	FROM Cards C
	WHERE C.idCard IN (SELECT idC FROM Transactions T GROUP BY idC HAVING COUNT(*)=(SELECT COUNT(*) FROM ATMs ))

SELECT * FROM showCardNrs

----4 list the cards nr and cvv that have the total transactions sum greater than 2000

CREATE FUNCTION getCards()
RETURNS TABLE AS
RETURN
	SELECT number,CVV
	FROM Cards
	WHERE idCard IN(SELECT idC FROM Transactions GROUP BY idC HAVING SUM(money_sum)>2000)

SELECT * FROM getCards()
SELECT * FROM Cards
SELECT * FROM Transactions
	