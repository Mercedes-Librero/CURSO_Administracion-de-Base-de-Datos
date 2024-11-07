use Empresa
go

-- INSERTA un Producto nuevo
Insert into Productos VALUES (11,3,'Lapices',100,8.5,0)

insert into Productos ([ID PRODUCTO],[ID PROVEEDOR],[NOMBRE DEL PRODUCTO],SUSPENDIDO) 
values (12,2,'Kikos',0)

select * from productos
select * from PROVEEDORES
select * from PROVE_ZARA

select productos.*, proveedores.[NOMBRE DEL PROVEEDOR], PROVEEDORES.[APELLIDOS DEL PROVEEDOR] from productos
inner join proveedores on proveedores.[ID PROVEEDOR]= PRODUCTOS.[ID PROVEEDOR]

--Mostrar los precio y cantidades de los productos que corresponden al proveedor Felipe López, 
--ordenados ascendentemente por precio de producto.

select productos.precio, productos.CANTIDAD, proveedores.[NOMBRE DEL PROVEEDOR]
from productos
inner join proveedores on proveedores.[ID PROVEEDOR]= productos.[ID PROVEEDOR]
where proveedores.[NOMBRE DEL PROVEEDOR] like 'Felipe'
and proveedores.[APELLIDOS DEL PROVEEDOR] like 'López'
order by precio

12.	Mostrar el máximo de los precios de los productos del proveedor 3, sin 
mostrar el código de este proveedor, hacer lo mismo con el mínimoto

select count([id produto]) as contador from productos where [id proveedor] = 4

select *, PRODUCTOS.* from proveedores 
left join productos on PROVEEDORES.[ID PROVEEDOR]= PRODUCTOS.[ID PROVEEDOR]

-- valor del stock por ciudad

-- calcula el 21% de cada producto
select * from productos

select PRODUCTOS.[NOMBRE DEL PRODUCTO],PRODUCTOS.PRECIO,(precio*0.21) IVA  FROM PRODUCTOS

SELECT PROVEEDORES.[ID PROVEEDOR],PROVEEDORES.[NOMBRE DEL PROVEEDOR],SUM(precio*0.21) IVA  
FROM PRODUCTOS
INNER JOIN PROVEEDORES ON PROVEEDORES.[ID PROVEEDOR]=PRODUCTOS.[ID PRODUCTO]
GROUP BY PROVEEDORES.[ID PROVEEDOR], PROVEEDORES.[NOMBRE DEL PROVEEDOR]

SELECT PROVEEDORES.CIUDAD,PRODUCTOS.[NOMBRE DEL PRODUCTO], MAX(PRODUCTOS.PRECIO)
FROM PRODUCTOS
RIGHT JOIN PROVEEDORES ON PROVEEDORES.[ID PROVEEDOR]= PRODUCTOS.[ID PROVEEDOR]
GROUP BY PROVEEDORES.CIUDAD, PRODUCTOS.[NOMBRE DEL PRODUCTO]
ORDER BY CIUDAD


SELECT PROVEEDORES.CIUDAD, PRODUCTOS.PRECIO
FROM PRODUCTOS
INNER JOIN PROVEEDORES ON PROVEEDORES.[ID PROVEEDOR]= PRODUCTOS.[ID PROVEEDOR]
WHERE CIUDAD LIKE 'BILBAO'
GROUP BY PROVEEDORES.CIUDAD

-- 1.	Crear una consulta que muestre los nombres de los proveedores, ordenados alfabéticamente por proveedor, 
-- que no estén suspendidos (sin visualizar este campo), y 
-- cuyo precio * cantidad no supere las 120,20 €.

SELECT PROVEEDORES.[NOMBRE DEL PROVEEDOR] FROM PROVEEDORES 
INNER JOIN PRODUCTOS ON PROVEEDORES.[ID PROVEEDOR]= PRODUCTOS.[ID PROVEEDOR]
WHERE ((PRECIO*CANTIDAD) < 120.2) AND PRODUCTOS.SUSPENDIDO = 0
ORDER BY [NOMBRE DEL PROVEEDOR] 

	select *
	  into products_copia
	  from dbo.Products;

-- Crear una consulta de creación de tabla prove_zara, a partir de la tabla proveedores, 
-- en los que se incluirán solamente los residentes en Zaragoza. 

	  SELECT * INTO PROVE_ZARA
	  FROM PROVEEDORES WHERE CIUDAD LIKE 'Zaragoza'

select * from proveedores
where [ID PROVEEDOR] not in ( select PROVE_ZARA.[ID PROVEEDOR] from PROVE_ZARA)

 --Crear una consulta que nos agregue a la tabla prove_zara, los proveedores de fuera de Zaragoza.
 insert into PROVE_ZARA  
 select * from PROVEEDORES where CIUDAD not like 'Zaragoza'


--Crear una consulta de creación de la tabla prod_prove en la que se incluirán 
--solamente los proveedores 
--de Zaragoza y los siguientes campos:

select PRODUCTOS.[ID PRODUCTO],PRODUCTOS.[NOMBRE DEL PRODUCTO],
		PROVEEDORES.[NOMBRE DEL PROVEEDOR], PROVEEDORES.CIUDAD
into Prod_prove
from PROVEEDORES 
inner join PRODUCTOS on PROVEEDORES.[ID PROVEEDOR] = PRODUCTOS.[ID PROVEEDOR]
where PROVEEDORES.CIUDAD like 'Zaragoza'

/*
crear un esquema llamado comercial, asignarle la tabla proveedor
crea un usuario 'persona' con el login 'usuario'
asignar a PERSONA esquema COMERCIAL
crea un rol 'rol' y asigna a 'persona' dentro
da permisos a rol en comercial para que haga de todo expecgo actualizar*/

--crear ESQUEMA

CREATE SCHEMA Comercial;

ALTER SCHEMA Comercial TRANSFER dbo.Proveedores;

CREATE LOGIN Usuario WITH PASSWORD = '12345', DEFAULT_DATABASE = Empresa;

create USER Persona FOR LOGIN Usuario 

ALTER USER Persona with default_schema = Comercial

CREATE ROLE Rol;
ALTER ROLE Rol ADD MEMBER Persona;

--da permisos a rol en comercial para que haga de todo expecgo actualizar
GRANT INSERT,DELETE,SELECT,CONTROL,alter ON SCHEMA :: Comercial TO Rol;

-- elimina el login usuario
--DROP LOGIN Usuario;

-- elimina el esquema comercial (no ejecutes)
-- DROP SCHEMA Comercial;

-- crea la tabla 'listado' (id int pk, nombre varchar) dentro de comercial
create table Comercial.Listado(
id int primary key,
nombre varchar(max),
) 

-- deniega a ROL los permisos de borrar dentro de listado
 DENY DELETE ON OBJECT ::Comercial.Listado TO Rol ;

-- crea EL USUARIO 'BECARIO' CON LOGIN 'Practicas' y añade a 'Rol'
CREATE LOGIN Practicas WITH PASSWORD = '12345', DEFAULT_DATABASE = Empresa;
create user Becario for login Practicas
alter role Rol Add Member Becario


-- muestra el precio de los prodcutos con tres decimales
select precio, round(precio/cantidad,3) from productos
where precio > 10 and precio < 130

select top 35 percent * from productos
order by precio desc

--muestra la direfencia en meses entre fecha_contrato y hoy
select * from comercial.PROVEEDORES;