-- Consultas queries ML - Parte I:
-- Categorias y productos:
SELECT * FROM `emarket`.`categorias`;
SELECT CategoriaNombre, Descripcion FROM `emarket`.`categorias`;
SELECT * FROM `emarket`.`productos`;
SELECT * FROM `emarket`.`productos` WHERE Discontinuado = 1;
SELECT * FROM `emarket`.`productos` WHERE ProveedorID = 8;
SELECT * FROM `emarket`.`productos` WHERE PrecioUnitario BETWEEN 10 AND 22;
SELECT * FROM `emarket`.`productos` WHERE UnidadesStock < NivelReorden;
SELECT * FROM `emarket`.`productos` WHERE UnidadesPedidas = 0;

-- Clientes:
SELECT Contacto, Compania, Titulo, Pais FROM `emarket`.`clientes` ORDER BY pais;
SELECT * FROM `emarket`.`clientes` WHERE Titulo = "Owner";
SELECT * FROM `emarket`.`clientes` WHERE Contacto LIKE "C%";

-- Facturas:
SELECT * FROM `emarket`.`facturas` ORDER BY FechaFactura;
SELECT * FROM `emarket`.`facturas` WHERE PaisEnvio = 'USA' AND EnvioVia != 3;
SELECT * FROM `emarket`.`facturas` WHERE ClienteID = 'GOURL';
SELECT * FROM `emarket`.`facturas` WHERE EmpleadoID IN (2, 3, 5, 8, 9);

-- Consultas queries ML - Parte II:
-- Productos:
SELECT * FROM `emarket`.`productos` ORDER BY PrecioUnitario DESC;
SELECT * FROM `emarket`.`productos` ORDER BY PrecioUnitario DESC LIMIT 5;
SELECT * FROM `emarket`.`productos` ORDER BY UnidadesStock DESC LIMIT 10;

-- FacturaDetalle:
SELECT FacturaID, ProductoID, Cantidad FROM `emarket`.`facturadetalle`;
SELECT FacturaID, ProductoID, Cantidad FROM `emarket`.`facturadetalle` ORDER BY Cantidad DESC;
SELECT FacturaID, ProductoID, Cantidad FROM `emarket`.`facturadetalle` WHERE Cantidad BETWEEN 50 AND 100 ORDER BY Cantidad DESC;
SELECT FacturaID AS NroFactura, ProductoID AS Producto, PrecioUnitario*Cantidad AS Total FROM `emarket`.`facturadetalle` ; 

-- EXTRAS:
SELECT * FROM `emarket`.`clientes` WHERE Pais IN ('Brazil', 'Mexico') OR Titulo LIKE 'Sales%';
SELECT * FROM `emarket`.`clientes` WHERE Compania LIKE 'A%';
SELECT Ciudad, Contacto AS 'Apellido y nombre', Titulo AS 'Puesto' FROM `emarket`.`clientes` WHERE Ciudad = 'Madrid';
SELECT * FROM `emarket`.`facturas` WHERE FacturaID BETWEEN 10000 AND 10500;
SELECT * FROM `emarket`.`facturas` WHERE FacturaID BETWEEN 10000 AND 10500 OR ClienteID LIKE 'B%';
SELECT * FROM `emarket`.`facturas` WHERE CiudadEnvio = "Vancouver" OR EnvioVia = 3;
SELECT EmpleadoID, Apellido FROM `emarket`.`empleados` WHERE Apellido = "Buchanan";
SELECT * FROM `emarket`.`facturas` WHERE EmpleadoID = 5;
