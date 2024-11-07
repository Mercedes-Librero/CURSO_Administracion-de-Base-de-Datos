SELECT * FROM dbo.Region;
SELECT * FROM dbo.Region WHERE RegionDescription LIKE 'N%' OR RegionDescription LIKE 'S%'

SELECT * FROM dbo.Region WHERE RegionDescription LIKE 'N%' 
	OR RegionDescription LIKE 'Southern%' COLLATE Latin1_General_CS_AS; -- Distingue entre mayusculas y minusculas

SELECT * FROM dbo.Region WHERE RegionID > 3 OR RegionDescription LIKE 'Western%' COLLATE Latin1_General_CS_AS; -- Distingue entre mayusculas y minusculas

SELECT * FROM dbo.Territories
SELECT * FROM dbo.Region;

SELECT RegionID, COUNT(RegionID) FROM dbo.Territories GROUP BY RegionID;

select distinct(Territorydescription) from Territories

SELECT RegionDescription, TerritoryDescription FROM Region 
INNER JOIN Territories ON Region.RegionID = Territories.RegionID
ORDER BY RegionDescription DESC;

-- MUESTRA LOS TERRITORIOS 
SELECT * FROM Territories WHERE TerritoryID IN (08837,11747,14450)

SELECT * FROM [Order Details]
select * from Products

-- Muestra promedio precio por unidad
SELECT AVG(UnitPrice) AS PrOmEdIo FROM [Order Details]

SELECT OrderID, ROUND(SUM(UnitPrice*Quantity-Discount),2) as Suma FROM [Order Details] GROUP BY OrderID;

--muestra los nombre de los productos de cada pedido y el id del pedido

SELECT OrderID, productName FROM [Order Details]
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
order by ProductName

-- muestra los  primeros pedidos 
select distinct TOP 10 ORDERid FROM [Order Details] ;

SELECT distinct TOP 10 OrderId FROM [Order Details] ORDER BY OrderId DESC;

SELECT * FROM Employees
SELECT * FROM EmployeEs ORDER BY BirthDate DESC

SELECT FirstName, YEAR(HireDate) AS Año from Employees 
--where year(HireDate) = 1994
--where HireDate between '01/01/1994' AND '31/12/1994' 
WHERE HireDate > '01/01/1994' AND HireDate <'31/12/1994' 


select * from Employees 
where MONTH(BirthDate) like 1

select TitleOfCourtesy, count(EmployeeId) as TOTAL FROM Employees
group by TitleOfCourtesy

SELECT EMPLEADO.FirstName as EMPLEADO, JEFE.FirstName AS JEFE
FROM Employees AS EMPLEADO 
INNER JOIN Employees AS JEFE ON EMPLEADO.ReportsTo = JEFE.EmployeeID

-- Muestra el id del EMPLEADO, APELLIDO, CIUDAD Y EL ID DE se Region

select * from Employees
select * from Territories
SELECT Employees.EmployeeID, lastname, city, territoryDescription
FROM (Employees INNER JOIN EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID)
inner join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
ORDER BY EmployeeID


Select * from Categories
Select * from Products
Select * from Suppliers
-- Descripcion de las categorias y nombre de los productos 
Select ProductName, Categories.Description from Categories
inner join Products on Categories.CategoryID = Products.CategoryID

-- mostrar cuantos productos hay en cada categoria
Select Count(ProductID) as Numero, CategoryName from Products 
inner join Categories on Products.CategoryID = Categories.CategoryID
group by Categories.CategoryName

-- mostrar la media u el total del precio por unidad los productos en cada categoria
Select  SUM(UnitPrice) AS TOTAL, AVG(UnitPrice) as MEDIA, Categories.CategoryName from Products
INNER JOIN Categories on Products.CategoryID = Categories.CategoryID
group by Categories.CategoryName


-- muestra el nombre de la categoria, nombre de los productos y el nombre del proveedor
Select Products.ProductName, CompanyName, CategoryName from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Products.CategoryID = Categories.CategoryID

Select Products.ProductName, Suppliers.CompanyName, Categories.CategoryName
from (Categories 
inner join products on Categories.CategoryID = Products.CategoryID)
inner join Suppliers on Products.SupplierID = Suppliers.SupplierID

-- muestra el nombre de los empleados y la descripcion de la region
Select distinct firstname, regiondescription
from (Employees inner join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID)
inner join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
inner join region on region.RegionID = Territories.RegionID

-- muestra id y nombre del producto, valor total en strock, iva de 18%, de aquellos