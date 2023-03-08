USE Lab5
DROP TABLE Tc
DROP TABLE Tb
DROP TABLE Ta

--Create the tables--
CREATE TABLE Ta(
	aid INT PRIMARY KEY,
	a2 INT UNIQUE,
	a3 INT
);
DELETE FROM Ta

CREATE TABLE Tb(
	bid INT PRIMARY KEY,
	b2 INT
);

CREATE	TABLE Tc(
	cid INT PRIMARY KEY,
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
);
---Insert data into Ta---
GO
CREATE OR ALTER PROCEDURE insertDataIntoTa(@rows INT) AS
BEGIN
	DECLARE @max INT
	SET @max=@rows*2+100
	WHILE @rows>0
	BEGIN
		INSERT INTO Ta 
		VALUES (@rows,@max,@max%210)
		SET @rows=@rows-1
		SET @max=@max-2
	END
END

---Insert data into Tb---
GO
CREATE OR ALTER PROCEDURE insertDataIntoTb(@rows INT)AS
BEGIN
	WHILE @rows>0
	BEGIN
		INSERT INTO Tb
		VALUES(@rows,@rows%542)
		SET @rows=@rows-1
	END
END

---Insert data into Tc---
GO
CREATE OR ALTER PROCEDURE insertDataIntoTc(@rows INT)AS
BEGIN
	DECLARE @aid INT
	DECLARE @bid INT
	WHILE @rows>0
	BEGIN
		SET @aid=(SELECT TOP 1 aid FROM Ta ORDER BY NEWID())
		SET @bid=(SELECT TOP 1 bid FROM Tb ORDER BY NEWID())
		INSERT INTO Tc 
		VALUES(@rows,@aid,@bid)
		SET @rows=@rows-1
	END
END

---Inserting the data---
EXEC insertDataIntoTa 5000
EXEC insertDataIntoTb 7500
EXEC insertDataIntoTc 3000

SELECT * FROM Ta
SELECT * FROM Tb
SELECT * FROM Tc

--clustered index created for column aid in Ta
--nonclustered index created for column a2 from Ta
EXEC sp_helpindex 'Ta'
GO

--clustered index created for column bid in Tb
--clustered index created for column cid from Tc
EXEC sp_helpindex 'Tb'
GO

EXEC sp_helpindex 'Tc'
GO

--- a. Write queries on Ta such that their execution plans contain the following operators: ---
---clustered index scan - scans the whole table;
SELECT * FROM Ta

---clustered index seek - gets a specific subset of rows;
SELECT * FROM Ta
WHERE aid<140

---nonclustered index scan - scan the entire nonclustered index;
SELECT a2 FROM Ta
ORDER BY a2

---nonclustered index seek - gets a specific subset;
SELECT a2 FROM Ta
WHERE a2 BETWEEN 100 AND 115

---key lookup - nonclustered index seek + key lookup
SELECT a3,a2 FROM Ta
WHERE a2=254

---b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. Create a nonclustered index that can speed up the query. Examine the execution plan again.
SELECT * FROM Tb
WHERE b2=255
--- Before creating a nonclustered index we have a clustered index scan with the cost: 0.0226431
DROP INDEX Tb_b2_index ON Tb
CREATE NONCLUSTERED INDEX Tb_b2_index ON Tb(b2)
--- After creating the nonclustered index on b2, we have a noclustered index seek with the cost: 0.0032974

---c. Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.
GO
CREATE OR ALTER VIEW VIEW1 AS
	SELECT A.aid, B.bid,C.cid
	FROM Tc C
	INNER JOIN Ta A ON A.aid=C.aid
	INNER JOIN Tb B ON B.bid=C.bid
	WHERE B.b2>350 AND A.a3<110
GO
SELECT * FROM VIEW1


-- With existing indexes(the automatically created ones + nonclustered index on b2): 0.170761
-- When adding a nonclustered index on a3 to the existing indexes: 0.159795
-- Without the nonclustered index on b2 and the nonclustered index on a3: 0.187913
-- Automatically created indexes + nonclustered index on b2 + nonclustered index on a3 + nonclustered index on (aid, bid) from Tc: 0.159054

DROP INDEX Ta_a3_index ON Ta
CREATE NONCLUSTERED INDEX Ta_a3_index ON Ta(a3)

DROP INDEX Tc_index ON Tc
CREATE NONCLUSTERED INDEX Tc_index ON Tc(aid, bid)