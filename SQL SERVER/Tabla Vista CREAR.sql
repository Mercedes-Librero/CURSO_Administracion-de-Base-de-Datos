USE Northwind
GO

-- Crear tabla 
	create table 
	utiles (id int primary key, nombre varchar(19) not NULL);

-- Crear Vista // Si se MODIFICA la TABLA original se modifica la LISTA
	create view Regiones_impares
	as 
	Select * from dbo.Region
	where RegionID in(1,5,3)

	select * from Regiones_impares  -- para ver la vista

-- Crear copia tabla de otra tabla COMPLETA
	select *
	  into products_copia
	  from dbo.Products;

-- Crear copia tabla de otra tabla ELIGIENDO CAMPOS O REGISTROS
	select ProductID
	  into products_copia
	  from dbo.Products WHERE CategoryID = 1;

	select PRODUCTOS.[ID PRODUCTO],PRODUCTOS.[NOMBRE DEL PRODUCTO],
		PROVEEDORES.[NOMBRE DEL PROVEEDOR], PROVEEDORES.CIUDAD
		into Prod_prove
		from PROVEEDORES 
		inner join PRODUCTOS on PROVEEDORES.[ID PROVEEDOR] = PRODUCTOS.[ID PROVEEDOR]
	where PROVEEDORES.CIUDAD like 'Zaragoza'


-- Copia de la tabla region, insertar, actualizar registros ... EJERCICION TRABAJOS

		select * into Region_COPIA
		from dbo.Region;

		insert into dbo.Region_COPIA (RegionID,RegionDescription)
		values (100,'Zaragoza');

		insert into dbo.Region_COPIA values (101,'Guadalajara');
		insert into dbo.Region_COPIA values (102,'Madrid');
		insert into dbo.Region_COPIA values (103,'Huesca');

		delete from Region_COPIA where  RegionID like 1 ;
		delete from Region_COPIA where  RegionID in (2,3,4)

-- BACKUP DATABASE AdventureWorksDW2019
BACKUP DATABASE AdventureWorksDW2019
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\copiaProgramadaAdventureWorksDW2019.bak';

-- SINONIMOS
	create synonym [Sino].[Pedidos] for [Northwind].dbo.Orders

	Select * from dbo.Pedidos
	select * from Sino.Clientes

-- REPLICACION

	USE ParaReplicarMercedes
	GO
	/*	create table 
		Tabla_1 (id int primary key, nombre varchar(19) not NULL);

			insert into dbo.Tabla_1 values (110,'Un Nombre');
			insert into dbo.Tabla_1 values (111,'Dos Nombre');
			insert into dbo.Tabla_1 values (112,'Tres Nombre'); */

			-- C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\ReplData
			-- C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Data




