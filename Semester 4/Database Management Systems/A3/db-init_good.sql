use DMSLab3;

CREATE TABLE Accounts(
		id int primary key,
		plan_type varchar(30),
		number_of_profiles int,
		tax int,
		date_of_creation datetime,
		email_adress varchar(30),
		password varchar(30)
);

CREATE TABLE Series(
		id int ,
		seasons int ,
		nr_of_episodes int ,
		name varchar(50),
		PRIMARY KEY(id)
);

CREATE TABLE NetflixParties(
		id int,
		nr_of_participants int,
		PRIMARY KEY(id)
);

CREATE TABLE Profiles(
		id int primary key,
		account_id int,
		type varchar(30) ,
		name varchar(30) ,
		display_language varchar(30) ,
		FOREIGN KEY(account_id)
				REFERENCES Accounts(id)
				ON DELETE CASCADE
);

CREATE TABLE Movies(
		id int primary key,
		title varchar(30),
		cast_members varchar(30) 
);

CREATE TABLE Genres(
		id int primary key,
		genre_type varchar(30)
);

CREATE TABLE MoviesGenres(
		movie_id int,
		genre_id int ,
		FOREIGN KEY(movie_id)
				REFERENCES Movies(id)
				ON DELETE CASCADE,
		FOREIGN KEY(genre_id)
				REFERENCES Genres(id)
				ON DELETE CASCADE
);


CREATE TABLE Watched(
		movie_id int,
		profile_id int ,
		FOREIGN KEY(movie_id)
				REFERENCES Movies(id)
				ON DELETE CASCADE,
		FOREIGN KEY(profile_id)
				REFERENCES Profiles(id)
				ON DELETE CASCADE
);

INSERT INTO Genres	
	(id, genre_type)
VALUES
	(1,'Comedy'),
	(2,'Romance'),
	(3,'Drama'),
	(4,'Horror');

SELECT * FROM Genres


INSERT INTO Movies
	(id,title,cast_members)
VALUES
	(1,'Red Notice','Dwayne Johnson Ryan Reynolds'),
	(2,'Titanic','Kate Winslet Leonardo DiCaprio');
SELECT * FROM Movies


INSERT INTO MoviesGenres
	(movie_id,genre_id)
VALUES
	(2,3)
SELECT * FROM MoviesGenres
