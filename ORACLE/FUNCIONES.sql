

-- Funcion que reciba un valor de la gama productos 
CREATE OR REPLACE FUNCTION Total_Stock_Gama (Gama_Usuario Productos.Gama%TYPE)

    RETURN number is TotalStock Number (20,5);
          BEGIN
              select sum(Cantidadenstock) into TotalStock from Productos where Gama Like Gama_Usuario;
              return TotalStock;
          END ;
      
      select Total_Stock_Gama ('Frutales') from dual;
      


-- FUNCION que reciba un codigo de empleado y nos diga (si es jefe ) la cantidad de empleados que tiene a su cargo
        CREATE OR REPLACE FUNCTION EmpleadosCargo (Codigo Empleados.CodigoJefe%TYPE)
        
            RETURN number is Total Number (6,0);
                  BEGIN
                      select Count(*) into Total from Empleados where CodigoJefe Like Codigo;
                      return Total;
        END EmpleadosCargo;
        
        select empleadosCargo(7) from dual;
        
        
  -------------------FUNCIONES---------------------
----las funciones solo permiten hacer select------

		CREATE OR REPLACE FUNCTION OBTENER_LIMITECREDITO_CLIENTE
		(cod number)
		return number
		is
		limite number;
		begin
			select clientes.limitecredito 
			into limite
			from clientes
			where codigocliente = cod;
			return limite;
		end OBTENER_LIMITECREDITO_CLIENTE;


		select *
		from clientes
		where limitecredito = obtener_limitecredito_cliente(1);

--------------------
		create or replace function promedio
		(valor1 number,
		valor2 number)
		return number
		is
		resultado number;
		begin
				resultado := (valor1 + valor2)/2;
				return resultado;
		end promedio;

		select *
		from clientes
		where limitecredito > promedio(10,2);

-----------------------------------------------------------
		create or replace function geolocalizar
		(cod_pais number)
		return varchar2
		is 
		estado varchar2(50);
		begin
			   CASE cod_pais
				when 34 then estado:= 'España';
				when 10 then estado:= 'USA';
				when 20 then estado:= 'France';
				end Case;
				return estado;
		end geolocalizar;

		select * from clientes where pais = geolocalizar(20);


-------------------------------------------------------
--funcion q controla si hay al ejecutar la sql
------------------------------------------------------
		create or replace function clientes_sin_error
		(cod number)
		return varchar2
		is
		variable_nombre varchar2(50);
		begin
			select nombrecliente
			into variable_nombre
			from clientes
			where codigocliente = cod;  
			 return variable_nombre;
			EXCEPTION
			WHEN OTHERS THEN
			  RAISE_APPLICATION_ERROR(-20001,
									  'OCURRIO UN ERROR AL OBTENER EL NOMBRE DEL CLIENTE - ' || SQLCODE || ' -ERROR- ' || SQLERRM);
                              
		end clientes_sin_error;

		select *
		from clientes
		where nombrecliente = clientes_sin_error(1);

--------------------
create or replace function f_incremento (avalor number, aincremento number)
  return number
 is
  begin 
   return avalor+(avalor*aincremento/100);
  end f_incremento;
  
   select nombrecliente,limitecredito,f_incremento(limitecredito,20) 
   from clientes;




        
        
          
