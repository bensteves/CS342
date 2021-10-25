--Performance homework

--Ben Steves 10-7-21

--Index version

use AdventureWorks2017
GO
 --select * from Sales.SalesOrderHeader

 --1A
 --drop index idx1a on sales.SalesOrderHeader
 create index idx1a ON sales.SalesOrderHeader (CreditCardId, CurrencyRateId)
 select CreditCardId, CurrencyRateId from sales.SalesOrderHeader

 --1B
 drop index idx1a on sales.SalesOrderHeader
 create index idx1b ON sales.SalesOrderHeader (CreditCardId, CurrencyRateId)
 select CreditCardId, CurrencyRateId from sales.SalesOrderHeader where CreditCardId = 8936

 --1C
 drop index idx1b ON sales.SalesOrderHeader
 create index idx1c ON sales.SalesOrderHeader (CreditCardId, CurrencyRateId, Comment, CustomerID)
 select CreditCardId, CurrencyRateId, CustomerID, Comment from sales.SalesOrderHeader where CreditCardId = 8936

--Query 2A: 
create nonclustered index idxcccti ON sales.SalesOrderHeader (territoryID)
select territoryid from sales.SalesOrderHeader where territoryid = 6
--Query 2B: 
select comment, duedate from sales.SalesOrderHeader   where TerritoryID = 6
--Query 2C: 
select CreditCardId, CurrencyRateId from sales.SalesOrderHeader   where TerritoryID = 6
--Query 2D: 
select territoryId, count(*) from sales.salesOrderHeader group by territoryId
drop index idxcccti on sales.SalesOrderHeader


--Query 3A: 
create index idxcmt ON sales.SalesOrderHeader (comment)
select comment from sales.SalesOrderHeader where comment like '%544%'
--Query 3B: 
select comment from sales.SalesOrderHeader where comment like '544%'
drop index idxcmt on sales.SalesOrderHeader

--Query 4A: 
create index idx4a ON sales.SalesOrderHeader (SalesOrderId)
select * from sales.SalesOrderDetail d
inner join sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
--Query 4B: 
select d.SalesOrderID  ,d.productid ,p.name from sales.SalesOrderDetail d
inner join production.Product p on d.ProductID = p.ProductID

--4c
select d.salesOrderId, d.productId, p.name 
from sales.SalesOrderDetail d, production.Product p
where p.ProductID = d.ProductID

--5
SELECT b.baseId "Base Product", 
	b.pCount as "# Orders With Base", 
	s.AffId  "Accompanied By Product",
	s.Frequency "# Accompanied w/Base",    
	FORMAT(CAST (s.Frequency as Decimal)
	       /CAST(b.pCount as decimal), 'P') "Affinity %"
FROM
(SELECT p.productid as baseId, --this is essentially a grouping
		t.productid as affId,  --on cartesian products within 
		count(*)  as Frequency  --each order
	FROM Sales.SalesOrderDetail p join 
			Sales.SalesOrderDetail t
	ON p.SalesOrderID = t.SalesOrderID 
	WHERE p.ProductID <> t.ProductID
	GROUP BY p.ProductID, t.ProductID
	HAVING count(*) > 1 ) as s  --The Having is to filter out the trivial 
INNER JOIN
	(SELECT productid baseId, COUNT(*) as pCount
	FROM sales.SalesOrderDetail
	GROUP by productid
	HAVING COUNT(*) >= 10) as b
ON b.baseId = s.baseId
ORDER BY 5 DESC

