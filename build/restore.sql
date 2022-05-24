/*
** Example Restore
**
** Download sample backup files from: 
**    <https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms>
**    <https://github.com/microsoft/sql-server-samples/tree/master/samples/databases>
**    <https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2019.bak>
*/

SET NOCOUNT ON
GO

USE master
GO

PRINT 'Executing `restore.sql` ...'

/*
  AdventureWorksDW2019
*/
IF DB_ID('AdventureWorksDW2019') IS NOT NULL
  PRINT 'AdventureWorksDW2019 exists'
ELSE
  BEGIN 
    PRINT 'Restoring AdventureWorksDW2019 ...'

    RESTORE DATABASE AdventureWorksDW2019
    FROM DISK = N'/var/opt/mssql/backup/AdventureWorksDW2019.bak'
    WITH 
      /*
        Verified via `RESTORE FILELISTONLY`
      */
      MOVE N'AdventureWorksDW2017' -- (-_Q)
        TO N'/var/opt/mssql/data/AdventureWorksDW2019.mdf',
      MOVE N'AdventureWorksDW2017_log' -- (-_Q)
        TO N'/var/opt/mssql/data/AdventureWorksDW2019_log.mdf',
      FILE = 1,
      NOUNLOAD,
      STATS = 5
      ;
    
    PRINT 'AdventureWorksDW2019 restored!'
  END
GO

PRINT '`restore.sql` fin.'