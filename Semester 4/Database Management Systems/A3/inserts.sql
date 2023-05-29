CREATE OR ALTER PROCEDURE addRowMovies @title varchar(100), @cast_members varchar(100) AS
BEGIN
	SET NOCOUNT ON
	DECLARE @maxId INT
	SET @maxId = 1
	SELECT TOP 1 @maxId = id + 1 FROM Movies ORDER BY id DESC
	DECLARE @error VARCHAR(max)
	SET @error = ''
	IF(@title IS NULL)
	BEGIN
		SET @error = 'Movie title must be non null'
		RAISERROR('Movie title must be non null', 16, 1);
	END
	IF(@cast_members IS NULL)
	BEGIN
		SET @error = 'Cast members must be non null'
		RAISERROR('Cast members be non null', 16, 1);
	END
	INSERT INTO Movies(id, title, cast_members)
	VALUES (@maxId, @title, @cast_members)
	EXEC sp_log_changes '', @title, 'Add row to movies', @error
END

GO
CREATE OR ALTER PROCEDURE addRowGenres @genre_type varchar(100) AS
BEGIN
	SET NOCOUNT ON
	DECLARE @maxId INT
	SET @maxId = 1
	SELECT TOP 1 @maxId = id + 1 FROM Genres ORDER BY id DESC
	DECLARE @error VARCHAR(max)
	SET @error = ''
	IF(@genre_type IS NULL)
	BEGIN
		SET @error = 'Genre type must be non null'
		RAISERROR('Genre type must be non null', 16, 1);
	END
	INSERT INTO Genres(id, genre_type) 
	VALUES (@maxId, @genre_type)
	EXEC sp_log_changes '', @genre_type, 'Add row to genres', @error
END


GO
CREATE OR ALTER PROCEDURE addRowMoviesGenres @MovieTitle VARCHAR(100),@GenreType VARCHAR(100) AS
BEGIN
	SET NOCOUNT ON
	DECLARE @error VARCHAR(max)
	SET @error = ''
	IF(@MovieTitle IS NULL)
	BEGIN
		SET @error = 'Movie title must be non null'
		RAISERROR(@error, 16, 1);
	END
	IF(@GenreType IS NULL)
	BEGIN
		SET @error = 'Genre type must be non null'
		RAISERROR(@error, 16, 1);
	END
	DECLARE @movieId INT
	SET @movieId = (SELECT id FROM Movies WHERE title = @MovieTitle)
	DECLARE @genreId INT
	SET @genreId = (SELECT id FROM Genres WHERE genre_type = @GenreType)
	IF(@movieId IS NULL)
	BEGIN
		SET @error = 'No movie with the given title'
		RAISERROR(@error, 16, 1);
	END
	IF(@genreId IS NULL)
	BEGIN
		SET @error = 'No genre with the given type'
		RAISERROR(@error, 16, 1);
	END
	INSERT INTO MoviesGenres VALUES (@movieId, @genreId)
	DECLARE @newData VARCHAR(350)
	SET @newData = @MovieTitle + ' ' + @GenreType
	EXEC sp_log_changes '', @newData, 'Connect movie to genre', @error
END


EXEC addRowMovies 'The Gray Man','Ryan Gosling'
EXEC addRowGenres 'Action'
EXEC addRowMoviesGenres 'The Gray Man', 'Action'



SELECT * FROM Movies
SELECT * FROM Genres
SELECT * FROM MoviesGenres
SELECT * FROM LogChanges

DELETE FROM MoviesGenres
DELETE FROM Movies
DELETE FROM Genres
DELETE FROM LogChanges



GO
CREATE OR ALTER PROCEDURE successfulAddRollback AS
BEGIN
	BEGIN TRAN
	BEGIN TRY 
		EXEC addRowMovies 'The Gray Man','Ryan Gosling'
		EXEC addRowGenres 'Action'
		EXEC addRowMoviesGenres 'The Gray Man', 'Action'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		EXEC sp_log_changes '', '', 'rolledback all data', ''
		RETURN
	END CATCH
	COMMIT TRAN
END


GO 
CREATE OR ALTER PROCEDURE failAddRollback AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		EXEC addRowMovies 'The Gray Man','Ryan Gosling'
		EXEC addRowGenres 'Action'
		EXEC addRowMoviesGenres 'The Gray', 'Action'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		EXEC sp_log_changes '', '', 'rolledback all data', ''
		RETURN
	END CATCH
	COMMIT TRAN
END


EXEC successfulAddRollback
EXEC failAddRollback

SELECT * FROM Movies
SELECT * FROM Genres
SELECT * FROM MoviesGenres
SELECT * FROM LogChanges

DELETE FROM MoviesGenres
DELETE FROM Movies
DELETE FROM Genres
DELETE FROM LogChanges