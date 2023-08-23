-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema universo-lector
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universo-lector` DEFAULT CHARACTER SET utf8 ;
USE `universo-lector` ;

-- -----------------------------------------------------
-- Table `universo-lector`.`socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`socio` (
  `id-socio` INT NOT NULL AUTO_INCREMENT,
  `DNI` INT NOT NULL,
  `apellido` VARCHAR(100) NULL,
  `nombre` VARCHAR(100) NULL,
  `direccion` VARCHAR(200) NULL,
  `localidad` VARCHAR(100) NULL,
  PRIMARY KEY (`id-socio`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`telefono-socio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`telefono-socio` (
  `id-telefono` INT NOT NULL,
  `numero-telefono` VARCHAR(100) NULL,
  `socio_id-socio` INT NOT NULL,
  PRIMARY KEY (`id-telefono`, `socio_id-socio`),
  INDEX `fk_telefono-socio_socio1_idx` (`socio_id-socio` ASC) VISIBLE,
  CONSTRAINT `fk_telefono-socio_socio1`
    FOREIGN KEY (`socio_id-socio`)
    REFERENCES `universo-lector`.`socio` (`id-socio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`autor` (
  `id-autor` INT NOT NULL,
  `apellido` VARCHAR(100) NULL,
  `nombre` VARCHAR(100) NULL,
  PRIMARY KEY (`id-autor`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`editorial` (
  `ideditorial` INT NOT NULL AUTO_INCREMENT,
  `razon-social` VARCHAR(100) NULL,
  `telefono` VARCHAR(100) NULL,
  PRIMARY KEY (`ideditorial`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`libro` (
  `id-libro` INT NOT NULL AUTO_INCREMENT,
  `ISBN` VARCHAR(13) NOT NULL,
  `titulo` VARCHAR(200) NULL,
  `anio_escrito` DATE NULL,
  `anio_edicion` DATE NULL,
  `autor_id-autor` INT NOT NULL,
  `editorial_ideditorial` INT NOT NULL,
  PRIMARY KEY (`id-libro`, `autor_id-autor`, `editorial_ideditorial`),
  INDEX `fk_libro_autor1_idx` (`autor_id-autor` ASC) VISIBLE,
  INDEX `fk_libro_editorial1_idx` (`editorial_ideditorial` ASC) VISIBLE,
  CONSTRAINT `fk_libro_autor1`
    FOREIGN KEY (`autor_id-autor`)
    REFERENCES `universo-lector`.`autor` (`id-autor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_libro_editorial1`
    FOREIGN KEY (`editorial_ideditorial`)
    REFERENCES `universo-lector`.`editorial` (`ideditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`prestamo` (
  `id-prestamo` INT NOT NULL,
  `socio_id-socio` INT NOT NULL,
  `fecha` DATETIME NULL,
  `fecha-devolucion` DATETIME NULL,
  `fecha-tope` DATETIME NULL,
  PRIMARY KEY (`id-prestamo`, `socio_id-socio`),
  INDEX `fk_prestamo_socio1_idx` (`socio_id-socio` ASC) VISIBLE,
  CONSTRAINT `fk_prestamo_socio1`
    FOREIGN KEY (`socio_id-socio`)
    REFERENCES `universo-lector`.`socio` (`id-socio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`volumen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`volumen` (
  `id-volumen` INT NOT NULL,
  `libro_id-libro` INT NOT NULL,
  `deteriorado` TINYINT(1) NULL,
  PRIMARY KEY (`id-volumen`, `libro_id-libro`),
  INDEX `fk_volumen_libro1_idx` (`libro_id-libro` ASC) VISIBLE,
  CONSTRAINT `fk_volumen_libro1`
    FOREIGN KEY (`libro_id-libro`)
    REFERENCES `universo-lector`.`libro` (`id-libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `universo-lector`.`prestamo_has_volumen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universo-lector`.`prestamo_has_volumen` (
  `prestamo_id-prestamo` INT NOT NULL,
  `volumen_id-volumen` INT NOT NULL,
  PRIMARY KEY (`prestamo_id-prestamo`, `volumen_id-volumen`),
  INDEX `fk_prestamo_has_volumen_volumen1_idx` (`volumen_id-volumen` ASC) VISIBLE,
  INDEX `fk_prestamo_has_volumen_prestamo1_idx` (`prestamo_id-prestamo` ASC) VISIBLE,
  CONSTRAINT `fk_prestamo_has_volumen_prestamo1`
    FOREIGN KEY (`prestamo_id-prestamo`)
    REFERENCES `universo-lector`.`prestamo` (`id-prestamo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestamo_has_volumen_volumen1`
    FOREIGN KEY (`volumen_id-volumen`)
    REFERENCES `universo-lector`.`volumen` (`id-volumen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert And Queries universo-lector
-- -----------------------------------------------------
-- Insercion de socios y telefonos:
INSERT INTO `universo-lector`.`socio`
(`id-socio`, `DNI`, `apellido`, `nombre`, `direccion`, `localidad`)
VALUES
(1,	3000000, "PATRICIA", "JOHNSON", "28 MySQL Boulevard", "QLD"),
(2,	2988800, "LINDA", "WILLIAMS", "23 Workhaven Lane", "Alberta"),
(3,	2500000, "BARBARA", "JONES", "1411 Lillydale Drive", "QLD"),
(4,	32980002, "LOIS", "BUTLER", "1688 Okara Way", "Nothwest Border Prov"),
(5,	2313909, "ROBIN", "HAYES", "262 A Corua (La Corua) Parkway", "Dhaka");
INSERT INTO `universo-lector`.`telefono-socio`
(`id-telefono`, `numero-telefono`, `socio_id-socio`)
VALUES
(1, "54911-45636453", 1),
(2, "54-11-47867654", 2),
(3, "11498-2173", 3),
(4, "11684736", 4),
(5, "2645887755", 5);

-- Insercion autor:
INSERT INTO `universo-lector`.`autor`
(`id-autor`, `apellido`, `nombre`)
VALUES
(1, "Rowling", "J. K.");

-- Insercion editoriales:
INSERT INTO `universo-lector`.`editorial`
(`ideditorial`, `razon-social`, `telefono`)
VALUES
(1, "Bloomsbury Publishing", "54911564874"),
(2, "Scholastic", "223483646"),
(3, "Pottermore Limited", "5694839582"),
(4, "Editorial Salamandra", "011-239-2343");

-- Insercion libro:
INSERT INTO `universo-lector`.`libro`
(`id-libro`, `ISBN`, `titulo`, `anio_escrito`, `anio_edicion`, `autor_id-autor`, `editorial_ideditorial`)
VALUES
(1,	9781907545009, "Harry Potter y la piedra filosofal", "1997-01-01", "1997-01-01", 1, 4),
(2,	9789878000114, "Harry Potter Y La Camara Secreta", "2020-01-01", "2020-01-01", 1, 4);

-- Insercion volumen (copia):
INSERT INTO `universo-lector`.`volumen`
(`id-volumen`, `libro_id-libro`, `deteriorado`)
VALUES
(1, 1, 0),
(2, 1, 0),
(3, 2, 0);

-- Insercion prestamo:
INSERT INTO `universo-lector`.`prestamo`
(`id-prestamo`, `socio_id-socio`, `fecha`, `fecha-devolucion`, `fecha-tope`)
VALUES
(1, 1, "2020-01-01", "2020-01-07", "2020-01-07"),
(2, 1, "2020-01-07", "2020-01-15", "2020-01-14"),
(3, 2, "2020-03-04", "2020-03-08", "2020-03-11");

-- Insercion prestamoxvolumen:
INSERT INTO `universo-lector`.`prestamo_has_volumen`
(`prestamo_id-prestamo`, `volumen_id-volumen`)
VALUES
(1, 1),
(2, 2),
(3,	1),
(3,	3);

-- Borrado de socio:
SELECT * FROM `universo-lector`.`socio`;
DELETE FROM `universo-lector`.`socio`
WHERE `id-socio` = 1;

-- Borrado de libro:
SELECT * FROM `universo-lector`.libro;
DELETE FROM `universo-lector`.`libro`
WHERE `id-libro` = 1;

-- Actualizar un socio:
SELECT * FROM `universo-lector`.socio;
UPDATE `universo-lector`.`socio`
SET
`apellido` = "JOHNSON",
`nombre` = "PATRICIA"
WHERE `id-socio` = 1;






