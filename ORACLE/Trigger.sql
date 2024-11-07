 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- T  R  I  G  G  E  R  --------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

    -- TRIGGER que al eliminar un pago, lo insert en la tabla pago_Borrados
            create table Pagos_Borrados as select * from Pagos;    
            Delete from Pagos_Borrados;
    
        
        CREATE OR REPLACE trigger PagosBorrados
            after delete on PAGOS
            FOR EACH ROW
            begin 
                insert into Pagos_Borrados values (:OLD.CodigoCliente,:OLD.formapago,:OLD.idtransaccion,:OLD.fechapago,:OLD.cantidad);
        END;
    

        delete from pagos where codigocliente like 28;
        select * from pagos_borrados;

--  CREAR UN TRIGGER EN LA TABLA SOLUCIONES Y SI SE INSERTA ALGO, QUE TAMBIEN LO HAGA EN LA TABLA 
-- COPIA_SOLUCIONES Y SI SE BORRA ALGO QUE HAGA LO MISMO

         if inserting then...
         if deleting then....
         
         create table copia_soluciones
         as
         select * from soluciones;
        
        create or replace trigger insertar_borrar_en_copia_soluciones
        after insert or delete
        on soluciones
        for each row
        begin
            if inserting then
                insert into copia_soluciones values (
                        :new.id_respuesta,
                        :new.nombre_respuesta,
                        :new.valor,
                        :new.fecha,
                        :new.tipo);
            end if;
            if deleting then
                delete from copia_soluciones where id_respuesta = :old.id_respuesta;
            end if;
        end;

---------------------------
-- crear un trigger en gammaproductos que mande un mensaje al insertar un registro
-- dicho mensaje debe indicar lo siguiente:
-- "La gama <gama> de tipo <descripciontexto> ha sido insertada"

        create or replace trigger insertar_mensaje_gamaproductos
        after insert 
        on gamasproductos
        for each row
        begin
                DBMS_OUTPUT.PUT_LINE('La gama ' || :new.gama || ' de tipo ' || :new.descripciontexto || ' ha sido insertada');
        end;
        
        insert into gamasproductos (gama,descripciontexto) values ('jummpers','muy ricos');

        
-- trigger que se inserte un pago en PAGOS_GRANDES si cantidad > 1000, en caso contrario en la tabla 
-- MINI_PAGOS. Haz lo mismo se se eliminan dichos pagos
        create table Pagos_Grandes AS select * from pagos where cantidad > 1000;
        create table Mini_Pagos AS select * from pagos where cantidad <= 1000;
        
        select * from Pagos_Grandes;
        select * from Mini_Pagos ;
        
        
        create or replace trigger Tipo_Pago
            after insert or delete
            on pagos
            
            for each row
             begin
                if INSERTING then              
                    if (:new.cantidad > 1000) then
                        insert into Pagos_Grandes values (:new.codigocliente,:new.formapago,:new.idtransaccion,:new.fechapago,
                                :new.cantidad);
                    else 
                        insert into Mini_Pagos values (:new.codigocliente,:new.formapago,:new.idtransaccion,:new.fechapago,
                                :new.cantidad);
                    end if;
                end if;
                
                if DELETING then              
                    if (:old.cantidad > 1000) then
                        delete from Pagos_Grandes where idtransaccion like :old.idtransaccion;
                    else 
                        delete from Mini_Pagos where idtransaccion like :old.idtransaccion;
                    end if;
                 end if;     
        end;
        
        
        insert into pagos values(1,'visa maña','numero 1','01/01/01',500);
        insert into pagos values(1,'visa maña','numero 2','02/02/02',8800);


-- Si hay 10 oficinas en la tabla oficinas, no debe permitir insertar una nueva.

        create or replace trigger prohibido_insertar_mas_oficinas
        after insert 
        on oficinas
        for each row
        declare total number;
        begin
           select count(codigooficina) 
           into total from oficinas;
            if inserting then
               
                   DELETE FROM oficinas
                   WHERE codigooficina = :new.codigooficina and total >= 10;
               
            end if;
        end;
        
        
        
        INSERT INTO OFICINAS (CODIGOOFICINA) VALUES ('101')
        SELECT * FROM OFICINAS;
        DROP TRIGGER prohibido_insertar_mas_oficinas
        
        
        
---------------------------------------------------------------------------------------------------
--Crear trigger que cuando se actualice la tabla oficinas, tb lo haga en copia_oficinas

        CREATE TABLE COPIA_OFICINAS AS SELECT * FROM OFICINAS;
        
        DROP TABLE COPIA_OFICINAS
        
        create or replace trigger actualización_en_copia_oficinas
        after UPDATE 
        on OFICINAS
        for EACH row
        begin
            UPDATE COPIA_OFICINAS 
            SET CODIGOOFICINA = :new.CODIGOOFICINA, CIUDAD = :new.CIUDAD,
                PAIS = :new.PAIS,REGION = :new.REGION,
                CODIGOPOSTAL = :new.CODIGOPOSTAL,TELEFONO = :new.TELEFONO,
                LINEADIRECCION1 = :new.LINEADIRECCION1,LINEADIRECCION2 = :new.LINEADIRECCION2
            WHERE 
                CODIGOOFICINA = :new.CODIGOOFICINA;
        end;
        
        
        
        drop trigger actualización_en_copia_oficinas;
        
        select * from COPIA_OFICINAS;
        select * from OFICINAS;
        
        
---------------------------------------------------------------------------------------------------
--CREAR TRIGGER QUE AL BORRAR UN REGISTRO DE LA TABLA OFICINAS, TB SE BORRE DE COPIA_OFICINAS

insert into OFICINAS (CODIGOOFICINA) values ('ZAR-ES');

create or replace trigger borrar_de_COPIA_OFICINAS
after delete on OFICINAS
for EACH row
begin
    delete from COPIA_OFICINAS
    where CODIGOOFICINA = :old.CODIGOOFICINA;
end;

DROP TRIGGER borrar_de_COPIA_OFICINAS;

select * from COPIA_OFICINAS;
select * from OFICINAS;

DELETE FROM OFICINAS WHERE CODIGOOFICINA = 'ZAR-ES';

---------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
CREATE TABLE copia_productos AS SELECT * FROM PRODUCTOS;

create or replace trigger actualización_en_copia_productos
after insert on productos
for EACH row
begin
    insert into copia_productos (codigoproducto,gama) values (:new.codigoproducto,'Frutales');
end;


drop trigger actualización_en_copia_productos;

select * from copia_productos;
select * from productos;
---------------------------------------------------------------------------------------------------
*CREAR UN TRIGGER EN GAMASPRODUCTOS QUE AL INSERTAR UN REGISTRO TB LO HAGA EN COPIA_GAMMAPRODUCTOS

---CREAR UN TRIGGER EN GAMASPRODUCTOS QUE AL INSERTAR UN REGISTRO TB LO HAGA EN 
COPIA_GAMMAPRODUCTOS---

CREATE TABLE COPIA_GAMASPRODUCTOS
AS
SELECT *
FROM GAMASPRODUCTOS;

create or replace trigger actualización_en_copia_gamasproductos
after insert on gamasproductos
for EACH row
begin
    insert into copia_gamasproductos values (:new.gama,:new.descripciontexto,:new.descripcionhtml,:new.imagen);
end;

insert into gamasproductos (GAMA) values ('Mixtas');
De mí para todos:  07:54 PM
CREATE TABLE COPIA_GAMASPRODUCTOS AS SELECT * FROM GAMASPRODUCTOS;

DROP TABLE COPIA_GAMASPRODUCTOS

EL MIO

create or replace trigger actualización_en_copia_gamasproductos
after insert on GAMASPRODUCTOS
for EACH row
begin
    insert into COPIA_GAMASPRODUCTOS (GAMA) 
    values (:new.GAMA);
end;



drop trigger aactualización_en_copia_gamasproductos;

select * from copia_gamasproductos;
select * from GAMASPRODUCTOS;

insert into GAMASPRODUCTOS (GAMA) values ('CANIVALES');
---------------------------------------------------------------------------------------------------
*CREAR UN TRIGGER QUE CUANDO BORREMOS UN REGISTRO DE GAMAPRODUCTOS TAMBIEN LO BORRE EN COPIA_GAMAPRODUCTOS

create or replace trigger borrar_de_copia_gamasproductos
after delete on GAMASPRODUCTOS
for EACH row
begin
    delete from COPIA_GAMASPRODUCTOS
    where gama = :old.gama;
end;

DROP TRIGGER borrar_de_copia_gamasproductos;

select * from copia_gamasproductos;
select * from GAMASPRODUCTOS;

DELETE FROM GAMASPRODUCTOS WHERE GAMA = 'CANIVALES';
---------------------------------------------------------------------------------------------------
*TRIGGER SI INSERTA O ELIMINA

create or replace trigger inserta_elimina_copia_gamaproductos
after insert or delete
on gamasproductos
for each row
begin
    IF INSERTING THEN
        --CODIGO DE INSERTAR
        insert into copia_gamaproductos values (:new.gama,:new.descripciontexto,:new.descripcionhtml,:new.imagen); 
    END IF;
    IF DELETING THEN
        --CODIGO DE ELIMINAR
        delete from copia_gamaproductos where gama = :old.gama;
    END IF;
end;

DROP TRIGGER inserta_elimina_copia_gamaproductos;

select * from copia_gamasproductos;
select * from GAMASPRODUCTOS;

insert into GAMASPRODUCTOS (GAMA) values ('CANIVALES');
DELETE FROM GAMASPRODUCTOS WHERE GAMA = 'CANIVALES';


------------------------------------------
--NO ES POSIBLE USAR SAVEPOINT DENTRO DE UN TRIGGER----
-----------------------------------------------
Crea puntos de guardado cada vez que insertes un registro en  Pedidos

create or replace trigger guardar_insert_pedidos
before insert
on pedidos
for each row
begin
savepoint A;
end guardar_insert_pedidos;

rollback to savepoint A; 

select * from pedidos;
insert into pedidos values (130,'01/01/01','01/01/01','01/01/01','Pendiente',NULL,30);
------------------------------------------
--NO ES POSIBLE USAR SAVEPOINT DENTRO DE UN TRIGGER----
-----------------------------------------------












-------------------------------------------