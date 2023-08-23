-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salud-dh
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salud-dh
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salud-dh` DEFAULT CHARACTER SET utf8 ;
USE `salud-dh` ;

-- -----------------------------------------------------
-- Table `salud-dh`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salud-dh`.`paciente` (
  `idpaciente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  UNIQUE INDEX `idpaciente_UNIQUE` (`idpaciente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salud-dh`.`especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salud-dh`.`especialidad` (
  `idespecialidad` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idespecialidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salud-dh`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salud-dh`.`medico` (
  `idmedico` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `especialidad_idespecialidad` INT NOT NULL,
  PRIMARY KEY (`idmedico`),
  UNIQUE INDEX `idpaciente_UNIQUE` (`idmedico` ASC) VISIBLE,
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) VISIBLE,
  INDEX `fk_medico_especialidad_idx` (`especialidad_idespecialidad` ASC) VISIBLE,
  CONSTRAINT `fk_medico_especialidad`
    FOREIGN KEY (`especialidad_idespecialidad`)
    REFERENCES `salud-dh`.`especialidad` (`idespecialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salud-dh`.`turnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salud-dh`.`turnos` (
  `idturnos` INT NOT NULL,
  `medico_idmedico` INT NOT NULL,
  `paciente_idpaciente` INT NOT NULL,
  PRIMARY KEY (`idturnos`),
  INDEX `fk_turnos_medico1_idx` (`medico_idmedico` ASC) VISIBLE,
  INDEX `fk_turnos_paciente1_idx` (`paciente_idpaciente` ASC) VISIBLE,
  CONSTRAINT `fk_turnos_medico1`
    FOREIGN KEY (`medico_idmedico`)
    REFERENCES `salud-dh`.`medico` (`idmedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turnos_paciente1`
    FOREIGN KEY (`paciente_idpaciente`)
    REFERENCES `salud-dh`.`paciente` (`idpaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
