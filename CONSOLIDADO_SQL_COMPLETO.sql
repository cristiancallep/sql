-- ====================================================================
-- CONSOLIDADO COMPLETO DE SQL - GUÍA DE REFERENCIA
-- ====================================================================
-- Este archivo contiene todos los conceptos y ejemplos de SQL
-- organizados por temas para fácil consulta y referencia
-- ====================================================================

-- ====================================================================
-- 1. CREACIÓN DE BASES DE DATOS Y TABLAS
-- ====================================================================

-- Crear una base de datos nueva
CREATE DATABASE Practica1;
GO

-- Usar una base de datos existente
USE Practica1;
GO

-- Crear tabla con restricciones básicas
CREATE TABLE Tbl_persona(
    id INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    email VARCHAR(40)
);

-- Crear tabla con clave foránea
CREATE TABLE Tbl_libros(
    codLibro INT PRIMARY KEY,
    nombreLibro VARCHAR(20) NOT NULL,
    fechaPublic DATE NOT NULL,
    codPersona INT NOT NULL
    CONSTRAINT FK_codPersona FOREIGN KEY (codPersona) REFERENCES Tbl_persona (id)
);

-- Crear tabla con IDENTITY (autoincremento)
CREATE TABLE empleado(
    cod INT PRIMARY KEY IDENTITY(1,10),  -- Inicia en 1, incrementa de 10 en 10
    cedula INT NOT NULL,
    nombres VARCHAR(25) NOT NULL,
    tel VARCHAR(12),
    fecha_nac DATE,
    area SMALLINT,
    salario DECIMAL(7,2)
);

-- Crear tabla con CHECK constraint
CREATE TABLE estudiante(
    cod INT IDENTITY(100,1),
    nombre VARCHAR(25),
    apellido VARCHAR(35),
    genero VARCHAR(1) CHECK (genero IN ('M', 'F')),  -- Solo permite M o F
    telefono VARCHAR(7)
);

-- Crear tabla con columna calculada y valor por defecto
CREATE TABLE libros(
    cod_libro VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(25),
    valorcompra DECIMAL(8,2),
    valortotal AS valorcompra + (valorcompra*0.15),  -- Columna calculada
    Fecha_ingreso DATETIME DEFAULT GETDATE()         -- Valor por defecto
);

-- ====================================================================
-- 2. MODIFICACIÓN DE ESTRUCTURA DE TABLAS (ALTER TABLE)
-- ====================================================================

-- Agregar columna
ALTER TABLE TbProducts 
ADD DateIN DATE NULL;

-- Eliminar columna
ALTER TABLE TbProducts 
DROP COLUMN DateIN;

-- Cambiar tipo de dato de una columna
ALTER TABLE TbProducts 
ALTER COLUMN ProductName VARCHAR(15);

-- Agregar clave primaria
ALTER TABLE TbProducts 
ADD PRIMARY KEY (ProductID);

-- Eliminar clave primaria
ALTER TABLE TbProducts 
DROP CONSTRAINT PK__TbProductID;

-- ====================================================================
-- 3. INSERCIÓN DE DATOS (INSERT)
-- ====================================================================

-- Insertar un solo registro especificando columnas
INSERT INTO Tbl_persona (id, nombre, email) 
VALUES (1, 'cristian', 'calle@gmail.com');

-- Insertar múltiples registros
INSERT INTO Tbl_persona (id, nombre, email) 
VALUES (1, 'cristian', 'calle@gmail.com'), 
       (2, 'stiven', 'perez@gmail.com');

-- Insertar sin especificar columnas (en orden de creación)
INSERT INTO TbProducts 
VALUES (2, 'jabon palmolive', 145.12, 'javon de avena');

-- Insertar múltiples registros sin especificar columnas
INSERT INTO TbProducts 
VALUES (5,'controles', 75489.15, 'samsung'), 
       (6, 'pantallas', 8558.15, 'sony');

-- ====================================================================
-- 4. CONSULTAS BÁSICAS (SELECT)
-- ====================================================================

-- Seleccionar todos los campos
SELECT * FROM Customers;

-- Seleccionar campos específicos
SELECT CompanyName, ContactName, ContactTitle, Country
FROM Customers;

-- Consulta con condición WHERE
SELECT CompanyName, ContactName, ContactTitle, Country
FROM Customers
WHERE Country = 'Mexico';

-- Múltiples condiciones con OR
SELECT CompanyName, ContactName, ContactTitle, Country
FROM Customers
WHERE Country = 'Mexico' OR Country = 'USA' OR Country = 'Brazil';

-- Usar IN para múltiples valores (equivale a múltiples OR)
SELECT CompanyName, ContactName, ContactTitle, Country
FROM Customers
WHERE Country IN ('Mexico','USA','Brazil');

-- Usar DISTINCT para eliminar duplicados
SELECT DISTINCT Country
FROM Customers;

-- ====================================================================
-- 5. OPERADORES DE COMPARACIÓN Y LÓGICOS
-- ====================================================================

-- Operadores de comparación
SELECT * FROM empleado
WHERE salario > 52000 AND salario < 75000;

-- BETWEEN para rangos
SELECT OrderID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1996-01-01' AND '1996-12-31';

-- NOT BETWEEN
SELECT nombres, salario, area
FROM empleado
WHERE area NOT BETWEEN 2 AND 5;

-- ====================================================================
-- 6. OPERADOR LIKE PARA BÚSQUEDAS DE TEXTO
-- ====================================================================

-- Buscar texto que contenga una cadena específica
SELECT * FROM empleado
WHERE nombres LIKE '%lo%';  -- Contiene 'lo'

-- Buscar texto que comience con una letra
SELECT * FROM empleado
WHERE nombres LIKE 'j%';    -- Comienza con 'j'

-- Buscar texto que NO comience con una letra
SELECT * FROM empleado
WHERE nombres NOT LIKE 'p%'; -- No comienza con 'p'

-- Buscar con rango de letras
SELECT cedula, nombres, area 
FROM empleado
WHERE nombres LIKE '[P-S]%'; -- Comienza con letra entre P y S

-- Buscar excluyendo letras específicas
SELECT cedula, nombres, area 
FROM empleado
WHERE nombres LIKE '[^PN]%'; -- NO comienza con P ni N

-- ====================================================================
-- 7. FUNCIONES DE AGREGADO
-- ====================================================================

-- SUM: Suma total
SELECT SUM(salario) AS [Total Salarios] FROM empleado;

-- SUM agrupada
SELECT area, SUM(salario) AS [total area]
FROM empleado
GROUP BY area;

-- AVG: Promedio
SELECT area, AVG(salario) AS prom 
FROM empleado
GROUP BY area;

-- COUNT: Contar registros
SELECT Country, COUNT(Country) AS Cantidad
FROM Customers
GROUP BY Country;

-- MAX: Valor máximo
SELECT area, MAX(salario) AS maxi
FROM empleado
GROUP BY area;

-- MIN: Valor mínimo
SELECT area, MIN(salario) AS mini
FROM empleado
GROUP BY area;

-- ====================================================================
-- 8. GROUP BY Y HAVING
-- ====================================================================

-- GROUP BY básico
SELECT Country, COUNT(Country) AS Cantidad
FROM Customers
GROUP BY Country;

-- HAVING para filtrar grupos (se usa después de GROUP BY)
SELECT Country, COUNT(Country) AS Cantidad
FROM Customers
GROUP BY Country
HAVING COUNT(Country) >= 5;  -- Solo países con 5 o más clientes

-- Ejemplo con múltiples condiciones
SELECT area, AVG(salario) AS average 
FROM empleado
GROUP BY area
HAVING AVG(salario) > 60000;

-- ====================================================================
-- 9. ORDER BY PARA ORDENAMIENTO
-- ====================================================================

-- Ordenar ascendente (por defecto)
SELECT area, nombres, salario 
FROM empleado
ORDER BY nombres ASC;

-- Ordenar descendente
SELECT area, nombres, salario 
FROM empleado
ORDER BY nombres DESC;

-- Ordenar con HAVING y GROUP BY
SELECT Country, COUNT(Country) AS Cantidad
FROM Customers
GROUP BY Country
HAVING COUNT(Country) >= 5
ORDER BY COUNT(Country) ASC;

-- ====================================================================
-- 10. JOINS (UNIONES DE TABLAS)
-- ====================================================================

-- INNER JOIN: Solo registros que coinciden en ambas tablas
SELECT c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- LEFT JOIN: Todos los registros de la tabla izquierda
SELECT c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- RIGHT JOIN: Todos los registros de la tabla derecha
SELECT c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
FROM Orders o
RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID;

-- FULL OUTER JOIN: Todos los registros de ambas tablas
SELECT c.CustomerID, c.CompanyName, o.OrderDate, o.OrderID
FROM Orders o
FULL OUTER JOIN Customers c ON c.CustomerID = o.CustomerID;

-- SELF JOIN: Tabla unida consigo misma
SELECT e.LastName, e.FirstName, e.ReportsTo, j.LastName, j.FirstName, j.Title
FROM Employees e
JOIN Employees j ON j.EmployeeID = e.ReportsTo;

-- JOIN con condiciones adicionales
SELECT p.ProductID, p.ProductName, p.UnitPrice, s.CompanyName, s.City
FROM Products AS p
JOIN Suppliers AS s ON p.CategoryID = s.SupplierID
WHERE p.UnitPrice > 20 AND p.Discontinued = 0;

-- ====================================================================
-- 11. SUBCONSULTAS
-- ====================================================================

-- Subconsulta simple en WHERE
SELECT OrderID, ProductID, UnitPrice
FROM [Order Details]
WHERE UnitPrice != (SELECT AVG(UnitPrice) FROM [Order Details]);

-- Subconsulta con IN
SELECT CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE OrderID IN (
        SELECT OrderID
        FROM [Order Details]
        WHERE Quantity > 20 AND ProductID = 23
    )
);

-- Subconsulta con ANY
SELECT OrderID
FROM [Order Details]
WHERE OrderID = ANY (
    SELECT OrderID 
    FROM [Order Details]
    WHERE UnitPrice >= 15
    GROUP BY OrderID
    HAVING COUNT(OrderID) > 3
);

-- Subconsulta con ALL
SELECT OrderID
FROM [Order Details]
WHERE OrderID = ALL (
    SELECT OrderID 
    FROM [Order Details]
    WHERE UnitPrice >= 15
    GROUP BY OrderID
    HAVING COUNT(OrderID) > 3
);

-- Subconsulta con EXISTS
SELECT ProductName, UnitPrice, ReorderLevel
FROM Products 
WHERE EXISTS (
    SELECT SupplierID 
    FROM Products 
    WHERE CategoryID > 5
);

-- Subconsulta en SELECT
SELECT ProductID, UnitPrice, 
       (SELECT MIN(UnitPrice) FROM Products WHERE Discontinued <> 0) AS MenorPrecio 
FROM Products;

-- ====================================================================
-- 12. OPERADORES DE CONJUNTOS
-- ====================================================================

-- UNION: Combina resultados eliminando duplicados
SELECT RegionID, RegionDescription
FROM Region 
UNION
SELECT RegionID, TerritoryDescription
FROM Territories;

-- UNION ALL: Combina resultados manteniendo duplicados
SELECT RegionID, RegionDescription
FROM Region 
UNION ALL
SELECT RegionID, TerritoryDescription
FROM Territories;

-- EXCEPT: Registros del primer conjunto que NO están en el segundo
SELECT SupplierID FROM Products
EXCEPT 
SELECT SupplierID FROM Suppliers WHERE City LIKE '%L%';

-- INTERSECT: Solo registros que están en AMBOS conjuntos
SELECT SupplierID FROM Products
INTERSECT 
SELECT SupplierID FROM Suppliers WHERE City LIKE '%L%';

-- ====================================================================
-- 13. VISTAS (VIEWS)
-- ====================================================================

-- Crear una vista simple
CREATE VIEW vw_orders
AS
SELECT * FROM Orders;

-- Consultar una vista
SELECT * FROM vw_orders;

-- Actualizar datos a través de una vista
UPDATE vw_orders
SET ShipVia = 2
WHERE EmployeeID = 5;

-- Verificar cambios en la vista
SELECT OrderID, EmployeeID, ShipVia
FROM vw_orders
WHERE EmployeeID = 5;

-- ====================================================================
-- 14. INTEGRIDAD REFERENCIAL Y CLAVES FORÁNEAS
-- ====================================================================

-- Crear tabla con clave foránea simple
CREATE TABLE Album (
    idAlbum INT IDENTITY(10, 10) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    idArtista INT,
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista)
);

-- Crear tabla con acciones de integridad referencial
CREATE TABLE Album_Avanzado (
    idAlbum INT IDENTITY(10, 10) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    idArtista INT,
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista) 
        ON DELETE SET NULL    -- Si se elimina el artista, pone NULL
        ON UPDATE CASCADE     -- Si se actualiza el artista, actualiza aquí también
);

-- Crear tabla con DELETE CASCADE
CREATE TABLE Cancion (
    idCancion INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    idAlbum INT,
    FOREIGN KEY (idAlbum) REFERENCES Album(idAlbum) 
        ON DELETE CASCADE     -- Si se elimina el álbum, elimina las canciones
        ON UPDATE CASCADE
);

-- ====================================================================
-- 15. MODIFICACIÓN DE DATOS
-- ====================================================================

-- UPDATE: Actualizar registros
UPDATE TbProducts
SET ProductID = 7 
WHERE ProductID = 6;

UPDATE TbProducts
SET ProductName = 'nevera' 
WHERE ProductName = 'controles';

-- DELETE: Eliminar registros
DELETE FROM TbProducts
WHERE ProductName = 'jabon palmolive';

-- ====================================================================
-- 16. FUNCIONES DE CADENA
-- ====================================================================

-- LOWER y UPPER: Convertir a minúsculas y mayúsculas
SELECT nombres, LOWER(nombres) AS minuscula, UPPER(nombres) AS mayuscula
FROM empleado;

-- SUBSTRING: Extraer parte de una cadena
SELECT cedula, 
       UPPER(SUBSTRING(nombres,1,1)) + LOWER(SUBSTRING(nombres,2,6)) AS nombre
FROM empleado;

-- ====================================================================
-- 17. ELIMINACIÓN DE OBJETOS
-- ====================================================================

-- Eliminar tabla
DROP TABLE TbProducts;

-- Eliminar base de datos (requiere que no esté en uso)
-- ALTER DATABASE sesion_2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE; 
-- DROP DATABASE sesion_2;

-- ====================================================================
-- 18. EJEMPLOS PRÁCTICOS COMBINADOS
-- ====================================================================

-- Consulta compleja con JOIN, WHERE, GROUP BY, HAVING y ORDER BY
SELECT c.Country, COUNT(o.OrderID) AS TotalOrdenes, AVG(od.UnitPrice) AS PrecioPromedio
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY c.Country
HAVING COUNT(o.OrderID) > 5
ORDER BY TotalOrdenes DESC;

-- Consulta con subconsulta correlacionada
SELECT p.ProductName, p.UnitPrice,
       (SELECT AVG(UnitPrice) 
        FROM Products p2 
        WHERE p2.CategoryID = p.CategoryID) AS PromedioCategoria
FROM Products p
WHERE p.UnitPrice > (
    SELECT AVG(UnitPrice) 
    FROM Products p3 
    WHERE p3.CategoryID = p.CategoryID
);

-- ====================================================================
-- FIN DEL CONSOLIDADO SQL
-- ====================================================================
-- Recuerda: Este archivo contiene todos los conceptos principales de SQL
-- Úsalo como referencia rápida para recordar sintaxis y ejemplos
-- ====================================================================