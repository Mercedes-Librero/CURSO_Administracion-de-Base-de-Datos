 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

--------------------------------------

EJECUTAR DESDE SYS
----------------------------------------------
crear el tablespace TajoBritanico
con el usuario Empresa
dar permisos completos a empresa
y crear la conexion empresa

----CREAR TABLESPACE TAJOBRITANICO
CREATE TABLESPACE TajoBritanico
    DATAFILE 'D:/Certificado BBDD/programas/Oracle/BBDDTajoBritanico.dbf' 
    size 100M
    autoextend on next 10M
    maxsize 2G;

--HACER QUE ORACLE NOS DEJE CREAR USUARIOS
alter session set "_ORACLE_SCRIPT"=true;
  
--CREAMOS USUARIO EMPRESA ASIGNANDOLE EL TABLESPACE TAJOBRITANICO
  CREATE USER empresa IDENTIFIED BY "empresa"
  default tablespace TajoBritanico
  temporary tablespace TEMP;

--DAR PERMISOS A USUARIO EMPRESA
GRANT CONNECT, RESOURCE TO EMPRESA;

GRANT UNLIMITED TABLESPACE TO EMPRESA;

GRANT ALL PRIVILEGES TO EMPRESA;

GRANT EXECUTE ANY PROCEDURE TO EMPRESA;
GRANT UNLIMITED TABLESPACE TO EMPRESA;

--eliminar usuario
drop user empresa;

--elminar tablespace
drop tablespace tajobritanico;

--quitar privilegios de una tabla
REVOKE ALL PRIVILEGES ON nombretabla FROM empresa;
--quitar todos los permisos a empresa (usuario)
REVOKE ALL PRIVILEGES FROM empresa;

--quitar todos los permisos de una tabla a todo el mundo
REVOKE ALL PRIVILEGES ON nombretabla FROM PUBLIC;


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
*CREAR UN TABLESPACE BBDDVENTAS

CREATE TABLESPACE BBDDVetas
    DATAFILE 'c:/BBDDoracle/BBDDVentas.dbf' 
    size 100M
    autoextend on next 10M
    maxsize 2G;
---------------------------------------------------------------------------------------------------
--CREAR USUARIO VENTAS Y DAR PRIVILEGIOS TOTAL DE USUARIO

alter session set "_ORACLE_SCRIPT"=true;
  
  CREATE USER ventas IDENTIFIED BY "Ventas"
  default tablespace BBDDVetas
  temporary tablespace TEMP;
  
CREATE USER VENTAS IDENRIFIED BY VENTAS;
CREATE USER 'Ventas'@'localhost' IDENTIFIED BY 'contraseña;

CREATE USER <NOMBRE_DEL_USUARIO> IDENTIFIED BY <PASSWORD_DEL_USUARIO>;

GRANT ALL PRIVILEGES TO Ventas;

GRANT EXECUTE ANY PROCEDURE TO ventas;
GRANT UNLIMITED TABLESPACE TO ventas;

-----------------------------------------------------------------------------------------------------------------------------
select GRANTEE, GRANTED_ROLE, ADMIN_OPTION from dba_role_privs where GRANTEE='GSMUSER';

GRANT CONNECT, RESOURCE TO GSMUSER;
GRANT UNLIMITED TABLESPACE TO GSMUSER;