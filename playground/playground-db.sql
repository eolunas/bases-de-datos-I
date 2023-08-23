-- Desarrollo de una DB para Playground basico:
-- Crear la DB en sql:
CREATE SCHEMA `playground`;
-- Creacion de tablas en sql:
CREATE TABLE `playground`.`categorias` (
    `idcategoria` INT NOT NULL,
    `nombre` VARCHAR(100) NULL,
    PRIMARY KEY (`idcategoria`)
);
CREATE TABLE `playground`.`usuarios` (
    `idusuario` INT NOT NULL,
    `nombre` VARCHAR(100) NULL,
    `apellido` VARCHAR(100) NULL,
    `email` VARCHAR(50) NULL,
    `categoria` INT NULL,
    PRIMARY KEY (`idusuario`),
    INDEX `FKcategoria_id` (`categoria` ASC) VISIBLE,
    CONSTRAINT `FKcategoria`
		FOREIGN KEY (`categoria`)
        REFERENCES `playground`.`categorias` (`idcategoria`)
);
CREATE TABLE `playground`.`carrera` (
    `idcarrera` INT NOT NULL,
    `titulo` VARCHAR(45) NULL,
    `descripcion` VARCHAR(100) NULL,
    PRIMARY KEY (`idcarrera`)
);
CREATE TABLE `playground`.`usuarios_carrera` (
    `id` INT NOT NULL,
    `usuario` INT NULL,
    `carrera` INT NULL,
	`fechainscripcion` DATE NULL,
    PRIMARY KEY (`id`),
    INDEX `usuario_idx` (`usuario` ASC) VISIBLE,
    INDEX `carrera_idx` (`carrera` ASC) VISIBLE,
    CONSTRAINT `usuario`
		FOREIGN KEY (`usuario`)
        REFERENCES `playground`.`usuarios` (`idusuario`),
	CONSTRAINT `carrera`
		FOREIGN KEY (`carrera`)
        REFERENCES `playground`.`carrera` (`idcarrera`)
);
-- Insercion de elementos en tabla en sql:
-- Agregar categorias de "Alumno", "Docente", "Editor" y "Administrador":
INSERT INTO `playground`.`categorias`
(`idcategoria`, `nombre`)
VALUES
(1, "Alumno"),
(2, "Docente"),
(3, "Editor"),
(4, "Administrador");
-- Agregar usuario "Juan Perez" "Alumno" "jperez@gmail.com":
INSERT INTO `playground`.`usuarios`
(`idusuario`,
`nombre`,
`apellido`,
`email`,
`categoria`)
VALUES
(1,
"Juan",
"Perez",
"jpere@gmail.com",
1);
-- Agregar carrera "Certified Tech Developer", "Carrera de programación y desarrollo de productos digitales":
INSERT INTO `playground`.`carrera`
(`idcarrera`,
`titulo`,
`descripcion`)
VALUES
(1,
"Certified Tech Developer",
"Carrera de programación y desarrollo de productos digitales");
-- Agregar fecha de ingreso de juan a CTD el 01/03/2021:
INSERT INTO `playground`.`usuarios_carrera`
(`id`,
`usuario`,
`carrera`,
`fechainscripcion`)
VALUES
(1,
1,
1,
"2021-03-01");
-- Borrar la categoria "Editor":
DELETE FROM `playground`.`categorias` 
WHERE nombre = 'Editor';
-- Borrar una categoria que tenga algun elemento genera error:
DELETE FROM `playground`.`categorias` 
WHERE nombre = 'Alumno';




