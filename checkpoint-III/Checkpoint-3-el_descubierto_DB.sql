-- ----------------------------------------------------------------------------------
-- Consigna - CheckPoint III
-- ----------------------------------------------------------------------------------
-- 1. Listar todos los clientes que tengan tres o más cuentas bancarias. Mostrar el
-- número de cliente, apellido y nombre separado por un espacio dentro de una
-- misma columna denominada "Cliente" y, la cantidad de cuentas que posee.
-- RESULTADO: 6 filas.
SELECT 
    c.id,
    CONCAT(nombre, apellido) AS Cliente,
    COUNT(cuenta_numero) AS Cantidad_Cuentas
FROM
    cliente c
        JOIN
    cliente_x_cuenta cc ON c.id = cc.cliente_id
        JOIN
    cuenta ct ON cc.cuenta_numero = ct.numero
GROUP BY cliente_id
HAVING Cantidad_Cuentas >= 3;

-- 2. Listar todos los clientes que no tengan una cuenta bancaria. Mostrar el número
-- de cliente, apellido y nombre en mayúsculas dentro de una misma columna
-- denominada "Cliente sin cuenta bancaria".
-- RESULTADO: 8 filas.
SELECT 
    c.id,
    UPPER(CONCAT(nombre," ", apellido )) AS Cliente,
    COALESCE(ct.numero, 'No tiene cuenta') AS 'Cliente sin cuenta bancaria'
FROM
    cliente c
        LEFT JOIN
    cliente_x_cuenta cc ON c.id = cc.cliente_id
        LEFT JOIN
    cuenta ct ON cc.cuenta_numero = ct.numero
WHERE
    ct.numero IS NULL;

-- 3. Listar todos los clientes que tengan al menos un préstamo que corresponda a la
-- sucursal de la ciudad de "Pilar - Buenos Aires". Se debe mostrar el número de
-- cliente, apellido, nombre, número de préstamo, número de sucursal, nombre de
-- la ciudad y país de dicha sucursal.
-- RESULTADO: 3 filas.
SELECT 
    c.id,
    c.nombre,
    c.apellido,
    p.id AS id_prestamo,
    s.numero AS numero_sucursal,
    cd.nombre Ciudad,
    pa.nombre Pais
FROM
    cliente c
        JOIN
    cliente_x_prestamo cp ON cp.cliente_id = c.id
        JOIN
    prestamo p ON cp.prestamo_id = p.id
        JOIN
    sucursal s ON p.sucursal_numero = s.numero
        JOIN
    ciudad cd ON s.Ciudad_id = cd.id
        JOIN
    pais pa ON cd.pais_id = pa.id
WHERE
    cd.nombre LIKE '%Pilar - Buenos Aires%'
ORDER BY c.id;

-- 4. Listar los clientes que tengan una o más cajas de ahorro y que en la segunda
-- letra de su apellido contenga una "e".
-- RESULTADO: 5 filas.
SELECT 
    cl.nombre, cl.apellido, ct.tipo AS tipo_de_cuenta
FROM
    cliente cl
        JOIN
    cliente_x_cuenta cc ON cc.cliente_id = cl.id
        JOIN
    cuenta cn ON cc.cuenta_numero = cn.numero
        JOIN
    cuenta_tipo ct ON cn.cuenta_tipo_id = ct.id
WHERE
    ct.tipo LIKE 'CAJA DE AHORRO'
        AND apellido LIKE '_e%';

-- 5. Listar absolutamente todos los países y la cantidad de clientes que tengan.
-- RESULTADO: 20 filas.
SELECT 
    pais.nombre AS Pais, COUNT(cliente.id) AS cantidad_clientes
FROM
    pais
        LEFT JOIN
    ciudad ON pais.id = ciudad.pais_id
        LEFT JOIN
    cliente ON ciudad.id = cliente.ciudad_id
GROUP BY pais.nombre
ORDER BY cantidad_clientes DESC;

-- 6. Calcular el importe total y la cantidad de préstamos otorgados en el mes de
-- agosto por cada cliente. Mostrar el número de cliente, importe total y cantidad
-- de préstamos.
-- RESULTADO: 9 fila.
SELECT 
    c.id, SUM(importe) importe_total, COUNT(c.id) cantidad_prestamos
FROM
    cliente c
        JOIN
    cliente_x_prestamo cxp ON c.id = cxp.cliente_id
        JOIN
    prestamo p ON p.id = cxp.prestamo_id
WHERE
    fecha_otorgado BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY c.id
ORDER BY importe_total DESC;

-- 7. Calcular el importe total y la cantidad de cuotas pagadas para el préstamo
-- número cuarenta.
-- RESULTADO: 1 fila.
SELECT 
    p.id,
    SUM(p.importe) importe_total,
    MAX(pa.cuota_nro) cantidad_cuotas
FROM
    cliente c
        JOIN
    cliente_x_prestamo cxp ON c.id = cxp.cliente_id
        JOIN
    prestamo p ON p.id = cxp.prestamo_id
        JOIN
    pago pa ON pa.prestamo_id = p.id
WHERE
    p.id = 40;

-- 8. Determinar el importe restante que falta por pagar para el préstamo número 45.
-- RESULTADO: 1 fila.
SELECT 
    p.importe - SUM(pa.importe) importe_restante
FROM
    cliente c
        JOIN
    cliente_x_prestamo cxp ON c.id = cxp.cliente_id
        JOIN
    prestamo p ON p.id = cxp.prestamo_id
        JOIN
    pago pa ON pa.prestamo_id = p.id
WHERE
    p.id = 45;

-- 9. Listar los préstamos de la sucursal número cuatro. Mostrar el número de cliente,
-- apellido, nombre y el número de préstamo.
-- RESULTADO: 6 filas.
SELECT 
    c.id, c.apellido, c.nombre, p.id
FROM
    cliente c
        JOIN
    cliente_x_prestamo cxp ON c.id = cxp.cliente_id
        JOIN
    prestamo p ON p.id = cxp.prestamo_id
        JOIN
    sucursal s ON s.numero = p.sucursal_numero
WHERE
    s.numero = 4;

-- 10. Reportar el número del préstamo y la cantidad de cuotas pagadas por cada uno
-- préstamo. Se debe formatear el dato de la cantidad de cuotas pagadas, por
-- ejemplo, si se ha pagado una cuota, sería "1 cuota paga"; si se han pagado dos o
-- más cuotas, sería en plural "2 cuotas pagas" y "Ninguna cuota paga" para los
-- préstamos que aún no han recibido un pago.
-- RESULTADO: 47 filas.
SELECT 
    p.id,
    CASE
        WHEN COUNT(pa.cuota_nro) = 0 THEN 'Ninguna cuota paga'
        WHEN COUNT(pa.cuota_nro) = 1 THEN '1 cuota paga'
        ELSE CONCAT(COUNT(pa.cuota_nro), ' cuotas pagas')
    END AS cuotas_pagadas
FROM
    prestamo p
        LEFT JOIN
    pago pa ON p.id = pa.prestamo_id
GROUP BY p.id;

-- 11. Listar absolutamente todos los empleados y las cuentas bancarias que tengan
-- asociada. Mostrar en una sola columna el apellido y la letra inicial del nombre del
-- empleado (Ej. Tello Aguilera C.), en otra columna, el número de cuenta y el tipo
-- (Ej. 10560 - CAJA DE AHORRO). Los campos nulos deben figurar con la leyenda
-- "-Sin asignación-".
-- RESULTADO: 60 filas.
SELECT 
    CONCAT(apellido, ' ', SUBSTR(nombre, 1, 1)),
    IFNULL(CONCAT(numero, ' - ', tipo),
            '-Sin asignación-')
FROM
    empleado e
        LEFT JOIN
    cuenta c ON e.legajo = c.ejecutivo_cuenta
        LEFT JOIN
    cuenta_tipo ct ON c.cuenta_tipo_id = ct.id;

-- 12. Reportar todos los datos de los clientes y los números de cuenta que tienen.
-- RESULTADO: 72 filas.
SELECT 
    *
FROM
    cliente c
        LEFT JOIN
    cliente_x_cuenta cxc ON c.id = cxc.cliente_id
ORDER BY id;

-- 13. Listar los clientes con residencia en las ciudades de "Las Heras - Mendoza", "Viña
-- del Mar - Valparaíso", "Córdoba - Córdoba" y "Monroe - Buenos Aires". Se debe
-- mostrar el apellido, nombre del cliente y todos los datos referidos a la ciudad
-- RESULTADO: 6 filas.
SELECT 
    cl.apellido,
    cl.nombre,
    ciudad_id,
    ci.nombre AS ciudad,
    ci.codigo_postal,
    ci.pais_id,
    p.nombre AS pais
FROM
    cliente cl
        JOIN
    ciudad ci ON cl.ciudad_id = ci.id
        JOIN
    pais p ON ci.pais_id = p.id
WHERE
    ci.nombre IN ('Las Heras - Mendoza' , 'Viña del Mar - Valparaíso',
        'Córdoba - Córdoba',
        'Monroe - Buenos Aires');

-- 14. Listar los clientes que tienen préstamos otorgados entre 15/08/21 al 5/09/21
-- (ordenarlos por fecha de otorgamiento). Mostrar sólo el email del cliente,
-- teléfono móvil y todos los datos referidos al préstamo.
-- RESULTADO: 6 filas.
SELECT 
    email, telefono_movil, p.*
FROM
    cliente c
        JOIN
    cliente_x_prestamo cxp ON c.id = cxp.cliente_id
        JOIN
    prestamo p ON p.id = cxp.prestamo_id
WHERE
    fecha_otorgado BETWEEN '2021-08-15' AND '2021-09-21'
ORDER BY fecha_otorgado;

-- 15. Listar de manera ordenada, los empleados que no pertenezcan a la sucursal de
-- la ciudad "Monroe - Buenos Aires" y que la fecha de alta del contrato se halle
-- dentro del rango 2016 al 2018. Mostrar el email del empleado, número de
-- sucursal y el nombre de la ciudad
-- RESULTADO: 22 filas.
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) Nombre,
    e.email,
    c.nombre Ciudad,
    e.alta_contrato_laboral
FROM
    empleado e
        LEFT JOIN
    sucursal s ON s.Ciudad_id = e.ciudad_id
        INNER JOIN
    ciudad c ON c.id = s.Ciudad_id
WHERE
    c.nombre != 'Monroe - Buenos Aires'
        AND e.alta_contrato_laboral BETWEEN '2016-01-01' AND '2019-01-01';

-- 16. Listar las cuentas bancarias que tienen dos titulares. Mostrar sólo el número de
-- cuenta y la cantidad de titulares
-- RESULTADO: 3 filas.
SELECT 
    c.numero N_Cuenta, COUNT(*) Titulares
FROM
    cuenta c
        LEFT JOIN
    cliente_x_cuenta cxc ON cxc.cuenta_numero = c.numero
		LEFT JOIN 
	cliente cl ON cl.id = cxc.cliente_id
GROUP BY c.numero
HAVING Titulares = 2;

-- 17. Se desea conocer el segundo pago con mayor importe efectuado en las
-- sucursales de Chile. Mostrar el número y hora de pago, importe pagado y el
-- nombre del país.
-- RESULTADO: 1 fila.
SELECT 
    p.id ID,
    p.cuota_nro Cuota,
    p.fecha,
    p.importe,
    pa.nombre Pais
FROM
    pago p
        LEFT JOIN
    prestamo pr ON pr.id = p.prestamo_id
        LEFT JOIN
    sucursal s ON s.numero = pr.sucursal_numero
        LEFT JOIN
    ciudad c ON c.id = s.Ciudad_id
        LEFT JOIN
    pais pa ON pa.id = c.pais_id
WHERE
    pa.nombre = 'Chile'
ORDER BY p.importe DESC
LIMIT 1 OFFSET 1;

-- 18. Listar los clientes que no tienen préstamos. Mostrar el apellido, nombre y email
-- del cliente.
-- RESULTADO: 20 filas.
SELECT 
    cl.apellido, cl.nombre, cl.email, p.id
FROM
    cliente cl
        LEFT JOIN
    cliente_x_prestamo cxp ON cxp.cliente_id = cl.id
        LEFT JOIN
    prestamo p ON p.id = cxp.prestamo_id
WHERE
    p.id IS NULL;

-- 19. Se desea conocer el mes y año en que se terminaría de pagar el préstamo
-- número treinta a partir de la fecha de otorgamiento. Se debe mostrar el email
-- del cliente, número de préstamo, fecha de otorgamiento, importe prestado, mes
-- y año que correspondería a la última cuota (Ej. "agosto de 2021").
-- RESULTADO: 1 fila.
SELECT 
    c.email,
    p.id ID_Prestamo,
    p.fecha_otorgado,
    p.importe,
    p.cantidad_cuota Cuotas,
    DATE_ADD(p.fecha_otorgado,
        INTERVAL p.cantidad_cuota MONTH) Ultima_cuota
FROM
    prestamo p
        LEFT JOIN
    cliente_x_prestamo cxp ON cxp.prestamo_id = p.id
        LEFT JOIN
    cliente c ON c.id = cxp.cliente_id
WHERE
    p.id = 30;

-- 20. Listar las ciudades (sin repetir) que tengan entre dos a cuatro cuentas bancarias.
-- Se debe mostrar el país, ciudad y la cantidad de cuentas. Además, se debe
-- ordenar por país y ciudad.
-- RESULTADO: 15 filas.
SELECT 
    p.nombre País, c.nombre Ciudad, COUNT(cu.numero) cuentas
FROM
    ciudad c
        JOIN
    pais p ON p.id = c.pais_id
        JOIN
    sucursal s ON s.Ciudad_id = c.id
        JOIN
    cuenta cu ON cu.sucursal_numero = s.numero
GROUP BY p.nombre , c.nombre
HAVING cuentas BETWEEN 2 AND 4
ORDER BY p.nombre , c.nombre;

-- 21. Mostrar el nombre, apellido, número de cuenta de todos los clientes que poseen
-- una cuenta tipo "CAJA DE AHORRO", cuyo saldo es mayor que $ 15000
-- RESULTADO: 9 filas.
SELECT 
    cli.nombre Nombre,
    cli.apellido Apellido,
    cu.numero Cuenta,
    ct.tipo Tipo,
    cu.saldo Saldo
FROM
    cliente cli
        JOIN
    cliente_x_cuenta cxc ON cxc.cliente_id = cli.id
        JOIN
    cuenta cu ON cu.numero = cxc.cuenta_numero
        JOIN
    cuenta_tipo ct ON ct.id = cu.cuenta_tipo_id
WHERE
    ct.tipo LIKE 'CAJA DE AHORRO'
        AND cu.saldo > 15000;

-- 22. Por cada sucursal, contar la cantidad de clientes y el saldo promedio de sus
-- cuentas.
-- RESULTADO: 21 filas.
SELECT 
    s.numero Sucursal,
    COUNT(cli.id) Clientes,
    AVG(cu.saldo) 'Saldo promedio'
FROM
    sucursal s
        JOIN
    cuenta cu ON cu.sucursal_numero = s.numero
        JOIN
    cliente_x_cuenta cxc ON cu.numero = cxc.cuenta_numero
        JOIN
    cliente cli ON cxc.cliente_id = cli.id
GROUP BY s.numero
ORDER BY s.numero;

-- 23. Listar todos aquellos clientes que teniendo un saldo negativo en la cuenta,
-- tengan un descubierto otorgado mayor a cero. Mostrar el apellido, nombre,
-- saldo y descubierto otorgado.
-- RESULTADO: 7 filas.
SELECT 
    cli.apellido,
    cli.nombre,
    cu.saldo Saldo,
    cu.descubierto_otorgado Descubierto
FROM
    cliente cli
        JOIN
    cliente_x_cuenta cxc ON cxc.cliente_id = cli.id
        JOIN
    cuenta cu ON cu.numero = cxc.cuenta_numero
WHERE
    cu.descubierto_otorgado > 0
        AND Saldo < 0;

-- 24. Se desea conocer el último acceso de cada cliente al sistema. Mostrar el nombre,
-- apellido y última fecha de acceso.
-- RESULTADO: 37 filas.
SELECT 
    cli.nombre Nombre,
    cli.apellido Apellido,
    MAX(acceso) 'Ultimo acceso'
FROM
    cliente cli
        JOIN
    historial_acceso h ON h.cliente_id = cli.id
GROUP BY cli.nombre , cli.apellido;


-- 25. Listar el apellido y nombre de todos los empleados del banco. Si poseen cuentas
-- a cargo, mostrar cuántas. Ordenar por apellido y nombre.
-- RESULTADO: 50 filas.
SELECT 
    e.apellido Apellido,
    e.nombre Nombre,
    COUNT(cu.numero) 'Cuentas a cargo'
FROM
    empleado e
        LEFT JOIN
    cuenta cu ON cu.ejecutivo_cuenta = e.legajo
GROUP BY e.apellido , e.nombre
ORDER BY e.apellido , e.nombre;