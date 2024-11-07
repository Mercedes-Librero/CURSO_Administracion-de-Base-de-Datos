CREATE DATABASE Alumnos_SuCarnet
GO

USE Alumnos_SuCarnet
GO

CREATE SCHEMA alumno
go

CREATE SCHEMA nota
GO

CREATE TABLE alumno.alumnos(
carnet int PRIMARY KEY,
nombre varchar(25),
apellidos varchar(25))
GO

CREATE TABLE nota.notas(
idnotas int identity,
carnet int FOREIGN KEY REFERENCES alumno.alumnos(carnet)
ON UPDATE CASCADE
ON DELETE CASCADE,
nota1 decimal(10,2),
nota2 decimal(10,2),
nota3 decimal(10,2),
promedio as (nota1+nota2+nota3)/3)
GO

INSERT INTO alumno.alumnos VALUES(111,'Juan Jose','Perez')
insert into alumno.alumnos VALUES(222,'Maria Luisa','Flores')
INSERT INTO alumno.alumnos VALUES(333,'Carlos Francisco','Gavidia')
insert into alumno.alumnos VALUES(444,'Claudia','Rivas')

insert into nota.notas VALUES (111,7.6,10,5.5)
insert into nota.notas VALUES (222,8.5,9,10)
insert into nota.notas VALUES (333,9,10,5.5)
insert into nota.notas VALUES (444,5.5,7.3,4)

SELECT * FROM NOTA.notas

CREATE LOGIN SuCarnet_2 with PASSWORD = '12345'

CREATE TABLE materias (ID INT, nombre varchar(50))
go

USE Alumnos_SuCarnet
GO

