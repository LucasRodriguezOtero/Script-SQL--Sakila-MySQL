1- Se debe generar un procedimiento para consultar las ventas totales de un empleado: 
Entrada: nombre del empleado
Salida: ventas totales


USE `sakila_es`;
DROP procedure IF EXISTS `ventas_totales`;

DELIMITER $$
USE `sakila_es`$$
CREATE PROCEDURE `ventas_totales` (in p_nombre varchar(15))
BEGIN
select sum(p.total) as Ventas from pago p inner join empleado e on p.id_empleado=e.id_empleado where e.nombre= p_nombre;
END$$

DELIMITER ;

----
2- Se pide generar un stored procedimiento que devuelva un listado de las peliculas en las que actua un determinado actor/actris
Entrada: nombre del ector/actris
Salida: Listado de nombres de película en donde actúa.


USE `sakila_es`;
DROP procedure IF EXISTS `peliculas_por_actor`;

DELIMITER $$
USE `sakila_es`$$
CREATE PROCEDURE `peliculas_por_actor` (in p_nombre varchar(15), p_apellido varchar(15))
BEGIN
select p.titulo as Peliculas_del_Actor from pelicula p inner join pelicula_actor pa on p.id_pelicula=pa.id_pelicula inner join actor a on pa.id_actor=a.id_actor where a.nombre=p_nombre and a.apellidos=p_apellido;
END$$

DELIMITER ;


------

3- Generar un procedimiento para obtener la categoría, el idioma y el número de actores a los que pertenece una película.
Entrada: nombre de la pelicula
Salida: nombre de la pelicula, nombre de la categoría, idioma, cantidad de actores

USE `sakila_es`;
DROP procedure IF EXISTS `informacion_pelicula`;

DELIMITER $$
USE `sakila_es`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `informacion_pelicula`(in p_titulo varchar(30))
BEGIN
select p.titulo as Pelicula, c.nombre as Categoria, i.nombre as Idioma, count(pa.id_actor) as Cantidad_Actores from pelicula p inner join pelicula_categoria pc on p.id_pelicula=pc.id_pelicula 
inner join categoria c on pc.id_categoria=c.id_categoria inner join idioma i on p.id_idioma=i.id_idioma inner join pelicula_actor pa on p.id_pelicula=pa.id_pelicula where p.titulo like p_titulo;
END$$

DELIMITER ;
;





