use Netflix;

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



CREATE TABLE MyList(
		id int NOT NULL,
		name varchar(30) NOT NULL,
		duration int NOT NULL,
		match int NOT NULL,
		PRIMARY KEY(id)
);
ALTER TABLE MyList
DROP COLUMN name,duration, match;
ALTER TABLE dbo.MyList
ADD nr_of_movies int NOT NULL;


CREATE TABLE Movies(
		id int NOT NULL,
		mylist_id int NOT NULL,
		title varchar(30) NOT NULL,
		cast_members varchar(30) NOT NULL,
		PRIMARY KEY(id),
		FOREIGN KEY(mylist_id)
				REFERENCES MyList(id)
				ON DELETE CASCADE
);
ALTER TABLE dbo.Movies 
ADD match int NOT NULL;
ALTER TABLE dbo.Movies
ADD duration int NOT NULL;
SELECT * FROM Movies
SELECT * FROM MyList

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
SELECT * FROM MoviesGenres

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
SELECT * FROM Watched

CREATE TABLE SeriesWatched(
		series_id int NOT NULL,
		profile_id int NOT NULL,
		FOREIGN KEY(series_id)
				REFERENCES Serials(id)
				ON DELETE CASCADE,
		FOREIGN KEY(profile_id)
				REFERENCES Profiles(id)
				ON DELETE CASCADE
)
SELECT * FROM SeriesWatched
ALTER TABLE SeriesWatched ADD CONSTRAINT SeriesWatchedPrimaryKey PRIMARY KEY(series_id,profile_id)


CREATE TABLE Serials(
		id int NOT NULL,
		seasons int NOT NULL,
		nr_of_episodes int NOT NULL,
		cast_members varchar(30) NOT NULL,
		name varchar(50) NOT NULL,
		PRIMARY KEY(id)
);



CREATE TABLE Genres(
		id int NOT NULL,
		genre_type varchar(30) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE NetflixParties(
		id int NOT NULL,
		nr_of_participants int NOT NULL,
		PRIMARY KEY(id)
);
ALTER TABLE dbo.NetflixParties
ADD movie_to_watch int NOT NULL;
SELECT * FROM NetflixParties

CREATE TABLE FreeTrial(
		id int NOT NULL,
		account_id int NOT NULL,
		starting_date datetime,
		ending_date datetime,
		PRIMARY KEY(id),
		FOREIGN KEY(account_id)
			REFERENCES Accounts(id)
				ON DELETE CASCADE
);
ALTER TABLE FreeTrial
ADD FOREIGN KEY (account_id)
REFERENCES Accounts(id)
SELECT * FROM FreeTrial

CREATE TABLE Top10Movies(
		id int NOT NULL,
		duration int NOT NULL,
		cast_members varchar(30) NOT NULL,
		PRIMARY KEY(id)
);
ALTER TABLE Top10Movies
DROP COLUMN duration,cast_members;
SELECT * FROM Top10Movies

CREATE TABLE SerialsGenres(
		serial_id int NOT NULL,
		genre_id int NOT NULL,
		FOREIGN KEY(serial_id)
				REFERENCES Serials(id)
				ON DELETE CASCADE,
		FOREIGN KEY(genre_id)
				REFERENCES Genres(id)
				ON DELETE CASCADE
);

/*inserting the data*/

INSERT INTO Genres	
	(id, genre_type)
VALUES
	(1,'Comedy'),
	(2,'Romance'),
	(3,'Action'),
	(4,'Science Fiction'),
	(5,'Drama'),
	(6,'Horror'),
	(7, 'Documentary'),
	(8,'Thriller'),
	(9,'Crime and mystery'),
	(10,'Animation');

SELECT * FROM Genres
SELECT * FROM Profiles
INSERT INTO Profiles
	(id,account_id,type,name,display_language)
VALUES
	(1,2,'All categories', 'Ella','English'),
	(2,2,'Child','Mary','Romanian'),
	(3,4,'All categories','Sam','French'),
	(4,1,'All categories', 'Bella', 'Italian'),
	(5,4,'All categories','Daniel','Romanian');
SELECT * FROM Profiles
DELETE FROM Profiles

INSERT INTO Accounts
	(id,plan_type,number_of_profiles,tax,date_of_creation,email_adress,password)
VALUES
	(1,'Minimum',4,8,'2020-06-19T00:00:00', 'vescan@gmail.com','mansjnks'),
	(2,'Standard',5,10,'2021-07-20T00:00:00', 'antonia@gmail.com','mkdios5'),
	(3,'Premium',3,12,'2019-01-05T00:00:00','brandon@gmail.com','gsattwgw'),
	(4,'Minimum',2,8,'2022-06-20T00:00:00','jackson@gmail.com','yatft'),
	(5,'Premium',4,12,'2022-02-18T00:00:00','benjamin@gmail.com','sayfradr'),
	(6,'Premium',5,12,'2020-02-10T00:00:00','simon@gmail.com','aaywfg'),
	(7,'Standard',4,10,'2021-12-02T00:00:00','melissa@gmail.com','sagwfttw'),
	(8,'Standard',4,10,'2021-07-20T00:00:00','daniel@gmail.com','sygtawwd');
SELECT * FROM Accounts
DELETE FROM Accounts

INSERT INTO Movies
	(id,mylist_id,title,cast_members,match,duration)
VALUES
	(1,2,'Red Notice','Dwayne Johnson Ryan Reynolds',80,120),
	(2,3,'The Grey Man','Ana de Armas Chris Evans',58,150),
	(3,1,'Titanic','Kate Winslet Leonardo DiCaprio',90,90),
	(4,'5','Man From Toronto','Kevin Hart',98,78),
	(5,4,'Home Alone','Kate',40,100);
SELECT * FROM Movies

INSERT INTO FreeTrial
	(id,starting_date,ending_date,account_id)
VALUES
	(1,'2020-06-19T00:00:00','2020-07-19T00:00:00',1),
	(2,'2021-07-20T00:00:00','2021-08-20T00:00:00',2);
SELECT * FROM FreeTrial

INSERT INTO MyList
	(id,nr_of_movies)
VALUES
	(1,7),
	(2,16),
	(3,20),
	(4,23),
	(5,12),
	(6,8);
SELECT * FROM MyList

ALTER TABLE dbo.Serials 
ADD name VARCHAR(20) NOT NULL ;
INSERT INTO Serials
	(id,seasons,nr_of_episodes,cast_members,name)
VALUES
	(1,5,108,'Elizabeth Gillies','Dynasty'),
	(2,2,20,'Chase Stokes','Outer Banks'),
	(3,1,25,'Lilly Collins','Emily in Paris'),
	(4,4,58,'Elizabeth Gillies', 'Victory in the spot'),
	(5,3,60,'Melissa Roxburgh','Manifest'),
	(6,9,134,'Gabriel Macht','Suits');
SELECT * FROM Serials
DELETE FROM Serials

ALTER TABLE Profiles ALTER COLUMN account_id INT NOT NULL;

INSERT INTO MoviesGenres
	(movie_id,genre_id)
VALUES
	(1,2),
	(2,3),
	(1,4),
	(2,4);
SELECT * FROM MoviesGenres

INSERT INTO Watched
	(movie_id,profile_id)
VALUES
	(1,2),
	(1,3),
	(2,1),
	(2,2);
SELECT * FROM Watched

INSERT INTO SeriesWatched
	(series_id,profile_id)
VALUES
	(1,2),
	(1,3),
	(2,1),
	(2,2);
SELECT * FROM SeriesWatched
DELETE FROM SeriesWatched


INSERT INTO SerialsGenres
	(serial_id,genre_id)
VALUES
	(1,5),
	(2,3),
	(2,5),
	(3,1),
	(3,2),
	(1,1),
	(1,2),
	(4,1);
SELECT * FROM SerialsGenres


/*UPDATE statements*/
UPDATE MyList
	SET duration=120
WHERE  nr_of_movies>5;

UPDATE Serials
	SET seasons=2,nr_of_episodes=30
WHERE name='Dynasty' AND id=1;

UPDATE Accounts
	SET tax=10
WHERE id IN (1,2) AND email_adress LIKE 'a%';

  /*DELETE*/

DELETE FROM Profiles
WHERE id=2 AND type IS NOT NULL;

DELETE FROM Accounts
WHERE number_of_profiles BETWEEN 1 and 3;

/* a)use UNION [ALL] and OR; 
     1->find the ids of the accounts that were created in the last year or have the profiles display language Romanian
	 used '>' */
SELECT A.id
FROM Accounts A
WHERE YEAR(A.date_of_creation)>2021
UNION
SELECT P.account_id
FROM Profiles P
WHERE P.display_language='Romanian'

/*   2->find the ids of the lists from MyList which have more than 15 films or contain a film that has Ryan Reynolds in the cast and
       have the duration less than 130 minutes
	   used DISTINCT */
SELECT DISTINCT L.id
FROM MyList L,Movies M
WHERE (L.id = M.mylist_id AND L.nr_of_movies >15) OR (L.id = M.mylist_id AND L.nr_of_movies >15 AND M.cast_members LIKE '%Ryan Reynolds%' AND M.duration<130)


/* b) use INTERSECT and IN
    1->find the ids of the serials that have both comedy genre and romance
	INTERSECT
	used AND */
SELECT SG.serial_id
FROM SerialsGenres SG, Genres G
WHERE SG.genre_id=G.id AND G.genre_type ='Comedy'
INTERSECT
SELECT SG1.serial_id
FROM SerialsGenres SG1, Genres G1
WHERE SG1.genre_id=G1.id AND G1.genre_type ='Romance'

SELECT * FROM SerialsGenres
SELECT * FROM Genres

/*  2->all the movies that are also in the mylist lists
	  USE IN*/
SELECT M.title
FROM Movies M
WHERE M.mylist_id IN (SELECT L.id
					  FROM MyList L)

SELECT * FROM Movies
SELECT * FROM MyList

/* c)use EXCEPT and NOT IN
    1->find the ids of the serials that have drama genre but dont have action genre*/
SELECT SG.serial_id
FROM SerialsGenres SG, Genres G
WHERE SG.genre_id=G.id AND G.genre_type ='Drama'
EXCEPT
SELECT SG1.serial_id
FROM SerialsGenres SG1, Genres G1
WHERE SG1.genre_id=G1.id AND G1.genre_type='Action'

SELECT * FROM Genres
SELECT * FROM SerialsGenres

/*  2->series that have lilly collins in the cast or elizabeth gillies but haven't been watched */
/*NOT IN, OR, AND*/
SELECT S.name
FROM Serials S
WHERE (S.cast_members='Lilly Collins' OR S.cast_members='Elizabeth Gillies') AND S.id NOT IN(SELECT SW.series_id FROM SeriesWatched SW)

/* d) 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables,
    while another one will join at least two many-to-many relationships*/
	/*1.INNER JOIN 
	    ->shows for each account the display languages for the profiles and the id of the accounts*/
SELECT A.id,P.display_language
FROM Accounts A 
INNER JOIN Profiles P ON P.account_id = A.id

	/*2.LEFT JOIN
	    ->Print all the accounts and their profiles and free trials, including the ones that have no free trials or no profiles yet
		LEFT JOIN
		  joins 3 tables: Accounts, Profiles and FreeTrial*/
SELECT A.id,P.name, F.starting_date
FROM Accounts A
LEFT JOIN Profiles P ON A.id = P.account_id
LEFT JOIN FreeTrial F ON A.id = F.account_id

    /*3.RIGHT JOIN
		->Print all the names of the serials and the genres that they each have ; including genres that do not have a coresponding serie in the database
		RIGHT JOIN*/
SELECT S.name, G.genre_type
FROM Serials S
RIGHT JOIN SerialsGenres SG ON SG.serial_id= S.id
RIGHT JOIN Genres G ON G.id = SG.genre_id

	/*4.FULL JOIN
	  -> Print all the genres with movies that were watched from any profile; include movies that werent watched, 
	 genres that don't have movies and profiles that haven't watched a movie
	  -> at least two many-to-many relationships*/
SELECT G.genre_type, M.title, P.name
FROM Genres G
FULL JOIN MoviesGenres MG ON MG.genre_id = G.id
FULL JOIN Movies M ON M.id= MG.movie_id
FULL JOIN Watched W ON W.movie_id = M.id 
FULL JOIN Profiles P ON P.id = W.profile_id


/*  e) 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause; */
/*   ->1. Finds the genre of the movies that were watched at least once*/
SELECT G.genre_type
FROM Genres G
WHERE G.id IN(
	SELECT DISTINCT G1.id
	FROM Movies M
	INNER JOIN MoviesGenres MG ON M.id=MG.movie_id
	INNER JOIN Genres G1 ON MG.genre_id=G1.id
	WHERE MG.movie_id IN(
		SELECT M2.id
		FROM Movies M2
		INNER JOIN Watched W ON W.movie_id=M2.id
		INNER JOIN Profiles P ON W.profile_id=P.id
	)
)

/*   ->2.Print the name of the profiles which belongs to an account that did not have the free trial in 2021  
      used AND, NOT,DISTINCT*/
SELECT P.name
FROM Profiles P
WHERE P.id IN (
	SELECT A.id
	FROM Accounts A
	WHERE A.date_of_creation IN(
		SELECT DISTINCT F.starting_date
		FROM FreeTrial F
		WHERE NOT YEAR(F.starting_date)=2021
	)
)

/*f) 2 queries with the EXISTS operator and a subquery in the WHERE clause;
   ->  Finds the series that have been watched(increase the seasons because they were watched so liked by users and might as wellhave new seasons) 
    INCREASED SEASONS*/
SELECT S.name, S.seasons+1 AS NewSeasons
FROM Serials S
WHERE EXISTS
(
	SELECT * 
	FROM Serials S2
	INNER JOIN  SeriesWatched SW ON S2.id=SW.series_id
	INNER JOIN Profiles P ON SW.profile_id=P.id
	WHERE S2.id=S.id
)

/*  -> finds the movies that have a corresponding genre*/
SELECT M.title
FROM Movies M
WHERE EXISTS(
	SELECT * 
	FROM Genres G
	INNER JOIN MoviesGenres MG ON G.id=MG.genre_id
	INNER JOIN Movies M1 ON M1.id=MG.movie_id
	WHERE M1.id=M.id
)

/*  g) 2 queries with a subquery in the FROM clause;
	-> find the accounts which have the tax greater than 9 and have at least one profile
	-> use distinct,NOT,ORDER BY
	 multiplied the tax*/
SELECT A.email_adress,A.tax*10 AS new_tax
FROM(
	SELECT*
	FROM Accounts A
	WHERE NOT A.tax<9
)a WHERE a.id IN (
		SELECT DISTINCT p.account_id
		FROM Profiles p
)
ORDER BY new_tax DESC

	/*-> finds the accounts that have the type of the profile 'All categories' and already had the free trial
	increased profile nr*/
SELECT a.id,a.email_adress,a.password,a.number_of_profiles+1 AS nr_profiles,a.plan_type
FROM(
	SELECT A.id,A.email_adress, A.password,A.plan_type,A.number_of_profiles
	FROM Accounts A INNER JOIN Profiles P ON P.account_id=A.id
	WHERE P.type='All categories'
)a WHERE a.id IN(
		SELECT A1.id
		FROM Accounts A1
		INNER JOIN FreeTrial F ON F.account_id=A1.id
)
ORDER BY number_of_profiles ASC

/* h) 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause;
      use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;  
	  1. find the display languages and the number of profiles that each display language has
	     -> used count*/
SELECT P.display_language, COUNT(*) AS display_languages
FROM Profiles P
GROUP BY P.display_language


	/*2. find the movies that are the most watched ones
	 -> contains HAVING
	 ->has a subquery in the HAVING clause
	 -> used COUNT,MAX*/
SELECT M.id,M.title, COUNT(*) AS movie_views
FROM Movies M 
INNER JOIN Watched W ON M.id=W.movie_id
INNER JOIN Profiles P ON W.profile_id=P.id
GROUP BY M.id,M.title
HAVING COUNT(*)=(
		SELECT MAX(T.C)
		FROM (
			SELECT COUNT(*) C
			FROM Movies M2 
			INNER JOIN Watched W2 ON M2.id=W2.movie_id
			INNER JOIN Profiles P2 ON P2.id=W2.profile_id
			GROUP BY M2.id,M2.title
		)T
)

/*or that way*/
SELECT M.id,M.title,COUNT(*) AS movies_views
FROM Movies M
INNER JOIN Watched W ON M.id=W.movie_id
GROUP BY M.id,M.title

/*		3.find the minimum from all the total episodes of a serie per cast members
		-> contains HAVING clause, 
		->subquery in the HAVING clause 
		->used SUM,MIN */
SELECT S.cast_members,SUM(S.nr_of_episodes) AS total_episodes
FROM Serials S
GROUP BY S.cast_members
HAVING SUM(S.nr_of_episodes)=(
	SELECT MIN(T.s)
	FROM(
			SELECT SUM(S2.nr_of_episodes) s
			FROM Serials S2
			GROUP BY S2.cast_members
		)T
)

/*		4. find the average nr of profiles for each account plan type with at least 2 accounts created in the last 2 years
		-> used AVG, COUNT
		-> contains the HAVING clause
		-> has a subquery in the HAVING clause*/
SELECT A.plan_type, AVG(A.number_of_profiles) as average_nr_profiles
FROM Accounts A
GROUP BY A.plan_type
HAVING 1<(
	SELECT COUNT(A2.plan_type)
	FROM Accounts A2
	WHERE A.plan_type=A2.plan_type AND YEAR(A2.date_of_creation)>=2020
)

/*	i) 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); 
	   rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN. 
	    1. ->Find the top 3 series which have more episodes than the least nr of episodes in which Elizabeth Gillies plays
		   ->using ANY
		   ->using ORDER BY likes*/
SELECT TOP 3 S.*
FROM Serials S
WHERE S.nr_of_episodes > ANY (
		SELECT S2.nr_of_episodes
		FROM Serials S2
		WHERE S2.cast_members='Elizabeth Gillies')
ORDER BY S.nr_of_episodes DESC

/*	      rewritten with the aggregation operator
			used MIN instead of ANY*/
SELECT TOP 3 S.*
FROM Serials S
WHERE S.nr_of_episodes > (
		SELECT MIN(S2.nr_of_episodes)
		FROM Serials S2
		WHERE S2.cast_members = 'Elizabeth Gillies')
ORDER BY S.nr_of_episodes DESC

/*		2.  find all the names of the profiles for the accounts that were created this year
			using ANY */
SELECT P.*
FROM Profiles P
WHERE P.account_id = ANY(
		SELECT A.id
		FROM Accounts A
		WHERE YEAR(A.date_of_creation)=2022)
		
		/*rewitten with IN*/
SELECT P.*
FROM Profiles P
WHERE P.account_id IN(
		SELECT A.id
		FROM Accounts A
		WHERE YEAR(A.date_of_creation)=2022)

		/* 3. Find the top 50% movies for which the duration is more than the duration of the movie with a match smaller than 50
		    ->using ALL
		    ->ordered descending by experience */

SELECT TOP 50 PERCENT M.*
FROM Movies M
WHERE M.duration>ALL(
		SELECT M2.duration
		FROM Movies M2
		WHERE M2.match < 50)
ORDER BY M.duration DESC


/*		    rewritten using aggregation operator
			  ->used MAX instead of ALL*/
SELECT TOP 50 PERCENT M.*
FROM Movies M
WHERE M.duration>(
		SELECT MAX(M2.duration)
		FROM Movies M2
		WHERE M2.match < 50)
ORDER BY M.duration DESC



/*		 4.Find all the accounts that do not have profiles whose name begin with letter E
		   ->using ALL*/
SELECT A.*
FROM Accounts A
WHERE A.id<>ALL(
		SELECT P.account_id
		FROM Profiles P
		WHERE P.name LIKE 'E%')

/*		rewritten using NOT IN*/
SELECT A.*
FROM Accounts A
WHERE A.id NOT IN(
		SELECT P.account_id
		FROM Profiles P
		WHERE P.name LIKE 'E%')