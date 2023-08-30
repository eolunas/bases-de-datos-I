-- ----------------------------------------------------------------------------------------
-- Bases de datos I - Volver al futuro: SAKILA
-- ----------------------------------------------------------------------------------------
-- Reportes parte 1: 
-- ----------------------------------------------------------------------------------------
-- Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
-- alias para mostrar los nombres de las columnas en español. 
SELECT 
    first_name Nombre, last_name Apellido
FROM
    `sakila`.`actor`
LIMIT 5;

-- Obtener un listado que incluya nombre, apellido y correo electrónico de los 
-- clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las 
-- columnas en español. 
SELECT 
    first_name Nombre,
    last_name Apellido,
    email 'Correo electrónico'
FROM
    sakila.customer
WHERE
    customer.active = 1;

-- Obtener un listado de films incluyendo título, año y descripción de los films 
-- que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de 
-- mayor a menor. Utilizar alias para mostrar los nombres de las columnas en  español.
SELECT 
    title "Título",
    release_year 'Año de lanzamiento',
    description "Descripción",
    rental_duration "Duración de renta"
FROM
    sakila.film
WHERE
    rental_duration > 5
ORDER BY rental_duration DESC;

-- Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
-- mayo de 2005, incluir en el resultado todas las columnas disponibles.
SELECT 
    *
FROM
    sakila.rental
WHERE
    rental_date BETWEEN '2005-05-01' AND '2005-06-01';

-- ----------------------------------------------------------------------------------------
-- Reportes parte 2: 
-- ----------------------------------------------------------------------------------------
-- Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo
-- en una columna llamada “cantidad”. 
SELECT 
    COUNT(*) "Cantidad"
FROM
    sakila.rental;
    
-- Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo
-- en una columna llamada “total”, junto a una columna con la cantidad de alquileres con
-- el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler. 
SELECT 
	COUNT(*) Cantidad,
    SUM(amount) Total,
    AVG(amount) "Importe promedio"
FROM
    sakila.payment;

-- Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más 
-- dinero gastan y en cuántos alquileres lo hacen? 
SELECT 
    CONCAT(customer.first_name, " ", customer.last_name) Nombre,
    COUNT(*) Cantidad, 
    SUM(amount) Total
FROM
    sakila.payment
        INNER JOIN
    sakila.customer ON payment.customer_id = customer.customer_id
GROUP BY Nombre
ORDER BY Total DESC
LIMIT 10;

-- Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total
-- para todos los clientes que hayan gastado más de 150 dólares en alquileres. 
SELECT 
    customer_id, COUNT(*) Cantidad, SUM(amount) Total
FROM
    sakila.payment
GROUP BY customer_id
HAVING total > 150;

-- Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
-- la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el 
-- año de alquiler 2005 (rental_date de tabla rental). 
SELECT 
	EXTRACT(month FROM rental_date) Mes,
    COUNT(*) Cantidad, 
    SUM(amount) Total
FROM `sakila`.`rental`
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY Mes
ORDER BY Mes;

-- Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más 
-- alquilados? (columna inventory_id en la tabla rental). Para cada una de ellas 
-- indicar la cantidad de alquileres. 
SELECT 
    rental.inventory_id, COUNT(*) Cantidad
FROM
    `sakila`.`rental`
        INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY rental.inventory_id
ORDER BY Cantidad DESC
LIMIT 5;


-- ----------------------------------------------------------------------------------------
-- Desafio extra - Join: 
-- ----------------------------------------------------------------------------------------
-- Obtener los artistas que han actuado en una o más películas.
SELECT DISTINCT
    actor.first_name Nombre,
    actor.last_name Apellido
FROM
    actor
        LEFT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        LEFT JOIN
    film ON film_actor.film_id = film.film_id
WHERE film.film_id IS NOT NULL;

-- Obtener las películas donde han participado más de un artista según nuestra base de datos.
SELECT DISTINCT
    film.title Titulo,
    COUNT(*) Actores
FROM
    actor
        RIGHT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        RIGHT JOIN
    film ON film_actor.film_id = film.film_id
GROUP BY film.title
HAVING Actores > 1
ORDER BY Actores;

-- Obtener aquellos artistas que han actuado en alguna película, incluso aquellos que aún 
-- no lo han hecho, según nuestra base de datos.
SELECT DISTINCT
    CONCAT(actor.first_name, " ", actor.last_name) NombreActor
FROM
    actor
        LEFT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        LEFT JOIN
    film ON film_actor.film_id = film.film_id;

-- Obtener las películas que no se le han asignado artistas en nuestra base de datos.
SELECT 
    film.title Titulo,
    actor.actor_id
FROM
    film
        LEFT JOIN
    film_actor ON film.film_id = film_actor.film_id
        LEFT JOIN
    actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id IS NULL;

-- Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.
SELECT DISTINCT
    CONCAT(actor.first_name, " ", actor.last_name) NombreActor
FROM
    actor
        LEFT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        LEFT JOIN
    film ON film_actor.film_id = film.film_id
WHERE film.film_id IS NULL;

-- Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos.
SELECT DISTINCT
    CONCAT(actor.first_name, ' ', actor.last_name) NombreActor,
    COUNT(*) Peliculas
FROM
    actor
        LEFT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        LEFT JOIN
    film ON film_actor.film_id = film.film_id
GROUP BY NombreActor
HAVING 
    Peliculas > 1
ORDER BY Peliculas;

-- Obtener aquellas películas que tengan asignado uno o más artistas, incluso aquellas que 
-- aún no le han asignado un artista en nuestra base de datos.
SELECT DISTINCT
    film.title Titulo
FROM
    film
        LEFT JOIN
    film_actor ON film.film_id = film_actor.film_id
        LEFT JOIN
    actor ON film_actor.actor_id = actor.actor_id;