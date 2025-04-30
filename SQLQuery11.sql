USE AdventureWorks2019
GO
SELECT p.ProductID,p.Name,p.Color,p.ListPrice
FROM Production.Product as p

SELECT p.ProductID,p.Name,p.Color,p.ListPrice
FROM Production.Product as p where p.ListPrice <> 0

SELECT p.ProductID,p.Name,p.Color,p.ListPrice
FROM Production.Product as p where p.Color is Null 

SELECT p.ProductID,p.Name,p.Color,p.ListPrice
FROM Production.Product as p where p.Color is Not Null

SELECT p.ProductID,p.Name,p.Color,p.ListPrice
FROM Production.Product as p where p.Color is Not Null and p.ListPrice > 0

SELECT p.Name + p.Color as Namecolor
FROM Production.Product p where p.Color is Null

SELECT p.Name, p.Color
FROM Production.Product as p
WHERE (p.Name = 'LL Crankarm' AND p.Color = 'Black')
   OR (p.Name = 'ML Crankarm' AND p.Color = 'Black')
   OR (p.Name = 'HL Crankarm' AND p.Color = 'Black')
   OR (p.Name = 'Chainring Bolts' AND p.Color = 'Silver')
   OR (p.Name = 'Chainring Nut' AND p.Color = 'Silver')
   OR (p.Name = 'Chainring' AND p.Color = 'Black');


SELECT p.ProductID, p.Name 
FROM Production.Product p where p.ProductID between 400 and 500

SELECT p.ProductID, p.Name , p.Color
FROM Production.Product p where p.Color Not in ('Black','Blue')

SELECT p.ProductID,p.Name
FROM Production.Product as p where p.Name like 'S%'

SELECT p.Name, p.ListPrice 
FROM Production.Product as p  order by p.Name

SELECT p.Name, p.ListPrice 
FROM Production.Product as p where p.Name like '[AS]%'  order by p.Name 

SELECT p.Name, p.ListPrice
FROM Production.Product as p
WHERE Name LIKE '[SPO]%' 
  or (LEN(p.Name) < 2 or SUBSTRING(p.Name, 2, 1) <> 'K')
ORDER BY p.Name;

SELECT DISTINCT p.Color
FROM Production.Product as p
ORDER BY p.Color DESC;