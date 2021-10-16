CREATE DATABASE IF NOT EXISTS proyecto2;
USE proyecto2 ;

-- -----------------------------------------------------
-- Table Temporal
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS temporal (
  idtemporal INT NOT NULL,
  NOMBRE_ELECCION VARCHAR(150) NOT NULL,
  ANIO_ELECCION INT NOT NULL,
  REGION VARCHAR(45) NOT NULL,
  DEPTO VARCHAR(45) NOT NULL,
  MUNICIPIO VARCHAR(45) NOT NULL,
  PARTIDO VARCHAR(45) NOT NULL,
  NOMBRE_PARTIDO VARCHAR(200) NOT NULL,
  SEXO VARCHAR(45) NOT NULL,
  RAZA VARCHAR(45) NOT NULL,
  ANALFABETOS INT NOT NULL,
  ALFABETOS INT NOT NULL,
  PRIMARIA INT NOT NULL,
  NIVEL_MEDIO INT NOT NULL,
  UNIVERSITARIOS INT NOT NULL,
  PRIMARY KEY (idtemporal)
)ENGINE = InnoDB;

