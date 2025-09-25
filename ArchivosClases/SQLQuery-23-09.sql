create database clase23D09

use clase23D09

create table estudiante
(
cod int identity (100,1),

nombre varchar(25),

apellido varchar(35),

genero varchar(1) CHECK (genero in ('M', 'F')),

telefono varchar(7)

)

select * from estudiante

drop table estudiante

----------------------------------------------------------

insert into estudiante values ('Juan', 'Mendez', 'm','715655')

select * from estudiante

insert into estudiante values ('Pedro', 'Loalza', 'M','4556')
-----------------------------------------------------------

create table libros(

cod_libro varchar(5) primary key,

nombre varchar(25),

valorcompra decimal(8,2),

valortotal as valorcompra + (valorcompra*0.15),

Fecha_ingreso datetime default getdate())

-----------------------------------------------

select * from libros

INSERT INTO libros (cod_libro, nombre, valorcompra)
VALUES ('L001', 'Introducción a SQL', 50000.00);

INSERT INTO libros (cod_libro, nombre, valorcompra)
VALUES ('L002', 'Fundamentos de Java', 65000.00);

INSERT INTO libros (cod_libro, nombre, valorcompra)
VALUES ('L003', 'Electrónica Básica', 42000.00);

INSERT INTO libros (cod_libro, nombre, valorcompra)
VALUES ('L004', 'Cálculo Avanzado', 80000.00);

INSERT INTO libros (cod_libro, nombre, valorcompra)
VALUES ('L005', 'Redes de Computadores', 72000.00);

----------------------------------------------------