							/**************************/
							/* Integridad Referencial */
							/**************************/
/*
La integridad referencial en SQL es un concepto fundamental en el diseño de bases de datos relacionales 
que asegura que las relaciones entre tablas se mantengan consistentes. 
Esto se logra mediante el uso de claves foráneas (foreign keys) y restricciones que garantizan que los datos
en una tabla estén relacionados correctamente con los datos en otra tabla.

Conceptos Clave
Clave Foránea (Foreign Key): Es un campo (o conjunto de campos) en una tabla que se refiere a la clave primaria de otra tabla. 
La clave foránea establece una relación entre las dos tablas.

Restricciones de Integridad Referencial: Estas restricciones aseguran que los valores de la clave foránea en una tabla 
coincidan con los valores de la clave primaria en la tabla referenciada. Esto evita la existencia de referencias inválidas.

***** Operaciones de Integridad Referencial *******

1. INSERT: No puedes insertar un valor en la clave foránea que no exista en la clave primaria de la tabla referenciada.


2. UPDATE: No puedes actualizar un valor de la clave primaria en la tabla referenciada si hay registros en la tabla 
que dependen de ese valor, a menos que se maneje adecuadamente con acciones como CASCADE.


3. DELETE: No puedes eliminar un registro de la tabla referenciada si hay registros en la tabla que dependen de ese valor, a menos que se maneje adecuadamente con acciones como CASCADE.

DELETE FROM Clientes WHERE idCliente = 1;


*/

Create database Musica
use Musica

-- Crear tabla Artista
CREATE TABLE Artista (
    idArtista INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Album con idAlbum que incrementa de 10 en 10
CREATE TABLE Album (
    idAlbum INT IDENTITY(10, 10) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    idArtista INT,
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista)
);

-- Crear tabla Cancion
CREATE TABLE Cancion (
    idCancion INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    idAlbum INT,
    FOREIGN KEY (idAlbum) REFERENCES Album(idAlbum)
);

-- Crear tabla Genero con idGenero que incrementa de 1 en 1
CREATE TABLE Genero (
    idGenero INT IDENTITY(1, 1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla intermedia AlbumGenero para la relación n:m
CREATE TABLE AlbumGenero (
    idAlbum INT,
    idGenero INT,
    PRIMARY KEY (idAlbum, idGenero),
    FOREIGN KEY (idAlbum) REFERENCES Album(idAlbum),
    FOREIGN KEY (idGenero) REFERENCES Genero(idGenero)
);

-- Insertar datos en la tabla Artista
INSERT INTO Artista (idArtista, nombre) VALUES (1, 'Artista 1');
INSERT INTO Artista (idArtista, nombre) VALUES (2, 'Artista 2');

-- Insertar datos en la tabla Album
INSERT INTO Album (titulo, idArtista) VALUES ('Album 1', 1),('Album 2', 2);

-- Insertar datos en la tabla Cancion
INSERT INTO Cancion (idCancion, titulo, duracion, idAlbum) VALUES (1, 'Cancion 1', '00:03:30', 10),
(2, 'Cancion 2', '00:04:00', 10),(3, 'Cancion 3', '00:02:45', 20);

-- Insertar datos en la tabla Genero
INSERT INTO Genero (nombre) VALUES ('Rock'),('Pop');

-- Insertar datos en la tabla intermedia AlbumGenero
INSERT INTO AlbumGenero (idAlbum, idGenero) VALUES (10, 1),(10, 2),(20, 1); 

--EJERICIO CLASE
SELECT * FROM Album
SELECT * FROM Artista

UPDATE Album SET idAlbum=1 WHERE idAlbum=20; -- NO DEJA POR SER IDENTITY
UPDATE Album SET titulo='Pies descalzos' WHERE titulo='Album 1';

UPDATE Artista SET idArtista=15 WHERE idArtista=1; -- NO DEJA PORQUE AFECTA A LA FK DE LA OTRA TABLA (ALBUM)

DELETE FROM Artista WHERE idArtista=1;

INSERT INTO Artista (idArtista, nombre) VALUES (7, 'Artista 3');
DELETE FROM Artista WHERE idArtista=7;

-----------------------------------------------------

Drop Table Artista
Drop Table Album
Drop Table Cancion
Drop Table Genero
Drop Table AlbumGenero

/* Consultar y Aplicar en las tablas 

******* Acciones de Integridad Referencial ********

Puedes definir acciones específicas para manejar las actualizaciones y eliminaciones en la tabla referenciada:

CASCADE: Propaga la operación a las filas relacionadas.
SET NULL: Establece la clave foránea a NULL si la fila referenciada se elimina o actualiza.
RESTRICT: Impide la operación si hay filas relacionadas.
NO ACTION: Similar a RESTRICT, pero se verifica al final de la transacción.

*/

-- Crear tabla Artista
CREATE TABLE Artista 
(
    idArtista INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Album con idAlbum que incrementa de 10 en 10
CREATE TABLE Album (
    idAlbum INT IDENTITY(10, 10) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    idArtista INT,
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Crear tabla Cancion
CREATE TABLE Cancion (
    idCancion INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracion TIME,
    idAlbum INT,
    FOREIGN KEY (idAlbum) REFERENCES Album(idAlbum) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear tabla Genero con idGenero que incrementa de 1 en 1
CREATE TABLE Genero (
    idGenero INT IDENTITY(1, 1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla intermedia AlbumGenero para la relación n:m
CREATE TABLE AlbumGenero (
    idAlbum INT,
    idGenero INT,
    PRIMARY KEY (idAlbum, idGenero),
    FOREIGN KEY (idAlbum) REFERENCES Album(idAlbum) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idGenero) REFERENCES Genero(idGenero) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insertar datos en la tabla Artista
INSERT INTO Artista (idArtista, nombre) VALUES (1, 'Artista 1');
INSERT INTO Artista (idArtista, nombre) VALUES (2, 'Artista 2');

-- Insertar datos en la tabla Album
INSERT INTO Album (titulo, idArtista) VALUES ('Album 1', 1),('Album 2', 2);

-- Insertar datos en la tabla Cancion
INSERT INTO Cancion (idCancion, titulo, duracion, idAlbum) VALUES (1, 'Cancion 1', '00:03:30', 10),
(2, 'Cancion 2', '00:04:00', 10),(3, 'Cancion 3', '00:02:45', 20);

-- Insertar datos en la tabla Genero
INSERT INTO Genero (nombre) VALUES ('Rock'),('Pop');

-- Insertar datos en la tabla intermedia AlbumGenero
INSERT INTO AlbumGenero (idAlbum, idGenero) VALUES (10, 1),(10, 2),(20, 1); 

/*
 1- ON DELETE SET NULL: Si se elimina un registro en la tabla Artista, el valor de idArtista en la tabla Album se establecerá en 
    NULL.
 2- ON UPDATE CASCADE: Si se actualiza el valor de la clave primaria en la tabla referenciada, el cambio se propagará a las tablas 
    que contienen la clave foránea.
 3- ON DELETE CASCADE: Si se elimina un registro en la tabla referenciada, todos los registros relacionados en la tabla que 
    contiene la clave foránea también se eliminarán.
*/
--*****Ejemplo de ON UPDATE CASCADE*****

-- Veamos como está compuesta la tabla Artista y Album

   select * from Artista
   select * from Album
   select * from AlbumGenero
   select * from Cancion
   select * from Genero

-- Vamos a actualizar el idArtista en la tabla Artista y ver cómo se propaga el cambio a la tabla Album:

-- Actualizar idArtista en la tabla Artista
   
   UPDATE Artista SET idArtista = 3 WHERE idArtista = 1;

/*Resultados Esperado*/
/*ON UPDATE CASCADE: Al actualizar idArtista de 1 a 3, el cambio se propagará a la tabla Album, actualizando idArtista 
en los registros correspondientes.*/

   select * from Artista

-- Verificar los cambios en la tabla Album

  SELECT * FROM Album;

--*****Ejemplo de ON DELETE CASCADE****
-- Veamos el contenido de la tabla Album, Canciones y AlbumGenero
select * from Album
select * from Cancion
select * from AlbumGenero
/*Vamos a eliminar un idAlbum en la tabla Album y ver cómo se eliminan las canciones relacionadas 
en la tabla Cancion y las relaciones en la tabla AlbumGenero:*/

-- Eliminar un álbum en la tabla Album

DELETE FROM Album WHERE idAlbum = 10;

-- Verificar los cambios en la tabla Cancion
SELECT * FROM Cancion;

-- Verificar los cambios en la tabla AlbumGenero
SELECT * FROM AlbumGenero;

/*Resultados Esperado*/
/*ON DELETE CASCADE: Al eliminar el álbum con idAlbum 10, se eliminarán las canciones relacionadas en la tabla Cancion y las relaciones 
en la tabla AlbumGenero.*/

 /*Ejemplo de ON DELETE SET NULL
Vamos a eliminar un idArtista en la tabla Artista y ver cómo se establece en NULL el idArtista en la tabla Album: */

-- Eliminar un artista en la tabla Artista
  DELETE FROM Artista WHERE idArtista = 2;

-- Verificar los cambios en la tabla Album
  SELECT * FROM Album;

 /*Resultados Esperado
ON DELETE SET NULL: Al eliminar el artista con idArtista 2, el idArtista en la tabla Album se establecerá en NULL para los registros 
correspondientes.*/