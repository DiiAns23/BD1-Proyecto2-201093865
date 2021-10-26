USE proyecto2;

DROP TABLE IF EXISTS R_votos ;
DROP TABLE IF EXISTS Edad;
DROP TABLE IF EXISTS Sexo ;
DROP TABLE IF EXISTS Raza ;
DROP TABLE IF EXISTS Partido ;
DROP TABLE IF EXISTS Eleccion ;
DROP TABLE IF EXISTS Fecha ;
DROP TABLE IF EXISTS Tipo ;
DROP TABLE IF EXISTS Municipio ;
DROP TABLE IF EXISTS Departamento ;
DROP TABLE IF EXISTS Region ;
DROP TABLE IF EXISTS Pais ;

-- -----------------------------------------------------
-- Table Pais
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pais (
  id_pais INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_pais))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Region
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Region (
  id_region INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  id_pais INT NOT NULL,
  PRIMARY KEY (id_region),
  INDEX fk_Region_Pais1_idx (id_pais ASC),
  CONSTRAINT fk_Region_Pais1
    FOREIGN KEY (id_pais)
    REFERENCES Pais (id_pais)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Departamento
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Departamento (
  id_departamento INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  id_region INT NOT NULL,
  PRIMARY KEY (id_departamento),
  INDEX fk_Departamento_Region1_idx (id_region ASC),
  CONSTRAINT fk_Departamento_Region1
    FOREIGN KEY (id_region)
    REFERENCES Region (id_region)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Municipio
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Municipio (
  id_municipio INT NOT NULL AUTO_INCREMENT,
  id_departamento INT NOT NULL,
  nombre VARCHAR(45) NULL,
  PRIMARY KEY (id_municipio),
  INDEX fk_Municipio_Departamento1_idx (id_departamento ASC),
  CONSTRAINT fk_Municipio_Departamento1
    FOREIGN KEY (id_departamento)
    REFERENCES Departamento (id_departamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Tipo
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Tipo (
  id_tipo INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(45) NULL,
  PRIMARY KEY (id_tipo))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Fecha
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Fecha (
  id_fecha INT NOT NULL AUTO_INCREMENT,
  fecha INT NULL,
  PRIMARY KEY (id_fecha))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Eleccion
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Eleccion (
  id_eleccion INT NOT NULL AUTO_INCREMENT,
  id_tipo INT NOT NULL,
  id_fecha INT NOT NULL,
  PRIMARY KEY (id_eleccion),
  INDEX fk_Eleccion_Tipo1_idx (id_tipo ASC),
  INDEX fk_Eleccion_Fecha1_idx (id_fecha ASC),
  CONSTRAINT fk_Eleccion_Tipo1
    FOREIGN KEY (id_tipo)
    REFERENCES Tipo (id_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Eleccion_Fecha1
    FOREIGN KEY (id_fecha)
    REFERENCES Fecha (id_fecha)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Partido
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Partido (
  id_partido INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  nombre_partido VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_partido))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Raza
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Raza (
  id_raza INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_raza))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Sexo
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Sexo (
  id_sexo INT NOT NULL AUTO_INCREMENT,
  sexo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_sexo))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Edad
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Edad (
  id_edad INT NOT NULL AUTO_INCREMENT,
  edad VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_edad))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table R_votos
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS R_votos (
  id_r_votos INT NOT NULL AUTO_INCREMENT,
  id_eleccion INT NOT NULL,
  id_municipio INT NOT NULL,
  id_departamento INT NOT NULL,
  id_region INT NOT NULL,
  id_pais INT NOT NULL,
  id_partido INT NOT NULL,
  id_raza INT NOT NULL,
  id_sexo INT NOT NULL,
  analfabetos INT NOT NULL,
  alfabetos INT NOT NULL,
  primaria INT NOT NULL,
  medio INT NOT NULL,
  universitario INT NOT NULL,
  PRIMARY KEY (id_r_votos),
  INDEX fk_R_votos_Eleccion1_idx (id_eleccion ASC),
  INDEX fk_R_votos_Partido1_idx (id_partido ASC),
  INDEX fk_R_votos_Raza1_idx (id_raza ASC),
  INDEX fk_R_votos_Sexo1_idx (id_sexo ASC),
  INDEX fk_R_votos_Municipio1_idx (id_municipio ASC),
  CONSTRAINT fk_R_votos_Eleccion1
    FOREIGN KEY (id_eleccion)
    REFERENCES Eleccion (id_eleccion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_R_votos_Partido1
    FOREIGN KEY (id_partido)
    REFERENCES Partido (id_partido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_R_votos_Raza1
    FOREIGN KEY (id_raza)
    REFERENCES Raza (id_raza)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_R_votos_Sexo1
    FOREIGN KEY (id_sexo)
    REFERENCES Sexo (id_sexo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_R_votos_Municipio1
    FOREIGN KEY (id_municipio)
    REFERENCES Municipio (id_municipio)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
