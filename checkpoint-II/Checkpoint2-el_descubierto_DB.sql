-- 1. Listar todos los clientes cuyo nombre comience con la letra "A". 
-- Se debe mostrar id como "Número de cliente", apellido y nombre.
SELECT 
    id AS 'Número de cliente', apellido, nombre
FROM
    el_descubierto.cliente
WHERE
    nombre LIKE 'A%';
-- 2. Mostrar el número de la sucursal con domicilio "Ramón Freire Serrano 7410".
SELECT 
    *
FROM
    `el_descubierto`.`sucursal`
WHERE
    domicilio = 'Ramón Freire Serrano 7410';
-- 3. Se requiere saber cuál es el mayor importe prestado
SELECT 
    MAX(importe)
FROM
    `el_descubierto`.`prestamo`;
-- 4. Listar los pagos realizados con números 10, 14, 27, 45.
SELECT 
    *
FROM
    `el_descubierto`.`pago`
WHERE
    prestamo_id IN (10 , 14, 27, 45);
-- 5. Calcular el total de los pagos realizados para el préstamo número cuarenta. 
-- El reporte debe tener dos columnas denominadas "Número de préstamo" y el "Total pagado".
SELECT 
    prestamo_id AS 'Número de préstamo',
    SUM(importe) AS 'Total pagado'
FROM
    el_descubierto.pago
WHERE
    prestamo_id = 40;
-- 6. Listar los empleados que no pertenezcan a la sucursal dos y que la fecha de alta del
-- contrato sea mayor que 5/09/21 o igual a 25/06/21. Ordenar por alta de contrato.
SELECT 
    *
FROM
    el_descubierto.empleado
WHERE
    sucursal_numero != 2
        AND alta_contrato_laboral > '2020-09-05'
        OR alta_contrato_laboral = '202-06-25';
-- 7. Listar los pagos realizados con importe entre $1030,25 a $1666,66 
-- (ordenarlos por el importe pagado de mayor a menor).
SELECT 
    *
FROM
    el_descubierto.pago
WHERE
    importe BETWEEN 1030.25 AND 1666.66;
-- 8. Mostrar el quinto pago realizado con menor importe.
SELECT 
    *
FROM
    el_descubierto.pago
ORDER BY importe
LIMIT 1 OFFSET 5;
-- 9. Mostrar el préstamo con mayor importe. 
-- Este reporte debe contener el número del préstamo, 
-- la fecha de otorgamiento y el importe.
SELECT 
    id, fecha_otorgado, importe
FROM
    `el_descubierto`.`prestamo`
ORDER BY importe DESC
LIMIT 1;
-- 10. Mostrar las diez cuentas bancarias con menor saldo. 
-- Este reporte debe contener el número de cuenta, saldo y el código del tipo de cuenta.
SELECT 
    numero, saldo, cuenta_tipo_id
FROM
    el_descubierto.cuenta
ORDER BY saldo
LIMIT 10;
-- 11. Listar los préstamos otorgados entre 10/07/21 al 10/08/21 
-- (ordenarlos por fecha de otorgamiento)
SELECT 
    *
FROM
    `el_descubierto`.`prestamo`
WHERE
    fecha_otorgado BETWEEN '2021-07-10' AND '2021-08-10';
-- 12. Listar en forma ordenada las cuentas bancarias que tengan un descubierto otorgado superior o igual a $8999,80.
SELECT 
    *
FROM
    el_descubierto.cuenta
WHERE
    descubierto_otorgado >= 8999.80
ORDER BY numero;
-- 13. Listar todos los empleados cuyo apellido termine con los caracteres "do". 
-- Se debe mostrar el legajo, apellido, nombre y email.
SELECT 
    legajo, apellido, nombre, email
FROM
    `el_descubierto`.`empleado`
WHERE
    apellido LIKE '%do';
-- 14. Se desea conocer cuál es el promedio de los saldos de las cajas de ahorro
SELECT 
    cuenta_tipo_id, AVG(saldo)
FROM
    el_descubierto.cuenta
WHERE
    cuenta_tipo_id = 1
GROUP BY cuenta_tipo_id;
-- 15. Mostrar el tercer préstamo con mayor importe.
SELECT 
    *
FROM
    `el_descubierto`.`prestamo`
ORDER BY importe DESC
LIMIT 1 OFFSET 2;
-- 16. Calcular la cantidad de cuentas que tiene la sucursal número cinco. 
-- El reporte debe tener dos columnas denominadas "Sucursal" y el "Cantidad de Cuentas".
SELECT 
    sucursal_numero AS Sucursal,
    COUNT(*) AS 'Cantidad de Cuentas'
FROM
    el_descubierto.cuenta
GROUP BY sucursal_numero
HAVING sucursal_numero = 5;
-- 17. Mostrar todas las ciudades que contengan una palabra de cinco caracteres, pero el tercer carácter debe ser igual a "n".
SELECT 
    *
FROM
    el_descubierto.ciudad
WHERE
    nombre LIKE '% __n__ %';
-- 18. Modificar el tipo de cuenta bancaria "Cuenta Corriente" a "Cuenta Especial"
UPDATE `el_descubierto`.`cuenta_tipo` 
SET 
    `tipo` = 'CUENTA ESPECIAL'
WHERE
    `id` = 2;
SELECT 
    *
FROM
    el_descubierto.cuenta_tipo;
-- 19. En la fecha de hoy, agregar en la sucursal número nueve 
-- al empleado Quinteros Arias Raúl Alejandro 
-- con domicilio en Av. 25 de mayo 7410 - Pilar - Buenos Aires, 
-- mail: quiteros2021bs@gmail.com, 
-- teléfono móvil: '+5491154000745'.
INSERT INTO `el_descubierto`.`empleado`
(`sucursal_numero`,
`apellido`,
`nombre`,
`domicilio`,
`ciudad_id`,
`email`,
`telefono_movil`,
`alta_contrato_laboral`)
VALUES
(9,
"Quinteros Arias",
"Raúl Alejandro",
"Av. 25 de mayo 7410",
14,
"quiteros2021bs@gmail.com",
"+5491154000745",
"2023-08-22");
SELECT 
    *
FROM
    `el_descubierto`.`empleado`
WHERE
    nombre = 'Raúl Alejandro';

-- 20. Eliminar el registro del préstamo número cuarenta y cinco.
SELECT 
    *
FROM
    `el_descubierto`.`prestamo`
WHERE
    id = 45;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM `el_descubierto`.`prestamo` 
WHERE
    id = 45;
SET SQL_SAFE_UPDATES = 1;
SELECT 
    *
FROM
    `el_descubierto`.`prestamo`
WHERE
    id = 45;
-- 21. Mostrar el importe total prestado por el banco a sus clientes.
SELECT 
    SUM(importe)
FROM
    `el_descubierto`.`prestamo`;
-- 22. Mostrar la cantidad total de cuentas activas que están registradas en el banco.
SELECT 
    activa, COUNT(*)
FROM
    `el_descubierto`.`cuenta`
GROUP BY activa;
-- 23. Mostrar el apellido y la cantidad de clientes que poseen el mismo apellido.
SELECT 
    apellido, COUNT(apellido)
FROM
    `el_descubierto`.`cliente`
GROUP BY apellido;
-- 24. Mostrar el id del país y la cantidad de ciudades que posee cada uno de ellos.
SELECT 
    pais_id, COUNT(pais_id)
FROM
    `el_descubierto`.`ciudad`
GROUP BY pais_id;
-- 25. Necesitamos saber la cantidad de préstamos por sucursal y día otorgado. 
-- ¿Hay sucursales que hayan realizado más de un préstamo el mismo día?
SELECT 
    sucursal_numero, fecha_otorgado, COUNT(*)
FROM
    `el_descubierto`.`prestamo`
GROUP BY sucursal_numero , fecha_otorgado
ORDER BY sucursal_numero;