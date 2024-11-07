USE [Verduleria]  
GO

-- VER REGISTROS DE UNA TABLA
SELECT * FROM dbo.Clientes; -- Todos los REGISTROS y CAMPOS de una tabla
SELECT clientes.ID_Cliente FROM dbo.Clientes; -- Todos ID_Cliente de la tabla
SELECT * FROM dbo.Clientes ORDER BY ID_Cliente DESC ; -- Ordena por un campo DESC O ASC
SELECT * FROM dbo.Clientes WHERE ID_Cliente = 1; -- Todos datos de ID_Cliente 1
SELECT * FROM dbo.Clientes WHERE Nombre LIKE 'Hanna'; -- Todos datos de Nombre COMO Hanna
SELECT * FROM dbo.Clientes WHERE Nombre LIKE 'M%'; -- Todos datos de Nombre EMPIEZA por M
SELECT * FROM dbo.Clientes WHERE Nombre LIKE '_O%'; -- SEGUNDA POSICION es M

SELECT * FROM dbo.Clientes WHERE ID_Cliente BETWEEN 1 AND 3
SELECT * FROM dbo.Clientes WHERE ID_Cliente in (1,3,4)
SELECT * FROM dbo.Clientes WHERE Nombre in ('Hanna', 'Paco')
SELECT DISTINCT Categoria as PRUEBA from Clientes;

SELECT *, Saldo * 0.16 AS IVA from dbo.Clientes;

--------------------------------------
-- SUM, MIN , MAX, AVG, COUNT, COUNT DISTINCT, 
--------------------------------------

SELECT COUNT (ID_Cliente) AS 'TOTAL VIP' FROM dbo.Clientes WHERE Categoria LIKE 'VIP';
SELECT Categoria, COUNT (ID_Cliente) AS 'TOTAL' FROM dbo.Clientes GROUP BY Categoria;
SELECT SUM (Saldo) AS 'TOTAL CHUSMA' FROM dbo.Clientes WHERE Categoria LIKE 'Chusma';
SELECT OrderID, ROUND(SUM(UnitPrice*Quantity-Discount),2) as Suma FROM [Order Details] GROUP BY OrderID;
SELECT AVG (Saldo) AS 'PROMEDIO' FROM dbo.Clientes WHERE Categoria LIKE 'VIP';

select distinct(Territorydescription) from Territories

SELECT * FROM dbo.Region WHERE RegionDescription LIKE 'N%' 
	OR RegionDescription LIKE 'Southern%' COLLATE Latin1_General_CS_AS; -- Distingue entre mayusculas y minusculas

SELECT * FROM dbo.Region 
	WHERE RegionID > 3 OR RegionDescription LIKE 'Western%' COLLATE Latin1_General_CS_AS; -- Distingue entre mayusculas y minusculas


select min(campo) as Minimo, max(campo) as Maximo, Campo3, Campo4 from TABLA group by Campo3


select distinct TOP 10 ORDERid FROM [Order Details] ; -- 10 PRIMEROS
SELECT distinct TOP 10 OrderId FROM [Order Details] ORDER BY OrderId DESC; -- 10 ULTIMOS
SELECT top 10 with ties Name from product order by Price -- devuelve los que empatan en precio, por lo que no son solo los 10
SELECT TOP 20 PERCENT ...


SELECT FirstName, YEAR(HireDate) AS Año from Employees 
--where year(HireDate) = 1994
--where HireDate between '01/01/1994' AND '31/12/1994' 
WHERE HireDate > '01/01/1994' AND HireDate <'31/12/1994' 

SELECT FirstName, YEAR(HireDate) AS Año from Employees WHERE HireDate > '01/01/1994' AND HireDate <'31/12/1994' 
--where year(HireDate) = 1994
--where HireDate between '01/01/1994' AND '31/12/1994' 


select * from Employees where MONTH(BirthDate) like 1

SELECT len(Nombre) FROM Tabla; -- logitud de cada nombre



SELECT Nombre FROM Tabla WHERE Nombre LIKE '%no%'  -- USAR LIKE  ([], [^], _, % )
--                             CHARINDEX('no', Nombre)>0; -- busca NO en nombre, si ha encontrado es mayor que 0 
--                             Left(Nombre,2) = 'no'  

-- RTRIM, TRIM, LTRIM   Quitar espacios

----------------
SELECT campo1 + '(' + campo2 + ')'  from tabla
SELECT concat(campo1,'(',campo2,')')  from tabla

select COALESCE(P.Color,'Transparente') as Color from Production.Product as P -- SI ALGO ES NULL LO SOBREESCRIBIMOS
------------------


-- INSERTAMOS UN REGISTRO EN LA TABLA
INSERT dbo.Clientes VALUES (1,'Hanna','VIP'); -- Si clave principal NO es autonumerico
INSERT dbo.Clientes VALUES ('Hanna','VIP'); -- Si clave principal es autonumerico
INSERT dbo.Clientes VALUES ('Montana','VIP'); 
INSERT dbo.Clientes VALUES ('Myley','VIP');
INSERT dbo.Clientes VALUES ('Paco','Chusma'); 

INSERT dbo.Pedidos VALUES (1, default); -- DEFAULT Cuando el campo tiene un valor por defecto

insert into PROVE_ZARA select * from PROVEEDORES where CIUDAD not like 'Zaragoza'

--Para permitir ingresar un valor en un campo de identidad (autonumerico) se debe activar la opción "identity_insert":
SET IDENTITY_INSERT arrocera.dbo.nuevapedidos ON;


 -- ACTUALIZAR
 UPDATE dbo.Clientes SET Saldo = 130 WHERE ID_Cliente = 4;

 UPDATE Comercial.pedidos
   SET [numpedido] = 113333,
      [fechapedido] = '1997-08-06 00:00:00.000',
      [clie] = 2114,
      [rep] = 102,
      [fab] = 'qsa',
      [importe] = 20125
 WHERE codigo = 29;

-- DELETE FROM [Comercial].[pedidos] WHERE codigo = 30;