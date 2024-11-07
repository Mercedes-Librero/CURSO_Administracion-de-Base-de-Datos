 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

---------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------- T  A  B  L  A  S -----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
    --  C R E A T E    T A B L E        
        CREATE TABLE Respuestas (id_respuesta number not null primary key,
                         nombre_respuesta varchar2 (25) not null unique,
                         valor varchar2 (20) default 'ninguna',
                         fecha date default sysdate );


    -- C H E C K
        --Haz que el valor solo pueda ser 'ninguna','a','b' o 'c'
                alter table respuestas add constraint valores check (valor in ('ninguna','a','b','c'));
                
         -- Precio tiene que ser mayor de 500
                create table Almuerzos(
                    id_number integer not null,
                    precio float not null,
                    constraint Comprobar_Precio check(precio > 500)
                );

    --muestra la estructura de la tabla
            describe respuestas;

    --modifica el nombre de la tabla respuestas a Soluciones
        rename table respuestas to soluciones;

    --añade el campo tipo que sea texto y que sea voluntario
        alter table soluciones add tipo varchar2(30); 

    --muestra todas las tablas del tablespace
        select * from tab;


--Crear tabla Clase
id alumno int pk
nombre alumno varchar2
nick varchar2
fecha nacimiento tipofecha
aprobado boolean

CREATE TABLE Clase (
    id_alumno number not null primary key,
    nombre varchar2(30) null,
    nick varchar2(30) null,
    fecha_nacimiento date null,
    aprobado char null);
    
drop table Clase;
---------------------------------------------------------------------------------------------------
*Crear tabla colegio y relacionar con la tabla clase crear tabla colegio (
idcolegio number pk
nombre colegio varchar2
id alumno number)

create table colegio (
id_colegio number not null primary key,
nombre_colegio varchar2(30),
id_alumno number)

alter table colegio add constraint FK_cole_alu 
foreign key (id_alumno) references Clase (id_alumno);

create table Viernes (
    id_viernes int not null primary key,
    tipo varchar2(10) default 'bueno',
    fecha date default SYSDATE);
    
alter table viernes add dni int;
alter table viernes add constraint clave_unica unique (dni);

select c.codigocliente,c.nombrecliente,p.codigopedido
from clientes c inner join pedidos p
on c.codigocliente = p.codigocliente;

delete from clientes where codigocliente = 4;

select * from pedidos;

delete from pedidos where codigopedido = 32;

alter table pedidos drop constraint pedidos_cliente;
alter table pedidos add constraint pedidos_cliente 
        references clientes(codigocliente) on delete cascade;

commit;

alter table usuarios add constraint pisciusu_FK foreign key (id_piscina)
    references piscina (id_piscina) ON DELETE CASCADE;

INSERT INTO piscina values (1,'Salduba');
insert into usuarios values (100,'pepe',1);
insert into usuarios values (200,'pepa',1);
insert into usuarios values (300,'pepo',1);

select piscina.nombre,usuarios.nombre_usuario 
from piscina inner join usuarios 
on piscina.id_piscina = usuarios.id_piscina;

delete from piscina where id_piscina = 1;

select * from usuarios;

alter table usuarios add constraint max_id_usuario check (id_usuario < 1000);

insert into piscina values (1,'Bombarda');
insert into usuarios values (678,'version original',1);

alter table piscina add constraint nombres_B check (nombre IN ('B','c','loquequiera'));


CREATE TABLE HECHIZOS (
    ID_HECHIZO INTEGER NOT NULL PRIMARY KEY,
    FECHA DATE DEFAULT SYSDATE,
    NUM_VELAS INTEGER DEFAULT 99,
    TIPO VARCHAR2(30) DEFAULT 'MAGICO')
    
    INSERT INTO HECHIZOS (ID_HECHIZO) VALUES (1);
    INSERT INTO HECHIZOS (ID_HECHIZO,NUM_VELAS) VALUES (2,64);
    
    SELECT * FROM HECHIZOS;
    
    DESCRIBE HECHIZOS;  --muestra la estrutura de la tabla
    describe clientes;
    
    SELECT * FROM TAB;--TODAS LAS TABLAS del TableSpace
    
    SHOW DATABASE ALL ; --muestra las opciones de una base de datos
    
    select table_name from user_tables;  --LAS TABLAS DEL USUARIO EN EL QUE ESTAMOS
    
    RENAME hechizos TO brujos; -- cambia el nombre de la tabla 
    
    alter table brujos read only;
    alter table brujos read write;
    
    insert into brujos (id_hechizo) values (183); 
    insert into brujos (id_hechizo) values (184); 
    insert into brujos (id_hechizo) values (185); 
    
    select * from brujos;
    
    delete from brujos;
    truncate table brujos; --igual que el delete from brujos;
    
----------------------------------------------------------------------------------
    savepoint embrujadas;
    rollback to embrujadas;
    
    rollback;
    
    select num_velas||'---  hola --- '||tipo as halliwey
    from brujos;
    
     select num_velas||q'[--- hola ---]'||tipo as halliwey
    from brujos;
    
    
    commit; --guarda las transacciones y elimina los savepoint's 
    
    savepoint A;
    
    insert into brujos (id_hechizo) values (9999);
    
    savepoint B;
    
        insert into brujos (id_hechizo) values (2222);
    
    rollback to B;
    
    rollback to A;

    rollback;
----------------------------------------------

    select * 
    from clientes
    where nombrecliente like 'J%'
    fetch first 2 rows only ; 
    
    select * 
    from clientes
    where nombrecliente like 'J%'
    offset 1 rows fetch first 2 rows only ; 
    
    
    -- con & se crea una variable que pide el sistema a través de un pop-up.
    select * 
    from productos
    where cantidadenstock > &cantidadenstock;
    
    alter table brujos add &columna number;
    
    select &columna
    from &tabla
    where &condicion;
    
    select &&columna   --solo pide una vez el valor de la variable 
    from productos
    order by &columna;
    
    --crea una select en la que el usuario determine los campos que muestran
    -- y el campo por el cual será ordenada la select
    
    select &&campo
    from clientes
    order by &campo;
    --------------------------
    define campo = &nombre_del_campo;
    
    select &campo
    from clientes
    order by &campo;
    
    undefine campo;
  -----------------------------  
   
    select nombrecliente
    from clientes
    where pais like '&nombre_pais';
    
    set verify on; --muestra el texto de la select con la variable y luego
                -- la misma select con el valor introducido en la variable
  ------------------------------------
  
  select *     
  from clientes
  natural join pagos;     --une por el campo que se coincida por el nombre 
                         -- en las dos tablas
  --------------------------------------
  
  select * 
  from clientes join pagos
  using (codigocliente);  --une por el campo especificado
  ---------------------------
  select *
  from clientes inner join pagos   --se puede omitir la palabra inner y poner solo join 
  on clientes.codigocliente = pagos.codigocliente; -- une por los campos especificados
        --- nos sirve cuando los campos no se llaman igual.
        
    -----------------------------
    
    select *     --muestra todos los clientes tengan pagos o no, y los pagos que coincidan por codigocliente
    from clientes left outer join pagos
    on clientes.codigocliente = pagos.codigocliente;
  ------------------------------------
   select *     --muestra todos los pagos tengan clientes o no, y los clientes que coincidan por codigocliente
    from clientes right outer join pagos
    on clientes.codigocliente = pagos.codigocliente;
  
  ---------------------------------
  
    select *     --muestra todo de las dos tablas.
    from clientes full outer join pagos
    on clientes.codigocliente = pagos.codigocliente;
    
    -----------------------------------------------
    select cantidad,limitecredito
    from clientes
    cross join pagos;
    --producto cartesiano de las dos tablas, muestra todos lo registros de una tabla
    -- por cada de uno de la otra
    
    
---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- S  E  L  E  C  T ------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
    --muestra todos los empleados y la ciudad de sus oficinas , tengan o no oficina

        select empleados.* , ciudad
        from empleados right join oficinas 
        on empleados.codigooficina = oficinas.codigooficina
        order by ciudad;

    --muestra los productos cuyo precio de venta este en el rango que decida el usuario
        select *
        from productos
        where precioventa between &min and &max;
        
    -- muestra los empleados que trabajen en la empresa que decida el usuario
            select nombre, apellido1, apellido2, email from empleados where email like '%@&empresa%';
    
    
    -- muestra cuantos pedidos hay pendientes, entregado o rechazo entre las fechas que decida el usuario
            select estado, count(codigopedido) from pedidos where fechapedido between '&Fecha1' and '&Fecha2'
            group by estado;

-----------------------------------------------
select * from soluciones;

insert into soluciones (id_respuesta,nombre_respuesta) values (1,'pregunta 1');
insert into soluciones (id_respuesta,nombre_respuesta) values (2,'pregunta 2');
insert into soluciones (id_respuesta,nombre_respuesta) values (3,'pregunta 3');

savepoint introducir;

update soluciones set nombre_respuesta = 'Answer two' where id_respuesta = 2;

savepoint actualizar;

insert into soluciones (id_respuesta,nombre_respuesta) values (4,'pregunta 4');

rollback to savepoint actualizar; --vuelve al momento antes de insertar la pregunta 4

rollback; -- vuelve al principio,en realidad al anterior commit

commit;

create global temporary table empleado_ciudad_ofinina as
select empleados.codigoempleado, oficinas.ciudad
from empleados,oficinas
where empleados.codigooficina = oficinas.codigooficina

drop table empleado_ciudad_oficina

select * from empleado_ciudad_ofinina;

insert into empleado_ciudad_ofinina (codigoempleado,ciudad) values
(1,'ZGZ');

-------------------------------------------------  C  A  S  C  A  D  E  --------------------------
select * from clientes;
select * from pagos;

delete from clientes where codigocliente like 1;

ALTER TABLE pagos ADD constraint PAGOS_CLIENTEFK FOREIGN KEY (CODIGOCLIENTE) 
                    REFERENCES CLIENTES (CODIGOCLIENTE) ON DELETE CASCADE;

alter table pagos drop constraint PAGOS_CLIENTEFK;

---------------------------------------------------------------------------
-- Select que busque un porcentaje, se puede poner cualquier simbolo
select * from oficinas where ciudad like '%\%%' escape '\';
----------------------------------------------------------------------------



  
