use northwind

select * from [Order Details]

select OrderID, sum(UnitPrice) as totalPrice  
from [Order Details]
group by OrderID

select ProductID, sum(UnitPrice) as totalPrice  
from [Order Details]
group by ProductID

select OrderID, avg(UnitPrice) as average -- promedio
  from [Order Details]
  group by OrderID

select OrderID, sum(UnitPrice) as totalPrice 
from [Order Details]
group by OrderID
having sum(UnitPrice) > 45

select * 
 from Customers
 where CompanyName like '	on%' /* que contenga per en la cadena de carateres */

 select * 
 from Customers
 where CompanyName like '%on%' /* que contenga per en la cadena de carateres */ and City like 'London'


