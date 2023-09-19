-- ---------------------------------------------------------------------------------------------
-- Stored procedures
-- ---------------------------------------------------------------------------------------------
-- SP: Clientes por País y Ciudad
-- Tabla: Clientes
-- 1. Crear un stored procedure que solicite como parámetros de entrada el nombre de un país y
-- una ciudad, y que devuelva como resultado la información de contacto de todos los clientes 
-- de ese país y ciudad.
-- En el caso que el parámetro de ciudad esté vacío, se debe devolver todos los clientes del 
-- país indicado.
DELIMITER $$
CREATE PROCEDURE getContactByLocation(IN country VARCHAR(20), IN city VARCHAR(20))
BEGIN
IF city IS NULL THEN 
      SELECT * 
      FROM clientes
      WHERE pais = country;
   ELSE 
      SELECT * 
      FROM clientes
      WHERE pais = country AND ciudad = city;
   END IF;
END $$
-- 2. Invocar el procedimiento para obtener la información de los clientes de Brasilia en Brazil.
CALL getContactByLocation('Brazil','Brasilia');
-- 3. Invocar el procedimiento para obtener la información de todos los clientes de Brazil.
CALL getContactByLocation('Brazil', NULL);

-- SP: Géneros musicales
-- Tabla: Generos
-- 1. Crear un stored procedure que reciba como parámetro un nombre de género musical y lo 
-- inserte en la tabla de géneros.
-- Además, el stored procedure debe devolver el id de género que se insertó.
-- TIP! Para calcular el nuevo id incluir la siguiente línea dentro del bloque de
-- código del SP: SET nuevoid = (SELECT MAX(id) FROM generos) + 1;
DELIMITER $$
CREATE PROCEDURE setGender(IN newGender VARCHAR(20), OUT newId INT)
BEGIN
SET newId = (SELECT MAX(id) FROM generos) + 1;
INSERT INTO `musimundos`.`generos`
(`id`,
`nombre`)
VALUES
(newId ,
newGender);
END $$
-- 2. Invocar el stored procedure creado para insertar el género Funk. ¿Qué id
-- devolvió el SP ? Consultar la tabla de géneros para ver los cambios.
CALL setGender("Funk", @id);
SELECT @id;

-- 3. Repetir el paso anterior insertando esta vez el género Tango.
CALL setGender("Tango", @id2);
SELECT @id2;

SELECT * FROM generos;