--1. Mostrar todos los ingredientes ordenados por precio gramo de forma descendente.
--2. Mostrar todos los ingredientes que comiencen por A,B o C
SELECT        ID_INGREDIENTE, NOMBRE_INGREDIENTE
FROM            INGREDIENTES
WHERE LEFT(NOMBRE_INGREDIENTE,1) in ('A','B','C')

SELECT        ID_INGREDIENTE, NOMBRE_INGREDIENTE
FROM            INGREDIENTES
WHERE nOMBRE_INGREDIENTE LIKE '[A-C|E-Z]%'

--3. Mostrar todos los ingredientes cuyo pais sea NULL.
SELECT        ID_RECETA, ID_INGREDIENTE, NOTA
FROM            INSTRUCCIONES
WHERE        (NOTA IS NULL)

SELECT ID_RECETA, ID_INGREDIENTE, ISNULL(NOTA,'No hay nota')
FROM INSTRUCCIONES

SELECT ID_RECETA, ID_INGREDIENTE, COALESCE(NOTA,'No hay nota')
FROM INSTRUCCIONES

--4. Mostrar todos los ingredientes ordenados por nombre de aquellos cuyo precio esté entre 10 y 40 
--5. Mostrar todas las recetas, cuyo año de la fecha de creación sea inferior a 2016.
--6. Mostrar todas las recetas, cuyo año de la fecha de creación esté entre 2010 y 2016.
SELECT        ID_RECETA, NOMBRE_RECETA
FROM            RECETAS
WHERE        (YEAR(FECHA_CREACION) BETWEEN 2010 AND 2016)

SELECT        ID_RECETA, NOMBRE_RECETA
FROM            RECETAS
WHERE        FECHA_CREACION BETWEEN '2010' AND '2016'

SELECT        ID_RECETA, ID_INGREDIENTE, NOTA
FROM            INSTRUCCIONES

SELECt CAST(ID_RECETA AS VARCHAR)+CAST(ID_INGREDIENTE AS VARCHAR) + ISNULL(NOTA,'')
FROM INSTRUCCIONES

--7. Mostrar todas las recetas, ordenadas por nombre, cuyo año de creación esté entre 2010 y 2016.
--8. Mostrar todas las recetas que sean de un determinado pais, ordenado primero por nombre de pais y luego por nombre de receta.
--9. Determinar para cada pais que cantidad de recetas tenemos.
--10. Calcular de que pais hay más recetas.
SELECT TOP 1 with ties PAISES.NOMBRE_PAIS, COUNT(RECETAS.ID_RECETA) AS numero
FROM            PAISES INNER JOIN
                         RECETAS ON PAISES.ID_PAIS = RECETAS.ID_PAIS
GROUP BY PAISES.NOMBRE_PAIS
ORDER BY numero desc

--11. Calcular de que pais hay menos recetas.
--12. Calcular la media de recetas por pais.
select avg(tabla.numero*1.0) from 
(SELECT        PAISES.NOMBRE_PAIS, COUNT(RECETAS.ID_RECETA) AS numero
FROM            PAISES LEFT OUTER JOIN
                         RECETAS ON PAISES.ID_PAIS = RECETAS.ID_PAIS
GROUP BY PAISES.NOMBRE_PAIS) as tabla

--13. Mostrar todos los ingredientes de cada receta, ordenando primero por nombre de receta y luego por cantidad.
--14. Mostrar todos los ingredientes de cada receta, ordenando primero por nombre de receta y luego por orden.
--15. Calcular cual es el coste de cada una de las recetas calculandolo por el precio del gramo y la cantidad.
SELECT        RECETAS.ID_RECETA, SUM(INSTRUCCIONES.CANTIDAD * INGREDIENTES.PRECIO_GRAMO) AS total
FROM            RECETAS INNER JOIN
                         INSTRUCCIONES ON RECETAS.ID_RECETA = INSTRUCCIONES.ID_RECETA INNER JOIN
                         INGREDIENTES ON INSTRUCCIONES.ID_INGREDIENTE = INGREDIENTES.ID_INGREDIENTE
GROUP BY RECETAS.ID_RECETA
--16. Mirar a ver cuantos ingredientes hay de un pais.
--17. Determinar cual es pais para el cual hay más ingredientes.
--18. Determinar cual es la receta más cara por pais.
SELECT tabla.ID_PAIS,max(tabla.total) FROM(
SELECT    INGREDIENTES.ID_PAIS,RECETAS.ID_RECETA, SUM(INSTRUCCIONES.CANTIDAD * INGREDIENTES.PRECIO_GRAMO) AS total 
FROM            RECETAS INNER JOIN
                         INSTRUCCIONES ON RECETAS.ID_RECETA = INSTRUCCIONES.ID_RECETA INNER JOIN
                         INGREDIENTES ON INSTRUCCIONES.ID_INGREDIENTE = INGREDIENTES.ID_INGREDIENTE
GROUP BY  INGREDIENTES.ID_PAIS,RECETAS.ID_RECETA) as tabla
group by tabla.ID_PAIS

--19. Determinar cual es la receta más barata por pais.
--20. Determinar para cada ingrediente, en que receta se ha utilizado, en que cantidad y en que orden.