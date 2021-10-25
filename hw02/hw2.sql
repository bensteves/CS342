--hw 2 Ben Steves - 9-16-21

--1
USE AP
GO

--2
SELECT *
FROM Vendors AS V
LEFT JOIN Invoices AS I
ON V.VendorID = I.VendorID 
WHERE V.VendorState = 'NY';
GO

--3
SELECT VendorName, 
	InvoiceNumber, 
	InvoiceDate,
       InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY Balance DESC;
GO

--4
 SELECT VendorName, 
 VendorState
  FROM Vendors
  WHERE VendorState IN ('CA', 'NY')
UNION
  SELECT VendorName, 
  'Neither'
  FROM Vendors
  WHERE VendorState NOT IN ('CA', 'NY')
ORDER BY VendorName;
GO

--5
USE PUBS
GO

--6
SELECT au_lname + ', ' + au_fname as [Name], 
	phone
FROM authors
WHERE phone LIKE '801%';
GO

--7
--select * from titles
SELECT A.au_id, 
	A.au_fname + ' ' + A.au_lname as [Name], 
	TI.title
FROM authors AS A
LEFT JOIN titleauthor as TA
ON A.au_id = TA.au_id
LEFT JOIN titles as TI
ON TA.title_id = TI.title_id;
GO

--8
SELECT pub_name,
	state , 
	'Publisher' as [Type]
FROM publishers
UNION
SELECT VendorName , 
	VendorState, 
	'Vendor'
FROM AP.dbo.vendors
ORDER BY STATE;
GO

--9
SELECT
	A.au_lname + ', ' + A.au_fname AS [Name],
	TI.title,
	ST.stor_name,
	ST.state,
	SA.qty
FROM authors as A
LEFT JOIN titleauthor as TA
ON A.au_id = TA.au_id
LEFT JOIN titles as TI
ON TA.title_id = TI.title_id
LEFT JOIN sales as SA
ON SA.title_id = TI.title_id
LEFT JOIN stores as ST
ON ST.stor_id = SA.stor_id;
GO

--10
USE AdventureWorks2017;
GO

--11
SELECT TOP 4
	E.NationalIDNumber,
	E.LoginID,
	EPH.Rate,
	EPH.RateChangeDate
FROM HumanResources.Employee AS E
LEFT JOIN HumanResources.EmployeePayHistory as EPH
ON E.BusinessEntityID = EPH.BusinessEntityID
ORDER BY Rate DESC;

--12
select * from Person.Password
select * from Person.Address
select * from HumanResources.Employee

SELECT
	A.AddressLine1 ,
	E.LoginID
FROM Person.Address as A
RIGHT JOIN Person.Password as P
ON A.rowguid = P.rowguid
RIGHT JOIN HumanResources.Employee as E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE AddressLine1 IS NULL

