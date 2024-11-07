-- Crear BBDD NORMAL
CREATE DATABASE [Primera]
ON PRIMARY
(NAME =N'Primera' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera.mdf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
LOG ON
(NAME = N'Primera_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera_log.ldf',
SIZE = 8000KB, MAXSIZE = 2048GB, FILEGROWTH = 65536KB)


-- Crear BBDD CON VARIOS ARCHIVOS, por ejemplo para guardar en distinto discos duros
CREATE DATABASE [Primera] 
ON PRIMARY
(NAME =N'Primera' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera.mdf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB),
(NAME =N'Primera3' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera3.mdf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB),
FILEGROUP Zaragoza
(NAME =N'Primera2' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera2.mdf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
LOG ON
(NAME = N'Primera_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera_log.ldf',
SIZE = 8000KB, MAXSIZE = 2048GB, FILEGROWTH = 65536KB),
(NAME = N'Primera2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera2_log.ldf',
SIZE = 8000KB, MAXSIZE = 2048GB, FILEGROWTH = 65536KB)


-- Añadir archivo a la BBDD
ALTER DATABASE Primera
ADD FILE
(NAME =N'Primera4' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera4.mdf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
TO FILEGROUP Zaragoza;


-- Añadir archivo LOG a la BBDD
ALTER DATABASE Primera
ADD LOG FILE
(NAME =N'Primera6_log' , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primera6_log.ldf',
SIZE = 8MB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB);


-- Cambiar NOMBRE ...
ALTER DATABASE Primera
MODIFY FILE
(NAME = 'Primera4', 
-- --------------------------opcional cambiar
NEWNAME= 'Primero4',
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Primero4.mdf',
SIZE = 10MB,
MAXSIZE = 300MB,
FILEGROWTH = 8MB);


-- Añadir Grupos
ALTER DATABASE Primera
ADD FILEGROUP Huesca;


-- Crear tabla ya en un GRUPO DE LA BBDD
USE Primera;
CREATE TABLE Clientes
(ID INT PRIMARY KEY, Nombre VARCHAR(50) NOT NULL)
ON Zaragoza;


-- DROP DATABASE Primera; --Eliminar BBDD


--Elimina Archivo de BBDD 
-- ALTER DATABASE Primera REMOVE FILE Primera2_log; 
