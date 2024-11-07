
-- muestra empleados que no sean de LONDRES
SELECT * FROM Employees 
 where city <> 'London'
 -- where city NOT LIKE 'London'

 -- muestra ID Y NOMBRE, valor total en stock, iva del 18% que no esten DISCONTINUOS y sean CONDIMENTOS
Select productid, productname, (unitPrice*UnitsinStock) as ValorTotal, 
	(unitPrice*UnitsinStock)*2.21 as [IVA21%]
from Products
where Categoryid like 2 and Discontinued like 0;

-- productos del proveedor de Oviedo (usa ALIAS) TODOS LOS CAMPOS DE LAS DOS TABLAS
Select * from Products;
Select S.*, P.* from Suppliers S
inner join Products P on P.SupplierID = S.SupplierID
where S.City like 'Oviedo'

-- Valor total de los productos, el precio medio por unidad, cuantos y cuantos productos diferentes
Select sum(unitPrice*Unitsinstock) as ValorStock,
 avg(unitPrice) as PromedioPrecioStock,
 sum(unitsinStock) as TotalUnidades,
 count(productId) as TotalProductos
 FROM Products; 

 -- MOSTRAR LAS VENTAS DE AÑO 97 Y TRANSPORTADAS POR Federal
 Select O.* from Orders O
 inner join Shippers S on S.ShipperID = O.ShipVia
 where Year(ShippedDate) = 1997 AND S.CompanyName LIKE 'Federal%';

 -- Muestra los trabajadores que han usado Federal como transportista
 Select * From Shippers
 Select * from orders
 Select * from Employees

 Select distinct(Trabajador.FirstName) from Employees Trabajador
 inner join Orders Factura on Factura.EmployeeID=Trabajador.EmployeeID
 inner join Shippers Transportista on Transportista.ShipperID = Factura.ShipVia
 Where Transportista.CompanyName like 'Federal%';

-- muestra en un solo campo 'EL PRODUCTO xxx VALE xxx €
Select 'El producto' + ProductName + '      Vale ' + Cast(unitprice as varchar) + '€'
from Products;

-- Empleados -> 'Hola Apellido, nombre vives en ...'
select 'Hola ' + LastName + ', ' + FirstName + ' vives en ' + City
from Employees

---------------------------------------------------------------------------------------------------------------
-- F U N C I O N E S    D E    V E N T A N A    (con over() es mucho mas rapido para BBDD muy grandes)

	USE AdventureWorks2016


	SELECT DISTINCT SUM(listprice) OVER (PARTITION BY COLOR) AS Total
				  , MAX(listprice) OVER (PARTITION BY COLOR) AS MAXIMO
	FROM Production.Product

	SELECT SUM(listprice) AS Total
		, MAX(listprice) AS MAXIMO
	FROM Production.Product
	GROUP BY cOLOR
 
	--*

	SELECT Production.ProductSubcategory.Name, 
			COUNT(*) AS Cantidad
	FROM     Production.ProductSubcategory 
	RIGHT OUTER JOIN Production.Product ON Production.ProductSubcategory.ProductSubcategoryID = Production.Product.ProductSubcategoryID
	GROUP BY Production.ProductSubcategory.Name



	SELECT distinct Production.ProductSubcategory.Name, Color, 
			COUNT(*) over (PArtition by Production.ProductSubcategory.ProductSubcategoryID,Color ) AS Cantidad
	FROM     Production.ProductSubcategory 
	inner JOIN Production.Product ON Production.ProductSubcategory.ProductSubcategoryID = Production.Product.ProductSubcategoryID
	
 
	--*
	-- Cuanto se ha vendido de cada color (teniendo en cuenta transparentes)
	SELECT  SUM(Sales.SalesOrderDetail.OrderQty) AS Cantidad, 
				COALESCE(Production.Product.Color,'Transparente') as Color 
	FROM     Production.Product 
	INNER JOIN  Sales.SalesOrderDetail ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
	GROUP BY COALESCE(Production.Product.Color,'Transparente') 

	SELECT distinct SUM(Sales.SalesOrderDetail.OrderQty) over (PArtition by Color) AS Cantidad,
		COALESCE(Production.Product.Color,'Transparente') as Color 
	FROM     Production.Product 
	INNER JOIN  Sales.SalesOrderDetail ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID


	--*
	--15.- Para cada producto quiero saber cual es el menr precio por el que hemos vendido un producto.

		SELECT MIN(Sales.SalesOrderDetail.UnitPrice) AS PrecioMinimo, 
				Production.Product.ProductID, Production.Product.Name
		FROM     Production.Product 
		INNER JOIN Sales.SalesOrderDetail ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
		GROUP BY Production.Product.ProductID, Production.Product.Name

		SELECT distinct MIN(Sales.SalesOrderDetail.UnitPrice) over (PArtition by Name) AS PrecioMinimo, 
				Production.Product.ProductID, Production.Product.Name
		FROM     Production.Product 
		INNER JOIN Sales.SalesOrderDetail ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID