use exemplu7;

----entities: Cakes,Cake Types, Orders and Confectionery Chefs

CREATE TABLE ConfectioneryChefs(
	idC INT PRIMARY KEY,
	name VARCHAR(150),
	gender VARCHAR(150),
	date_of_birth DATE
)

CREATE TABLE CakeTypes(
	idT INT PRIMARY KEY,
	name VARCHAR(150),
	description VARCHAR(150),

)

CREATE TABLE Cakes(
	idCake INT PRIMARY KEY,
	name VARCHAR(150),
	shape VARCHAR(150),
	weight INT,
	price INT,
	idT INT REFERENCES CakeTypes(idT)
)

CREATE TABLE ChefsSpecialisations(
	idC INT REFERENCES ConfectioneryChefs(idC),
	idCake INT REFERENCES Cakes(idCake)
)

CREATE TABLE Orders(
	idO INT PRIMARY KEY,
	order_date DATE
)

CREATE TABLE OrderedCakes(
	idCake INT REFERENCES Cakes(idCake),
	idO INT REFERENCES Orders(idO),
	quantity INT
)

INSERT INTO ConfectioneryChefs VALUES (1,'Name1','F','2002-06-07'),(2,'Name2','M','1999-05-02'),(3,'Name3','F','1989-07-09')
INSERT INTO CakeTypes VALUES (1,'Type1','with cheese'),(2,'Type2','with chocolate'),(3,'Type3','Honey')
INSERT INTO Cakes VALUES (1,'Cheesecake','round',2,150,1),(2,'Diplomat','square',1,100,3),(3,'Brownies', 'round',3,300,2)
INSERT INTO ChefsSpecialisations VALUES (1,2),(1,3),(2,3),(3,1)
INSERT INTO Orders VALUES (1,'2023-09-02'),(2,'2022-03-02')
INSERT INTO OrderedCakes VALUES (1,1,2),(1,2,1),(2,1,1),(3,2,2)
INSERT INTO ChefsSpecialisations VALUES (1,1)

DELETE FROM OrderedCakes

SELECT * FROM ConfectioneryChefs
SELECT * FROM CakeTypes
SELECT * FROM Cakes
SELECT * FROM ChefsSpecialisations
SELECT * FROM Orders
SELECT * FROM OrderedCakes

------2 procedure with given idOrder,cake name and a positive nr P as the nr of ordered pieces and adds the cake to the order. If the cake is already in the order the nr of ordered pieces is set to P
GO
CREATE OR ALTER PROCEDURE addCakeToOrder(@orderId INT, @cakeName VARCHAR(150),@P INT)
AS
BEGIN
	IF @orderId IN (SELECT idO FROM Orders)
		BEGIN
			DECLARE @cakeId INT = (SELECT idCake FROM Cakes WHERE name=@cakeName)
			IF @cakeId IS NOT NULL
				BEGIN
				IF @cakeId IN (SELECT idCake FROM OrderedCakes WHERE idO=@orderId)
				BEGIN
					UPDATE OrderedCakes
					SET quantity=@P
					WHERE @orderId=idO AND idCake=@cakeId
				END
				ELSE 
				BEGIN
					INSERT INTO OrderedCakes
					VALUES(@cakeId,@orderId,@P)
				END
				END
			ELSE
				raiserror('The cake does not exist',16,2)
		END
	ELSE 
		raiserror('The order does not exist',16,1)
END

EXEC addCakeToOrder 7,'x',5
EXEC addCakeToOrder 1,'Mars',5
EXEC addCakeToOrder 1,'Cheesecake',5
EXEC addCakeToOrder 2,'Diplomat',3

SELECT * FROM OrderedCakes

----3 function, list the name of the chefsspecialized in the preparation of all cakes

GO
CREATE OR ALTER FUNCTION getChefs()
RETURNS TABLE AS
RETURN	
	SELECT CC.name
	FROM ConfectioneryChefs CC
	WHERE CC.idC IN (SELECT idC FROM ChefsSpecialisations GROUP BY idC HAVING COUNT(*)=(SELECT COUNT(*) FROM Cakes))

SELECT * FROM getChefs()

SELECT * FROM ConfectioneryChefs
SELECT * FROM Cakes
SELECT * FROM ChefsSpecialisations