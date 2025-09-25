create database sesion3

use sesion3


create table empleado(
cod int primary key identity(1,10),
cedula int not null,
nombres varchar (25) not null,
tel varchar(12),
fecha_nac date,
area smallint,
salario decimal (7,2))



insert empleado (cedula, nombres, tel, fecha_nac, area, salario)
values (1046523,'Juan Dominguez','7854628','02-07-1975',1,52486.45), 
(4325418,'Pedro Mendoza','7882111','12-24-1975',1,52486.45),
(3475178,'Carlos Medrano','4420063','07-10-1983',2,74589),
(8654222,'Sofia Mej?a','5107862','09-12-1986',4,65246.45),
(9245721,'Diego Soto','4168796','02-07-1975',2,52486.45),
(2478923,'Jorge Sanchez','5069875','12-30-1980',4,65426.45),
(4768951,'Catalina Rodriguez ','7823489','02-09-1975',2,74589),
(7546200,'Federico L?pez','5104796','02-07-1975',3,52486),
(2456325,'Natalia Hernandez','4425478','02-02-1986',2,75489),
(9985662,'Xilene Mendoza','4442563','10-19-1990',3,75489),
(1046823,'Luisa Lopera','514789','12-09-1984',3,82486);


/* consultas con el where */

Select * from empleado

select cod, cedula, nombres, area
from empleado
where area = 1

/* realizar una consulta que permita obtener todas las personas que sean mayores a 52000 y menores a 75000*/


select *
from empleado
where salario > 52000 and salario <75000


/*Group by --> https://guru99.es/group-by/ 
se utiliza junto con funciones agregadas para producir informes resumidos a partir de la base de datos.

*** las funciones de agregado***

son funciones que realizan c?lculos sobre un conjunto de valores y devuelven un solo valor. 
Estas funciones se utilizan en consultas para realizar operaciones estad?sticas, sumar datos, obtener el promedio, entre otros c?lculos. 
Las funciones de agregado operan en grupos de filas y son fundamentales para la generaci?n de informes y an?lisis de datos en bases de datos. 

Funciones b?sicas:
 sum() Suma
 avg() Promedio
 count() Contar
 max() M?ximo
 min() M?nimo

Funciones Estad?sticas
  stdev()  Desviaci?n Estandar
  stdevp()  Desviaci?n Estandar Poblacional
  var() Varianza
  varP() Varianza Poblacional

*/

/* se calcula la suma total de la columna salario agrupado por area*/

select area, sum(salario) as [total area] -- el as permite colocar un nombre propio al resultado obtenido del uso de la funci?n de agregado
  from empleado
  group by area;

-- muestra la suma total del salario de todos los empleados
select sum(salario) as [Total Salarios] from empleado

-- agrupa la suma de salario por fecha de nacimiento
select fecha_nac, sum(salario) as [total area]
  from empleado
  group by fecha_nac;

/*otras funciones para group by*/

/* se calcula el valor maximo de la columna salario para cada ?rea*/

select area, max(salario) as maxi
  from empleado
  group by area;

/* se calcula el valor m?nimo de la columna salario agrupandola por ?rea*/

select area, min(salario) as mini
  from empleado
  group by area;

  /* se calcula el promedio de la columna salario agrupada por el area*/
 select area as area, avg(salario) as prom 
  from empleado
  group by area;

  /* se calcula cuantos registros hay por area*/
select area, count(*) as cont
  from empleado
  group by area;

/* contar cuantas personas cumplen en la misma fecha */

select fecha_nac, count(fecha_nac) as cantidad
from empleado
group by fecha_nac
/*------------------------------------------------*/

/* ORDER BY -->  https://www.w3schools.com/sql/sql_orderby.asp
La ORDER BYpalabra clave se utiliza para ordenar el conjunto de resultados en orden ascendente o descendente. */

select area, nombres, salario 
  from empleado
  order by nombres desc;

/*funciones desc (Ordena de manera descendente y asc(Ordena de forma ascendente)

la clausula order by no puede emplearse para campos text, ntext e image */

/*------------------------------------------------*/
/****** Having********/
https://www.w3schools.com/SQL/sql_having.asp

select area, avg(salario) as average 
  from empleado
  where avg(salario) > 60000;
  group by area
/* este es un error, el ejemplo bueno esta abajo*/


  select area, avg(salario) as average 
  from empleado
  group by area
  having avg(salario) > 60000;

/*se pueden hacer operaciones logicas con and, or */

/*------------------------------------------------*/
/******** clausulas con Between *********/
/* http://sql.11sql.com/sql-between.htm  */ 

 select nombres, salario, area
  from empleado
  where area between 2 and 5
 /*se puede utilizar la clausula not between*/
 select nombres, salario, area
  from empleado
  where area not between 2 and 5

/*------------------------------------------------*/
/********** clausulas con IN ***********/
/* https://www.webyempresas.com/el-operador-in-en-sql/ */ 

  select area, avg(salario) as average 
  from empleado
  where area IN (2,3,6)
  group by area

/*------------------------------------------------*/
/********** clausulas con Like ************/
/* http://deletesql.com/viewtopic.php?f=5&t=16 */


 select * 
 from empleado
 where nombres like '%lo%' /* que contenga per en la cadena de carateres */


  select * 
  from empleado
  where nombres like 'j%' /* comienza por j */


  select * 
  from empleado
  where nombres  not like 'p%' /* no comienza por p */


select cedula, nombres, area 
from empleado
where nombres like '[P-S]%'; /*Buscamos los empleados cuyo nombre comienza con las letras entre la "P" y la "S"*/

select cedula, nombres, area 
from empleado
where nombres like '[^PN]%'; /*Seleccionamos los empleados cuyo nombre NO comienza con las letras "P" ni "N":*/

/*Recuperamos los campos cuyo salario se encuentra entre 1000.00 y 1009.99:*/
select cedula, nombres, area, salario 
from empleado
where salario like '5%';


select cedula, nombres, area, salario  
from empleado
where salario like '%.00';



/********** clausulas con LOWER y UPPER *********/


select nombres, LOWER(nombres) as minuscula, UPPER(nombres) as mayuscula
from empleado

select cedula, UPPER(SUBSTRING(nombres,1,1)) + LOWER(SUBSTRING(nombres,2,6)) as nombre
from empleado