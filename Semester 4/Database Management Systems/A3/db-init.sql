use Lab3DMS;

CREATE TABLE Accounts(
		id int NOT NULL,
		plan_type varchar(30) NOT NULL,
		number_of_profiles int NOT NULL,
		tax int NOT NULL,
		date_of_creation datetime,
		email_adress varchar(30) NOT NULL,
		password varchar(30) NOT NULL,
		PRIMARY KEY(id)
);


CREATE TABLE Profiles(
		id int NOT NULL,
		account_id int,
		type varchar(30) NOT NULL,
		name varchar(30) NOT NULL,
		display_language varchar(30) NOT NULL,
		PRIMARY KEY(id),
		FOREIGN KEY(account_id)
				REFERENCES Accounts(id)
				ON DELETE CASCADE
);


CREATE TABLE Movies(
		id int NOT NULL,
		title varchar(30) NOT NULL,
		cast_members varchar(30) NOT NULL,
		PRIMARY KEY(id)
);
Drop table Movies
drop table MyList

CREATE TABLE Genres(
		id int NOT NULL,
		genre_type varchar(30) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE MoviesGenres(
		movie_id int NOT NULL,
		genre_id int NOT NULL,
		FOREIGN KEY(movie_id)
				REFERENCES Movies(id)
				ON DELETE CASCADE,
		FOREIGN KEY(genre_id)
				REFERENCES Genres(id)
				ON DELETE CASCADE
);


CREATE TABLE Watched(
		movie_id int NOT NULL,
		profile_id int NOT NULL,
		FOREIGN KEY(movie_id)
				REFERENCES Movies(id)
				ON DELETE CASCADE,
		FOREIGN KEY(profile_id)
				REFERENCES Profiles(id)
				ON DELETE CASCADE
);