1- Realizar una función que devuelva el promedio de duración de todas las películas de una determinada categoría que deberá ingresarse como parámetro.

CREATE FUNCTION avg_duracion_por_categoria(categoria_nombre VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE avg_duracion DECIMAL(10,2);
    
    SELECT AVG(pelicula.duracion) INTO avg_duracion
    FROM pelicula
    INNER JOIN pelicula_categoria ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
    INNER JOIN categoria ON pelicula_categoria.id_categoria = categoria.id_categoria
    WHERE categoria.nombre = categoria_nombre;
    
    RETURN avg_duracion;
END 



