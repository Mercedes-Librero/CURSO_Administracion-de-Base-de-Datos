USE Pedidos 
go
-- 1 Listar los nombres de los clientes que tienen asignado el representante Alvaro Jaumes 
--   (suponiendo que no pueden haber representantes con el mismo nombre).
select nombre from clientes
where repclie = (select numemp from empleados where nombre = 'Alvaro Jaumes')


-- 2 Listar los vendedores (numemp, nombre, y nº de oficina) que trabajan en oficinas "buenas" 
--     (las que tienen ventas superiores a su objetivo).
select numemp, nombre, oficina from empleados
where oficina in (select oficina from oficinas where ventas > objetivo)


-- 3 Listar los vendedores que no trabajan en oficinas dirigidas por el empleado 108.
select * from empleados 
where oficina not in ( select oficina from oficinas where dir like 108)


--4 Listar los productos (idfab, idproducto y descripción) para los cuales no se ha recibido ningún pedido de 25000 o más.
select idfab,idproducto, descripcion from productos where idproducto in
(select producto from pedidos where importe < 25000)


--5 Listar los clientes asignados a Ana Bustamante que no han remitido un pedido superior a 3000 pts.
select * from pedidos
select * from clientes where repclie in (select numemp from empleados where nombre like 'Ana%')
and  numclie not in ( select clie from pedidos where importe > 3000)


--6 Listar las oficinas en donde haya un vendedor cuyas ventas representen más del 55% del objetivo de su oficina.



--7 Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.

--8 Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus vendedores.



