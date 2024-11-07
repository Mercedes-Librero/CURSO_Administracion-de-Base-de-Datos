-- Crea una tabla con los pedidos de los clientes de mexico
-- incluye los campos orderid, companyname y phone
Select Orders.orderid, customers.CompanyName, customers.phone
into PedidosMexico
from Orders
inner join customers on customers.CustomerID = Orders.CustomerID
where customers.City like 'México%'

-- pedidos de cada cliente de la tabla Pedidos Mexico
select * from PedidosMexico
select count(orderid),  CompanyName
from PedidosMexico
group by Companyname

-- modifica el telefono de la compañia Tortuga a 555-555
 update PedidosMexico set Phone = '555-555' where CompanyName like 'Tortuga%'

 -- elimina todos los registros de Tortuga y Pericles
 --delete from PedidosMexico where CompanyName like 'Tortuga%' or CompanyName like 'Pericles%'
