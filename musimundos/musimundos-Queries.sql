-- Ejercicios PLAYGROUND:
SELECT pais, COUNT(*) FROM `musimundos`.`clientes` GROUP BY pais HAVING pais = 'Brazil';
SELECT id_genero, COUNT(*) FROM `musimundos`.`canciones` GROUP BY id_genero HAVING id_genero = 6;
SELECT SUM(total) FROM `musimundos`.`facturas`;
SELECT id_album, AVG(milisegundos) FROM `musimundos`.`canciones` GROUP BY id_album;
SELECT MIN(bytes) FROM `musimundos`.`canciones`;
SELECT id_cliente, SUM(total) FROM `musimundos`.`facturas` GROUP BY id_cliente HAVING SUM(total) > 45;