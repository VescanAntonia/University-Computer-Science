--DEADLOCK T1

EXEC addRowMovies 'Movie', 'cast'
EXEC addRowMovies 'Movie2', 'cast1'
EXEC addRowMovies 'Movie3', 'cast2'

--table A: Movie, table B: Series
BEGIN TRAN
UPDATE Movies SET cast_members='new cast' WHERE id=2
WAITFOR DELAY '00:00:10'
UPDATE Series SET seasons=6 WHERE id = 4
COMMIT TRAN

--cast
SELECT * FROM Series
SELECT * FROM Movies

DELETE FROM Movies


--DEADLOCK T2
--table A: Movies, table B: Series
--SET DEADLOCK_PRIORITY HIGH --solution
BEGIN TRAN
UPDATE Series SET seasons=52 WHERE id = 3
WAITFOR DELAY '00:00:10'
UPDATE Movies SET cast_members='new cast 2' WHERE id=2
COMMIT TRAN

--cast2, 15