use AdventureWorks2019
go

select COUNT(*)
from Production.Product

select count(p.ProductSubcategoryID)
from Production.Product as p where p.ProductSubcategoryID is not null

select p.ProductSubcategoryID,count(p.ProductID) as CountedProducts
from Production.Product as p  where p.ProductSubcategoryID is not null group by (p.ProductSubcategoryID)

select count(p.ProductID)
from Production.Product as p where p.ProductSubcategoryID is null

select sum(p.Quantity)
from Production.ProductInventory as p

SELECT p.ProductID, SUM(p.Quantity) AS TheSum
FROM Production.ProductInventory AS p
WHERE p.LocationID = 40
GROUP BY p.ProductID
HAVING SUM(p.Quantity) < 100;

SELECT p.Shelf,p.ProductID, SUM(p.Quantity) AS TheSum
FROM Production.ProductInventory AS p
WHERE p.LocationID = 40
GROUP BY p.ProductID,p.Shelf
HAVING SUM(p.Quantity) < 100;

select AVG(p.Quantity)
from Production.ProductInventory as p where p.LocationID=10

select p.ProductID,p.Shelf,AVG(p.Quantity)
from Production.ProductInventory as p group by p.ProductID,p.Shelf

select p.ProductID,p.Shelf,AVG(p.Quantity)
from Production.ProductInventory as p where p.Shelf<>'N/A' group by p.ProductID,p.Shelf 

select p.Color, p.Class,COUNT(*) as TheCount ,avg(p.ListPrice) as AvgPrice
from Production.Product as p where p.Color is not null and p.Class is not null group by p.Color,p.Class

select c.Name as Country,s.Name as Province
from person. CountryRegion as c
join person. StateProvince as s
on c.CountryRegionCode=s.CountryRegionCode

select c.Name as Country,s.Name as Province
from person. CountryRegion as c
join person. StateProvince as s
on c.CountryRegionCode=s.CountryRegionCode where c.Name in('Canada','Germany')


use Northwind
go

select p.ProductName,o.OrderDate
from dbo.Orders as o join dbo.[Order Details] as d on o.OrderID=d.OrderID join dbo.Products as p on d.ProductID=p.ProductID where o.OrderDate>=DATEADD(year,-27,GETDATE())

select *
from dbo.[Orders] proid

select top 5 d.ProductID,o.ShipPostalCode, COUNT(o.ShipPostalCode) as totalOrders
from dbo.Orders as o join dbo.[Order Details]as d on o.OrderID=d.OrderID 
where o.ShipPostalCode is not null and o.OrderDate>=DATEADD(year,-27,getdate())
group by d.ProductID,o.ShipPostalCode order by totalOrders desc 