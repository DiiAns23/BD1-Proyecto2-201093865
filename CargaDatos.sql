-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
USE MySQL;
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--  -----------------------------------------------------
-- Llenado de Paises
-- -----------------------------------------------------
INSERT INTO pais (nombre)
SELECT DISTINCT pais FROM temporal; 

-- -----------------------------------------------------
-- Llenado de Regiones
-- -----------------------------------------------------
INSERT INTO region (nombre, id_pais)
SELECT DISTINCT region, p.id_pais FROM temporal t, pais p
WHERE
	t.pais = p.nombre
;

-- -----------------------------------------------------
-- Llenado de Departamentos
-- -----------------------------------------------------
INSERT INTO departamento (nombre, id_region)
SELECT DISTINCT depto, r.id_region FROM temporal t, pais p, region r
WHERE
	t.pais = p.nombre AND
    r.nombre = t.region AND
    r.id_pais = p.id_pais
    
;

-- -----------------------------------------------------
-- Llenado de Municipios
-- -----------------------------------------------------
INSERT INTO municipio (nombre, id_departamento)
SELECT DISTINCT municipio, d.id_departamento FROM temporal t, pais p, region r, departamento d
WHERE
	t.pais = p.nombre AND
    r.nombre = t.region AND
    t.depto = d.nombre AND
    p.id_pais = r.id_pais AND
    d.id_region = r.id_region
;

-- -----------------------------------------------------
-- Llenado de Tipos
-- -----------------------------------------------------
INSERT INTO tipo (tipo)
SELECT DISTINCT nombre_eleccion FROM temporal;

-- -----------------------------------------------------
-- Llenado de Fechas
-- -----------------------------------------------------
INSERT INTO fecha (fecha)
SELECT DISTINCT año_eleccion FROM temporal;

-- -----------------------------------------------------
-- Llenado de Elecciones
-- -----------------------------------------------------
INSERT INTO eleccion (id_tipo, id_fecha)
SELECT DISTINCT tipo.id_tipo, fecha.id_fecha FROM temporal t, tipo, fecha
WHERE
	t.año_eleccion = fecha.fecha AND
    t.nombre_eleccion = tipo.tipo
;
-- -----------------------------------------------------
-- Llenado de Partidos
-- -----------------------------------------------------
INSERT INTO partido (nombre, nombre_partido)
SELECT DISTINCT partido, nombre_partido FROM temporal t;

-- -----------------------------------------------------
-- Llenado de Razas
-- -----------------------------------------------------
INSERT INTO raza (nombre)
SELECT DISTINCT raza FROM temporal t;

-- -----------------------------------------------------
-- Llenado de Sexo
-- -----------------------------------------------------
INSERT INTO sexo (sexo)
SELECT DISTINCT sexo FROM temporal t;

-- -----------------------------------------------------
-- Llenado de Votos
-- -----------------------------------------------------
INSERT INTO R_votos (id_eleccion, id_municipio, id_departamento, id_region, id_pais, id_partido, id_raza, id_sexo, analfabetos, alfabetos, primaria, medio, universitario) 
SELECT DISTINCT e.id_eleccion, m.id_municipio,d.id_departamento, re.id_region, re.id_pais, p.id_partido, r.id_raza, s.id_sexo, t.analfabetos, t.alfabetos, t.primaria, t.nivel_medio, t.universitarios 
FROM eleccion e, municipio m, partido p, raza r, sexo s, temporal t, tipo ti, fecha f, pais pa, region re, departamento d
WHERE
	t.nombre_eleccion = ti.tipo AND
    ti.id_tipo = e.id_tipo AND
    t.año_eleccion = f.fecha AND
    f.id_fecha = e.id_fecha AND
    t.municipio = m.nombre AND
    m.id_departamento = d.id_departamento AND
    t.depto = d.nombre AND
    d.id_region = re.id_region AND
    t.region = re.nombre AND
    re.id_pais = pa.id_pais AND
    t.pais = pa.nombre AND
    t.partido = p.nombre AND
    t.nombre_partido = p.nombre_partido AND
    t.sexo = s.sexo AND
    t.raza = r.nombre
;

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------








