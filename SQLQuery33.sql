

use Northwind
go
-- 1. List all cities that have both Employees and Customers.
SELECT DISTINCT City
FROM Customers
WHERE City IN (SELECT DISTINCT City FROM Employees);

-- 2a. Cities that have Customers but no Employee (using sub-query)
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT DISTINCT City FROM Employees);

-- 2b. Cities that have Customers but no Employee (without sub-query)
SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL;

-- 3. Products and their total order quantities
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 4. Customer Cities and total products ordered
SELECT c.City, SUM(od.Quantity) AS TotalProductsOrdered
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

-- 5. Customer Cities with at least two customers
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

-- 6. Cities that ordered at least two different kinds of products
SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

-- 7. Customers with ship city different from their own city
SELECT DISTINCT c.CustomerID, c.CompanyName, c.City AS CustomerCity, o.ShipCity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;

-- 8. 5 most popular products, average price, and top ordering customer city
WITH ProductPopularity AS (
    SELECT od.ProductID, SUM(od.Quantity) AS TotalQuantity
    FROM [Order Details] od
    GROUP BY od.ProductID
),
TopProducts AS (
    SELECT TOP 5 ProductID
    FROM ProductPopularity
    ORDER BY TotalQuantity DESC
),
ProductCitySales AS (
    SELECT od.ProductID, o.ShipCity, SUM(od.Quantity) AS QuantitySold
    FROM [Order Details] od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE od.ProductID IN (SELECT ProductID FROM TopProducts)
    GROUP BY od.ProductID, o.ShipCity
),
MaxCitySales AS (
    SELECT pcs.ProductID, pcs.ShipCity, pcs.QuantitySold,
           ROW_NUMBER() OVER (PARTITION BY pcs.ProductID ORDER BY pcs.QuantitySold DESC) AS rn
    FROM ProductCitySales pcs
)
SELECT p.ProductName, AVG(od.UnitPrice) AS AveragePrice, mcs.ShipCity AS TopCity
FROM MaxCitySales mcs
JOIN Products p ON mcs.ProductID = p.ProductID
JOIN [Order Details] od ON mcs.ProductID = od.ProductID
WHERE mcs.rn = 1
GROUP BY p.ProductName, mcs.ShipCity;

-- 9a. Cities that never ordered anything but have employees (using sub-query)
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (
    SELECT DISTINCT c.City
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
);

-- 9b. Cities that never ordered anything but have employees (without sub-query)
SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN (
    SELECT DISTINCT c.City
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
) co ON e.City = co.City
WHERE co.City IS NULL;

-- 10. One city that's top in order count and top in total quantity ordered
WITH EmployeeOrderCounts AS (
    SELECT e.City AS EmployeeCity, COUNT(o.OrderID) AS OrderCount
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
TopEmployeeCity AS (
    SELECT TOP 1 EmployeeCity
    FROM EmployeeOrderCounts
    ORDER BY OrderCount DESC
),
CustomerOrderQuantities AS (
    SELECT c.City AS CustomerCity, SUM(od.Quantity) AS TotalQuantity
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.City
),
TopCustomerCity AS (
    SELECT TOP 1 CustomerCity
    FROM CustomerOrderQuantities
    ORDER BY TotalQuantity DESC
)
SELECT tec.EmployeeCity, tcc.CustomerCity
FROM TopEmployeeCity tec
JOIN TopCustomerCity tcc ON tec.EmployeeCity = tcc.CustomerCity;

-- 11. How to remove duplicate records from a table
-- Example using ROW_NUMBER (you need to replace TableName and columns)
WITH CTE_Duplicates AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Column1, Column2 ORDER BY ID) AS rn
    FROM TableName
)
DELETE FROM CTE_Duplicates
WHERE rn > 1;
