/*
Tablas TEMPORALES

	#locales: Las tablas temporales locales tienen una # como primer carácter en su nombre y sólo se pueden utilizar 
		en la conexión en la que el usuario las crea. Cuando la conexión termina la tabla temporal desaparece.

	##globales Las tablas temporales globales comienzan con ## y son visibles por cualquier usuario conectado al SQL 
	Server. Y una cosa más, estás tablas desaparecen cuando ningún usuario está haciendo referencias a ellas, no cuado 
	se desconecta el usuario que la creo.

	Temp Realmente hay un tipo más de tablas temporales. Si creamos una tabla dentro de la base de datos temp es una 
	tabla real en cuanto a que podemos utilizarla como cualquier otra tabla en cualquier base de datos, y es temporal 
	en cuanto a que desaparece en cuanto apagamos el servidor.



	Crear una tabla temporal es igual que crear una tabla normal. Veámoslo con un ejemplo:*/
		CREATE TABLE #TablaTemporal (Campo1 int, Campo2 varchar(50))

		INSERT INTO #TablaTemporal VALUES (1,'Primer campo')
		INSERT INTO #TablaTemporal VALUES (2,'Segundo campo')
		SELECT * FROM #TablaTemporal /*

	Con SQL Server 2000 podemos declarar variables de tipo table. Este tipo de variables tienen una serie de 
	ventajas sobre las tablas temporales por lo que siempre que podamos escogeremos usar variables de tabla 
	frente a tablas temporales. Usar variables temporales es sencillo: */

		DECLARE @VariableTabla TABLE (Campo1 int, Campo2 char(50))

		INSERT INTO @VariableTabla VALUES (1,'Primer campo')
		INSERT INTO @VariableTabla VALUES (2,'Segundo campo')
		SELECT * FROM @VariableTabla

		/*Ventajas que encontraremos al usar variables de tipo tabla:

			Tienen un ámbito bien definido. El procedimiento almacenado, la función o el batch en el que se declaran.
			Las variables de tipo tabla producen menos recompilaciones de los procedimientos almacenados en los que 
				se encuentran que si utilizamos tablas temporales.
			Las variables de tabla no necesitan de bloqueos ni de tantos recursos como las tablas temporales.

		Pero también tienen inconvenientes:

			No podemos cambiar la definición de la tabla una vez declarada
			No podemos utilizar índices que no sean agrupados
			No se pueden utilizar en INSERT INTO ni en SELECT INTO
			No podemos utilizar funciones en las restricciones 


Tablas temporales */

		declare @st datetime
		SET @st =getdate()
		CREATE TABLE #Actualizar (OrderId int, ShipVia int, Freight money)
		INSERT INTO #Actualizar SELECT OrderID, ShipVia, Freight  
			FROM Orders WHERE ShipVia=2 AND ShippedDate IS NULL
		UPDATE Orders SET ShipVia=3, Freight=10 WHERE OrderID IN   
			(SELECT OrderID FROM #Actualizar)DROP TABLE #Actualizar
		PRINT 'Operacion completada en: '  + RTRIM(cast(datediff(ms,@st,getdate()) as char(10)))  
			+ ' milisegundos' /*

		Y obtenemos como resultado:

		(11 filas afectadas)
		(11 filas afectadas)
		Operacion completada en: 140 milisegundos

Variables tipo Tabla */

		DECLARE @st datetime
		SET @st =getdate() 
		DECLARE @Actualizar TABLE(OrderId int, ShipVia int, Freight money)
		INSERT INTO @Actualizar SELECT OrderID, ShipVia, Freight 
			FROM Orders WHERE ShipVia=2 AND ShippedDate IS NULL
		UPDATE Orders SET ShipVia=3, Freight=10 WHERE OrderID IN   
			(SELECT OrderID FROM @Actualizar)
		PRINT 'Operacion completada en: '   + rtrim(cast(datediff(ms,@st,getdate()) AS char(10)))   
			+ ' milisegundos' /*

		Y en este caso el resultado es:

		(11 filas afectadas)
		(11 filas afectadas)
		Operacion completada en: 73 milisegundos 

Sin Tablas temporales*/

		DECLARE @st datetime
		SET @st =getdate()
		UPDATE Orders SET ShipVia=3, Freight=10 WHERE OrderID IN   
			(SELECT OrderID FROM Orders WHERE ShipVia=2 AND ShippedDate IS NULL)
		PRINT 'Operacion completada en: '   + rtrim(cast(datediff(ms,@st,getdate()) AS char(10)))   
			+ ' milisegundos' /*

		Y por último obtenemos:

		(11 filas afectadas)
		Operacion completada en: 50 milisegundos