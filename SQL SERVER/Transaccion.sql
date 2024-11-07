use Arrocera

-- transaccion
		SET IMPLICIT_TRANSACTIONS ON -- SI NO FUNCIONA LA TRANSACCION

		BEGIN TRANSACTION
			delete from PEDIDOS WHERE CODIGO = 26
			SAVE TRANSACTION CODIGO_ROJO
			DELETE FROM PEDIDOS WHERE CODIGO = 30
		COMMIT TRANSACTION

		ROLLBACK TRANSACTION CODIGO_ROJO -- NOS DEVUELVE AL PUNTO DE ANTES DE CREAR CODIGO_ROJO

		SELECT * FROM PEDIDOS;

-- transaccion que inserte una venta, guarde un punto de slavado, elimine dicha venta, escribe como
-- fijar estas operacion y como recuperar hasta el punto de salvados
	select * from ventas

		SET IMPLICIT_TRANSACTIONS ON -- SI NO FUNCIONA LA TRANSACCION
		BEGIN TRANSACTION
			insert into ventas values(getdate(),9,10,6,105,1010);
			insert into ventas values(getdate(),9,10,6,105,1011);
		SAVE TRANSACTION CODIGO_ROJO
		delete from ventas where importe like 1010;
		COMMIT TRANSACTION

		ROLLBACK TRANSACTION CODIGO_ROJO -- NOS DEVUELVE AL PUNTO DE ANTES DE CREAR CODIGO_ROJO

		SELECT * FROM ventas;

-- borrar todos los registro de pedidos y deshazlo (haz copia de por si acaso)
		SELECT * FROM pedidos;

		SET IMPLICIT_TRANSACTIONS ON -- SI NO FUNCIONA LA TRANSACCION
		BEGIN TRANSACTION
		SAVE TRANSACTION CODIGO_ROJO
			delete from pedidos
		COMMIT TRANSACTION
		rollback TRANSACTION CODIGO_ROJO



-- que insete una pieza y que se pueda deshacer, pero tambien que borre una pieza y se pueda 
-- deshacer ( el borrado y la inserccion)
				select * from piezas_copia

		SET IMPLICIT_TRANSACTIONS ON -- SI NO FUNCIONA LA TRANSACCION

		BEGIN TRANSACTION
			SAVE TRANSACTION Trans_Insertar
			insert into piezas_copia values('257','Insertada','Insert');

			SAVE TRANSACTION Trans_Borrar
			DELETE FROM piezas_copia WHERE Descripcion_Pieza like '%Metro%'

		COMMIT TRANSACTION

		rollback TRANSACTION Trans_Insertar
		rollback TRANSACTION Trans_Borrar

