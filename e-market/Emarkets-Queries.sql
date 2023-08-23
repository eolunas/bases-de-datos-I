-- Consultas queries ML - Parte I:
-- -----------------------------------------------
-- Categorias y productos:
-- -----------------------------------------------
-- Queremos tener un listado de todas las categorías.
SELECT 
    *
FROM
    `emarket`.`categorias`;
-- Cómo las categorías no tienen imágenes, solamente interesa obtener un listado
-- de CategoriaNombre y Descripcion.
SELECT 
    CategoriaNombre, Descripcion
FROM
    `emarket`.`categorias`;
-- Obtener un listado de los productos.
SELECT 
    *
FROM
    `emarket`.`productos`;
-- ¿Existen productos discontinuados? (Discontinuado = 1).
SELECT 
    *
FROM
    `emarket`.`productos`
WHERE
    Discontinuado = 1;
-- Para el viernes hay que reunirse con el Proveedor 8. 
-- ¿Qué productos son los que nos provee?
SELECT 
    *
FROM
    `emarket`.`productos`
WHERE
    ProveedorID = 8;
-- Queremos conocer todos los productos cuyo precio unitario se encuentre entre 10 y 22.
SELECT 
    *
FROM
    `emarket`.`productos`
WHERE
    PrecioUnitario BETWEEN 10 AND 22;
-- Se define que un producto hay que solicitarlo al proveedor si sus unidades 
-- en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?
SELECT 
    *
FROM
    `emarket`.`productos`
WHERE
    UnidadesStock < NivelReorden;
-- Se quiere conocer todos los productos del listado anterior,
-- pero que unidades pedidas sea igual a cero.
SELECT 
    *
FROM
    `emarket`.`productos`
WHERE
    UnidadesPedidas = 0;
-- -----------------------------------------------
-- Clientes:
-- -----------------------------------------------
-- Obtener un listado de todos los clientes con Contacto, Compania, Título, País. 
-- Ordenar el listado por País.
SELECT 
    Contacto, Compania, Titulo, Pais
FROM
    `emarket`.`clientes`
ORDER BY pais;
-- Queremos conocer a todos los clientes que tengan un título “Owner”.
SELECT 
    *
FROM
    `emarket`.`clientes`
WHERE
    Titulo = 'Owner';
-- El operador telefónico que atendió a un cliente no recuerda su nombre. 
-- Solo sabe que comienza con “C”. 
-- ¿Lo ayudamos a obtener un listado con todos los contactos que inician con la letra “C”?
SELECT 
    *
FROM
    `emarket`.`clientes`
WHERE
    Contacto LIKE 'C%';

-- -----------------------------------------------
-- Facturas:
-- -----------------------------------------------
-- Obtener un listado de todas las facturas, ordenado por fecha de factura ascendente.
SELECT 
    *
FROM
    `emarket`.`facturas`
ORDER BY FechaFactura;
-- Ahora se requiere un listado de las facturas con el país de envío “USA” 
-- y que su correo (EnvioVia) sea distinto de 3.
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    PaisEnvio = 'USA' AND EnvioVia != 3;
-- ¿El cliente 'GOURL' realizó algún pedido?
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    ClienteID = 'GOURL';
-- Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    EmpleadoID IN (2 , 3, 5, 8, 9);

-- Consultas queries ML - Parte II:
-- -----------------------------------------------
-- Productos:
-- -----------------------------------------------
-- Obtener el listado de todos los productos ordenados descendentemente por precio unitario.
SELECT 
    *
FROM
    `emarket`.`productos`
ORDER BY PrecioUnitario DESC;
-- Obtener el listado de top 5 de productos cuyo precio unitario es el más caro.
SELECT 
    *
FROM
    `emarket`.`productos`
ORDER BY PrecioUnitario DESC
LIMIT 5;
-- Obtener un top 10 de los productos con más unidades en stock.
SELECT 
    *
FROM
    `emarket`.`productos`
ORDER BY UnidadesStock DESC
LIMIT 10;

-- -----------------------------------------------
-- FacturaDetalle:
-- -----------------------------------------------
-- Obtener un listado de FacturaID, Producto, Cantidad.
SELECT 
    FacturaID, ProductoID, Cantidad
FROM
    `emarket`.`facturadetalle`;
-- Ordenar el listado anterior por cantidad descendentemente.
SELECT 
    FacturaID, ProductoID, Cantidad
FROM
    `emarket`.`facturadetalle`
ORDER BY Cantidad DESC;
-- Filtrar el listado solo para aquellos productos donde la cantidad
-- se encuentre entre 50 y 100.
SELECT 
    FacturaID, ProductoID, Cantidad
FROM
    `emarket`.`facturadetalle`
WHERE
    Cantidad BETWEEN 50 AND 100
ORDER BY Cantidad DESC;
-- En otro listado nuevo, obtener un listado con los siguientes
-- nombres de columnas: NroFactura (FacturaID), Producto
-- (ProductoID), Total (PrecioUnitario*Cantidad).
SELECT 
    FacturaID AS NroFactura,
    ProductoID AS Producto,
    PrecioUnitario * Cantidad AS Total
FROM
    `emarket`.`facturadetalle`;
    
-- -----------------------------------------------
-- EXTRAS:
-- -----------------------------------------------
-- Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”,
-- o que tengan un título que empiece con “Sales”.
SELECT 
    *
FROM
    `emarket`.`clientes`
WHERE
    Pais IN ('Brazil' , 'Mexico')
        OR Titulo LIKE 'Sales%';
-- Obtener un listado de todos los clientes que pertenecen a una compañía
-- que empiece con la letra "A".
SELECT 
    *
FROM
    `emarket`.`clientes`
WHERE
    Compania LIKE 'A%';
-- Obtener un listado con los datos: Ciudad, Contacto y renombrarlo
-- como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos
-- los clientes que sean de la ciudad "Madrid".
SELECT 
    Ciudad, Contacto AS 'Apellido y nombre', Titulo AS 'Puesto'
FROM
    `emarket`.`clientes`
WHERE
    Ciudad = 'Madrid';
-- Obtener un listado de todas las facturas con ID entre 10000 y 10500.
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    FacturaID BETWEEN 10000 AND 10500;
-- Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de
-- los clientes con ID que empiecen con la letra “B”.
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    FacturaID BETWEEN 10000 AND 10500
        OR ClienteID LIKE 'B%';
-- ¿Existen facturas que la ciudad de envío sea “Vancouver” o que
-- utilicen el correo 3?
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    CiudadEnvio = 'Vancouver'
        OR EnvioVia = 3;
-- ¿Cuál es el ID de empleado de “Buchanan”?
SELECT 
    EmpleadoID, Apellido
FROM
    `emarket`.`empleados`
WHERE
    Apellido = 'Buchanan';
-- ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior?
-- (No relacionar, sino verificar que existan facturas)
SELECT 
    *
FROM
    `emarket`.`facturas`
WHERE
    EmpleadoID = 5;
