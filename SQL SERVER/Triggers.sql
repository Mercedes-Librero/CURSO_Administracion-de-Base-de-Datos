use Arrocera
go

-- DROP TRIGGER [T_OfinaBorrada]  BORRAR TRIGGER

--crear trigger en Pedidos, crea una tabla al eliminar un pedidos
		CREATE TRIGGER [copia pedidos antes de borrar Pedidos]
		ON Pedidos AFTER DELETE
		AS
		BEGIN
		SELECT * INTO Copia2_Pedidos FROM Pedidos;
		END;

		-- Delete from pedidos where codigo like 1

-- Crea Trigger que haga copia de articulos en HistoricoArticulos en cada INSERT
		CREATE TRIGGER [HistoricoArticulo]
		on Artículos
		AFTER INSERT AS SELECT * INTO HistoricoArticulos from Artículos;

		INSERT INTO Artículos VALUES (9,'Lacito rosa',55,3,1566);

--CREA TRIGGER  Crea Tabla Copia_Cartera con el registro eliminado
			CREATE TRIGGER [copia tabla Cartera]
			ON Cartera
			FOR DELETE
			AS
			select *
			INTO Copia_Cartera
			from Deleted;

			--DELETE FROM Cartera where id_cartera like 3;

			select * from Copia_Cartera

-- cuando se actualice la tabla Cartera que salga un mensaje avisando
			create trigger [Mensaje Cartera]
			on Cartera
			after update
			as
			print 'TABLA TARJETAS ACTUALIZADA'

			UPDATE Cartera SET  Saldo = Saldo + 1000;

-- Trigger que cuando se actualice la tabla piezas mueste el mensaje 'PIEZAS ACTUALIZADAS'
			Create trigger [Piezas actualizadas]
			on Piezas
			after UPDATE
			AS PRINT 'PIEZAS ACTUALIZADAS'
	
			SELECT * FROM Piezas

			UPDATE Piezas SET  Nombre_pieza = 'Hilo Blanco' where cod_pieza = 'P1'

-- Tigger que nos diga que oficina ha sido borrada
			Create trigger [T_OfinaBorrada]
			on Oficinas
			for Delete
			AS 
			BEGIN
				PRINT 'Oficina Borrada';
				SELECT 'Oficina Borrada ' +  CAST(OFICINA AS VARCHAR) + ' ' + CIUDAD FROM DELETED;
			END;

			-- Delete from OFICINAS where OFICINA LIKE 26;

-- crea un TRIGGER QUE AL INSERTAR UN REGISTRO NUEVO EN CARTERA, TB LO HABA EN COPIA_CARTERA
		CREATE TRIGGER [T_CopiaCartera]
		ON Cartera
		for insert
		as 
		begin
			INSERT INTO Copia_Cartera select * from inserted;
		end;

		insert into Cartera values (55,'pina',64773,2,2999)

-- Cuando se borre de Cartera Tambien de Copia_Cartera
		CREATE TRIGGER [T_BorrarCartera]
		ON Cartera
		for delete
		as 
		begin
			Delete from Copia_Cartera where id_cartera in (select id_cartera from deleted)
		end;

		Delete from Cartera where id_cartera = 55

		select * from cartera
		select * from Copia_cartera


-- Crear un trigger que actualize copia_cartera cuando se inserte o borre un registro nuevo en cartera
		CREATE TRIGGER [Actualiza copia_cartera]
		on cartera
		for insert,delete 
		AS
		BEGIN 
				insert into copia_cartera 
				select *
				from INSERTED;
				delete from COPIa_Cartera where id_cartera in 
				(select id_cartera from  DELETED);
				print 'Tabla Copia Cartera actualizada';		
		END

-- cuando se inserte en  piezas lo copiemos a Piezas_Nuevas
		SELECT * INTO Piezas_Nuevas FROM Piezas;

		select * from Piezas_Nuevas

		CREATE TRIGGER [T_InsertarPiezasNuevas]
		on Piezas
		for insert
		AS
		BEGIN 
				insert into Piezas_Nuevas select * from INSERTED;	
		END;

		/* TAMBIEN 
			CREATE TRIGGER [T_InsertarPiezasNuevas]
			on Piezas
			for insert
			AS
			BEGIN 
					insert into Piezas_Nuevas select * from Piezas;	
			END; */

		insert into piezas values('102','Masdfasdf','sirve para')

/* INSTEAD OF 
Es un tipo de trigger, que asociado a una vista, cuando se intenta realizar el tipo de consulta que indica el 
trigger (insertar, modificar, o eliminar), una vez están los registros en las tablas inserted o deleted, la 
consulta se interrumpe y salta el trigger, con lo que podemos manejar los datos que hay en estas tablas temporales 
mediante el trigger, esto es muy práctico cuando queremos insertar en varias tablas pertenecientes a una vista, ya 
que con una simple consulta no podremos, tendremos que trabajar con un trigger Instead Of y usar las filas incluidas 
en la tabla inserted. */


-- Crear TRIGGER que cuando se intente borrar en la tabla Piezas registre el intento de borrado en la tabla ACCIONES

		CREATE TABLE Acciones (
		ID INT PRIMARY KEY IDENTITY,
		Accion Varchar(50),
		FechaAccion DATETIME)


		CREATE TRIGGER [T_NoBorrarCodigoPiezas]
		ON Piezas
		INSTEAD OF DELETE
		AS 
		BEGIN 
			INSERT INTO Acciones VALUES('Intento borrado',GETDATE())
		END

		DELETE FROM Piezas where cod_pieza LIKE '101'


-- Crear TRIGGER que cuando intentemos insertar en piezas_nuevas lo haga en PIEZAS
		CREATE TRIGGER [t_InsertarNuevasPiezasNuevas]
		ON Piezas_Nuevas
		instead of insert
		as 
		begin
			insert into Piezas Select * from inserted;
		end;

		insert into Piezas_Nuevas values ('223','Toses','ni idea');


-- crear un trigger en la tabla oficinas que cuando se inserte un registro nuevo tb lo inserte en copia_oficinas.

		select * into copia_oficinas from oficinas;

		create trigger [NOVEDAD copia_oficinas]
		on Oficinas
		for insert 
		as begin
		insert into copia_oficinas select * from inserted;
		print 'enhorabuena';
		end


		insert into oficinas values (66, 'Andorra', 'muy al norte', 103, 50000, 60000);


		create trigger [T_AvisoPedidoInsertado]
		on Pedidos
		after insert
		as
		begin
			declare @pedido int;
			set @pedido =(select top 1 codigo from inserted)
			if @pedido = null
				print 'Pedido no insertado'
			else
				print concat ('Pedido numero ', @pedido, ' insertado');
		end

-- cuando se intente borrar de la tabla piezas nuevas borre todo menos el cogigo
	CREATE TRIGGER [IntentoBorrarPiezas]
	on Piezas_Nuevas
	instead of Delete
	as
	begin
		Delete from Piezas_Nuevas where cod_pieza in (Select cod_pieza from Deleted);
		insert into Piezas_Nuevas (cod_pieza) select cod_Pieza from deleted;
	end

	Delete from Piezas_Nuevas where cod_pieza = '101'

	select * from Piezas_Nuevas 

-- TRIGGER QUE AL INSERTAR UN MOVIMIENTO, QUE MUESTRE LO SIGUIENTE: 
	-- EL MONTO SI ES < 1000
	-- MONTO + 21% SI ES > 1000

		SELECT * FROM CUENTA
		SELECT * FROM MOVIMIENTO

		CREATE TRIGGER [T_ MostrarMonto]
		ON Movimiento
		FOR INSERT
		AS
		BEGIN
			declare @Monto float;
			set @Monto =(select Monto from inserted);
			if @Monto < 1000
				Print Concat('Monto: ', @Monto);
			else
				Print Concat('Monto: ', @Monto*1.21);
		end;
			
		insert into Movimiento VALUES ('2','34','CA',1100,'20/04/2023')


-- CREAR TRIGGER QUE AVISE SI QUEDA POCO STOCK
		select * from Artículos

		CREATE TRIGGER [T_ QuedaPocoStock]
		ON Artículos
		FOR UPDATE
		AS
		BEGIN
			declare @NumArticulo int;
			set @NumArticulo =(select nºartículo from inserted);

			declare @Existencias int;
			set @Existencias =(select existencias from inserted);
			if @Existencias < 25
				Print Concat('Del articulo: ', @NumArticulo, ' quedan ', @Existencias  ,' unidades');
		end;

		update Artículos set existencias = existencias - 325 where nºartículo = 1;

-- CREAR TRIGGER QUE NO DEJE TENER STOCK NEGATIVO
		select * from Artículos

		CREATE TRIGGER [T_SiStockNegativo]
		on Artículos
		instead of update
		as 
		begin
			declare @NumArticulo int;
			declare @Existencias int;
			declare @ExistenciasReales int;

			set @NumArticulo =(select nºartículo from inserted);
			set @Existencias =(select existencias from inserted);
			set @ExistenciasReales =(select existencias from Artículos where nºartículo like @NumArticulo);

			if @Existencias < 0
				Print Concat('Del articulo: ', @NumArticulo, ' quedan ', @ExistenciasReales  ,' negativas');
			else
				update Artículos set existencias = @Existencias where @NumArticulo = 1;
		end;

		 update Artículos set existencias = existencias - 325  where nºartículo = 1;


-- crear TRIGGER si insertamos en MOVIMIENTO tambien en CopiaMovimiento
SELECT * INTO Copia_Movimiento FROM Movimiento;

	CREATE TRIGGER [ActualizarCopiaMovimiento]
	ON Movimiento
	for insert
	as 
	Begin
		insert into Copia_Movimiento Select * from inserted
		print 'Tabla copia movimiento actualizada'
	END

	insert into Movimiento VALUES ('140','300','CA',1100,'20/04/2023')


--
select * from MOVIMIENTO
select * from Copia_Movimiento

	CREATE TRIGGER [ModificarCopiaMovimiento]
	ON Movimiento
	for delete
	as 
	Begin
		delete from Copia_Movimiento where IDMOVIMIENTO = (select IDMOVIMIENTO from deleted);

		print 'Tabla copia movimiento actualizada'
	END

	DELETE FROM MOVIMIENTO WHERE IDMOVIMIENTO = 33

-- Trigger QUE CUANDO SE INSERTE O ACTUALICE UNA CUENTA CON SALDO INFERIOR A 100 QUE MUESTRE 'cLIENTE PELIGROSO' 
-- Y SI EL SALDO ES SUPERIOR A 5000 MUESTRE 'CLIENTE POTENCIAL'
Select * from clientes
select * from cuenta

	CREATE TRIGGER [ComprobarCliente]
	ON Cuenta
	for Insert,update
	as 
	Begin
			declare @Saldo float;
			set @Saldo =(select saldo from inserted);

			declare @Cliente varchar(5);
			set @Cliente =(select IDCLIENTE from inserted);

			if  @Saldo < 100
				Print Concat(@Cliente, ' CLIENTE PELIGROSO');
			if @Saldo > 5000
					Print Concat(@Cliente, ' CLIENTE POTENCIAL');

	END

	INSERT INTO CUENTA VALUES ('11','11',30,NULL);

-- trigger que bloquee cualquier actividad en la TABLA CUENTA
		CREATE TRIGGER [BloquearTablaCuenta]
		ON Cuenta
		INSTEAD of INSERT, DELETE, UPDATE
		as
		Begin
			print 'No tienes permiso';
		END

-- trigger que cuando quede menos de 25 de stock inserte en pedidos proveedor y el mas barato
		CREATE TABLE PedidosProveedor (
			ID_Pedido_Proveedor int primary key identity,
			Linea_Pedido int ,
			ID_PROVEEDOR int,
			ID_PRODUCTO int,
			Fecha_Pedido date)

		ALTER TABLE Artículos ADD Coste FLOAT;

		CREATE TRIGGER [HacerPedido]
			ON Artículos
			for Insert,update
			as
			Begin
				declare @Existencias int;
				declare @NumArticulo int;
				declare @proveedor int;

				set @Existencias =(select Existencias from inserted);
				set @NumArticulo =(select nºartículo from inserted);
				set @proveedor = (Select TOP 1 nºartículo from Artículos order by Coste ASC)

				if @Existencias < 25
					insert into PedidosProveedor Values (1,@proveedor,@NumArticulo,GETDATE());

		END;

		update Artículos set existencias = existencias - 300 where nºartículo like 1

-- QUE NO PERMITA DAR DE ALTA CLIENTES QUE SE LLAMEN ANA
		CREATE TRIGGER [NoAnaS]
			ON Clientes
			INSTEAD of INSERT
			AS
			BEGIN
				declare @Nombre varchar(50);
				set @Nombre = (Select TOP 1 [nombre cliente] from inserted)
				if (@Nombre like '%Ana%')
					print 'No queremos Ana'
				else
					insert into clientes select * from inserted
			end;


			INSERT INTO Clientes (nºcliente,[nombre cliente]) values (77,'Ana')


-- Trigger QUE CUANDO SE INSERTE O ACTUALICE UNA CUENTA y ese cliente viva en Zaragoza CON SALDO INFERIOR A 
-- 100 QUE MUESTRE 'cLIENTE PELIGROSO' Y SI EL SALDO ES SUPERIOR A 5000 MUESTRE 'CLIENTE POTENCIAL'
Select * from clientes where [provincia cliente] like 'Zaragoza'
select * from cuenta

	CREATE TRIGGER [ComprobarClienteZaragoza]
	ON Cuenta
	for Insert,update
	as 
	Begin
			declare @Saldo float;
			set @Saldo =(select saldo from inserted);

			declare @Cliente varchar(5);
			set @Cliente =(select IDCLIENTE from inserted);

			declare @Poblacion nvarchar(50);
			set @Poblacion =(Select [provincia cliente] from clientes where nºcliente like cast(@Cliente as int));

			if  @Saldo < 100 and @Poblacion like 'Zaragoza'
				Print Concat(@Cliente, ' CLIENTE PELIGROSO');
			if @Saldo > 5000 and @Poblacion like 'Zaragoza'
				Print Concat(@Cliente, ' CLIENTE POTENCIAL');
	END

	INSERT INTO CUENTA VALUES ('1','21',5500,NULL);

	--trigger que cuando se intente borrar una oficina no deje y avese con un mesnsaje

	create trigger [MensajeBorrarOficina]
	on Oficinas
	instead of delete
	as 
	begin print 'no se puede borrar ofininas'
	end;

-- TRIGGER QUE CUANOD SE BORRE UN PROVEEDOR SE INSERTE EN LA TABLA PROVEEDOR_BORRADOS
		SELECT *  INTO PROVEEDORES_BORRADOS FROM PROVEEDORES;

		CREATE TRIGGER [InsertarProveedoresBorrados]
			ON Proveedores
			for delete
			as 
			Begin
				INSERT INTO PROVEDORES_BORRADOS SELECT * FROM DELETED;
			END

-- TRIGGER QUE CUANDO SE HAGA UNA VENTA CON UN IMPORTE MAYOR DE 10.000 Y 
-- EL CLIENTE SEA SOLTERO AVISE CON UN MENSAJE
SELECT * FROM CLIENTES
SELECT * FROM vENTAS

		CREATE TRIGGER [VentaMayor]
			ON Ventas
			for insert
			as 
			Begin
				Declare @Importe int;
				Set @Importe = (Select importe from inserted);

				Declare @Casado bit;
				Set @Casado = (Select Casado from inserted INNER JOIN CLIENTES
					ON INSERTED.nºcliente =  cLIENTES.nºcliente);

				if @Importe > 10000
					print 'ATENCION VENTA SUPERIOR A 10.000'
			END


-- TRIGGER QUE SOLO DEJE INSERTAR OFICINAS DE ZARAGOZA

select * from oficinas

		CREATE TRIGGER [InsertarZaragoza]
			ON Oficinas
			INSTEAD OF insert
			as 
			Begin
				Declare @Region nvarchar(50);
				Set @Region = (Select region from inserted);

				if @Region like 'Zaragoza'
					INSERT INTO oficinas SELECT * FROM INSERTED;
				ELSE
					PRINT 'NO ZARAGOZA';
			END;

			INSERT INTO oficinas values (51,null,'Soria',null,null,null);

-- TRIGGER QUE IMPIDA Y AVISE DE UN INTENTO DE BORRADO DE UNA VENTA
		CREATE TRIGGER [BorradoVenta]
			ON Ventas
			INSTEAD OF delete
			as 
			Begin
				PRINT 'Nop se puede borrar';
			END;
		
-- TRIGGER que impida insertar o actualizar movimientos con fecha posterior a hoy

	SELECT * FROM MOVIMIENTO;

		CREATE TRIGGER [FueraFecha]
			ON MOVIMIENTO
			INSTEAD OF INSERT, UPDATE
			as 	
			begin
				Declare @IDMovimiento varchar(5);
				Declare @Fecha datetime;
				Set @Fecha = (Select Fecha from inserted);

				if (@Fecha <= GETDATE())
					Set @IDMovimiento = (Select inserted.IDMovimiento from inserted
						inner join MOVIMIENTO on MOVIMIENTO.IDMOVIMIENTO = inserted.IDMOVIMIENTO);

					if @IDMovimiento = ''
						insert into MOVIMIENTO select * from inserted;
					else
						Declare @Tipo varchar(5);
						Declare @Monto float;	
						Declare @IdCuenta varchar(5);	
						Set @IdCuenta = (Select IDCUENTA from inserted);
						Set @Tipo = (Select Tipo from inserted);
						Set @Monto = (Select Monto from inserted);

						update MOVIMIENTO set IDCUENTA = @IdCuenta where IDMOVIMIENTO = @IDMovimiento;
						update MOVIMIENTO set tipo = @Tipo where IDMOVIMIENTO = @IDMovimiento;
						update MOVIMIENTO set Monto = @Monto where IDMOVIMIENTO = @IDMovimiento;
			END;
