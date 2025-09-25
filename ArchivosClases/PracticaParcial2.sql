use northwind

-- selecciona todos los campos de customers
SELECT * 
FROM Customers
go

-- selecciona algunos campos unicamente 
select CompanyName, ContactName, ContactTitle, Country
from Customers
go

-- clientes solo de mexico
select CompanyName, ContactName, ContactTitle, Country
from Customers
where Country = 'Mexico'
go

-- clientes solo de mexico Y USA 
select CompanyName, ContactName, ContactTitle, Country
from Customers
where Country = 'Mexico' or Country = 'USA'
go

-- clientes solo de mexico Y USA Y BRAZIL
select CompanyName, ContactName, ContactTitle, Country
from Customers
where Country = 'Mexico' or Country = 'USA' or Country = 'Brazil'
go


-- clientes solo de mexico Y USA Y BRAZIL con 'in', no reconoce mayusculas o minusculas, lo busca igual
select CompanyName, ContactName, ContactTitle, Country
from Customers
where Country in ('Mexico','USA','Brazil')
go

-- mostrar paises donde tengo clientes - salen repetidos
select Country
from Customers
go

-- mostrar paises donde tengo clientes - usamos distinct para mostrar todos los paises diferentes, no se repiten
select distinct Country
from Customers
go

-- cuantos clientes existen en cada pais
select Country, count(country) as Cantidad -- 'as Cantidad' para poner nombre a la columna en la que voy a contar
from Customers
group by Country
go

-- cuantos clientes existen en cada pais, 'having' aplica el filtro sobre el agrupamiento
select Country, count(Country) as Cantidad -- 'as Cantidad' para poner nombre a la columna en la que voy a contar
from Customers
group by Country
having count(Country) >= 5 -- paises con 5 o mas clientes
go

-- cuantos clientes existen en cada pais, 'having' aplica el filtro sobre el agrupamiento
select Country, count(Country) as Cantidad -- 'as Cantidad' para poner nombre a la columna en la que voy a contar
from Customers
group by Country
having count(Country) >= 5 -- paises con 5 o mas clientes
order by count(Country) asc -- 'asc' ordena de manera ascendente, usar 'desc' para decendente
go

-- between -- se usa para dar un rango de datos
select OrderID, OrderDate
from Orders
where OrderDate between '1996-01-01 00:00:00.000' and '1996-12-31 00:00:00.000' -- and para condicionar 
go

-- operaciones con and
select ProductName, SupplierID, CategoryID
from Products
where SupplierID = 1 and CategoryID = 1

-- operaciones con or
select ProductName, SupplierID, CategoryID
from Products
where SupplierID = 1 or CategoryID = 1

-----------------------------------------------------------
/* 
Join (o Inner Join):
Devuelve solo las filas que tienen coincidencia en ambas tablas.

Left Join (o Left Outer Join):
Devuelve todas las filas de la tabla izquierda y las coincidentes de la derecha; si no hay coincidencia, muestra NULL en la derecha.

Right Join (o Right Outer Join):
Devuelve todas las filas de la tabla derecha y las coincidentes de la izquierda; si no hay coincidencia, muestra NULL en la izquierda.

Full Outer Join:
Devuelve todas las filas de ambas tablas; donde no hay coincidencia, coloca NULL.

Self Join:
Une una tabla consigo misma, útil para comparar filas dentro de la misma tabla.
*/

use Northwind
go

-- Mostrar todos los clientes
select * from Customers c  

-- Mostrar todas las órdenes
select * from Orders  


-- INNER JOIN (Join)
-- Devuelve solo los clientes que tienen pedidos registrados en Orders.
-- Es decir, muestra coincidencias entre Customers y Orders.
select c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
from Customers c
join Orders o on c.CustomerID = o.CustomerID


-- LEFT JOIN
-- Devuelve todos los clientes, aunque no tengan pedidos.
-- Si un cliente no tiene pedido, las columnas de Orders aparecen como NULL.
select c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
from Customers c
left join Orders o on c.CustomerID = o.CustomerID

-- RIGHT JOIN
-- Devuelve todas las órdenes (Orders), incluso si no tienen un cliente asociado.
-- Si una orden no tiene cliente, los campos de Customers aparecen como NULL.
select c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
from Orders o
right join Customers c on c.CustomerID = o.CustomerID


-- SELF JOIN
-- Se usa para comparar una tabla consigo misma.
-- En este caso, Employees se une con sí misma para mostrar quién reporta a quién.
-- "e" es el empleado y "j" es su jefe.
select e.LastName, e.FirstName, e.ReportsTo, j.LastName, j.FirstName, j.Title
from Employees e
join Employees j on j.EmployeeID = e.ReportsTo

-- FULL OUTER JOIN
-- Devuelve todos los clientes (Customers) y todas las órdenes (Orders).
-- Si un cliente no tiene pedidos, las columnas de Orders aparecen como NULL.
-- Si una orden no tiene cliente asociado, las columnas de Customers aparecen como NULL.
select c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
from Orders o
full outer join Customers c on c.CustomerID = o.CustomerID
