use exemplu4;

---shoes, shoe Models, Presentation Shops and women

CREATE TABLE PresentationShop(
	idP INT PRIMARY KEY,
	name VARCHAR(150),
	city VARCHAR(150),
)

CREATE TABLE Women(
	idW INT PRIMARY KEY,
	name VARCHAR(150),
	max_amount INT
)

CREATE TABLE ShoesModels(
	idM INT PRIMARY KEY,
	name VARCHAR(150),
	season VARCHAR(150)
)

CREATE TABLE Shoes(
	idS INT PRIMARY KEY,
	price INT,
	idM INT REFERENCES ShoesModels(idM)
)

CREATE TABLE ShoesWomen(
	idW INT REFERENCES Women(idW),
	idS INT REFERENCES Shoes(idS),
	number INT,
	amount INT
)

CREATE TABLE ShoesPresented(
	idS INT REFERENCES Shoes(idS),
	idP INT REFERENCES PresentationShop(idP),
	available INT
)

INSERT INTO PresentationShop VALUES (1,'Name1','City1'),(2,'Name2','City2'),(3,'Name3','City3')
INSERT INTO Women VALUES (1,'W1',1000),(2,'W2',2000),(3,'W3',500)
INSERT INTO ShoesModels VALUES (1,'M1','summer'),(2,'M2','winter'),(3,'M3','spring')
INSERT INTO Shoes VALUES (1,500,1),(2,250,3),(3,500,2)
INSERT INTO ShoesWomen VALUES (1,2,2,500),(2,1,1,500),(3,1,1,500)
INSERT INTO ShoesPresented VALUES (4,2,200),(1,1,100),(1,2,100),(1,3,110),(4,3,150),(3,1,100)

-----2 recieve a shoe a presentation shop and the nr of shoes and adds the shoe to the presentation shop
GO
CREATE OR ALTER PROCEDURE addShoeToPresentation(@shoe_price INT,@shoe_model VARCHAR(150),@presentationShopName VARCHAR(150), @available INT) AS
BEGIN
	DECLARE @shoe_id INT=(SELECT idS from Shoes WHERE price=@shoe_price and idM=@shoe_model)
	IF @shoe_id IS NULL
		begin
			DECLARE @shopId INT = (SELECT idP FROM PresentationShop WHERE name=@presentationShopName)
			IF @shopId IS NOT NULL
				BEGIN
					DECLARE @currentId INT=(SELECT COUNT(*) FROM Shoes)+1
					INSERT INTO Shoes VALUES (@currentId,@shoe_price,@shoe_model)

					INSERT INTO ShoesPresented VALUES (@currentId,@shopId,@available)
				END
			ELSE 
				raiserror('The shop does not exist',16,2)
		end
	ELSE 
		raiserror('The shoe already exists',16,1)
END

EXEC addShoeToPresentation 100,3,'Name1',155
SELECT * FROM Shoes
SELECT * FROM ShoesPresented

-----3 show the women that bought at leas 2 shows from a given shoe model
GO
CREATE OR ALTER VIEW showWomen
AS
	SELECT W.name
	FROM Women W
	WHERE W.idW IN (SELECT DISTINCT SW.idW from ShoesWomen SW WHERE SW.amount>=2  AND SW.idS IN (SELECT idS FROM Shoes where idM=3))

SELECT * FROM Women
SELECT * FROM Shoes
SELECT * FROM ShoesWomen

SELECT * FROM showWomen

-----4 function that lists the shoes that can be found in at least T presesntation shops where T>=1
CREATE OR ALTER FUNCTION showShoes(@T INT)
RETURNS TABLE AS
RETURN
	SELECT S.idS, S.idM,S.price
	FROM Shoes S
	WHERE idS IN (SELECT SP.idS FROM ShoesPresented SP GROUP BY idS HAVING COUNT(*)>=@T)


SELECT * FROM showShoes(3)

SELECT * FROM Shoes
SELECT * FROM ShoesPresented