                                                                                                  /*
1º CREAMOS DOS ESQUEMAS
                                                                                                  */
USE Verduleria -- BBDD de ejemplo Verduleria
GO
CREATE SCHEMA RecursosHumanos;
CREATE SCHEMA Produccion;
                                                                                                  /*
2º CREAMOS UNA TABLA
                                                                                                  */
CREATE TABLE RecursosHumanos.Empleado
( codigo int primary key,
 nombre varchar(25),
 apellido varchar(25)
)

--------------------------------------------------------------------------------------------------
                                                                                                  /*
3º  CREAMOS 2 INICIOS DE SESION
                                                                                                  */
USE MASTER 
GO
CREATE LOGIN Director
WITH PASSWORD = '12345';

CREATE LOGIN Gerente
WITH PASSWORD = '12345';
--------------------------------------------------------------------------------------------------
                                                                                                  /*
4º  CREAMOS DOS USUARIOS, UNO PARA CADA ESQUEMA
                                                                                                  */
USE Verduleria 
GO
CREATE USER JuanPerez FOR LOGIN Director
WITH DEFAULT_SCHEMA = RecursosHumanos
CREATE USER MarioRivas FOR LOGIN Gerente
WITH DEFAULT_SCHEMA = Produccion
--------------------------------------------------------------------------------------------------
                                                                                                  /*
5º  ASIGNAMOS PERMISOS AL USURIO
                                                                                                  */
USE Verduleria 
GO

GRANT SELECT
ON SCHEMA :: RecursosHumanos
TO JuanPerez
WITH GRANT OPTION
GO
--------------------------------------------------------------------------------------------------
                                                                                                  /*
6º  Asignar permisos tabla por tabla
                                                                                                  */
USE Verduleria 
GO																								  
GRANT INSERT ON OBJECT::RecursosHumanos.Empleado
TO JuanPerez
--------------------------------------------------------------------------------------------------
                                                                                                  /*
Quitar los permisos sobre un esquema
                                                                                                  */
REVOKE SELECT
ON SCHEMA :: RecursosHumanos
TO JuanPerez CASCADE
--------------------------------------------------------------------------------------------------
                                                                                                  /*
Quitar permisos sobre tablas
                                                                                                  */
REVOKE INSERT ON OBJECT::RecursosHumanos.Empleado
TO JuanPerez