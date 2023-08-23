SELECT * FROM movies_db.movies;
SELECT first_name, last_name, rating FROM movies_db.actors;
SELECT title FROM movies_db.series;

SELECT first_name, last_name FROM movies_db.actors WHERE rating > 7.5;
SELECT title, rating, awards FROM movies_db.movies WHERE rating > 7.5 AND awards > 2;
SELECT title, rating FROM movies_db.movies ORDER BY rating DESC;

SELECT title, rating FROM movies_db.movies WHERE title LIKE "%toy story%";
SELECT * FROM movies_db.actors WHERE first_name LIKE "SAM%";
SELECT title FROM movies_db.movies WHERE release_date AND release_date BETWEEN "2004-01-01" AND "2008-12-31";


SELECT title as "titulo" FROM movies_db.series;
SELECT title FROM movies_db.movies WHERE rating > 3 AND awards > 1 BETWEEN "1988-01-01" AND "2009-12-31" ORDER BY rating DESC;
SELECT title FROM movies_db.movies WHERE rating > 3 AND awards > 1 BETWEEN "1988-01-01" AND "2009-12-31" ORDER BY rating DESC LIMIT 3 OFFSET 10;
SELECT title, rating FROM movies_db.episodes ORDER BY rating LIMIT 3;
SELECT id, first_name AS nombre, last_name AS apellido, rating AS calificacion FROM movies_db.actors;

-- Ejercicios clase en vivo 9:
SELECT COUNT(*) FROM `movies_db`.`movies`;
SELECT COUNT(*) FROM `movies_db`.`movies` WHERE awards BETWEEN 3 AND 7 AND rating > 7;
SELECT genre_id, COUNT(*) FROM `movies_db`.`movies` GROUP BY genre_id;
SELECT genre_id, COUNT(*), SUM(awards) FROM `movies_db`.`movies` GROUP BY genre_id HAVING SUM(awards) > 5;

