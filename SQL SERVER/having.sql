USE Pedidos 
go

-- Lista de todos los productos indicando para cada uno su idfab, idproducto, descripción, precio y precio 
-- con I.V.A. incluido (es el precio anterior aumentado en un 16%). 
SELECT idfab, idproducto, descripcion, precio, ( precio * 1.16) AS iva
FROM productos

-- De cada pedido queremos saber su número de pedido, fab, producto, cantidad, precio unitario e importe. 
select numpedido, fab, producto, cant, (importe/cant) as  precio_unitario, importe from pedidos

-- Listar de cada empleado su nombre, nº de días que lleva trabajando en la empresa y su año de nacimiento 
-- (suponiendo que este año ya ha cumplido años). 
Select nombre, DATEDIFF(day,contrato,getdate()) as DiasTrabajados,year(getdate())-edad as AnioNac
from empleados

-- Obtener la lista de los clientes agrupados por código de representante asignado, 
-- visualizar todas la columnas de la tabla. 
select * from clientes order by repclie

-- Obtener las oficinas ordenadas por orden alfabético de región y dentro de cada región por ciudad, 
-- si hay más de una oficina en la misma ciudad, aparecerá primero la que tenga el número de oficina mayor. 
Select * from oficinas order by region,ciudad, oficina asc

select * from pedidos order by fechapedido

select top 4 * from pedidos order by importe desc 

select top 5 numpedido, fab, producto, cant, (importe/cant) as  precio_unitario, importe from pedidos
order by precio_unitario

--Listar toda la información de los pedidos de marzo. 
select * from pedidos where MONTH(fechapedido) like 3

select numemp from empleados where oficina is not null

select * from oficinas where dir is null

select * from oficinas where region like 'norte' or region like 'este' order by region desc

select * from productos where idproducto like '%x'

-- Listar las oficinas del este indicando para cada una de ellas su número, ciudad, números y nombres de sus empleados. 
-- Hacer una versión en la que aparecen sólo las que tienen empleados, y hacer otra en las que aparezcan las oficinas del este que no tienen empleados.
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


-- Listar los pedidos mostrando su número, importe, nombre del cliente, y el límite de crédito del cliente 
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

--Listar los pedidos superiores a 25.000 pts, incluyendo el nombre del empleado que tomó el pedido 
-- y el nombre del cliente que lo solicitó.
select pedidos.*, empleados.nombre, clientes.nombre 
from pedidos
inner join empleados on empleados.numemp = pedidos.rep
inner join clientes on clientes.numclie = pedidos.clie
where importe > 25000

select * from pedidos where importe > 25000

-- Listar los códigos de los empleados que tienen una línea de pedido superior a 10.000 ptas o que 
-- tengan una cuota inferior a 10.000 pts.
SELECT * FROM empleados
SELECT * FROM PEDIDOS
WHERE CUOTA > 10000

-- Cuál es la cuota media y las ventas medias de todos los empleados?
SELECT AVG(CUOTA) Media_Cuota, AVG(VENTAS) Media_Ventas FROM EMPLEADOS

-- Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta 
--(el precio de venta es el precio unitario en cada pedido). 
Select * from pedidos
Select avg(importe) Media_Importe, sum(importe) Total , avg(importe/cant) Media_Unitario from pedidos

-- Hallar en qué fecha se realizó el primer pedido (suponiendo que en la tabla de pedidos tenemos todos los pedidos 
-- realizados hasta la fecha). 
SELECT MIN(FECHAPEDIDO)  FROM pedidos

-- Hallar cuántos pedidos hay de más de 25000 ptas.
SELECT COUNT(codigo)Pedidos FROM PEDIDOS WHERE IMPORTE > 25000

--Listar cuántos empleados están asignados a cada oficina, indicar el número de oficina y cuántos hay asignados
select count(numemp)Empleados, oficina from empleados group by oficina

--Para cada empleado, obtener su número, nombre, e importe vendido por ese empleado a cada cliente indicando el 
-- número de cliente. 
select  empleados.numemp, empleados.nombre, sum(pedidos.importe),pedidos.clie  from pedidos
inner join empleados on empleados.numemp = pedidos.rep
group by empleados.nombre, empleados.numemp, pedidos.clie
order by numemp

-- Para cada empleado cuyos pedidos suman más de 30.000 ptas, hallar su importe medio de pedidos. 
-- En el resultado indicar el número de empleado y su importe medio de pedidos. select * from empleados
select rep, avg(importe) as importe_medio
from pedidos
group by rep
having SUM(IMPORTE) > 30000

-- Listar de cada producto, su descripción, precio y cantidad total pedida, incluyendo sólo los productos cuya cantidad 
-- total pedida sea superior al 75% del stock; y ordenado por cantidad total pedida. 
SELECT descripcion, precio, SUM(cant) AS total_pedido
FROM productos INNER JOIN pedidos ON pedidos.fab = productos.idfab AND pedidos.producto = productos.idproducto
GROUP BY idfab, idproducto, descripcion, precio, existencias
HAVING SUM(cant) > existencias * 0.75
ORDER BY 3;

-- Saber cuántas oficinas tienen empleados con ventas superiores a su cuota, no queremos saber cuales sino cuántas hay.
select distinct(count(oficina)) from empleados
where ventas > cuota


