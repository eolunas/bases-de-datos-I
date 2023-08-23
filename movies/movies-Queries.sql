-- ----------------------------------------------------------
-- Ejercitación opcional I
-- ----------------------------------------------------------
-- SELECT
-- Mostrar todos los registros de la tabla de movies.
SELECT 
    *
FROM
    movies_db.movies;
-- Mostrar el nombre, apellido y rating de todos los actores.
SELECT 
    first_name, last_name, rating
FROM
    movies_db.actors;
-- Mostrar el título de todas las series.
SELECT 
    title
FROM
    movies_db.series;
    
-- WHERE Y ORDER BY
-- Mostrar el nombre y apellido de los actores cuyo rating sea mayor a 7,5.
SELECT 
    first_name, last_name
FROM
    movies_db.actors
WHERE
    rating > 7.5;
-- Mostrar el título de las películas, el rating y los premios de las películas con
-- un rating mayor a 7,5 y con más de dos premios.
SELECT 
    title, rating, awards
FROM
    movies_db.movies
WHERE
    rating > 7.5 AND awards > 2;
-- Mostrar el título de las películas y el rating ordenadas por rating en forma ascendente.
SELECT 
    title, rating
FROM
    movies_db.movies
ORDER BY rating DESC;

-- BETWEEN y LIKE
-- Mostrar el título y rating de todas las películas cuyo título incluya Toy Story.
SELECT 
    title, rating
FROM
    movies_db.movies
WHERE
    title LIKE '%toy story%';
-- Mostrar a todos los actores cuyos nombres empiecen con Sam.
SELECT 
    *
FROM
    movies_db.actors
WHERE
    first_name LIKE 'SAM%';
-- Mostrar el título de las películas que salieron entre el ‘2004-01-01’ y ‘2008-12-31’.
SELECT 
    title
FROM
    movies_db.movies
WHERE
    release_date
        AND release_date BETWEEN '2004-01-01' AND '2008-12-31';
        
-- ----------------------------------------------------------
-- Ejercitación opcional II
-- ----------------------------------------------------------
-- Alias, limit y offset
-- Mostrar el título de todas las series y usar alias para que el nombre del campo este en español.
SELECT 
    title AS 'titulo'
FROM
    movies_db.series;
-- Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con
-- fecha de lanzamiento entre el año ‘1988-01-01’ al ‘2009-12-31’. Ordenar los
-- resultados por rating descendentemente.
SELECT 
    title
FROM
    movies_db.movies
WHERE
    rating > 3
        AND awards > 1 BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC;
-- Traer el top 3 a partir del registro 10 de la consulta anterior.
SELECT 
    title
FROM
    movies_db.movies
WHERE
    rating > 3
        AND awards > 1 BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC
LIMIT 3 OFFSET 10;
-- ¿Cuáles son los 3 peores episodios teniendo en cuenta su rating?
SELECT 
    title, rating
FROM
    movies_db.episodes
ORDER BY rating
LIMIT 3;
-- Obtener el listado de todos los actores. Quitar las columnas de fechas y película
-- favorita, además traducir los nombres de las columnas.
SELECT 
    id,
    first_name AS nombre,
    last_name AS apellido,
    rating AS calificacion
FROM
    movies_db.actors;
    
-- ----------------------------------------------------------
-- Ejercitación opcional III
-- ----------------------------------------------------------
-- Funciones de agregación, GROUP BY y HAVING
-- ¿Cuántas películas hay?
SELECT 
    COUNT(*)
FROM
    `movies_db`.`movies`;
-- ¿Cuántas películas tienen entre 3 y 7 premios?
SELECT 
    COUNT(*)
FROM
    `movies_db`.`movies`
WHERE
    awards BETWEEN 3 AND 7;
-- ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
SELECT 
    COUNT(*)
FROM
    `movies_db`.`movies`
WHERE
    awards BETWEEN 3 AND 7 AND rating > 7;
-- Crear un listado a partir de la tabla de películas, mostrar un reporte de la
-- cantidad de películas por id. de género.
SELECT 
    genre_id, COUNT(*)
FROM
    `movies_db`.`movies`
GROUP BY genre_id;
-- De la consulta anterior, listar sólo aquellos géneros que tengan como suma
-- de premios un número mayor a 5.
SELECT 
    genre_id, COUNT(*), SUM(awards)
FROM
    `movies_db`.`movies`
GROUP BY genre_id
HAVING SUM(awards) > 5;