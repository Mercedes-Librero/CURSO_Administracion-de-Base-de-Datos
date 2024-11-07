USE Pedidos 
go

-- Lista de todos los productos indicando para cada uno su idfab, idproducto, descripci�n, precio y precio 
-- con I.V.A. incluido (es el precio anterior aumentado en un 16%). 
SELECT idfab, idproducto, descripcion, precio, ( precio * 1.16) AS iva
FROM productos

-- De cada pedido queremos saber su n�mero de pedido, fab, producto, cantidad, precio unitario e importe. 
select numpedido, fab, producto, cant, (importe/cant) as  precio_unitario, importe from pedidos

-- Listar de cada empleado su nombre, n� de d�as que lleva trabajando en la empresa y su a�o de nacimiento 
-- (suponiendo que este a�o ya ha cumplido a�os). 
Select nombre, DATEDIFF(day,contrato,getdate()) as DiasTrabajados,year(getdate())-edad as AnioNac
from empleados

-- Obtener la lista de los clientes agrupados por c�digo de representante asignado, 
-- visualizar todas la columnas de la tabla. 
select * from clientes order by repclie

-- Obtener las oficinas ordenadas por orden alfab�tico de regi�n y dentro de cada regi�n por ciudad, 
-- si hay m�s de una oficina en la misma ciudad, aparecer� primero la que tenga el n�mero de oficina mayor. 
Select * from oficinas order by region,ciudad, oficina asc

select * from pedidos order by fechapedido

select top 4 * from pedidos order by importe desc 

select top 5 numpedido, fab, producto, cant, (importe/cant) as  precio_unitario, importe from pedidos
order by precio_unitario

--Listar toda la informaci�n de los pedidos de marzo. 
select * from pedidos where MONTH(fechapedido) like 3

select numemp from empleados where oficina is not null

select * from oficinas where dir is null

select * from oficinas where region like 'norte' or region like 'este' order by region desc

select * from productos where idproducto like '%x'

-- Listar las oficinas del este indicando para cada una de ellas su n�mero, ciudad, n�meros y nombres de sus empleados. 
-- Hacer una versi�n en la que aparecen s�lo las que tienen empleados, y hacer otra en las que aparezcan las oficinas del este que no tienen empleados.
select oficinas.oficina, oficinas.ciudad, empleados.numemp, empleados.nombre 
from oficinas 
inner join empleados on empleados.oficina = oficinas.oficina
where region like 'este'

select oficinas.oficina, oficinas.ciudad, empleados.numemp, empleados.nombre 
from oficinas 
right join empleados on empleados.oficina = oficinas.oficina
where numemp is not null

select oficinas.oficina, oficinas.ciudad, empleados.numemp, empleados.nombre 
from oficinas 
left join empleados on empleados.oficina = oficinas.oficina
where region like 'este' and empleados.nombre is null


-- Listar los pedidos mostrando su n�mero, importe, nombre del cliente, y el l�mite de cr�dito del cliente 
-- correspondiente (todos los pedidos tienen cliente y representante).
select * from pedidos
select pedidos.numpedido, pedidos.importe, clientes.nombre, clientes.limitecredito
from pedidos
inner join clientes on clientes.numclie=pedidos.clie

-- Listar las oficinas con objetivo superior a 600.000 pts indicando para cada una de ellas el nombre de su director. 
select * from oficinas 
inner join empleados on empleados.numemp = oficinas.dir
where oficinas.objetivo > 600000

select * from empleados

--Listar los pedidos superiores a 25.000 pts, incluyendo el nombre del empleado que tom� el pedido 
-- y el nombre del cliente que lo solicit�.
select pedidos.*, empleados.nombre, clientes.nombre 
from pedidos
inner join empleados on empleados.numemp = pedidos.rep
inner join clientes on clientes.numclie = pedidos.clie
where importe > 25000

select * from pedidos where importe > 25000

-- Listar los c�digos de los empleados que tienen una l�nea de pedido superior a 10.000 ptas o que 
-- tengan una cuota inferior a 10.000 pts.
SELECT * FROM empleados
SELECT * FROM PEDIDOS
WHERE CUOTA > 10000

-- Cu�l es la cuota media y las ventas medias de todos los empleados?
SELECT AVG(CUOTA) Media_Cuota, AVG(VENTAS) Media_Ventas FROM EMPLEADOS

-- Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta 
--(el precio de venta es el precio unitario en cada pedido). 
Select * from pedidos
Select avg(importe) Media_Importe, sum(importe) Total , avg(importe/cant) Media_Unitario from pedidos

-- Hallar en qu� fecha se realiz� el primer pedido (suponiendo que en la tabla de pedidos tenemos todos los pedidos 
-- realizados hasta la fecha). 
SELECT MIN(FECHAPEDIDO)  FROM pedidos

-- Hallar cu�ntos pedidos hay de m�s de 25000 ptas.
SELECT COUNT(codigo)Pedidos FROM PEDIDOS WHERE IMPORTE > 25000

--Listar cu�ntos empleados est�n asignados a cada oficina, indicar el n�mero de oficina y cu�ntos hay asignados
select count(numemp)Empleados, oficina from empleados group by oficina

--Para cada empleado, obtener su n�mero, nombre, e importe vendido por ese empleado a cada cliente indicando el 
-- n�mero de cliente. 
select  empleados.numemp, empleados.nombre, sum(pedidos.importe),pedidos.clie  from pedidos
inner join empleados on empleados.numemp = pedidos.rep
group by empleados.nombre, empleados.numemp, pedidos.clie
order by numemp

-- Para cada empleado cuyos pedidos suman m�s de 30.000 ptas, hallar su importe medio de pedidos. 
-- En el resultado indicar el n�mero de empleado y su importe medio de pedidos. select * from empleados
select rep, avg(importe) as importe_medio
from pedidos
group by rep
having SUM(IMPORTE) > 30000

-- Listar de cada producto, su descripci�n, precio y cantidad total pedida, incluyendo s�lo los productos cuya cantidad 
-- total pedida sea superior al 75% del stock; y ordenado por cantidad total pedida. 
SELECT descripcion, precio, SUM(cant) AS total_pedido
FROM productos INNER JOIN pedidos ON pedidos.fab = productos.idfab AND pedidos.producto = productos.idproducto
GROUP BY idfab, idproducto, descripcion, precio, existencias
HAVING SUM(cant) > existencias * 0.75
ORDER BY 3;

-- Saber cu�ntas oficinas tienen empleados con ventas superiores a su cuota, no queremos saber cuales sino cu�ntas hay.
select distinct(count(oficina)) from empleados
where ventas > cuota


