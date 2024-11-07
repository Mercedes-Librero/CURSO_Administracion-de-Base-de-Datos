-- Precio tiene que ser mayor de 500
create table Almuerzos(
    id_number integer not null,
    precio float not null,
    constraint Comprobar_Precio check(precio > 500)
);

-- drop table Almuerzos;

insert into Almuerzos values (2,501);