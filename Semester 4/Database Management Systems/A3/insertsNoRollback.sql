CREATE OR ALTER PROCEDURE addRowMovieRecover  @title varchar(100), @cast_members varchar(100) AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
	BEGIN TRY
		DECLARE @maxId INT
		SET @maxId = 1
		SELECT TOP 1 @maxId = id + 1 FROM Movies ORDER BY id DESC
		DECLARE @error VARCHAR(max)
		SET @error = ''
		IF(@title IS NULL)
		BEGIN
			SET @error = 'Movie title must be non null'
			RAISERROR('Movies title must be non null', 16, 1);
		END
		IF(@cast_members IS NULL)
		BEGIN
			SET @error = 'Movie cast members must be non null'
			RAISERROR('Movie cast members must be non null', 16, 1);
		END
		INSERT INTO Movies(id, title, cast_members)
		VALUES (@maxId, @title, @cast_members)
		EXEC sp_log_changes '', @title, 'Add row to movies', @error
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		EXEC sp_log_changes '', '', 'rolledback movie data', ''
	END CATCH
END

GO
CREATE OR ALTER PROCEDURE addRowGenreRecover @genre_type varchar(100) AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
	BEGIN TRY
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
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		EXEC sp_log_changes '', '', 'rolledback genre data', ''
	END CATCH
END



GO
CREATE OR ALTER PROCEDURE addRowMoviesGenresRecover @MovieTitle VARCHAR(100),@GenreType VARCHAR(100) AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRAN
	BEGIN TRY
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
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		EXEC sp_log_changes '', '', 'rolledback movie in genre data', ''
	END CATCH
END

GO
CREATE OR ALTER PROCEDURE successfulAddNoRollback AS
BEGIN
	DECLARE @CONTOR INT
	SET @CONTOR=0
	BEGIN TRY
		EXEC addRowMovieRecover 'The Gray Man','Ryan Gosling'
	END TRY
	BEGIN CATCH
		SET @CONTOR=@CONTOR+1
	END CATCH

	BEGIN TRY
		EXEC addRowGenreRecover 'Action'
	END TRY
	BEGIN CATCH
		SET @CONTOR=@CONTOR+1
	END CATCH

	IF (@CONTOR=0) BEGIN
		BEGIN TRY
			EXEC addRowMoviesGenresRecover 'The Gray Man', 'Action'
		END TRY
		BEGIN CATCH
		END CATCH
	END

END

GO 
CREATE OR ALTER PROCEDURE failAddNoRollback AS
BEGIN

	DECLARE @CONTOR INT
	SET @CONTOR=0
	BEGIN TRY
		EXEC addRowMovieRecover 'The Gray Man','Ryan Gosling'
	END TRY
	BEGIN CATCH
		SET @CONTOR=@CONTOR+1
	END CATCH

	BEGIN TRY
		EXEC addRowGenreRecover 'Action'
	END TRY
	BEGIN CATCH
		SET @CONTOR=@CONTOR+1
	END CATCH

	IF (@CONTOR=0) BEGIN
		BEGIN TRY
			EXEC addRowMoviesGenresRecover 'The Gray', 'Action'
		END TRY
		BEGIN CATCH
		END CATCH
	END
	
END


EXEC successfulAddNoRollback
EXEC failAddNoRollback

SELECT * FROM Movies
SELECT * FROM Genres
SELECT * FROM MoviesGenres
SELECT * FROM LogChanges

DELETE FROM MoviesGenres
DELETE FROM Movies
DELETE FROM Genres
DELETE FROM LogChanges

