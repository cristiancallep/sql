create database sesion_2 /* esto es un comentario*/
use sesion_2

create table TbProducts
(
 ProductID int primary key not null, 
 ProductName varchar(25) not null,
 Price decimal(7,2) null,
 ProductDescription varchar(100) null,
 /*tambien podemos definir la primary key de la siguiente forma
 add constraint PK_ProductID primary key(productID);
 */
)

/*---------------------------------------------------*/
     /* insertar registros a la base de datos */
/*---------------------------------------------------*/

insert TbProducts
    (ProductID, ProductName, Price, ProductDescription)
values (2, 'jabon palmolive', 145.12, 'javon de avena');

insert TbProducts values 
(5,'controles', 75489.15, 'samsung'), 
(6, 'pantallas', 8558.15, 'sony');

/*---------------------------------------------------*/
     /* insertar registros a la base de datos */
/*---------------------------------------------------*/

select * from TbProducts /*mostrar todas las columnas con sus datos */

select ProductID, ProductName from TbProducts /* mostrar las columnas seleccionadas */

/*---------------------------------------------------*/
     /* Modificar las columnas */
/*---------------------------------------------------*/

alter table TbProducts /* agregar columna en tabla*/
add DateIN date null /*el tipo de dato que requiera la columna*/

alter table TbProducts /*eliminar cokumna*/
drop column DateIN

alter table TbProducts /* cambiar el tipo de daro de una columna*/
Alter column ProductName varchar(15) 

/*---------------------------------------------------*/
     /* Modificar PK en tablas */
/*---------------------------------------------------*/

alter table TbProducts /* eliminar llave primaria en una tabla*/
drop constraint PK__TbProductID /* hay que modificar el nombre de la llave primaria*/

alter table TbProducts /* agregar una llave primaria en una tabla */
add primary key (ProductID)

/*---------------------------------------------------*/
     /* Eliminar un registro */
/*---------------------------------------------------*/

delete from TbProducts
where ProductName = 'jabon palmolive' /*cuando se elimina una cadena de texto*/

/*---------------------------------------------------*/
     /* Eliminar un registro */
/*---------------------------------------------------*/

select *from TbProducts

update TbProducts
set ProductID=  7 where ProductID = 6 /*siendo 7 el nuevo codigo*/

update TbProducts
set ProductName = 'nevera' where ProductName = 'controles' /* siendo nevera el nuevo nombre*/
 
 /*---------------------------------------------------*/
     /* Eliminar una tabla */
/*---------------------------------------------------*/

Drop table TbProducts

 /*---------------------------------------------------*/
     /* Eliminar una base de datos */
/*---------------------------------------------------*/

-- alter database DBsesion_2 set single user with rollback inmediate; 
drop database sesion_2
