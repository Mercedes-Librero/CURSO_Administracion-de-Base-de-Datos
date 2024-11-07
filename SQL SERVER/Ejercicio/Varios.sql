-- 1 Crear la tabla empleados y definir su clave principal en la misma instrucci�n de creaci�n.
create table Empleadas (
	numemp int primary key,
	nombre varchar(50) not null,
	edad tinyint not null);

--2 Crear la tabla oficinas con su clave principal y su clave for�nea 
	-- (la columna dir contiene el c�digo de empleado del director de la oficina luego es un campo que hace referencia a un 
	-- empleado luego es clave for�nea y hace referencia a la tabla empleados).
create table oficinos(
	oficina int primary key,
	ciudad varchar(50) not null,
	region varchar(50) not null);

alter table oficinos add dir int NOT NULL;

-- MODIFICA EL CAMPO DIR Y HACERLO TINYINT

ALTER TABLE OFICINOS ALTER COLUMN dir tinyint not null;

-- Relaciona empleadas y oficinos
ALTER TABLE oficinos ADD CONSTRAINT FK_Oficinos_Empleadas FOREIGN KEY (oficina) REFERENCES Empleadas (numemp);

	select *
	  into ClientesVisa
	  from Clientes where limitecredito > 5000 

	  create index 	indice_dir ON OFICINOS(DIR)


-- 3 Crear la tabla productAs con su clave principal.
CREATE TABLE productas(
	idfab int,
	idproducto int IDENTITY,
	descripcion varchar(50) unique not null,
	exitencias int DEFAULT 0,
	precio float not null,
constraint pk_Productas primary key (idfab, idproducto))



4 Crear la tabla clientes tambi�n con todas sus claves y sin la columna limitecredito.
5 Crear la tabla pedidos sin clave principal, con la clave for�nea que hace referencia a los productos, la que hace referencia a clientes y la que indica el representante (empleado) que ha realizado el pedido.
6 A�adir a la definici�n de clientes la columna limitecredito.
7 A�adir a la tabla empleados las claves for�neas que le faltan. (Si no tienes claro cuales son te lo decimos ahora: la columna oficina indica la oficina donde trabaja el empleado y la columna director indica qui�n dirige al empleado, su jefe inmediato).
8 Hacer que no puedan haber dos empleados con el mismo nombre.
9 A�adir a la tabla de pedidos la definici�n de clave principal.
10 Definir un �ndice sobre la columna regi�n de la tabla de oficinas.
11 Eliminar el �ndice creado.
