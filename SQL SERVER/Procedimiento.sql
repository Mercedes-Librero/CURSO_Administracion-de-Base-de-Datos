use Arrocera
go
/* 
		@ para variable LOCAL
		# para variable GLOBAL
		## para variable GLOBAL QUE FUNCIONA EN TODAS PARTES
*/
--drop procedure [BACKUP Arrocera];

		Create procedure [BACKUP Arrocera]
		as
		begin
		BACKUP DATABASE Arrocera
		TO DISK ='c:\temp\arrocera_clase.bak'
			WITH FORMAT,
			MEDIANAME = 'SQLServerBackups',
			NAME = 'Copia de Seguridad de Arrocera';
			end;

			exec [BACKUP Arrocera];



-- Procedimiento que seleccione los pedidos de una fecha en concreto
		CREATE PROCEDURE [ProcedimientoPedidoFecha] @Fecha DateTime
		as
		begin
			select * from Pedidos where fechapedido like @Fecha;
		end;

	 	select * from pedidos;
		exec [ProcedimientoPedidoFecha] @Fecha = '02/01/1997';


-- Para insertar una pieza
		CREATE PROCEDURE [InsertarPieza] @Cod nchar(10), @nombre nchar(10), @Descripcion nchar(10)
		as
		begin
			insert into Piezas values (@Cod,@nombre,@Descripcion);
		end;

		select * from Piezas;
		exec [InsertarPieza] @Cod = 124, @nombre = 'Pieza Bonita', @Descripcion = 'Es muy bonita';

-- Crear tabla con dos campos enteros, el primero primary key, y los nombres son varaiables

		CREATE PROCEDURE [TablaDosCampos] 
			@NombreTabla varchar(20), 
			@IdTabla varchar(20),	
			@Descripcion varchar(20)
		as
		begin
			declare @sql nvarchar(max);
			set @sql = N'
				Create table ' +  @NombreTabla + ' ( ' +
					@IdTabla + ' int primary key, ' +
					@Descripcion + ' varchar(20)
				)';

			exec sp_executesql @sql;
		end;

		exec [TablaDosCampos] @NombreTabla = 'Fruta', @IdTabla = 'ID_Fruta', @Descripcion = 'Descripcion';

-- que muestre los articulos entro dos precios que elija el USUARIO
	
		CREATE PROCEDURE [EntrePrecios] 
			@PrecioMin int, 	
			@PrecioMax int
		as
		begin
			select * from artículos where precio between @PrecioMin and @PrecioMax;
		end;

		exec [EntrePrecios] @PrecioMin = 0, @PrecioMax = 30;

-- Crear tabla

	create procedure [EliminarTabla] @NombreTabla varchar(max)
		as begin
		declare @sql nvarchar(max)
		set @sql = N' drop table ' + @nombreTabla;
		execute sp_executesql @sql;
	end

	exec [EliminarTabla]@NombreTabla = 'Fruta'

-- Elimina de Una tabla todos los registros
	create procedure [EliminarRegistros] @NombreTabla varchar(max)
		as begin
		declare @sql nvarchar(max)
		set @sql = concat(' Delete from ' , @nombreTabla) ;
		execute sp_executesql @sql;
		print @sql;
	end

		exec [EliminarRegistros] @NombreTabla = 'Piezas_Copia4'

-- ACTUALIZAR CAMPO TABLA CON VALOR 
	create procedure [CambiarDatosTabla] 
		@NombreTabla Nvarchar(max), 
		@Campo varchar(max), 
		@Valor varchar(max),
		@CampoCondicion Varchar(max),
		@ValorCondicion Varchar(max)

		as begin
			declare @sql nvarchar(max);
			set @sql = N' UPDATE ' + @NombreTabla + ' SET ' + @Campo + ' = ' +  @Valor + 
			 ' WHERE ' + @CampoCondicion + ' LIKE '   +  @ValorCondicion;

			execute sp_executesql @sql;
			print @sql;
	end

	EXEC [CambiarDatosTabla] 
		@NombreTabla = 'pIEZAS_COPIA', 
		@Campo = 'Nombre_Pieza', 
		@Valor =  '''Prueba%''',
		@CampoCondicion = 'Descripcion_pieza',
		@ValorCondicion = '''Metro%'''

		SELECT * FROM pIEZAS_COPIA
		UPDATE pIEZAS_COPIA SET Nombre_Pieza = '%Prueba' WHERE Descripcion_pieza LIKE '%Metro%'

-- Genere relaciones entre lo dos tablas que el usuario elija (usar campo id por unirlas)
	create procedure [CrearRelaciones] 
		@NombreTabla1 Nvarchar(max), 
		@NombreTabla2 Nvarchar(max), 

		@NombreFK varchar(max)

		as begin
			declare @sql nvarchar(max);
			set @sql = CONCAT( 'ALTER TABLE ', @NombreTabla1,' add constraint ', @NombreTabla2 ,
			' FOREIGN KEY (id) references ', @NombreTabla2, '(id)');

			execute sp_executesql @sql;
			print @sql;
	end

-- muestre el texto 'hola' 10 VECES
	create procedure [Hola] 
		@num int
		as 
		begin
			declare @Contador int = 0;

			while @Contador < @num
				begin
					print 'Hola';
					set @contador = @contador + 1;
				end;
	end;

	exec  [Hola] @num = 1;

-- Crear una tabla con el nombre que el usuario decida y la cantidad de campos (nombre) 
	-- que el usuario decida ?????
																			/*
A.- crear un procedimiento que cree una tabla vacia(id int primary key) 
con el nombre que el usuario decida*/

		CREATE PROCEDURE [crear tabla vacía]
			@nombre_tabla varchar(max)
			AS
			begin
			declare @sql nvarchar(max);
			set @sql = Concat('Create table ', @nombre_tabla, ' ( 
						id int primary key )')
			exec sp_executesql @sql;
		end;

	exec [crear tabla vacía] @nombre_tabla = 'Carmen2';
																			/*
B.- Crear procedimiento que cree tantos campos como el usuario decida */

	Create procedure [crear tantos campos y tipos como el usuario quiera]
		@nombre_tabla varchar(max),
		@campo varchar(max)
		--@tipo varchar(max)

		AS
		begin

		declare @cantidad_campos int;
		declare @tabla_temporal table( 
				posicion int identity (1,1) ,
				nombre varchar(max) );

		insert into @tabla_temporal select * from STRING_SPLIT(@campo,',');

		set @cantidad_campos = (select count(*) from @tabla_temporal);

		declare @contadora int = 1;
		--set @contadora = 1;
		declare @sql nvarchar(max);
		WHILE @contadora <= @cantidad_campos
			begin
			set @campo = (select nombre from @tabla_temporal where posicion = @contadora);
			set @sql = CONCAT('Alter Table ', @nombre_tabla,' ADD ', @campo , ' varchar(max); ');
			exec sp_executesql @sql;
			set @contadora = @contadora + 1;
		end
	end;

		--drop procedure [crear tantos campos y tipos como el usuario quiera];

		-- ALTER DATABASE [Arrocera] SET COMPATIBILITY_LEVEL = 130 // para que funcione STRING_SPLIT( ,',')

	exec [crear tantos campos y tipos como el usuario quiera] 
			@nombre_tabla = 'Carmen2',
			@campo = 'nombre,apellidos,tlfno,fecha_nacimiento' ;
			--@tipo = 'varchar(max),varchar(max),int,datetime';
				
-- INCREMENTE EN 1 10% LOS ARTICULOS QUE EL USUARIO DETERMINE
	Create procedure [AumentarPorcentaje]
		@NumArticulo int,
		@Aumento int

		AS
		begin
		Update Artículos set precio = precio+(precio*@Aumento/100)+1 where nºartículo = @NumArticulo;
		print @Aumento;

	end;


	--drop procedure [AumentarPorcentaje];
	--select * from Artículos;
	exec [AumentarPorcentaje]1,10;

-- Crear tabla temporal que almacene todos los clientes casados
	Create procedure [TablaTemporal]
		AS
		begin
		select * into #tabla from Clientes where casado = 1; --opcion 1
		select * into ##tabla from Clientes where casado = 1;  --opcion 2
		-- 		delete from ###tabla; --- eliminamos registro y nos quedamos con la estructura OPCION 2

		CREATE TABLE ##tmpAux (tmpPkId int) --opcion 3

		declare @tabla TABLE(id_cliente varchar(5) PRIMARY KEY) --opcion 4

	end;

		--drop procedure [TablaTemporal];

		EXEC [TablaTemporal];

		drop table ##tabla;

		select * from #tabla;  -- AL SALIR DEL PROCEDIMIENTO YA NO EXISTE
		select * from @tabla;  -- AL SALIR DEL PROCEDIMIENTO YA NO EXISTE
		select * from ##tabla; -- AL SALIR DEL PROCEDIMIENTO EXISTE
		select * from ##tmpAux; -- AL SALIR DEL PROCEDIMIENTO EXISTE




-- cursor en procedimiento que muestre las oficinas que elija el usuario
select * from oficinas

	Create procedure [CursorOficinas]
		@Oficinas varchar(max)

		AS
		begin

		declare @tmpOficinas table( nombre varchar(max) );

		insert into @tmpOficinas select * from STRING_SPLIT(@Oficinas,',');

		declare @Oficina varchar(50);
		declare @Ciudad varchar(50);

		declare Oficinas_cursor cursor for SELECT oficina, ciudad from oficinas
			where oficina in(select * from @tmpOficinas);
		open Oficinas_cursor;

		fetch next from Oficinas_cursor into @Oficina,@Ciudad; 

		while @@FETCH_STATUS = 0 
			begin 
			print 'Oficina  ' + cast(@Oficina as varchar(50)) + ', Ciudad  ' + cast(@Ciudad as varchar(50));
			fetch next from Oficinas_cursor into @Oficina,@Ciudad;
		end;

		CLOSE Oficinas_cursor; 
		DEALLOCATE Oficinas_cursor; 
	end;

	
	exec [CursorOficinas] @Oficinas = '12,21' ;
	--drop proc CursorOficinas;


-- procedimiento que elimine un campo de la tabla que elija el usuario

	Create procedure[EliminaCampo]
		@Tabla varchar(max),
		@Campo varchar(max)

		AS
		begin
			Declare @SQL NVARCHAR(max) = 'ALTER TABLE'+ @Tabla +' DROP COLUMN '+@Campo;
			exec sp_executesql @sql;
	end;

