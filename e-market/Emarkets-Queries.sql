-- --------------------------------------------------------------------------------
-- Consultas queries ML - Parte I:
-- --------------------------------------------------------------------------------
-- Categorias y productos:

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
    
-- Clientes:

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

-- Facturas:

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

-- --------------------------------------------------------------------------------
-- Consultas queries ML - Parte II:
-- --------------------------------------------------------------------------------
-- Productos:

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

-- FacturaDetalle:

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
    
-- EXTRAS:

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

-- --------------------------------------------------------------------------------
-- Consultas queries XL parte I - GROUP BY
-- --------------------------------------------------------------------------------
-- Clientes:
-- ¿Cuántos clientes existen?
SELECT 
    COUNT(*)
FROM
    `clientes`;
-- ¿Cuántos clientes hay por ciudad?
SELECT 
    ciudad, COUNT(*)
FROM
    `clientes`
GROUP BY ciudad;
-- Facturas:
-- ¿Cuál es el total de transporte?
SELECT 
    SUM(Transporte)
FROM
    `emarket`.`facturas`;
-- ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT 
    EnvioVia, SUM(Transporte)
FROM
    `emarket`.`facturas`
GROUP BY EnvioVia;
-- Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
-- cantidad de facturas.
SELECT 
    ClienteID, COUNT(FacturaID)
FROM
    `emarket`.`facturas`
GROUP BY ClienteID
ORDER BY COUNT(FacturaID) DESC;
-- Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT 
    ClienteID, COUNT(FacturaID)
FROM
    `emarket`.`facturas`
GROUP BY ClienteID
ORDER BY COUNT(FacturaID) DESC
LIMIT 5;
-- ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT 
    PaisEnvio, COUNT(PaisEnvio)
FROM
    `emarket`.`facturas`
GROUP BY PaisEnvio
ORDER BY COUNT(PaisEnvio)
LIMIT 1;
-- Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?
SELECT 
    EmpleadoID, COUNT(EmpleadoID)
FROM
    `emarket`.`facturas`
GROUP BY EmpleadoID
ORDER BY COUNT(EmpleadoID) DESC
LIMIT 1;
-- Factura detalle:
-- ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
SELECT 
    ProductoID, SUM(ProductoID)
FROM
    `emarket`.`facturadetalle`
GROUP BY ProductoID
ORDER BY SUM(ProductoID) DESC
LIMIT 1;
-- ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.
SELECT 
    SUM(PrecioUnitario * Cantidad) "Total facturado"
FROM
    `emarket`.`facturadetalle`;
-- ¿Cuál es el total facturado para los productos ID entre 30 y 50?
SELECT 
    SUM(PrecioUnitario * Cantidad) 'Total facturado'
FROM
    `emarket`.`facturadetalle`
WHERE
    ProductoID BETWEEN 30 AND 50;
-- ¿Cuál es el precio unitario promedio de cada producto?
SELECT 
    ProductoID, AVG(PrecioUnitario) 'Precio promedio'
FROM
    `emarket`.`facturadetalle`
GROUP BY ProductoID;
-- ¿Cuál es el precio unitario máximo?
SELECT 
     MAX(PrecioUnitario) 'Precio maximo'
FROM
    `emarket`.`facturadetalle`;
    
-- --------------------------------------------------------------------------------
-- Consultas queries XL parte II - JOIN
-- --------------------------------------------------------------------------------
-- Generar un listado de todas las facturas del empleado 'Buchanan'.
SELECT 
    facturas.FacturaID,
    empleados.Apellido
FROM
    `emarket`.`facturas`
        INNER JOIN
    empleados ON facturas.EmpleadoID = empleados.EmpleadoID
WHERE
    empleados.Apellido = 'Buchanan';
-- Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT 
    correos.Compania, facturas.*
FROM
    `emarket`.`facturas`
        INNER JOIN
    correos ON facturas.EnvioVia = correos.CorreoID
WHERE
    correos.Compania = 'Speedy Express';
-- Generar un listado de todas las facturas con el nombre y apellido de los empleados.
SELECT 
    facturas.FacturaID, empleados.Nombre, empleados.Apellido
FROM
    `emarket`.`facturas`
        INNER JOIN
    empleados ON facturas.EmpleadoID = empleados.EmpleadoID;
-- Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT 
    facturas.FacturaID, clientes.Titulo, clientes.Pais
FROM
    `emarket`.`facturas`
        INNER JOIN
    clientes ON facturas.ClienteID = clientes.ClienteID
WHERE
    clientes.Titulo = 'Owner'
        AND clientes.Pais = 'USA';
-- Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” o que incluyan el producto id = “42”.
SELECT 
    empleados.Apellido, facturadetalle.ProductoID, facturas.*
FROM
    `emarket`.`facturas`
        INNER JOIN
    empleados ON facturas.EmpleadoID = empleados.EmpleadoID
        INNER JOIN
    facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE
    empleados.Apellido = 'Leverling'
        OR facturadetalle.ProductoID = 42;
-- Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” y que incluya los producto id = “80” o ”42”.
SELECT 
    empleados.Apellido, facturadetalle.ProductoID, facturas.*
FROM
    `emarket`.`facturas`
        INNER JOIN
    empleados ON facturas.EmpleadoID = empleados.EmpleadoID
        INNER JOIN
    facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
WHERE
    empleados.Apellido = 'Leverling'
        AND facturadetalle.ProductoID IN (80 , 42);
-- Generar un listado con los cinco mejores clientes, según sus importes de
-- compras total (PrecioUnitario * Cantidad).
SELECT 
    clientes.Contacto,
    SUM(facturadetalle.PrecioUnitario * facturadetalle.Cantidad) AS Total_compras
FROM
    `emarket`.`facturas`
        INNER JOIN
    clientes ON facturas.ClienteID = clientes.ClienteID
        INNER JOIN
    facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY clientes.Contacto
ORDER BY Total_compras DESC
LIMIT 5;
-- Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.
SELECT 
    clientes.ClienteID,
    clientes.Contacto,
    facturas.FechaFactura,
    facturas.PaisEnvio,
    SUM(facturadetalle.PrecioUnitario * facturadetalle.Cantidad) AS Total
FROM
    `emarket`.`facturas`
        INNER JOIN
    clientes ON facturas.ClienteID = clientes.ClienteID
        INNER JOIN
    facturadetalle ON facturas.FacturaID = facturadetalle.FacturaID
GROUP BY facturas.FacturaID
ORDER BY facturas.FechaFactura DESC
LIMIT 10;

-- --------------------------------------------------------------------------------
-- Joins - Consignas I y II.
-- --------------------------------------------------------------------------------
-- Reportes parte I - Repasamos INNER JOIN:
-- Realizar una consulta de la facturación de e-market. 
-- Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad
SELECT 
    f.FacturaID,
    FechaFactura,
    co.Compania,
    c.Contacto,
    CategoriaNombre,
    ProductoNombre,
    fd.PrecioUnitario,
    Cantidad
FROM
    facturas f
        INNER JOIN
    clientes c ON f.clienteID = c.ClienteID
        INNER JOIN
    facturadetalle fd ON f.FacturaID = fd.FacturaID 
        INNER JOIN
    productos p ON fd.ProductoID = p.ProductoID
        INNER JOIN
    correos co ON f.EnvioVia = co.CorreoID
        INNER JOIN
    categorias cat ON p.CategoriaID = cat.CategoriaID;
		

-- Reportes parte II - INNER, LEFT Y RIGHT JOIN:
-- Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.
SELECT 
    *
FROM
    categorias c
        LEFT JOIN
    productos p ON c.CategoriaID = p.CategoriaID;

-- Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.
SELECT 
    contacto
FROM
    clientes cli
        LEFT JOIN
    facturas f ON cli.ClienteID = f.ClienteID
WHERE f.FacturaID IS NULL;

-- Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.
SELECT 
    ProductoNombre,
    CategoriaNombre,
    Contacto
FROM
    productos p
        LEFT JOIN
    categorias cat ON p.CategoriaID = cat.CategoriaID
		LEFT JOIN 
	proveedores pro ON p.ProveedorID = pro.ProveedorID;

-- Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT 
    CategoriaNombre, AVG(PrecioUnitario)
FROM
    categorias c
        INNER JOIN
    productos p ON c.CategoriaID = p.CategoriaID
GROUP BY CategoriaNombre;

-- Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.
SELECT 
    Contacto, MAX(FechaFactura)
FROM
    clientes c
        LEFT JOIN
    facturas f ON c.ClienteID = f.ClienteID
GROUP BY c.ClienteID;

-- Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.
SELECT 
    Compania,
    COUNT(FacturaID)
FROM
    facturas f
        RIGHT JOIN
    correos c ON f.EnvioVia = c.CorreoID
GROUP BY Compania;