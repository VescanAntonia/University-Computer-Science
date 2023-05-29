--Update conflicts
--T1
WAITFOR DELAY '00:00:05'
BEGIN TRAN
UPDATE Series SET seasons = 11 WHERE id=100
WAITFOR DELAY '00:00:05'
COMMIT TRAN

--ALTER DATABASE DMSLab3 SET ALLOW_SNAPSHOT_ISOLATION_OFF
--UPDATE Series SET seasons = 10 WHERE id = 100
--SELECT * FROM Series

--T2

SET TRAN ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
WAITFOR DELAY '00:00:05'
-- T1 has updated and has a lock on the table
-- T2 will be blocked when trying to update the table
UPDATE Series SET seasons = 12 WHERE id = 100
COMMIT TRAN