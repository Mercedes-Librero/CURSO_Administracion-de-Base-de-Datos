use Arrocera;

-- Devuelve el promedio de las ventas de los empleados de una oficina que elija el usuario

CREATE OR ALTER FUNCTION Promedio_Ventas(@oficina int)
	returns float
	as
	begin
	declare @Media as float;
	select @Media = avg(Ventas) from empleados where oficina like @oficina;

	return @Media;
end;

	select dbo.Promedio_Ventas(11);


-- Devuelve todas las ventas del año que indique el usuario

CREATE OR ALTER FUNCTION Ventas_anio (@Anio int)
	RETURN TABLE
	AS 
	SELECT
END;

-- MUESTRE Nº ARTICULOS, Nº DEL PROVEEDOR QUE ELJIJA EL USUARIO
		CREATE OR ALTER FUNCTION dbo.ArtProvee (@Proveedor int)

			RETURNs @art TABLE (
				Artinulo int,
				Precio int,
				Proveedor int )

			AS
			begin
				INSERT INTO @Art Select nºartículo, precio, nºProveedor from Artículos where nºproveedor 
					like @Proveedor
				return
		end;

		select * from dbo.ArtProvee(3)

-- que si le enviamos el proveedor 3 nos muestre el promedio de los precios de sus articulos y si nos
-- envian el proveedor 4 haga lo mismo pero con un 10% de descuento

		CREATE OR ALTER FUNCTION PrecioMedioProveedor(@Proveedor int)
			returns float
			AS
			begin
				declare @Precio_Medio float;
				if @Proveedor = 3
					set @Precio_Medio = (Select avg(Precio) from Artículos where nºproveedor like 3)
				else if @Proveedor = 4
					set @Precio_Medio = (Select avg(Precio)*0.9 from Artículos where nºproveedor like 4)

				return @Precio_Medio;
		end;

		select dbo.PrecioMedioProveedor (3)

--  que muestre el nombre del director de la oficina que elija el usuario
		CREATE OR ALTER FUNCTION NombreDirector(@Oficina int)
			returns nvarchar(max)
			AS
			begin
				declare @Nombre nvarchar(max);

				select @Nombre = empleados.nombre from oficinas
						inner join empleados on empleados.numemp = oficinas.dir
						where oficinas.oficina = @Oficina;
				return @Nombre;

				/*declare @Nombre2 nvarchar(max);
				set @Nombre2 =(Select empleados.nombre from oficinas
						inner join empleados on empleados.numemp = oficinas.dir
						where oficinas.oficina = @Oficina);
				return @Nombre2;*/
		end;

		select dbo.NombreDirector (11)

	---- Con TABLA----------------------------------------------------------------------
		CREATE OR ALTER FUNCTION NombreDirectorTabla(@Oficina int)
			returns table
			AS

				Return Select empleados.nombre from oficinas
						inner join empleados on empleados.numemp = oficinas.dir
						where oficinas.oficina = @Oficina
				-----------
		select * from dbo.NombreDirectorTabla(11)

-- MUESTRE OFICINAS DE LA REGION QUE DIGA EL USUARIO
		SELECT * FROM oficinas WHERE region LIKE 'ESTE'

		CREATE OR ALTER FUNCTION OficinasRegion(@RegOficina nvarchar(50))
			returns table
			AS
				Return SELECT * FROM oficinas WHERE region LIKE @RegOficina
		------------
		select * from dbo.OficinasRegion('Este')

--si las oficinas son del 'ESTE' muestre objetivo menos ventas y si son del 'CENTR0' mostrar 'No computable'
		CREATE OR ALTER FUNCTION EsteCentro(@OtraOficina nvarchar(10))
			returns varchar(max)
			AS
			begin 
			DECLARE @rESULTADO VARCHAR(MAX);
				if @OtraOficina = 'Este'
				 set @Resultado =(Select STRING_AGG(OBJETIVO-VENTAS,',') AS TOTAL FROM OFICINAS
						WHERE  REGION = 'Este')
				else if @OtraOficina = 'Centro'
					set @Resultado = 'NO COMPUTABLE'

				RETURN @RESULTADO

		end;


Declare @Datos varchar(max)
set @Datos = (Select dbo.EsteCentro ('Este'));
select value from string_split (@datos,',')