--SHEEP LAB - BEN STEVES

--1: now second query

--drop database sheep

--2:
CREATE DATABASE sheep;
GO

--3
USE sheep
GO

--4
CREATE SCHEMA ActiveHerd;
GO

--5

--6
CREATE TABLE [ActiveHerd].sheep (
	IdNumber int IDENTITY(1,1) NOT NULL,
	SheepName varchar(40),
	BreedCategory varchar(80) NOT NULL,
	Gender char(1) NOT NULL,
	ShepherdId int NOT NULL,
	CONSTRAINT [Pk_id] PRIMARY KEY (IdNumber)
)
GO

CREATE TABLE [ActiveHerd].breed (
	BreedCategory varchar(80) NOT NULL PRIMARY KEY,
	BreedDescription varchar(600)
)
GO

CREATE TABLE [ActiveHerd].sheepShots (
	IdNumber int NOT NULL,
	ShotType varchar(14) NOT NULL,
	ShotDate DATE,
	InjectionType varchar(14),
	CONSTRAINT pk_shots PRIMARY KEY (IdNumber, ShotType)
)
GO

CREATE TABLE [ActiveHerd].shotList (
	ShotType varchar(14) NOT NULL PRIMARY KEY,
	shotDescription varchar(600),
	dayCycle int
)
GO

CREATE TABLE [ActiveHerd].injectionList (
	InjectionType varchar(14) NOT NULL PRIMARY KEY,
	injectionDescription varchar(600)
)
GO

CREATE TABLE [ActiveHerd].shepherd (
	ShepherdId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LastName varchar(25),
	FirstName varchar(25),
	ShepherdCertification BIT NOT NULL
)
GO

--7
ALTER TABLE [ActiveHerd].sheep
ADD CONSTRAINT Fk_BreedCategory1
FOREIGN KEY (BreedCategory) 
REFERENCES [ActiveHerd].breed(BreedCategory)

ALTER TABLE	[ActiveHerd].sheep
ADD CONSTRAINT Fk_ShepherdId
FOREIGN KEY (ShepherdId)
REFERENCES [ActiveHerd].shepherd(ShepherdId)

ALTER TABLE [ActiveHerd].sheepShots
ADD CONSTRAINT Fk_IdNum
FOREIGN KEY (IdNumber) 
REFERENCES [ActiveHerd].sheep(IdNumber)

ALTER TABLE [ActiveHerd].sheepShots
ADD CONSTRAINT Fk_ShotType
FOREIGN KEY (ShotType) 
REFERENCES [ActiveHerd].shotList(ShotType)

ALTER TABLE [ActiveHerd].sheepShots
ADD CONSTRAINT Fk_InjectionType
FOREIGN KEY (InjectionType) 
REFERENCES [ActiveHerd].injectionList(InjectionType)

--8
INSERT INTO [ActiveHerd].breed (BreedCategory, BreedDescription) VALUES ('Najdi', 
	'The Najdi or Nejdi is a breed of domestic sheep native to the Najd region of the Arabian Peninsula')
INSERT INTO [ActiveHerd].breed (BreedCategory, BreedDescription) VALUES ('Corriedale', 
	'Corriedale sheep are a dual purpose breed, meaning they are used both in the production of wool and meat')
INSERT INTO [ActiveHerd].breed (BreedCategory, BreedDescription) VALUES ('Southdown',
	'The Southdown is a British breed of domestic sheep, ​​the smallest of the British breeds')

INSERT INTO [ActiveHerd].shotList (ShotType, shotDescription, dayCycle) VALUES ('Parvo', 'Vaccine that prevents Parvovirus', 14)
INSERT INTO [ActiveHerd].shotList (ShotType, shotDescription, dayCycle) VALUES ('CDT', 'Vaccine that prevents overeating disease', 21)
INSERT INTO [ActiveHerd].shotList (ShotType, shotDescription, dayCycle) VALUES ('Pasteurella', 'Vaccine that prevents Pasteurella multocida', 14)

INSERT INTO [ActiveHerd].injectionList (InjectionType, injectionDescription) VALUES ('Oral Injection', 'Mouth')
INSERT INTO [ActiveHerd].injectionList (InjectionType, injectionDescription) VALUES ('Subcutaneous', 'Ribs, shoulder')
INSERT INTO [ActiveHerd].injectionList (InjectionType, injectionDescription) VALUES ('IV', 'Jugular vein')

INSERT INTO [ActiveHerd].shepherd (LastName, FirstName, ShepherdCertification) VALUES ('Steves', 'Ben', 0)
INSERT INTO [ActiveHerd].shepherd (LastName, FirstName, ShepherdCertification) VALUES ('Reynolds', 'Byran', 1)
INSERT INTO [ActiveHerd].shepherd (LastName, FirstName, ShepherdCertification) VALUES ('Streep', 'Meryl', 1)

INSERT INTO [ActiveHerd].sheep (SheepName, BreedCategory, Gender, ShepherdId) VALUES ('Damien', 'Najdi', 'M', 1)
INSERT INTO [ActiveHerd].sheep (SheepName, BreedCategory, Gender, ShepherdId) VALUES ('Sandra', 'Corriedale', 'F', 2)
INSERT INTO [ActiveHerd].sheep (SheepName, BreedCategory, Gender, ShepherdId) VALUES ('Meryl Sheep', 'Southdown', 'F', 3)

--9
INSERT INTO [ActiveHerd].sheepShots (IdNumber, ShotType)
SELECT sh.IdNumber , sl.ShotType
FROM ActiveHerd.sheep AS sh
CROSS JOIN ActiveHerd.shotList AS sl

UPDATE ActiveHerd.sheepShots
SET ShotDate = GETDATE(),
	InjectionType = 'Oral Injection'


--10
UPDATE ActiveHerd.sheepShots
SET ShotDate = CAST('2020-02-03' AS DATE)

--11
select*from ActiveHerd.sheepShots
select*from ActiveHerd.sheep
select*from ActiveHerd.breed
select*from ActiveHerd.injectionList
select*from ActiveHerd.shotList
select*from ActiveHerd.shepherd

--12
DELETE FROM ActiveHerd.sheepShots
DELETE FROM ActiveHerd.sheep

--13
--code above worked

--14
DELETE FROM ActiveHerd.shepherd

--15
--Done

--16
DROP TABLE ActiveHerd.sheepShots
DROP TABLE ActiveHerd.sheep
DROP TABLE ActiveHerd.shepherd
DROP TABLE ActiveHerd.breed
DROP TABLE ActiveHerd.shotList
DROP TABLE ActiveHerd.injectionList

--17 
DROP SCHEMA ActiveHerd
USE PUBS;
GO
DROP DATABASE IF EXISTS sheep;
GO