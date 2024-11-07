use Arrocera;

declare @Descripcion as nvarchar(400); -- VARIABLE PARA ALMACENAR CADA REGISTRO
declare ProdInfo Cursor for Select descripción from Artículos -- CREAMOS CURSOR

open ProdInfo;
	fetch next from prodinfo into @Descripcion; -- CARGA EL PRIMER REGISTRO EN LA VARIABLE

	while @@FETCH_STATUS = 0 -- MIENTRAS HAYA REGISTROS ESTA VARIABLE VALE 0
		begin print @descripcion;
		fetch next from Prodinfo into @Descripcion; --CARGA EL SIGUIENTE REGISTRO EN LA VARIABLE
	end;

CLOSE ProdInfo; -- SE CIERRA EL CURSOR

DEALLOCATE ProdInfo; -- SE DESTRULLE CURSOR

-- CURSOR QUE MUESTRO TODOS LOS IMPORTES Y CANTIDAD DE LA TABLA VENTAS
	declare @importe int;
	declare @cantidad int;

	declare ventas_cursor cursor for SELECT importe, cantidad from ventas;
	
	open ventas_cursor;
			fetch next from ventas_cursor into @importe,@cantidad; 
			print 'el primer registro: ' + cast(@importe as varchar(50)) + ',' + cast(@cantidad as varchar(50));

			while @@FETCH_STATUS = 0 
				begin 
				print 'TOTAL: ' + CAST(@importe*@Cantidad as varchar(50));
				fetch next from ventas_cursor into @importe,@cantidad; --CARGA EL SIGUIENTE REGISTRO EN LA VARIABLE


			end;

	CLOSE ventas_cursor; 

	DEALLOCATE ventas_cursor; 

--crear cursor que muestre las piezas en packs de 5 registros (usa tablas temporales para almacenar packs)
	declare @codPieza nchar(10);
	declare @NombrePieza nchar(10);
	declare @DescripcionPieza nchar(10);

	declare cursor_piezas cursor for select * from piezas;

	open cursor_piezas;
		fetch next from cursor_piezas into @codPieza, @NombrePieza, @DescripcionPieza;
		declare @tabla_temporal table(
			cod_pieza nchar(10),
			nombre_pieza nchar(10),
			descripcion_pieza nchar(10)
		);

		declare @contador int = 1;

		while @@FETCH_STATUS = 0 and @contador <=2
		begin
			insert into @tabla_temporal values(@codPieza,@NombrePieza,@DescripcionPieza);
			fetch next from cursor_piezas into @codPieza, @NombrePieza, @DescripcionPieza;
			set @contador = @contador + 1

			if @contador = 3
			begin
					set @contador = 1;
					select * from @tabla_temporal;
					delete from @tabla_temporal;
			end;
		end;

	CLOSE cursor_piezas; 

	DEALLOCATE cursor_piezas; 

-- Cursor que muestre el nombre y fecha Nac de los clientes
	select * from clientes

	declare @Nombre varchar(50);
	declare @FechaNac datetime;
	declare @ContadorCli int = 1;

	declare Clientes_cursor cursor for SELECT [nombre cliente], [Fecha nacimiento] from clientes;
	open Clientes_cursor;

	fetch next from Clientes_cursor into @Nombre,@FechaNac; 
	print 'el primer registro: ' + cast(@Nombre as varchar(50)) + ',' + cast(@FechaNac as varchar(50));
	print ' ----------------------- '

		while @@FETCH_STATUS = 0 
			begin 
			print cast(@ContadorCli as varchar(10)) + '.' + cast(@Nombre as varchar(50)) + ',' + cast(@FechaNac as varchar(50));
			fetch next from Clientes_cursor into @Nombre,@FechaNac;  --CARGA EL SIGUIENTE REGISTRO EN LA VARIABLE
			set @ContadorCli = @ContadorCli + 1;
		end;

	CLOSE Clientes_cursor; 

	DEALLOCATE Clientes_cursor; 

-- Cursor que recorra la primera mitad de los registros de 
	select * from clientes
	declare @Cliente int;
	declare @poblacion nvarchar(50);

	declare Cursor_Mitad cursor for
		Select top 50 percent nºcliente, [población cliente] from clientes

	open Cursor_Mitad;
	fetch next from Cursor_Mitad into @Cliente,@poblacion; 
		while @@FETCH_STATUS = 0 
			begin 
			print 'Nº Cliente: ' + cast(@Cliente as varchar(50)) + ', Poblacion: ' + cast(@poblacion as varchar(50))  ;
			fetch next from Cursor_Mitad into @Cliente,@poblacion; 
		end;

	CLOSE Cursor_Mitad; 
	DEALLOCATE Cursor_Mitad; 

-- Cursor que recorra la primera mitad de los registros de 
	select * from clientes
	declare @Cliente2 int;
	declare @poblacion2 nvarchar(50);

	declare Cursor_2Mitad cursor dynamic for
		Select top 50 percent nºcliente, [población cliente] from clientes 
		order by nºcliente desc;

	open Cursor_2Mitad;
	fetch last from Cursor_2Mitad into @Cliente2,@poblacion2; 
		while @@FETCH_STATUS = 0 
			begin 
			print 'Nº Cliente: ' + cast(@Cliente2 as varchar(50)) + ', Poblacion: ' + cast(@poblacion2 as varchar(50))  ;
			fetch prior from Cursor_2Mitad into @Cliente2,@poblacion2; 
		end;

	CLOSE Cursor_2Mitad; 
	DEALLOCATE Cursor_2Mitad; 

--Cursor que muestre a todos los proveedores de valencia o madrid, nombre y poblacion

	declare @Nombre3 nvarchar(50);
	declare @Poblacion3 nvarchar(50);

	declare cursorNomPob cursor for SELECT [nombre proveedor],[provincia proveedor] FROM Proveedores
										WHERE [población proveedor] IN ('Madrid','Valencia');

	open cursorNomPob;
	fetch next from cursorNomPob into @Nombre3, @Poblacion3;
	while @@FETCH_STATUS = 0
		begin
		print 'Nombre:' +  @Nombre3 + 'Nombre:' + @Poblacion3;
		fetch next from cursorNomPob into @Nombre3, @Poblacion3;
	end;

	CLOSE cursorNomPob; 
	DEALLOCATE cursorNomPob; 

-- todos los empleados del ultimo al primero (Nombre, oficina y cuota)
		select * from empleados
		inner join oficinas on oficinas.oficina = empleados.oficina;

	declare @Nombre4 nvarchar(50);
	declare @Oficina4 nvarchar(50);
	declare @Cuota4 nvarchar(50);

	--declare cursorEmpleados cursor for SELECT [nombre],[ciudad],cuota FROM empleados
										--inner join oficinas on oficinas.oficina = empleados.oficina
										--order by numemp desc;  

	declare cursorEmpleados cursor dynamic for SELECT [nombre],[ciudad],cuota FROM empleados
										inner join oficinas on oficinas.oficina = empleados.oficina; 

	open cursorEmpleados;
	--fetch next from cursorEmpleados into @Nombre4, @Oficina4, @Cuota4;
	 fetch last from cursorEmpleados into @Nombre4, @Oficina4, @Cuota4;

	while @@FETCH_STATUS = 0
		begin
		print 'Nombre: ' +  @Nombre4 + '  Oficina: ' + @Oficina4 + '  Cuota: ' + @Cuota4;
		--fetch next from cursorEmpleados into @Nombre4, @Oficina4, @Cuota4;
		fetch prior from cursorEmpleados into @Nombre4, @Oficina4, @Cuota4;
	end;

	CLOSE cursorEmpleados; 
	DEALLOCATE cursorEmpleados;
	
-- que muestre el articulo, descripcion y existencias, pero solo aquellos que sus existencias sean < 500
-- ademas muestra el mensaje 'compras x unidades' donde x es la deferencia entre 1000 y las existencias 
-- reales
			select nºartículo, descripción, existencias  from Artículos where existencias < 500

	declare @Articulo nvarchar(50);
	declare @Descrip nvarchar(50);
	declare @Existencias int;

	declare cursor500 cursor for select nºartículo, descripción, (1000-existencias)  from Artículos 
											where existencias < 500

	open cursor500;
	fetch next from cursor500 into @Articulo, @Descrip, @Existencias;

	while @@FETCH_STATUS = 0
		begin
		print 'Articulo: ' +  @Articulo + '  -  ' + @Descrip + '  Comprar: ' + cast( @Existencias as nvarchar(50)) +  '  Unidades ' ; 
		fetch next from cursor500 into @Articulo, @Descrip, @Existencias;
	end;

	CLOSE cursor500; 
	DEALLOCATE cursor500;

-- que cargue en una talba temporal los 5 primeros pedidos (numpedido e importe)
		select top 5 * from pedidos;

		declare @numPedido int;
		declare @importe2 int

		CREATE TABLE ##tmpAux (
			numpedido int,
			importe int	);

		declare cursorTabla cursor for select top 5 numpedido,importe from pedidos;
		open cursorTabla;

	    fetch next from cursorTabla into @numPedido, @importe2;

		while @@FETCH_STATUS = 0
			begin
			insert into ##tmpAux values(@numPedido, @importe2);
			fetch next from cursorTabla into @numPedido, @importe2;
		end;

		select * from ##tmpAux;

		drop table ##tmpAux;
	CLOSE cursorTabla; 
	DEALLOCATE cursorTabla;