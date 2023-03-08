use Netflix;
/* a. modify the type of a column; */

GO
CREATE OR ALTER PROCEDURE changeAccountsTaxDecimal
AS
	ALTER TABLE Accounts ALTER COLUMN tax DECIMAL(4,2) /*two digits before the decimal point and 2 after*/


GO
CREATE OR ALTER PROCEDURE changeAccountsTaxInteger
AS
	ALTER TABLE Accounts ALTER COLUMN tax INT
EXEC changeAccountsTaxInteger
SELECT * FROM Accounts

/*b. add / remove a column; */

GO
CREATE OR ALTER PROCEDURE addMinimumViewingAgeToMovie
AS
	ALTER TABLE Movies ADD minimum_viewing_age INT

GO
CREATE OR ALTER PROCEDURE removeMinimumViewingAgeToMovie
AS
	ALTER TABLE Movies DROP COLUMN minimum_viewing_age

SELECT * FROM Movies

/* c. add / remove a DEFAULT constraint; */

GO
CREATE OR ALTER PROCEDURE addDefaultDisplayLanguageToProfile
AS
	ALTER TABLE Profiles ADD CONSTRAINT default_display_language DEFAULT('English') FOR display_language

GO
CREATE OR ALTER PROCEDURE removeDefaultDisplayLanguageToProfile
AS
	ALTER TABLE Profiles DROP CONSTRAINT default_display_language

SELECT * FROM Profiles

EXEC removeDefaultDisplayLanguageToProfile
EXEC addDefaultDisplayLanguageToProfile

/* g. create / drop a table; */
GO
CREATE OR ALTER PROCEDURE addFeedback
AS
	CREATE TABLE Feedback(
		feedback_id INT,
		feedback_type VARCHAR(50),   /*like,love,dislike*/
		feedback_text VARCHAR(300),
		nr_of_likes INT,
		CONSTRAINT FEEDBAK_PRIMARY_KEY PRIMARY KEY(feedback_id),
		movie_id INT NOT NULL
	);

GO
CREATE OR ALTER PROCEDURE dropFeedback
AS
	DROP TABLE Feedback


/* d. add / remove a primary key;  */

GO 
CREATE OR ALTER PROCEDURE addFeedbackTypeAndTextPrimaryKeyToFeedback
AS
	ALTER TABLE Feedback
		DROP CONSTRAINT FEEDBACK_PRIMARY_KEY
	ALTER TABLE Feedback
		ADD CONSTRAINT FEEDBACK_PRIMARY_KEY PRIMARY KEY(feedback_type,feedback_text)

GO
CREATE OR ALTER PROCEDURE removeFeedbackTypeAndTextPrimaryKeyToFeedback
AS
	ALTER TABLE Feedback
		DROP CONSTRAINT FEEDBACK_PRIMARY_KEY
	ALTER TABLE Feedback
		ADD CONSTRAINT FEEDBACK_PRIMARY_KEY PRIMARY KEY(feedback_id)

/* e. add / remove a candidate key; */
GO
CREATE OR ALTER PROCEDURE addCandidateKeyNetflixParties
AS
	ALTER TABLE NetflixParties
		ADD CONSTRAINT NETFLIX_PARTIES_CANDIDATE_KEY UNIQUE(nr_of_participants,movie_to_watch)

GO
CREATE OR ALTER PROCEDURE removeCandidateKeyNetflixParties
AS
	ALTER TABLE NetflixParties
		DROP CONSTRAINT NETFLIX_PARTIES_CANDIDATE_KEY

/* f. add / remove a foreign key; */

GO
CREATE OR ALTER PROCEDURE newForeignKeyFeedback
AS
	ALTER TABLE Feedback
		ADD CONSTRAINT FEEDBACK_FOREIGN_KEY FOREIGN KEY(movie_id) REFERENCES Movies(id)

GO
CREATE OR ALTER PROCEDURE removeForeignKeyFeedback
AS
	ALTER TABLE Feedback
		DROP CONSTRAINT FEEDBACK_FOREIGN_KEY

/* Create a new table that holds the current version of the database schema */

CREATE TABLE currentVersionTable(
	version INT
)
SELECT * FROM currentVersionTable

INSERT INTO currentVersionTable
VALUES
		(1)  /* initial version */

CREATE TABLE proceduresTable(
		initial_version INT,
		final_version INT,
		procedure_name VARCHAR(300),
		PRIMARY KEY(initial_version,final_version)
)

INSERT INTO proceduresTable
VALUES
	(1,2,'changeAccountsTaxDecimal'),
	(2,1,'changeAccountsTaxInteger'),
	(2,3,'addMinimumViewingAgeToMovie'),
	(3,2,'removeMinimumViewingAgeToMovie'),
	(3,4,'addDefaultDisplayLanguageToProfile'),
	(4,3,'removeDefaultDisplayLanguageToProfile'),
	(4,5,'addFeedback'),
	(5,4,'dropFeedback'),
	(5,6,'addFeedbackTypeAndTextPrimaryKeyToFeedback'),
	(6,5,'removeFeedbackTypeAndTextPrimaryKeyToFeedback'),
	(6,7,'addCandidateKeyNetflixParties'),
	(7,6,'removeCandidateKeyNetflixParties'),
	(7,8,'newForeignKeyFeedback'),
	(8,7,'removeForeignKeyFeedback')

SELECT * FROM proceduresTable

/* Write a stored procedure that receives as a parameter a version number and brings the database to that version. */
GO
CREATE OR ALTER PROCEDURE getVersion(@newVersion INT)
AS
	DECLARE @current_version INT
	DECLARE @procedureName VARCHAR(300)
	SELECT @current_version=version FROM currentVersionTable

	IF (@newVersion>(SELECT MAX(final_version) FROM proceduresTable)OR @newVersion<1)
		RAISERROR('Bad chosen version',10,1)
	ELSE
	BEGIN
		IF @newVersion=@current_version
			PRINT('You are already in the given version')
		ELSE
		BEGIN
			IF @current_version>@newVersion
				BEGIN
					WHILE @current_version>@newVersion
						BEGIN
							SELECT @procedureName=procedure_name FROM proceduresTable WHERE initial_version=@current_version AND final_version=@current_version-1
							PRINT('Executing' + @procedureName);
							EXEC(@procedureName)
							SET @current_version=@current_version-1
						END
				END
			IF @current_version<@newVersion
			BEGIN
				WHILE @current_version<@newVersion
					BEGIN
						SELECT @procedureName =procedure_name FROM proceduresTable WHERE initial_version=@current_version AND final_version=@current_version+1
						PRINT('Executing ' + @procedureName);
						EXEC(@procedureName)
						SET @current_version=@current_version+1
					END
			END
			UPDATE currentVersionTable SET version=@newVersion
		END
	END

EXEC getVersion 7

SELECT * FROM currentVersionTable

SELECT * FROM proceduresTable