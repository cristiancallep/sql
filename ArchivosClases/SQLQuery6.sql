
/*------------------SUB CONSULTAS--------------- */
use northwind

select OrderID, ProductID, UnitPrice
from [Order Details]
where UnitPrice != (select AVG(UnitPrice) from [Order Details])

select ProductID, AVG(UnitPrice) from [Order Details] group by ProductID


/*---------------------------------------------------------- */

SELECT OrderID
FROM [Order Details]
where OrderID = any (SELECT OrderID FROM [Order Details]
						WHERE UnitPrice >= 15
						group by OrderID
						having count(orderID) > 3)

order by OrderID

SELECT OrderID
FROM [Order Details]
Where OrderID = all (SELECT OrderID FROM [Order Details]
					WHERE UnitPrice >= 15
					group by OrderID
					having count(orderID) > 3)

order by OrderID

SELECT OrderID
FROM [Order Details]
Where OrderID in (SELECT OrderID FROM [Order Details])

order by OrderID

/*---------------------------------------------------------- */

SELECT  ProductID, UnitPrice, (select min(UnitPrice)
										from Products
										where Discontinued <> 0)
										as MenorPrecio 

										from Products 

SELECT productname, unitprice, reorderlevel
FROM Products WHERE exists  (SELECT SupplierID 
								FROM Products 
								WHERE CategoryID > 5)


select a.productid, a.productname, b.price_avg
from products a,
(select supplierid, avg(unitprice) price_avg
from products
group by supplierid) b
where b.supplierid = a. supplierid and a.unitprice < b.price_avg
 



