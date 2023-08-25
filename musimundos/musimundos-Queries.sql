-- Ejercicios PLAYGROUND:
-- Identificar la cantidad de clientes que son de Brazil.
SELECT 
    pais, COUNT(*)
FROM
    `musimundos`.`clientes`
GROUP BY pais
HAVING pais = 'Brazil';
-- consulta a la base de datos que traiga el id del género y la cantidad de canciones que posee. 
-- Seleccioná el número que te dio como resultado de la cantidad de canciones del género con id = 6.
SELECT 
    id_genero, COUNT(*)
FROM
    `musimundos`.`canciones`
GROUP BY id_genero
HAVING id_genero = 6;
-- cuánto dinero llevan gastados los clientes en nuestra empresa.
SELECT 
    SUM(total)
FROM
    `musimundos`.`facturas`;
-- Obtener una lista de todos los álbumes y su duración (milisegundos) promedio.
SELECT 
    id_album, AVG(milisegundos)
FROM
    `musimundos`.`canciones`
GROUP BY id_album;
-- Hace una consulta a la base de datos para saber cuál es el archivo con menor peso en bytes.
SELECT 
    MIN(bytes)
FROM
    `musimundos`.`canciones`;
-- Hacé una consulta a la base de datos que nos traiga por id_cliente la suma total de sus facturas. 
-- Filtra aquellos que la suma del total sea > 45. ¿Cuál es la suma total del cliente con id = 6?
SELECT 
    id_cliente, SUM(total)
FROM
    `musimundos`.`facturas`
GROUP BY id_cliente
HAVING SUM(total) > 45;
-- Traer los albumnes de los artistas dcon id de 7 a 10.
SELECT 
    *
FROM
    musimundos.albumes
WHERE
    id_artista BETWEEN 7 AND 10;
-- Traer los albumnes que tengan en su titulo la palabra "live".
SELECT 
    *
FROM
    musimundos.albumes
WHERE
    titulo LIKE '%live%';
-- Traer los albumnes donde la segunda leta del titulo sea una "l".
SELECT 
    *
FROM
    musimundos.albumes
WHERE
    titulo LIKE '_l%';

-- ---------------------------------------------------------------------
-- Ejercicios PLAYGROUND Table Reference
-- ---------------------------------------------------------------------
-- una consulta en la base de datos donde muestre todos los registros 
-- que contengan canciones con sus géneros, Y que el compositor sea 
-- Willie Dixon, Y que tengan el género Blues.
SELECT 
    `canciones`.`compositor`,
    `canciones`.`nombre`,
    `generos`.`nombre`
FROM
    `musimundos`.`canciones`,
    `musimundos`.`generos`
WHERE
    id_genero = generos.id
        AND compositor LIKE 'Willie%'
        AND generos.nombre = 'Blues';






