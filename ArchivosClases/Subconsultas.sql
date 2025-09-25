--1. listar todos los clientes que han pedido más de 20 unidaes del producto  con número 23
--2. lista de productos y el pedido mayor realizado hasta la fecha de cada producto de la tabla order details.
--3. Listado de Clientes (Customers) que compraron en Julio de 1997
--4. Listado con las cantidades vendidas de los productos descontinuados. Incluir solamente los que tienen Stock 
--5.  Empleados y la cantidad de órdenes generadas y NO atendidas
--6. Mostrar todos los empleados que tengan el mismo sexo (TitleOfCourtesy) que el empleado 9 (EmployeeID).
--7. Mostrar todos los productos de las categorías bebidas  y condimentos .
--8. Mostrar los productos cuando su precio es mayor que los precios de los detalles de pedidos, cuando la cantidad del pedido es 130

use northwind

--1. listar todos los clientes que han pedido más de 20 unidaes del producto  con número 23
select * from Orders

SELECT CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE OrderID IN (
        SELECT OrderID
        FROM [Order Details]
        WHERE Quantity > 20 
          AND ProductID = 23
    )
);

-- forma con duplicados

SELECT 
    (SELECT CompanyName 
     FROM Customers
     WHERE CustomerID = (
         SELECT CustomerID 
         FROM Orders 
         WHERE OrderID = OD.OrderID
     )
    ) as CompanyName
FROM [Order Details] OD
WHERE OD.ProductID = 23 
  AND OD.Quantity > 20;

--2. lista de productos y el pedido mayor realizado hasta la fecha de cada producto de la tabla order details.

SELECT 
    (SELECT P.ProductName 
     FROM Products P 
     WHERE P.ProductID = OD.ProductID
    ) AS ProductName,
    OD.Quantity
FROM [Order Details] OD
WHERE OD.Quantity = (
    SELECT MAX(OD2.Quantity)
    FROM [Order Details] OD2
    WHERE OD2.ProductID = OD.ProductID
);

--3. Listado de Clientes (Customers) que compraron en Julio de 1997
select * from Orders

SELECT CustomerID
FROM Orders
WHERE OrderDate >= '1997-07-01'
  AND OrderDate < '1997-08-01';

-- con subconsultas

SELECT CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE OrderID IN (
        SELECT OrderID
        FROM Orders
        WHERE YEAR(OrderDate) = 1997
          AND MONTH(OrderDate) = 7
    )
);

--------------------------------------------------------------------

-- 9.LISTAR LOS EMPLEADOS DE LONDRES QUE SU HIREDATE SEA DEL AÑO 1993

select * from Employees

select EmployeeID, FirstName, HireDate
from Employees
where YEAR(HireDate) = 1993 and City like 'London'

-- 

select * from Customers

-- ELABORAR UN INFROME QUE MUESTRE LA CANTIDAD DE CLIENTES QUE HAY POR CIUDADES CUANDO EL PÁIS ES FRANCIA

SELECT City, COUNT(CustomerID) AS CantidadClientes
FROM Customers
WHERE Country = 'France'
GROUP BY City
ORDER BY CantidadClientes DESC;

--------------------------------------------
SELECT DISTINCT City,
       (SELECT COUNT(*)
        FROM Customers C2
        WHERE C2.City = C1.City
          AND C2.Country = 'France') AS CantidadClientes
FROM Customers C1
WHERE C1.Country = 'France'
ORDER BY CantidadClientes DESC;

