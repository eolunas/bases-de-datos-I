-- ---------------------------------------------------------------------------------------------
-- Stored procedures
-- ---------------------------------------------------------------------------------------------
-- Empleados: 
-- a) Crear un SP que liste los apellidos y nombres de los empleados ordenados alfabéticamente.
DELIMITER $$
CREATE PROCEDURE orderWorkerByName()
BEGIN
	SELECT 
    Apellido, Nombre
FROM
    empleados
ORDER BY Apellido , Nombre;
END $$ 
-- b) Invocar el SP para verificar el resultado.
CALL orderWorkerByName();

-- Empleados por ciudad:
-- a) Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa ciudad.
DELIMITER $$
CREATE PROCEDURE getWorkerByCity(IN city VARCHAR(20))
BEGIN
	SELECT 
    Apellido, Nombre
FROM
    empleados
WHERE
    Ciudad = city
ORDER BY Apellido , Nombre;
END $$ 
-- b) Invocar al SP para listar los empleados de Seattle.
CALL getWorkerByCity("Seattle");

-- Clientes por país:
-- a) Crear un SP que reciba el nombre de un país y devuelva la cantidad de clientes en ese país.
DELIMITER $$
CREATE PROCEDURE getTotalCustomers(IN country VARCHAR(20), OUT totalCustomers INT)
BEGIN
	SELECT 
    COUNT(*) INTO totalCustomers
FROM
    clientes
GROUP BY Pais
HAVING Pais = "Portugal";
END $$ 
-- b) Invocar el SP para consultar la cantidad de clientes en Portugal.
CALL getTotalCustomers("Portugal", @totalCustomers);
SELECT @totalCustomers;

-- Productos sin stock:
-- a) Crear un SP que reciba un número y liste los productos cuyo stock está por debajo de ese 
-- número. El resultado debe mostrar el nombre del producto, el stock actual y el nombre de la 
-- categoría a la que pertenece el producto.
DELIMITER $$
CREATE PROCEDURE getProductsByStock(IN minStock INT)
BEGIN
	SELECT 
    ProductoNombre, UnidadesStock, CategoriaNombre
FROM
    productos p
        INNER JOIN
    categorias c ON c.CategoriaID = p.CategoriaID
WHERE
    UnidadesStock <= minStock;
END $$ 
-- b) Listar los productos con menos de 10 unidades en stock.
CALL getProductsByStock(10);
-- c) Listar los productos sin stock.
CALL getProductsByStock(0);

-- Ventas con descuento:
-- a) Crear un SP que reciba un porcentaje y liste los nombres de los productos que hayan sido
-- vendidos con un descuento igual o superior al valor indicado, indicando además el nombre del
-- cliente al que se lo vendió.

DELIMITER $$
CREATE PROCEDURE getProductsByPercentage(IN percentage INT)
BEGIN
	SELECT 
    p.ProductoNombre, fd.Descuento, c.Compania
FROM
    emarket.facturadetalle fd
        INNER JOIN
    productos p ON p.ProductoID = fd.ProductoID
		INNER JOIN 
	facturas f ON f.FacturaID = fd.FacturaID
		INNER JOIN
	clientes c ON c.ClienteID = f.ClienteID
WHERE Descuento >= percentage/100;
END $$ 
-- b) Listar información de los productos que hayan sido vendidos con un descuento mayor al 10%.
CALL getProductsByPercentage(10);