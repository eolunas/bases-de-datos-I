-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema companía_aerea
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema companía_aerea
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `companía_aerea` DEFAULT CHARACTER SET utf8 ;
USE `companía_aerea` ;

-- -----------------------------------------------------
-- Table `companía_aerea`.`avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `companía_aerea`.`avion` (
  `matricula` INT NOT NULL,
  `fabricante` VARCHAR(50) NULL,
  `modelo` VARCHAR(50) NULL,
  `capacidad` SMALLINT NULL,
  `autonomia` SMALLINT NULL,
  PRIMARY KEY (`matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `companía_aerea`.`aeropuerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `companía_aerea`.`aeropuerto` (
  `id` CHAR(3) NOT NULL,
  `nombre` VARCHAR(50) NULL,
  `ciudad` VARCHAR(50) NULL,
  `pais` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `companía_aerea`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `companía_aerea`.`vuelo` (
  `id` CHAR(10) NOT NULL,
  `avion_matricula` INT NOT NULL,
  `fecha_hora` DATETIME NULL,
  `aeropuerto_id_origen` CHAR(3) NOT NULL,
  `aeropuerto_id_destino` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vuelo_avion1_idx` (`avion_matricula` ASC) VISIBLE,
  INDEX `fk_vuelo_aeropuerto1_idx` (`aeropuerto_id_origen` ASC) VISIBLE,
  INDEX `fk_vuelo_aeropuerto2_idx` (`aeropuerto_id_destino` ASC) VISIBLE,
  CONSTRAINT `fk_vuelo_avion1`
    FOREIGN KEY (`avion_matricula`)
    REFERENCES `companía_aerea`.`avion` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_aeropuerto1`
    FOREIGN KEY (`aeropuerto_id_origen`)
    REFERENCES `companía_aerea`.`aeropuerto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vuelo_aeropuerto2`
    FOREIGN KEY (`aeropuerto_id_destino`)
    REFERENCES `companía_aerea`.`aeropuerto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
