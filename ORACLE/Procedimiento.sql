 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- P  R  O  C  E  D  I  M  I  E N  T  O --------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------


-- PROCEDIMIENTO que reciba un codigo de oficina y muestre todo lo necesario par enviarle una carta
        SELECT * FROM oficinas;
        
        set serveroutput on;
        
             CREATE OR REPLACE  PROCEDURE EnvioPostal (Codigo in Varchar2) as Texto Varchar2(50);
                  BEGIN
                      Select CodigoOficina|| ' ' || LineaDireccion1 || ' ' || Pais || ' ' || CodigoPostal
                            into Texto from Oficinas where CodigoOficina like Codigo;
                      DBMS_OUTPUT.PUT_LINE(Texto); 
                  END EnvioPostal;
                  
        call EnvioPostal ('BCN-ES'); 
        
        

-- procedimiento que pida al usuario una forma de pago y que muestre cuantas trasacciones 
-- tiene el total de la cantidad (suma de las cantidades)
            select count(*) from pagos where formapago like '&pago';

            set serveroutput on;

     CREATE OR REPLACE  PROCEDURE FormaPago (Pago in Varchar2) as Total Varchar2(50);
          BEGIN
              Select count(*) || '   Total cantidad: ' || sum(Cantidad) 
                    into Total from Pagos where FormaPago like Pago;
              DBMS_OUTPUT.PUT_LINE(Total); 
          END FormaPago;
          
    call FormaPago ('&Pago'); 
    
    
-- mostrar el texto 'El cliente <nombre> ha comprado el día <fechapedido>' usa cursores

        CREATE OR REPLACE PROCEDURE ver_clientes_y_fecha_compra
        IS
        CURSOR cursor_clientes_fechas IS
            SELECT *
            FROM Clientes INNER JOIN Pedidos
            ON Clientes.codigocliente = Pedidos.codigocliente;
        BEGIN
            FOR registro IN cursor_clientes_fechas
            LOOP
                dbms_output.put_line('el cliente ' || registro.nombrecliente || ' ha comprado el día ' || registro.fechapedido);
            END LOOP;
        END ver_clientes_y_fecha_compra;
        
        CALL ver_clientes_y_fecha_compra();
        
        
---------------------------------------------------
-- muestra la suma de las cantidades en stockde la tabla productos,
--      agrupados por gamma. con el texto 'la gama <gamma> tiene <suma cantidades> en stock'
--      * mejora el ejercicio abriendo la posibilidad de que el usuario eliga la gamma

            create or replace procedure cantidades_en_stock_por_gama
            is
            cursor cursor_stock_gama is
                select gama, sum(cantidadenstock) suma
                from productos
                group by gama;
            begin
                for registro in cursor_stock_gama
                loop
                    dbms_output.put_line('la gama' || registro.gama || ' tiene ' || registro.suma || ' en stock ');
                end loop;
            end cantidades_en_stock_por_gama;
            
            call cantidades_en_stock_por_gama();

-- 2ºparte
        create or replace procedure cantidades_en_stock_por_gama_eligiendo
        is
        cursor cursor_stock_gama_elegir is
            select gama, sum(cantidadenstock) suma
            from productos
            where gama like '&gamo'
            group by gama;
        begin
            for registro in cursor_stock_gama_elegir
            loop
                dbms_output.put_line('la gama ' || registro.gama || ' tiene ' || registro.suma|| ' unidades en stock ');
            end loop;
        end cantidades_en_stock_por_gama_eligiendo;
        
        call cantidades_en_stock_por_gama_eligiendo();
        
 ----------------------------------------------------       
SET SERVEROUTPUT ON;
    create or replace procedure ver_empleados
    is
    variable_nombre varchar2(50);
    begin
        select nombre 
        into variable_nombre
        from empleados
        where codigoempleado = 1;
        dbms_output.put_line('El empleado se llama ' || variable_nombre);
    end ver_empleados;

    call ver_empleados();
----------------------------------------------------------------------
-- Crear un procedimiento que muestre por consola los nombres de los empleados, con cursores

create or replace procedure empleados_nombres
is
    cursor conjunto_nombres is
        select nombre 
        from empleados;
begin
        for tabla_temporal in conjunto_nombres 
        loop
            DBMS_OUTPUT.PUT_LINE(tabla_temporal.nombre);
        end loop;
end empleados_nombres;

call empleados_nombres();

set serveroutput on;

select * from PRODUCTOS;
---------------------------------------------------------------------------------------------------
*Crear un procedimiento que muestre por consola los nombres de los clientes, con cursores

create or replace procedure clientes_nombres
is
cursor conjunto_nombres is 
select nombrecliente from clientes;
begin 
for tabla_temporal in conjunto_nombres
loop
DBMS_OUTPUT.PUT_LINE(tabla_temporal.nombrecliente);
end loop;
end clientes_nombres;


call clientes_nombres();

set serveroutput on;

select * from clientes;
---------------------------------------------------------------------------------------------------
*Crear procedimiento que muestre los productos de la gama que el usuario elija

Create or replace procedure gama_usuario_nueva
(gama_usuario in varchar2)
is
Begin
    select gama
    from  productos
    where gama = gama_usuario;
end gama_usuario_nueva;

call gama_usuario_nueva('Herramientas');

select * from gamasproductos;
-----------------------
---------------------------------------------------------------------------------------------------
*Crear procedimiento que baje en 25% el precio de venta en todos los productos

create or replace procedure rebajas25 
IS
Begin
    update productos
    set precioventa = precioventa*0.75;
End rebajas25;


select * from productos

call rebajas25();
---------------------------------------------------------------------------------------------------
* Crear un procedimiento por el cual los productos de frutales suban un 30% y los aromáticos bajen un 10%

CREATE OR REPLACE PROCEDURE Frutales30arriba_Aromaticos10abajo
IS
BEGIN
        UPDATE PRODUCTOS SET PRECIOVENTA = PRECIOVENTA * 1.30 WHERE GAMA = 'Frutales';
        UPDATE PRODUCTOS SET PRECIOVENTA = PRECIOVENTA *0.90 WHERE GAMA = 'Aromáticas';
END Frutales30arriba_Aromaticos10abajo;

call Frutales30arriba_Aromaticos10abajo();

select * from productos
---------------------------------------------------------------------------------------------------
*Crear un procedimiento que ponga la descripcion texto con 'nuevo'
a la gamma que elija el usuario

Create or replace procedure gama_nueva
(gama_usuario in varchar2)
is
Begin
    update gamasproductos
    set descripciontexto = 'Nuevo'
    where gama = gama_usuario;
end gama_nueva;

call gama_nueva('Herramientas');

select * from gamasproductos;
---------------------------------------------------------------------------------------------------
*Crear procedimiento que en la tabla productos cambie la precioproveedor
al valor que eliga el usuario solo si hay mas en stock que la cantidad 
que decida el usuario

Create or replace procedure cambiar_precio_proveedor
(PRECIOSELECT in NUMBER,
NUEVOPRECIO in NUMBER
)
is
Begin
    update PRODUCTOS
    set PRECIOPROVEEDOR = PRECIOSELECT
    where CANTIDADENSTOCK > NUEVOPRECIO;
end cambiar_precio_proveedor;

DROP PROCEDURE cambiar_precio_proveedor;

FORMA JOSEP

create or replace procedure cambiar_precio_proveedor
(precio_usuario in number,cantidad_usuario in number)
is
begin
    update productos
    set precioproveedor = precio_usuario
    where cantidadenstock > cantidad_usuario;
end cambiar_precio_proveedor;

call cambiar_precio_proveedor(555,10);

--roll back sirve para deshacer un cambio antes del commit;
rollback;
--commit sirve para fijar/grabar los cambios realizados
commit;


call cambiar_precio_proveedor(555,10);

select * from PRODUCTOS;

--roll back sirve para deshacer un cambio antes del commit;
rollback;
--commit sirve para fijar/grabar los cambios realizados
commit;
--para mostrar texto por pantalla
set serveroutput on;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Esto cómo lo imprimo?!');
END;
---------------------------------------------------------------------------------------------------
------CURSORES-------
*crea un procedimiento que muestre por pantalla los nombres de los productos
cuyos pedidos(detallepedido) superen la cantidad de 25

create or replace procedure productos_cantidad_pedido_25
is
    cursor conjunto_nombres is
        select nombre 
        from productos inner join detallepedidos
        on productos.codigoproducto = detallepedidos.codigoproducto
        where detallepedidos.cantidad > 25;
begin
        for tabla_temporal in conjunto_nombres 
        loop
            DBMS_OUTPUT.PUT_LINE(tabla_temporal.nombre);
        end loop;
end productos_cantidad_pedido_25;

call productos_cantidad_pedido_25();

DROP PROCEDURE productos_cantidad_pedido_25;

select * from productos_cantidad_pedido_25;

--------------------------------------------------------------------------------------------------------------------------------
INSERTAR IMAGEN    NO FUNCIOONA
--------------------------------------------------------------------------------------------------------------------------------------

        CREATE TABLE FOTOS
        (
         ID_IMAGEN NUMBER,
         NOMBRE_IMAGEN VARCHAR2(50),
         IMAGEN BLOB
        )
        
        INSERT INTO fotos  
        VALUES (100, 'BOB', utl_raw.cast_to_raw('C:\Users\Profesor\Desktop\imagenes para compartir\f1.jpg'));
        
        select * from fotos;
        
        SELECT UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(DBMS_LOB.SUBSTR(imagen,1400,1))) imagen
        FROM fotos
        where id_imagen = 1;
        
        
        -------------------
        CREATE OR REPLACE DIRECTORY <'NOMBRE DIRECTORIO'>
        AS <'RUTA DE LAS IMAGENES'>
        
        CREATE DIRECTORY IMAGENES AS 'C:\Users\Profesor\Desktop\imagenes para compartir';
        GRANT READ, WRITE, EXECUTE ON DIRECTORY IMAGENES TO SYSTEM;
        
        create table Test (id number, logo blob);
        
        create or replace procedure insert_img as
                f_lob bfile;
                b_lob blob;
                begin
                insert into test (id, logo) values (8088, empty_blob())
                return logo into b_lob;
                f_lob :=bfilename('IMAGENES', 'f1.jpg');
                dbms_lob.fileopen (f_lob, dbms_lob.file_readonly);
                dbms_lob.loadfromfile(b_lob, f_lob, dbms_lob.getlength(f_lob));
                dbms_lob.fileclose(f_lob);
                commit;
                end;
        
        call insert_img();

--------------------------------------------------
FIN INSERTAR IMAGENES NO FUNCIONA
--------------------------------------------------
