use practic;

CREATE TABLE Artists(
	idA INT PRIMARY KEY,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	debut_date DATE
)

CREATE TABLE Songs(
	idS INT PRIMARY KEY,
	title VARCHAR(150),
	duration INT,
	genre VARCHAR(150),
	idA INT REFERENCES Artists(idA)
)

CREATE TABLE Users(
	idU INT PRIMARY KEY,
	email_address VARCHAR(150) UNIQUE,
	username VARCHAR(150) UNIQUE,
	birth_date DATE,

)
CREATE TABLE Playlists(
	idP INT PRIMARY KEY,
	name VARCHAR(150),
	date_creation DATE,
	time_creation TIME,
	idU INT REFERENCES Users(idU)
)

CREATE TABLE PlaylistSongs(
	idP INT REFERENCES Playlists(idP),
	idS int REFERENCES Songs(idS),
)

CREATE TABLE PlayLogs(
	idU INT REFERENCES Users(idU),
	idS INT REFERENCES Songs(idS),
	time_played TIME
)

INSERT INTO Artists VALUES(1,'F1','L1','2022-06-05'),(2,'F2','L2','2021-05-08'),(3,'F3','L3','2009-09-10')
INSERT INTO Songs VALUES (1,'S1',120,'Pop',2),(2,'S2',115,'Rock',2)
INSERT INTO Users VALUES (1,'A.com','a','2002-10-09'),(2,'B.com','b','2001-08-09')
INSERT INTO Playlists VALUES (1,'P1','2022-06-04','12:00',1),(2,'P2','2023-01-02','11:00',2)
INSERT INTO PlaylistSongs VALUES (1,2),(1,1),(2,1)
INSERT INTO PlayLogs VALUES (1,2,'11:00'),(2,1,'13:00')

SELECT * FROM Artists
SELECT * FROM Songs
SELECT * FROM Users
SELECT * FROM Playlists
SELECT * FROM PlaylistSongs
SELECT * FROM PlayLogs

---2 
GO
CREATE OR ALTER PROCEDURE addPlayLog(@userName VARCHAR(150), @songName VARCHAR(150)) AS
BEGIN
	DECLARE @songId INT =(SELECT idS FROM Songs WHERE title=@songName)
	IF @songId IS NOT NULL
	BEGIN
	DECLARE @userId INT=(SELECT idU FROM Users WHERE username=@userName)
	IF @userId IS NOT NULL
		BEGIN
		DECLARE @current_time TIME= (SELECT CONVERT(VARCHAR(8), GETDATE(), 108))
		INSERT INTO PlayLogs VALUES (@userId,@songId,@current_time)
		END
	ELSE
		raiserror('The user does not exist',16,2)
	END
	ELSE
		raiserror('The song does not exist',16,1)
END

SELECT * FROM Songs 
SELECT * FROM Users
SELECT * FROM PlayLogs
EXEC addPlayLog 'a',S1

--3
GO
CREATE OR ALTER VIEW topListened AS
	SELECT TOP 3  PLog.idS,count(*) as Times
	FROM PlayLogs PLog
	Group BY idS

SELECT * FROM topListened 
SELECT * FROM PlayLogs
----4 
GO
CREATE OR ALTER FUNCTION getPlaylists(@songsNr INT, @genre VARCHAR(150))
RETURNS TABLE AS
RETURN
	SELECT COUNT(*)
	FROM PlaylistSongs 
	WHERE idP IN (SELECT idP FROM PlaylistSongs GROUP BY idP HAVING COUNT(*)>= @songsNr AND idS IN (SELECT SNG.idS FROM Songs SNG WHERE genre=@genre))

SELECT * FROM getPlaylists(1,'Pop')


	