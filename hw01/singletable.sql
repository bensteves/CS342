--HW 1 - Ben Steves 9-10-21

--1
USE AP

--2
SELECT VendorContactFName, 
		VendorContactLName, 
		VendorName, 
		VendorCity, 
		VendorState
FROM Vendors
ORDER BY VendorCity, 
	VendorState, 
	VendorContactLName, 
	VendorContactFName;
GO

--3
SELECT VendorContactLName + ', ' + VendorContactFName
AS [Full Name],
VendorState
FROM Vendors
WHERE VendorState = 'OH'
ORDER BY VendorContactLName, 
		VendorContactFName;
GO

--4
SELECT InvoiceTotal, InvoiceTotal / 10 AS [25%],
       InvoiceTotal * 1.1 AS [Plus 25%]
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
ORDER BY InvoiceTotal DESC;
GO

--5a
SELECT VendorContactLName + ', ' + VendorContactFName 
AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A, D, E, L]%'
ORDER BY VendorContactLName, VendorContactFName;
GO

--5b
SELECT VendorContactLName + ', ' + VendorContactFName
AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A-L]%' AND
		VendorContactLName NOT LIKE '[B-C, F-K]%'
ORDER BY VendorContactLName, VendorContactFName;
GO

--6 returns nothing becaue all null values have payment total of 0
SELECT * 
FROM Invoices 
WHERE PaymentDate IS NULL
AND PaymentTotal > 0
GO

--7
SELECT VendorContactLName + ', ' + VendorContactFName
AS [Full Name],
DefaultTermsID
FROM Vendors
WHERE DefaultTermsID = 3
GO

--8
SELECT VendorContactLName + ', ' + VendorContactFName
AS [Full Name],
DefaultTermsID,
DefaultAccountNo
FROM Vendors
WHERE DefaultTermsID = 3
AND DefaultAccountNo > 540
ORDER BY DefaultAccountNo
GO

--9
SELECT VendorName 
FROM Vendors
WHERE VendorName LIKE '%Company%'
GO

--10 
--logic from --https://stackoverflow.com/questions/14959166/mysql-select-query-get-only-first-10-characters-of-a-value
SELECT DISTINCT VendorState,
		LEFT(VendorPhone, 5)
AS [AreaCode]
FROM Vendors
GO

--11
SELECT DISTINCT VendorState,
		LEFT(VendorPhone, 5)
AS [AreaCode]
FROM Vendors
WHERE VendorPhone IS NOT NULL
GO

--12
Use pubs
GO

--13
SELECT TOP 5 ytd_sales,
		title
FROM titles
ORDER BY ytd_sales DESC
GO

--14
SELECT title,
		ytd_sales / price AS [Sold]
FROM titles
GO

--15
SELECT TOP 3 (ytd_sales / price) AS [Sold],
		title	
FROM titles
ORDER BY ytd_sales DESC
GO

--16
--My guess is that DATEDIFF returns an integer and totalPayToDate is probably a date type, 
--so the computation produces an error because there is division being done to two different types