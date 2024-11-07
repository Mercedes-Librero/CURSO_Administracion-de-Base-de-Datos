USE Primera
GO
----------- Tipo de datos
-- char(10) longitud fija. Siempre guarda 10 caracteres (rellena con espacios)
-- varchar(10) longitud variable. Solo guarda lo que ocupe la cadena que hemos metido
-- nvarchar(30) -> longitud variable y puede almacenar datos en formato unicode,


-- RESUMEN  CREATE (Crear) DROP (Eliminar) ALTER (Modificar, añadir a la estructura)

-- Crear tabla de CLIENTES en BBDD Primera con 
		-- ID INT PRINCIPAL
		-- NOMBRE TEXTO OBLIGATORIO
	
		IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME ='Clientes' AND XTYPE = 'U')
			CREATE TABLE Clientes (
				ID int, 
				Nombre varchar(50) not NULL
		)

-- Crear TABLA con DOS PRIMAY KEY
CREATE TABLE productas(
	idfab int,
	idproducto int IDENTITY,
constraint pk_Productas primary key (idfab, idproducto))


-- DROP TABLE Clientes;
-- DROP TABLE Pedidos;

-- Cambiar caracteristicas campo, si queremos cambiar a PRIMARY KEY
	ALTER TABLE Clientes ALTER COLUMN ID INT NOT NULL ; -- Primero, NOT NULL
	ALTER TABLE Clientes ADD PRIMARY KEY (ID); 

-- AÑADIR UN CAMPO A UNA TABLA
	ALTER TABLE dbo.Clientes ADD Saldo INT PRIMARY KEY;


-- Con ID AUTONUMERICO
	CREATE TABLE Clientes (
		ID_Cliente int PRIMARY KEY IDENTITY, 
		Nombre varchar(50) not NULL);

-- Añadimos FOREIGN KEY 

	-- 1º Cuando CREAMOS la TABLA, con relacion al final de la sentecia
		CREATE TABLE Pedidos(
			ID_Pedido INT PRIMARY KEY IDENTITY, -- IDENTITY AUTONUMERICO
			ID_Cliente INT NOT NULL,
			Cantidad FLOAT NOT NULL DEFAULT 0, -- SI NO PONEMOS NADA PONE 0
			CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (ID_Cliente) REFERENCES Clientes (ID_Cliente));

	-- 2º Cuando CREAMOS la TABLA, con relacion a nivel de CAMPO
			CREATE TABLE Pedidos(
				ID_Pedido INT PRIMARY KEY IDENTITY, 
				ID_Cliente INT NOT NULL CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY REFERENCES Clientes (ID_Cliente),
				Cantidad FLOAT DEFAULT 0);

	-- 3º Crear RELACION en tablas EXISTENTES
		ALTER TABLE Pedidos ADD CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (ID_Cliente) REFERENCES Clientes (ID_Cliente);


-- Eliminamos RELACCION  FK_Pedidos_Clientes 
	ALTER TABLE  dbo.Pedidos DROP CONSTRAINT  FK_Pedidos_Clientes;


-- Poner DEFAULT a un CAMPO ya creado. DEFAUL -> VALOR POR DEFECTO
	ALTER TABLE Pedidos ADD DEFAULT 0 FOR Cantidad;


-- Crear un INDICE, para busquedas rapidas por un campo NO PRIMARY KEY
	CREATE TABLE Productos (
	ID_Producto INT PRIMARY KEY IDENTITY,
	Nombre_Producto VARCHAR(MAX) NOT NULL,
	Precio FLOAT UNIQUE,
	INDEX  IndicePrecio (Precio ASC));  --Tambien UNIQUE INDEX para que no se pueda repetir

-- 	ELIMINAR PRIMARY KEY
	ALTER TABLE Proveedores 
	DROP CONSTRAINT PK__Proveedo__477B858E67EC87D9; -- Este nombre esta en la Tabla Proveedores > CLAVES  
	GO 


	-- ALTER TABLE Productos DROP INDEX IndicePrecio  --ELIMINAR index
	-- ALTER TABLE Oficinas DROP COLUMN DIR -- ELIMINAR columna
	-- CREATE INDEX IndicePrecio ON Productos (Precio ASC)   -- Incluir un INDICE despues de CREADA la TABLA
--------------------------------------------------------------------------------------
SELECT * FROM Clientes;
SELECT * FROM Pedidos;
SELECT * FROM Productos WHERE Cantidad is null;
INSERT dbo.Clientes VALUES ('Juan'); 
INSERT dbo.Pedidos VALUES (1, default); 
INSERT dbo.Productos VALUES ('Producto 3', 15.2,null); 
--------------------------------------------------------------------------------------

UPDATE Productos SET Cantidad = 10 where Cantidad is NULL;


-- Cambiar NOMBRE de CAMPO
exec sp_rename 'TABLA.nombre_viejo', 'nombre_nuevo','column';

-- Cambiar NOMBRE de TABLA
exec sp_rename tarjetas, CARDS
