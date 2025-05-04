use AdventureWorks2019
go
--1
select COUNT(*)
from Production.Product
--2
select count(p.ProductSubcategoryID)
from Production.Product as p where p.ProductSubcategoryID is not null
--3
select p.ProductSubcategoryID,count(p.ProductID) as CountedProducts
from Production.Product as p  where p.ProductSubcategoryID is not null group by (p.ProductSubcategoryID)
--4
select count(p.ProductID)
from Production.Product as p where p.ProductSubcategoryID is null
--5
select sum(p.Quantity)
from Production.ProductInventory as p
--6
SELECT p.ProductID, SUM(p.Quantity) AS TheSum
FROM Production.ProductInventory AS p
WHERE p.LocationID = 40
GROUP BY p.ProductID
HAVING SUM(p.Quantity) < 100;
--7
SELECT p.Shelf,p.ProductID, SUM(p.Quantity) AS TheSum
FROM Production.ProductInventory AS p
WHERE p.LocationID = 40
GROUP BY p.ProductID,p.Shelf
HAVING SUM(p.Quantity) < 100;
--8
select AVG(p.Quantity)
from Production.ProductInventory as p where p.LocationID=10
--9
select p.ProductID,p.Shelf,AVG(p.Quantity)
from Production.ProductInventory as p group by p.ProductID,p.Shelf
--10
select p.ProductID,p.Shelf,AVG(p.Quantity)
from Production.ProductInventory as p where p.Shelf<>'N/A' group by p.ProductID,p.Shelf 
--11
select p.Color, p.Class,COUNT(*) as TheCount ,avg(p.ListPrice) as AvgPrice
from Production.Product as p where p.Color is not null and p.Class is not null group by p.Color,p.Class
--12
select c.Name as Country,s.Name as Province
from person. CountryRegion as c
join person. StateProvince as s
on c.CountryRegionCode=s.CountryRegionCode
--13
select c.Name as Country,s.Name as Province
from person. CountryRegion as c
join person. StateProvince as s
on c.CountryRegionCode=s.CountryRegionCode where c.Name in('Canada','Germany')

use Northwind
go
--14
select p.ProductName,o.OrderDate
from dbo.Orders as o join dbo.[Order Details] as d on o.OrderID=d.OrderID join dbo.Products as p on d.ProductID=p.ProductID where o.OrderDate>=DATEADD(year,-27,GETDATE())
--15
select *
from dbo.[Orders] proid
--16
select top 5 d.ProductID,o.ShipPostalCode, COUNT(o.ShipPostalCode) as totalOrders
from dbo.Orders as o join dbo.[Order Details]as d on o.OrderID=d.OrderID 
where o.ShipPostalCode is not null and o.OrderDate>=DATEADD(year,-27,getdate())
group by d.ProductID,o.ShipPostalCode order by totalOrders desc 
--17
select c.City, count(c.CustomerID) as NumberCustomers
from dbo.Customers as c group by c.City
--18
select c.City, count(c.CustomerID) as NumberCustomers
from dbo.Customers as c group by c.City having count(c.CustomerID)>=2
--19
select c.CompanyName, o.OrderDate
from dbo.Orders as o join dbo.Customers as c on c.CustomerID=o.CustomerID where o.OrderDate>= '1998-01-01'
--20
select c.CompanyName,max(o.OrderDate)
from dbo.Orders as o join dbo.Customers as c on c.CustomerID=o.CustomerID group by c.CompanyName
--21
select c.CompanyName,sum(d.Quantity) as CountProducts
from dbo.Orders as o join dbo.Customers as c on c.CustomerID=o.CustomerID join dbo.[Order Details] as d on o.OrderID=d.OrderID group by c.CompanyName
--22
select c.CustomerID,sum(d.Quantity) as CountProducts
from dbo.Orders as o join dbo.Customers as c on c.CustomerID=o.CustomerID join dbo.[Order Details] as d on o.OrderID=d.OrderID group by c.CustomerID having sum(d.Quantity)<=100
--23
select su.CompanyName,sh.CompanyName
from dbo.Suppliers as su cross join dbo.Shippers as sh
--24
select o.OrderDate,p.ProductName
from dbo.[Order Details] as d join dbo.Orders as o on o.OrderID=d.OrderID join dbo.Products as p on p.ProductID=d.ProductID 
--25
select distinct e.FirstName,es.FirstName,e.Title
from dbo.Employees as e left join dbo.Employees as es on e.Title=es.Title where e.EmployeeID<es.EmployeeID
--26
select e.EmployeeID,e.FirstName+' '+e.LastName as employeeName
from dbo.Employees as e join dbo.Employees as es on e.EmployeeID=es.ReportsTo group by e.EmployeeID,e.FirstName,e.LastName having e.EmployeeID>2
--27
select s.City, s.CompanyName,s.ContactName, 'Supplier' as Type
from dbo.Suppliers as s union all
select c.City, c.CompanyName,c.ContactName, 'Customer' as Type
from dbo.Customers as c 

