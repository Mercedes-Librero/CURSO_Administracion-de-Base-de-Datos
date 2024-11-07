USE Primera
GO

--crear ESQUEMA
CREATE SCHEMA Segunda;


-- crear UN TABLA con el ESQUEMA
CREATE TABLE Segunda.Materiales(
	ID_Material INT PRIMARY KEY,
	Descripcion Varchar(MAX) NOT NULL);


--CREAR LOGIN o inicio de sesion para la BBDD Primera
CREATE LOGIN Chema WITH PASSWORD = '12345', DEFAULT_DATABASE = Primera;


-- ELIMINAR LOGIN
--DROP LOGIN Chema;


-- CREAR USUARIO con esquema
create USER Platanito FOR LOGIN Chema 
WITH DEFAULT_SCHEMA = Segunda;


--PONER ESQUEMA USUARIO
ALTER USER Platanito with DEFAULT_SCHEMA = Segunda;


-- MODIFICAR LOGIN DE USUARIO
ALTER USER Platanito WITH LOGIN 'Inicio_Sesion';


-- Poner TABLA de ESQUEMA
ALTER SCHEMA Segunda TRANSFER dbo.Materiales;


-- Eliminar ESQUEMA
-- DROP SCHEMA Segunda;


-- Dar PERMISOS
GRANT SELECT ON SCHEMA :: Segunda TO Platanito
WITH GRANT OPTION
GO

-- Denegar permisos (para la tabla Comercial.Listado y nombre del ROL)
 DENY DELETE ON OBJECT ::Comercial.Listado TO Rol




-- Quita PERMISOS
REVOKE DELETE ON SCHEMA :: Segunda to Platanito;


-- Crear ROL
CREATE ROLE Penitentes;

-- Crear ROL con PROPIETARIO
CREATE ROLE MADE AUTHORIZATION Platanito;

-- Añadir USUARIOS a un ROL
ALTER ROLE Penitentes ADD MEMBER Platanito;

-- dar PERMISOS a un ROL o un ESQUEMA
GRANT INSERT,DELETE,UPDATE,SELECT ON SCHEMA :: Segunda TO Penitentes;

GRANT INSERT,DELETE,UPDATE,SELECT ON ROLE :: Segunda TO Penitentes;


-- MODIFICAR ROL (Solo elegir una )
ALTER ROLE role_name 
	ADD MEMBER database_principal |
	DROP MEMBER database_principal |
	WITH NAME = new_name
;


