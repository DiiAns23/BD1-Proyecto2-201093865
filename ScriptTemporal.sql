CREATE DATABASE IF NOT EXISTS MySQL;
USE MySQL ;

-- -----------------------------------------------------
-- Table Temporal
-- -----------------------------------------------------
DROP TABLE IF EXISTS temporal;
CREATE TABLE IF NOT EXISTS temporal (
  idtemporal INT NOT NULL AUTO_INCREMENT,
  NOMBRE_ELECCION VARCHAR(150) NOT NULL,
  AÑO_ELECCION INT NOT NULL,
  PAIS VARCHAR(45) NOT NULL,
  REGION VARCHAR(45) NOT NULL,
  DEPTO VARCHAR(45) NOT NULL,
  MUNICIPIO VARCHAR(45) NOT NULL,
  PARTIDO VARCHAR(45) NOT NULL,
  NOMBRE_PARTIDO VARCHAR(200) NOT NULL,
  SEXO VARCHAR(45) NOT NULL,
  RAZA VARCHAR(45) NOT NULL,
  ANALFABETOS INT NOT NULL,
  ALFABETOS INT NOT NULL,
  SEXO2 VARCHAR(45) NOT NULL,
  RAZA2 VARCHAR(45) NOT NULL,
  PRIMARIA INT NOT NULL,
  NIVEL_MEDIO INT NOT NULL,
  UNIVERSITARIOS INT NOT NULL,
  PRIMARY KEY (idtemporal)
)ENGINE = InnoDB;
-- Carga Masiva desde consola ---
-- mysql --local-infile=1 -u root -p
-- SET GLOBAL local_infile = 1;
-- LOAD DATA LOCAL INFILE 'C:\\Users\\diego\\OneDrive\\Documentos\\Bases_1\\Laboratorio\\BD1-Proyecto2-201093865\\carga.csv' 
-- INTO TABLE proyecto2.temporal COLUMNS TERMINATED BY ','
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 LINES (NOMBRE_ELECCION,AÑO_ELECCION,PAIS,REGION,DEPTO,MUNICIPIO,PARTIDO,NOMBRE_PARTIDO,SEXO,RAZA,ANALFABETOS,ALFABETOS,SEXO,RAZA,PRIMARIA,NIVEL_MEDIO,UNIVERSITARIOS);
