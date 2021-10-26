SELECT * FROM temporal;
SELECT * FROM R_votos;
SELECT * FROM eleccion;
SELECT * FROM tipo;
SELECT * FROM fecha;
SELECT * FROM pais;
SELECT * FROM partido;


select  nombre, max(porcentaje)
from (
SELECT p.nombre, par.nombre_partido, res.fecha, res.tipo, SUM(voto.alfabetos+voto.analfabetos) as Voto, gen.voto as Total, (SUM(voto.alfabetos+voto.analfabetos)/gen.voto)*100 as Porcentaje
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
INNER JOIN (SELECT p.nombre,  res.fecha, SUM(voto.alfabetos+voto.analfabetos) as Voto
FROM r_votos voto INNER JOIN pais p ON voto.id_pais = p.id_pais
INNER JOIN partido par ON voto.id_partido = par.id_partido
INNER JOIN (SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo) as res ON voto.id_eleccion = res.id_eleccion
GROUP BY p.nombre, res.fecha) as gen ON p.nombre = gen.nombre AND res.fecha = gen.fecha
GROUP BY p.nombre, par.nombre_partido, res.fecha, res.tipo
ORDER BY p.nombre, par.nombre_partido) as bbb
group by  nombre;
 









SELECT  final.tipo, final.fecha, final.nombre, final.nombre_partido,   MAX(final.Porcentaje) FROM 
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
GROUP BY p.nombre, par.nombre_partido, res.fecha, res.tipo
ORDER BY p.nombre, par.nombre_partido) AS final
GROUP BY final.nombre
ORDER BY final.nombre_partido; 




SELECT e.id_eleccion, f.fecha, t.tipo FROM eleccion e INNER JOIN fecha f ON e.id_fecha = f.id_fecha
INNER JOIN tipo t ON e.id_tipo = t.id_tipo
