 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- C  U  R  S  O  R -----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
    set serveroutput on;  --Hace funcionar el put_line

        create or replace procedure mostrar_empleados_cursor
        is
            cursor cursor_tabla_empleados is   select * from empleados;
            begin 
                for registro_temporal in cursor_tabla_empleados
                loop
                    DBMS_OUTPUT.PUT_LINE(registro_temporal.nombre);
                end loop
        end mostrar_empleados_cursor;


    -- mostrar mediante un cursor los email de los empleados que trabajen en la ciudad que el usuario quiera

            create or replace procedure cursor_email_empleados
                is
                cursor cursor_empleados is     select email
                
                    from empleados natural join oficinas where ciudad like '&ciudad';
                    begin
                        for registro in cursor_empleados
                        loop
                            DBMS_OUTPUT.PUT_LINE(registro.email);
                        end loop;        
                end cursor_email_empleados;
        
                call cursor_email_empleados();


-- mediante curosres haz que se muestre todos los clientes y el nombre de los empleados, tengan o no codigoempleadoventa(clientes)

        create or replace procedure clientes_empleados
        is
            cursor cursor_nombrecliente is
                select nombrecliente, empleados.nombre
                from clientes inner join empleados
                on clientes.codigoempleadorepventas = empleados.codigoempleado;
        begin
                for registro in cursor_nombrecliente 
                loop
                    DBMS_OUTPUT.PUT_LINE(registro.nombrecliente || ',' || registro.nombre);
                end loop;
        end clientes_empleados;
        
        call clientes_empleados();


-- mediante cursores muestra el codigopedido y fechapedido , de aquellos pedidos que elija el usuario (codigo pedido).

        create or replace procedure cursor_datos_pedidos_usuario (var_cp in number)
        is
        
            cursor cursor_pedidos is
                select codigopedido, fechapedido
                from pedidos 
                where codigopedido like var_cp;
        begin
            for registro in cursor_pedidos
            loop
            DBMS_OUTPUT.PUT_LINE(registro.codigopedido || ',' || registro.fechapedido);
            end loop;
        end cursor_datos_pedidos_usuario;
        
        call cursor_datos_pedidos_usuario(&var_cp);
        
---Cursor que muestre todos los metodos de pago

        select distinct FormaPago from Pagos;
        
        SET SERVEROUTPUT ON;
        
        BEGIN 
        for Cursor_Pago IN (select Distinct FormaPago from Pagos)
        LOOP 
        DBMS_OUTPUT.PUT_LINE('Forma pago:    ' || Cursor_Pago.FormaPago); 
        END LOOP; 
        END; 
        /


-- cursor que muestre todos los pagos (todos los campo)
        select  * from Pagos;
        
        SET SERVEROUTPUT ON;

        BEGIN 
        for CursorTodosPagos IN (select * from Pagos)
            LOOP 
                DBMS_OUTPUT.PUT_LINE('Cliente:    ' || CursorTodosPagos.CodigoCliente ||
                    ' Forma pago:    ' || CursorTodosPagos.FormaPago ||
                    ' Transaccion:    ' || CursorTodosPagos.idTransaccion ||
                    ' Fecha:    ' || CursorTodosPagos.idTransaccion ||
                    ' Cantidad:    ' || CursorTodosPagos.Cantidad
                ); 
            END LOOP; 
        END; 
        /
        
        DECLARE CURSOR CursorTodosPagos is select * from Pagos;
        BEGIN 
        for Tabla_Temporal IN CursorTodosPagos
            LOOP 
                DBMS_OUTPUT.PUT_LINE('Cliente:    ' || Tabla_Temporal.CodigoCliente ||
                    ' Forma pago:    ' || Tabla_Temporal.FormaPago ||
                    ' Transaccion:    ' || Tabla_Temporal.idTransaccion ||
                    ' Fecha:    ' || Tabla_Temporal.idTransaccion ||
                    ' Cantidad:    ' || Tabla_Temporal.Cantidad
                ); 
            END LOOP; 
        END; 
        /


-- cursor que muestro todos los pagos de metodo de pago que elija el usuario (&)
        select  * from Pagos;
        
        SET SERVEROUTPUT ON;
    
        BEGIN 
            for CursorTodosPagos IN (select * from Pagos where FormaPago like '&Pago')
            LOOP 
                DBMS_OUTPUT.PUT_LINE('Cliente:    ' || CursorTodosPagos.CodigoCliente ||
                    ' Forma pago:    ' || CursorTodosPagos.FormaPago ||
                    ' Transaccion:    ' || CursorTodosPagos.idTransaccion ||
                    ' Fecha:    ' || CursorTodosPagos.idTransaccion ||
                    ' Cantidad:    ' || CursorTodosPagos.Cantidad
                ); 
            END LOOP; 
        END; 
        /

---  
        create or replace procedure ver_empleados_cursor
        is
        cursor cursor_empleados is
            select *
            from empleados;
        begin
            for registro in cursor_empleados 
            loop
                dbms_output.put_line('el empleado ' || registro.nombre || ' trabaja en la oficina ' || registro.codigooficina);
            end loop;
            
        end ver_empleados_cursor;
        
        call ver_empleados_cursor();
        
        
-- CURSOR
        SET SERVEROUTPUT ON;
        
        BEGIN 
        for item IN (select NOMBRE, GAMA from PRODUCTOS where gama like 'Frutales')
        LOOP 
        DBMS_OUTPUT.PUT_LINE('producto nombre   ' || item.nombre); 
        END LOOP; 
        END; 
        /
        
                select NOMBRE, GAMA from PRODUCTOS where gama like 'Frutales';


