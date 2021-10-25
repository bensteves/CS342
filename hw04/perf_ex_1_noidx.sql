--Performance homework

--Ben Steves 10-7-21

--No index version


use AdventureWorks2017
GO

--1a
 select CreditCardId, CurrencyRateId from sales.SalesOrderHeader

 --1b
  select CreditCardId, CurrencyRateId from sales.SalesOrderHeader where CreditCardId = 8936

 --1c
 select CreditCardId, CurrencyRateId, CustomerID, Comment from sales.SalesOrderHeader where CreditCardId = 8936

 --Query 2A: 

select territoryid from sales.SalesOrderHeader where territoryid = 6
--Query 2B: 
select comment, duedate from sales.SalesOrderHeader   where TerritoryID = 6
--Query 2C: 
select CreditCardId, CurrencyRateId from sales.SalesOrderHeader   where TerritoryID = 6
--Query 2D: 
select territoryId, count(*) from sales.salesOrderHeader group by territoryId


--Query 3A: 
select comment from sales.SalesOrderHeader where comment like '%544%'
--Query 3B: 
select comment from sales.SalesOrderHeader where comment like '544%'

--Query 4A:  
select * from sales.SalesOrderDetail d
inner join sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
--Query 4B: 
select d.SalesOrderID  ,d.productid ,p.name from sales.SalesOrderDetail d
inner join production.Product p on d.ProductID = p.ProductID