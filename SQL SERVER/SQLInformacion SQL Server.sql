--muestra las bases de datos
SELECT * FROM sys.databases;
EXEC sp_databases;
--muestra la ocupacion real de la base de datos;
exec sp_spaceused;

--muestra los archivos de las bases de datos
SELECT * FROM sys.master_files;
select database_id,name,file_id,type_desc,physical_name
from sys.master_files;



--mostrar todas las tablas y vistas de una base de datos
use arrocera;
Select * From information_schema.tables

--mostrar usuario conectados
exec SP_WHO2;


use master;
--muestra los usuarios de una base de datos
SELECT * FROM sysusers;
--muestra todos los login de una entidad
SELECT *  FROM syslogins;
SELECT * FROM sys.sql_logins;

--muestra usuarios,roles de una base datos
use AdventureWorksDW2019;
SELECT * FROM sys.database_principals;
SELECT * FROM sys.server_principals;

--muestra los roles y sus miembros
SELECT
  p.name rol,
  p.principal_id id_rol,
  m.name usuario,
  m.principal_id id_usuario
FROM sys.database_role_members rm
  INNER JOIN sys.database_principals p
    ON rm.role_principal_id = p.principal_id
  INNER JOIN sys.database_principals m
    ON rm.member_principal_id = m.principal_id
ORDER BY p.name

--muestra los esquemas de una base de datos
SELECT * FROM Alumno_suCarnet.INFORMATION_SCHEMA.SCHEMATA;
--muestra los esquemas y las tablas/vistas correspondientes
use AdventureWorksDW2019;
select sc.name, o.name from sys.objects o
join sys.schemas sc on o.schema_id = sc.schema_id
where o.type = 'U';


-- SINONIMOS
--		1º Crear esquema
--		2º En Sinonimos (BBDD) > Boton derecho NUEVO SINONIMO

-- TAREAS PROGRAMADAS
--		Agente SQL Server


-- crear sinonimos
		CREATE SYNONYM Seguridad.Currantes   --NOMBRE SINONIMO
		FOR dbo.Empleados                    -- Tabla

		select * from sys.synonyms

		select * from sys.synonyms
		inner join sys.schemas on sys.schemas.schema_id = sys.synonyms.schema_id