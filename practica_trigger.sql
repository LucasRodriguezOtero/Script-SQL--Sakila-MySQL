1- Crear la tabla "CONTROL" para auditoria de cambios en los precios.

create table control(
  codigo_de_libro int ,
  titulo varchar(40),
  autor varchar(30),
  precio_anterior double(10,2),
  precio_nuevo double(10,2),
  usuario varchar(30),
  fecha_actualizacion datetime
 );
 
 2- Crear un trigger que se dispare antes del update de un precio en la tabla de libros (solo se debe disparar si hubo un cambio de precios), se debe almacenar en la tabla de control los siguientes datos:
- codigo del libro
- titulo
- autor
- precio anterior
- precio nuevo
- usuario que está modificando el precio
- fecha y hora de la actualización.

 delimiter $$
 create  trigger control_update
 before update on libro
 for each row
 begin
	IF new.precio<>old.precio
    then
    insert into control(codigo_de_libro, titulo, autor, precio_anterior, precio_nuevo, usuario, fecha_actualizacion) 
    values(old.codigo, old.titulo, old.autor, old.precio, new.precio, user(), current_timestamp);
    end if;
 
 end$$
 
 3- Aumentamos en un 10% el precio de todos los libros de editorial 'Nuevo siglo':
    Realizar un select de la tabla de control para verificar que se hayan guardado los datos.
	
	update libro set precio=(precio*1.10) where editorial like 'Nuevo Siglo';
	SELECT * FROM control;
	
4- Cambiar el autor "Carroll" por "Lewis Carroll" en la tabla de libros.
Realizar un select de la tabla de control y describir que sucedió.

 update libro set autor="Lewis Carroll" where codigo=145;
 
 No sucedio nada en la tabla de control, solo se actualizara mediante el trigger si el precio es actualizado en la tabla Libro;

	
	
	
 
 