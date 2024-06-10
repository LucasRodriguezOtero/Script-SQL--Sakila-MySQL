1- Realizar una función que devuelva el promedio de duración de todas las películas de una determinada categoría que deberá ingresarse como parámetro.

USE `sakila_es`;
DROP function IF EXISTS `promedio`;

DELIMITER $$
USE `sakila_es`$$
CREATE FUNCTION `promedio` (p_titulo varchar(50))
RETURNS decimal (6,2)
BEGIN
declare promedio decimal(6,2);
set promedio= (select avg(p.duracion) from pelicula p inner join pelicula_categoria pc on p.id_pelicula=pc.id_pelicula inner join categoria c on pc.id_categoria=c.id_categoria where c.nombre="Action");

RETURN promedio;
END$$

DELIMITER ;

-----

2- Realizar una función de devuelva a que genero pertenecen la mayoria de peliculas en las que aparece determinado actor. Entradas nombre y apellido del actor, resultado el nombre del genero en el que aparece más dicho actor.

USE `sakila_es`;
DROP function IF EXISTS `mayor_genero_por_actor`;

DELIMITER $$
USE `sakila_es`$$
CREATE FUNCTION `mayor_genero_por_actor` (p_nombre varchar (50), p_apellido varchar(50))
RETURNS varchar(50)
BEGIN
DECLARE mayor_genero varchar(50);

set mayor_genero=(Select x.nombre from (Select count(c.nombre) as cantidad, c.nombre from categoria c inner join pelicula_categoria pc on c.id_categoria=pc.id_categoria inner join pelicula p on pc.id_pelicula=p.id_pelicula inner join pelicula_actor pa on p.id_pelicula=pa.id_pelicula inner join actor a on pa.id_actor=a.id_actor where a.id_actor=3 group by c.nombre order by 1 desc limit 1) x);

RETURN mayor_genero;
END$$

DELIMITER ;


