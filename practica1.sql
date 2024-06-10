USE `sakila_es`;
DROP procedure IF EXISTS `Cantidad_peliculas`;

DELIMITER $$
USE `sakila_es`$$
CREATE PROCEDURE `Cantidad_peliculas` (in p_nombre varchar(20), p_apellido varchar(20) )
BEGIN
SELECT a.nombre, a.apellidos, count(p.id_pelicula) as cantidad FROM actor a left join pelicula_actor p on a.id_actor=p.id_actor left join pelicula pe on pe.id_pelicula=p.id_pelicula where a.nombre=p_nombre and a.apellidos=p_apellido;
END$$

DELIMITER ;



-----

USE `sakila_es`;
DROP procedure IF EXISTS `Cantidad_peliculas`;

DELIMITER $$
USE `sakila_es`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Promedio_categoria`(in p_categoria varchar(15))
BEGIN
SELECT c.nombre as Categoria, round(AVG(p.duracion),2) as Duracion from categoria c right join pelicula_categoria pc on c.id_categoria=pc.id_categoria right join pelicula p on pc.id_pelicula=p.id_pelicula where c.nombre=p_categoria;
END

DELIMITER ;

------

USE `sakila_es`;
DROP procedure IF EXISTS `Ciudad_nombre_compuesto`;

USE `sakila_es`;
DROP procedure IF EXISTS `sakila_es`.`Ciudad_nombre_compuesto`;
;

DELIMITER $$
USE `sakila_es`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ciudad_nombre_compuesto`()
BEGIN
select c.nombre as Ciudad, p.nombre as Pais from ciudad c inner join pais p on  c.id_pais=p.id_pais where c.nombre like "% %"order by c.nombre;
END$$

DELIMITER ;
;



