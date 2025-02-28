SELECT c.CustomerID, p.FirstName, p.LastName, soh.SalesOrderID, soh.TotalDue
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID;
SELECT p.ProductID, p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory psc 
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc 
    ON psc.ProductCategoryID = pc.ProductCategoryID;
SELECT soh.SalesOrderID, soh.OrderDate, sm.Name AS ShippingMethod
FROM Sales.SalesOrderHeader soh
JOIN Purchasing.ShipMethod sm 
    ON soh.ShipMethodID = sm.ShipMethodID;
SELECT sp.BusinessEntityID, p.FirstName, p.LastName, st.Name AS TerritoryName
FROM Sales.SalesPerson sp
JOIN Person.Person p 
    ON sp.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Sales.SalesTerritory st 
    ON sp.TerritoryID = st.TerritoryID;
SELECT p.ProductID, p.Name AS ProductName, sod.SalesOrderID, sod.OrderQty
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID;
SELECT c.CustomerID, p.FirstName, p.LastName, SUM(soh.TotalDue) AS TotalSpent
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName;
SELECT p.Name AS ProductName, SUM(sod.OrderQty) AS TotalSold
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
GROUP BY p.Name;
    SELECT p.Name AS ProductName, SUM(sod.OrderQty) AS TotalSold
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
GROUP BY p.Name;
SELECT st.Name AS TerritoryName, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesTerritory st
JOIN Sales.SalesOrderHeader soh 
    ON st.TerritoryID = soh.TerritoryID
GROUP BY st.Name;
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (
    SELECT CustomerID FROM Sales.SalesOrderHeader
);
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID FROM Sales.SalesOrderDetail
);
    SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product);
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice = (SELECT MIN(ListPrice) FROM Production.Product);
SELECT DISTINCT p.FirstName, p.LastName
FROM Person.Person p
JOIN Sales.Customer c 
    ON p.BusinessEntityID = c.PersonID
WHERE c.CustomerID IN (
    SELECT soh.CustomerID 
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod 
        ON soh.SalesOrderID = sod.SalesOrderID
    WHERE sod.ProductID = 707
);
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice > (
    SELECT AVG(ListPrice) FROM Production.Product
);
SELECT sp.BusinessEntityID, p.FirstName, p.LastName, sp.SalesYTD
FROM Sales.SalesPerson sp
JOIN Person.Person p 
    ON sp.BusinessEntityID = p.BusinessEntityID
WHERE sp.SalesYTD > (
    SELECT SalesYTD FROM Sales.SalesPerson WHERE BusinessEntityID = 276
);
