-- 1. Usar la base de datos Northwind
USE Northwind;
GO

-- 2. Crear la vista sobre la tabla Orders
CREATE VIEW vw_orders
AS
SELECT * 
FROM Orders;
GO

-- 3. Consultar la vista (acceso a la vista, no directamente a la tabla)
SELECT * 
FROM vw_orders;
GO

-- 4. Actualizar el ShipVia a 2 cuando el EmployeeID sea 5
-- (se puede hacer en la tabla directamente o a través de la vista)
UPDATE vw_orders
SET ShipVia = 2
WHERE EmployeeID = 5;
GO

-- 5. Verificación: consultar las filas afectadas
SELECT OrderID, EmployeeID, ShipVia
FROM vw_orders
WHERE EmployeeID = 5;
GO
