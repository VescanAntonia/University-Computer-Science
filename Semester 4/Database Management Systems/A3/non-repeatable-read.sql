DELETE FROM Series


--T1 non-repeatable reads

INSERT INTO Series(id,seasons,nr_of_episodes,name)
VALUES(4,5,108,'The Night Agent')
SELECT * FROM Series



BEGIN TRAN
WAITFOR DELAY '00:00:05'
UPDATE Series SET nr_of_episodes=100
WHERE id = 4
COMMIT TRAN

INSERT INTO Series(id,seasons,nr_of_episodes,name)
VALUES (5,1,10,'Wednesday')
BEGIN TRAN
WAITFOR DELAY '00:00:05'
UPDATE Series SET nr_of_episodes=100
WHERE id = 5
COMMIT TRAN



--T2 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ -- solution
BEGIN TRAN
SELECT * FROM Series
WAITFOR DELAY '00:00:05'
SELECT * FROM Series
COMMIT TRAN
