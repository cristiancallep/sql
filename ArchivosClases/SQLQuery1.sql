create database Practica1

use Practica1

create table Tbl_persona(
	id int primary key,
	nombre varchar(20) not null,
	email varchar(40)
	--constraint PK_id primary key Tbl_persona
)

create table Tbl_libros(
	codLibro int primary key,
	nombreLibro varchar(20) not null,
	fechaPublic date not null,
	codPersona int not null
	constraint FK_codPersona foreign key (codPersona) references Tbl_persona (id)
	
)

insert into Tbl_persona (id, nombre, email) values (1, 'cristian', 'calle@gmail.com'), (2, 'stiven', 'perez@gmail.com')

insert into Tbl_libros (codLibro, nombreLibro, fechaPublic, codPersona) values (11,'ciencia', '08-21-2025', 1),(22,'calculo', '08-22-2025', 2)