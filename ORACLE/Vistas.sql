 set serveroutput on;  -- PARA DBMS_OUTPUT.PUT_LINE(Texto)
 alter session set "_ORACLE_SCRIPT"=true;

---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- V  I  S  T  A  S ------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
        
    --crea una vista que muestre cuantos empleados hay en cada ciudad
        create view emplados_por_ciudad AS
        select ciudad,count(codigoempleado) total 
        from empleados inner join oficinas 
        on empleados.codigooficina = oficinas.codigooficina
        group by ciudad;