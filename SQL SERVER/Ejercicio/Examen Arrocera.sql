use Arrocera
go

--muestra las provincias de los proveedores, id venta de cada venta
select * from ventas

select * from Proveedores
select * from artículos
select * from clientes

select Proveedores.[provincia proveedor], ventas.Id
from Proveedores
inner join (artículos inner join ventas on ventas.nºartículo=Artículos.nºartículo )
on Artículos.nºproveedor=Proveedores.nºproveedor

-- crear una tabla con los clientes casados qur hayan comprado algo en 2001
select * into Clie_Casados from clientes
where casado = 1 
and nºcliente in (select nºcliente from ventas where year(fecha) like 2001 )

-- oficinas con y sin empleados y numero de empleados
select * from oficinas
select * from empleados

select oficinas.oficina, oficinas.ciudad, empleados.nombre from oficinas
left join empleados on empleados.oficina = oficinas.oficina

-- queremos saber las ventas mensuales de cada oficina
-- distinguiendo meses de distintos años
select * from oficinas
select * from empleados
select * from ventas

select count(v.id)numero, e.oficina, year(v.fecha) as año, month(v.fecha) as mes
from empleados e
inner join ventas v  on v.numemp = e.numemp
group by e.oficina,v.fecha



