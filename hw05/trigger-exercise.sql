--Trigger exercise
--Ben Steves
--CS 342
--10-20-21


--1
CREATE DATABASE avlogs
go

--2
use avlogs 
go

--
--3
CREATE TABLE StateProvinceLog (
	[StateProvinceID] [int] not null,
	[StateProvinceCode] [nchar](3),
	[CountryRegionCode] [nvarchar](3),
	[IsOnlyStateProvinceFlag] bit,
	[Name] nvarchar(50),
	[TerritoryID] [int],
	[rowguid] [uniqueidentifier] ROWGUIDCOL,
	[ModifiedDate] [datetime],
	ChangeType nchar(1),
	ChangeDate datetime,
	UserName nvarchar(30),
	CHECK(ChangeType = 'I' or ChangeType = 'U' or ChangeType = 'D'),
	CHECK(UserName = 'bjs48')
)
go

INSERT INTO StateProvinceLog (StateProvinceID, 
								StateProvinceCode,
								CountryRegionCode,
								IsOnlyStateProvinceFlag,
								Name,
								TerritoryID,
								rowguid,
								ModifiedDate)
	SELECT * FROM AdventureWorks2017.Person.StateProvince
	go

ALTER TABLE StateProvinceLog
DROP COLUMN rowguid
go

SELECT * FROM StateProvinceLog

--4
use AdventureWorks2017;
go

--5  logic from --https://www.sqlservertutorial.net/sql-server-triggers/sql-server-create-trigger/
--         and --https://stackoverflow.com/questions/741414/insert-update-trigger-how-to-determine-if-insert-or-update
CREATE TRIGGER stPersonLog
ON AdventureWorks2017.Person.StateProvince
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	set nocount on;
	--update, prints old value in deleted table and updated value in insert table
	IF EXISTS (SELECT * FROM inserted) and EXISTS (SELECT * FROM deleted)
			INSERT INTO avlogs.dbo.StateProvinceLog(
					StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					ChangeType,
					ChangeDate,
					UserName
			)
			SELECT 
					StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					'U',
					getdate(),
					'bjs48'
				FROM inserted
			UNION ALL 
			SELECT 
				StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					'U',
					getdate(),
					'bjs48'
				FROM deleted
	--insert or delete
	ELSE 
			INSERT INTO avlogs.dbo.StateProvinceLog(
					StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					ChangeType,
					ChangeDate,
					UserName
			)
			SELECT 
					StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					'I',
					getdate(),
					'bjs48'
				FROM inserted
			UNION ALL 
			SELECT 
				StateProvinceID, 
					StateProvinceCode,
					CountryRegionCode,
					IsOnlyStateProvinceFlag,
					Name,
					TerritoryID,
					ModifiedDate,
					'D',
					getdate(),
					'bjs48'
				FROM deleted
END

--6
INSERT INTO Person.StateProvince (StateProvinceCode, CountryRegionCode, IsOnlyStateProvinceFlag, Name, TerritoryID, rowguid, ModifiedDate) 
VALUES ('BA', 'UM', 0, 'Bailey', 1, NEWID(), getdate())

UPDATE Person.StateProvince
SET Name = 'Buckey'
WHERE StateProvinceCode = 'BA'

DELETE FROM Person.StateProvince
WHERE StateProvinceCode = 'BA'

select * from avlogs.dbo.StateProvinceLog

--7
use avlogs;
go

--8, --9
CREATE PROCEDURE procLogActivity
@checkDate datetime,
@activeCount int output
AS 
BEGIN
	set @activeCount = 0

	SELECT @activeCount = COUNT(*)
	FROM avlogs.dbo.StateProvinceLog
	WHERE ChangeDate > getdate()
END

--10
DECLARE @ReturnCount int
DECLARE @ReturnValue int
DECLARE @curDate date
SELECT @curDate = GETDATE()

EXEC @ReturnValue = procLogActivity 
      @checkDate = @curDate
	  ,@activeCount = @ReturnCount OUTPUT

SELECT @ReturnValue, @ReturnCount

--11
use AdventureWorks2017
go

DROP TRIGGER  Person.stPersonLog

--12
drop database avlogs

--13
--It works, however it only does so if you don't press execute, so unfortunately the code has to be run chunk by chunk.