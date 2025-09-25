use northwind

--union

select * from Region
select * from Territories

select RegionID, RegionDescription
from Region 
union
select RegionID, TerritoryDescription
from Territories

select RegionID, RegionDescription
from Region 
union all
select RegionID, TerritoryDescription
from Territories

select * from Region where RegionID = 1
union
select * from Territories where RegionID = 1 

--except

select * from Products
select * from Suppliers

select SupplierID from Products
except 
select SupplierID from Suppliers where City like '%L%'

select SupplierID, CompanyName, City from Suppliers where City not like '%L%'

--intersect 

select SupplierID from Products
intersect 
select SupplierID from Suppliers where City like '%L%'

--Devuelve solo las filas que tienen coincidencias en ambas Tablas.

select * from Suppliers

select * from Products

select p.productID, p. ProductName, p.UnitPrice, s.CompanyName, s.city

from Products as p

join Suppliers as s

on p.CategoryID= s. SupplierID

--podemos complementarlas con condiciones */

select p.productID, p.ProductName, p.UnitPrice, s.companyName, s.city

from Products as p

Join Suppliers as s

on p. CategoryID = s.SupplierID

where p.UnitPrice > 20

--incluso con elementos que no hagan parte de la consulta

select p.productID, P.ProductName, p.UnitPrice, s.CompanyName, s.city

from Products as p

inner join Suppliers as s

on p.CategoryID = s. SupplierID

where p.UnitPrice > 20 and p.Discontinued = 0

--

select * from Shippers
select * from Orders

select o.orderID, o.CustomerID, o.OrderDate, o.ShipCity, s.CompanyName from orders as o
left join Shippers as s on o.Shipvia = s.ShipperID

select o.orderID, o. CustomerID, o. OrderDate, o.ShipCity, s.CompanyName
from shippers as s
left join orders as o
on o. ShipVia = s. ShipperID
order by ShipCity

-- caso en el que se evidencia la diferencia de colocar una tabla a la izquierd

select c.CustomerID, c.ContactName, o. OrderID
from Customers as c
left outer join Orders as o
on c.CustomerID = o.CustomerID;

select c.CustomerID, c.ContactName, o.OrderID
from orders as o
left outer join customers as c
on c.CustomerID = o. CustomerID;

