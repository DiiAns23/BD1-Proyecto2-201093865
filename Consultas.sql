USE MySQL;
-- ------------------------------------------------
-- ------------------------------------------------
-- ------------------------------------------------

-- ------------------------------------------------
-- CONSULTA NO. 1
-- ------------------------------------------------
SELECT Tfinal.tipo, Tfinal.nombre, Tfinal.fecha, Tfinal.nombre_partido, Tfinal.porcentaje FROM (SELECT final.nombre, MAX(final.Porcentaje) as Porcentaje FROM 
(SELECT p.nombre, par.nombre_partido, res.fecha, res.tipo, SUM(voto.alfabetos+voto.analfabetos) as Voto, gen.voto as Total, (SUM(voto.alfabetos+voto.analfabetos)/gen.voto)*100 as Porcentaje
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
INNER JOIN (SELECT p.nombre,res.fecha, SUM(voto.alfabetos+voto.analfabetos) as Voto
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
GROUP BY p.nombre, res.fecha) as gen ON p.nombre = gen.nombre AND res.fecha = gen.fecha 
GROUP BY p.nombre, par.nombre_partido, res.fecha, res.tipo) AS final
GROUP BY final.nombre) as generali INNER JOIN (SELECT p.nombre, par.nombre_partido, res.fecha, res.tipo, SUM(voto.alfabetos+voto.analfabetos) as Voto, gen.voto as Total, (SUM(voto.alfabetos+voto.analfabetos)/gen.voto)*100 as Porcentaje
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
INNER JOIN (SELECT p.nombre,res.fecha, SUM(voto.alfabetos+voto.analfabetos) as Voto
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
GROUP BY p.nombre, res.fecha) as gen ON p.nombre = gen.nombre AND res.fecha = gen.fecha 
GROUP BY p.nombre, par.nombre_partido, res.fecha, res.tipo) as Tfinal ON generali.nombre = Tfinal.nombre AND generali.Porcentaje = Tfinal.porcentaje;

-- ------------------------------------------------
-- CONSULTA NO. 2
-- ------------------------------------------------

SELECT Datos.Pais, Datos.nombre as Departamento, Datos.Votos, CONCAT( (Datos.Votos/Totales.Votos)*100, '%') AS Porcentaje FROM (SELECT pa.nombre as Pais,depto.nombre, SUM(voto.analfabetos+voto.alfabetos) as Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN departamento depto ON voto.id_departamento = depto.id_departamento
WHERE voto.id_sexo = 2
GROUP BY pa.nombre, depto.nombre) as Datos INNER JOIN (SELECT pa.nombre, SUM(voto.analfabetos+voto.alfabetos) as Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN departamento depto ON voto.id_departamento = depto.id_departamento
WHERE voto.id_sexo = 2
GROUP BY pa.nombre) as Totales ON Datos.Pais = Totales.nombre
;

-- ------------------------------------------------
-- CONSULTA NO. 3
-- ------------------------------------------------

-- ------------------------------------------------
-- CONSULTA NO. 4
-- ------------------------------------------------
SELECT Datos.pais as Pais, Datos.region as Region, Datos.raza as Raza, Datos.votos as Votos_Totales FROM (
SELECT pa.nombre as pais, reg.nombre as region,raza.nombre as raza, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre, reg.nombre, raza.nombre
ORDER BY 1) as Datos 
INNER JOIN (
SELECT datos.pais, datos.region, MAX(datos.votos) as Votos FROM (
SELECT pa.nombre as pais, reg.nombre as region,raza.nombre as raza, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre, reg.nombre, raza.nombre) as datos
GROUP BY datos.pais, datos.region
ORDER BY 1) as Maximo ON Datos.pais = Maximo.pais AND Datos.region = Maximo.region AND Datos.votos = Maximo.votos
WHERE Datos.Raza = 'INDIGENAS'
ORDER BY 4
;
-- ------------------------------------------------
-- CONSULTA NO. 5
-- ------------------------------------------------

-- ------------------------------------------------
-- CONSULTA NO. 6
-- ------------------------------------------------

SELECT man.depto, fem.votos as Mujeres, man.votos as Hombres FROM (
SELECT totales.depto as Depto, hombres.sexo as Sexo, (hombres.votos/totales.votos)*100 as Votos FROM
(SELECT depto.nombre as Depto,sex.sexo as Sexo, SUM(voto.universitario) as Votos  FROM r_votos voto 
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN sexo sex ON sex.id_sexo = 1
WHERE voto.id_sexo = 1
GROUP BY 1,2
) as hombres 
INNER JOIN (
SELECT depto.nombre as Depto, SUM(voto.universitario) as Votos  FROM r_votos voto 
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
GROUP BY 1
) as totales ON totales.Depto = hombres.Depto
) AS man INNER JOIN (
SELECT totales.depto as Depto, mujeres.sexo as Sexo, (mujeres.votos/totales.votos)*100 as Votos FROM
(SELECT depto.nombre as Depto,sex.sexo as Sexo, SUM(voto.universitario) as Votos  FROM r_votos voto 
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN sexo sex ON sex.id_sexo = 2
WHERE voto.id_sexo = 2
GROUP BY 1,2
) as mujeres 
INNER JOIN (
SELECT depto.nombre as Depto, SUM(voto.universitario) as Votos  FROM r_votos voto 
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
GROUP BY 1
) as totales ON totales.Depto = mujeres.Depto
) AS fem ON man.depto = fem.depto AND fem.votos > man.votos
ORDER BY 1
;


-- ------------------------------------------------
-- CONSULTA NO. 7
-- ------------------------------------------------

SELECT totales.pais as Pais, totales.region as Region, (totales.votos/cantidades.cantidad) FROM 
(
SELECT pa.nombre as Pais, reg.nombre as Region,SUM(voto.analfabetos+voto.alfabetos) as Votos FROM r_votos voto 
INNER JOIN departamento depto ON voto.id_departamento = depto.id_departamento
INNER JOIN region reg ON voto.id_region = reg.id_region
INNER JOIN pais pa ON voto.id_pais = pa.id_pais
GROUP BY 1,2
) AS totales INNER JOIN 
(
SELECT pa.nombre as Pais, reg.nombre as Region, COUNT(depto.nombre) AS Cantidad FROM departamento depto, region reg, pais pa
WHERE depto.id_region = reg.id_region AND
reg.id_pais = pa.id_pais
GROUP BY 1,2
ORDER BY 1,2
) as cantidades ON totales.pais = cantidades.pais AND totales.region = cantidades.region
ORDER BY 1
;

-- ------------------------------------------------
-- CONSULTA NO. 8
-- ------------------------------------------------

SELECT pa.nombre as Pais, SUM(voto.primaria) as Primaria, SUM(voto.medio) as Medio, SUM(voto.universitario) as Universitario FROM r_votos voto 
INNER JOIN pais pa ON pa.id_pais = voto.id_pais
GROUP BY 1
;
-- ------------------------------------------------
-- CONSULTA NO. 9
-- ------------------------------------------------

SELECT Datos.pais as Pais, datos.raza as Raza, (datos.votos/totales.votos)*100 AS Porcentaje FROM
(SELECT pa.nombre as pais,raza.nombre as raza, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre, raza.nombre) AS Datos INNER JOIN (SELECT pa.nombre as pais, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre) AS Totales ON datos.pais = totales.pais
ORDER BY 1,3
;

-- ------------------------------------------------
-- CONSULTA NO. 11
-- ------------------------------------------------
SELECT Votos.Pais, Votos.Votos, (Votos.Votos/Totales.Votos)*100 as Porcentaje FROM
(SELECT pa.nombre as Pais, SUM(voto.alfabetos) as Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
WHERE voto.id_sexo = 2 AND voto.id_raza = 1
GROUP BY pa.nombre) as Votos INNER JOIN (
SELECT pa.nombre as pais, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre) AS Totales ON Totales.pais = Votos.pais
;

-- ------------------------------------------------
-- CONSULTA NO. 12
-- ------------------------------------------------
SELECT Datos.Pais, (Datos.Votos/Totales.Votos)*100 as Porcentaje FROM (
SELECT pa.nombre as Pais, SUM(voto.analfabetos) as Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
GROUP BY pa.nombre) as Datos INNER JOIN (
SELECT pa.nombre as pais, SUM(voto.analfabetos+voto.alfabetos) as votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN region reg ON reg.id_region = voto.id_region
INNER JOIN departamento depto ON depto.id_departamento = voto.id_departamento
INNER JOIN municipio mun ON mun.id_municipio = voto.id_municipio
INNER JOIN raza raza ON raza.id_raza = voto.id_raza
GROUP BY pa.nombre) as Totales ON Datos.Pais = Totales.Pais
ORDER BY 2 DESC
LIMIT 1
;

-- ------------------------------------------------
-- CONSULTA NO. 13
-- ------------------------------------------------
SELECT datos.pais, datos.depto, datos.votos FROM(
SELECT pa.nombre as Pais, depto.nombre Depto, SUM(voto.analfabetos+voto.alfabetos) Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN departamento depto ON voto.id_departamento = depto.id_departamento
WHERE pa.nombre = 'GUATEMALA'
GROUP BY 1,2) as Datos INNER JOIN (
SELECT pa.nombre as Pais, depto.nombre Depto, SUM(voto.analfabetos+voto.alfabetos) Votos FROM r_votos voto INNER JOIN pais pa ON voto.id_pais = pa.id_pais
INNER JOIN departamento depto ON voto.id_departamento = depto.id_departamento
WHERE pa.nombre = 'GUATEMALA' AND depto.nombre = 'Guatemala'
GROUP BY 1,2) as Guate ON datos.votos > Guate.votos
;

-- ------------------------------------------------
-- ------------------------------------------------
-- ------------------------------------------------