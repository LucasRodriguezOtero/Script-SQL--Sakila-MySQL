1- Crear un procedimiento que almacene en una tabla nueva los bonos que se darán a los empleados.
La tabla nueva debe contener el ID del empleado y el monto del bono.

#El bono se calcula de la siguiente manera:
 - Cada pelicula alquilada por el empleado suma 1 al bono, es decir, si el empleado con el id: 15 realizó 48 alquileres, el bono será de $48.
# La tabla no puede tener ids de empleados repetidos.
# Se deberá usar cursores para este procedimiento.
# No es necesario que el procedimiento retorne los valores de los bonos ya que quedaran almacenados en la tabla nueva.



create table bono(id_empleado integer, bono decimal(10,2));



USE `sakila_es`;
DROP procedure IF EXISTS `cursor_bono`;

USE `sakila_es`;
DROP procedure IF EXISTS `sakila_es`.`cursor_bono`;
;

DELIMITER $$
USE `sakila_es`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_bono`()
BEGIN
declare v_id_empleado integer;
declare v_testigo integer;
declare v_testigo2 integer;
declare v_bono decimal(10,2);
declare v_fin integer;

declare v_cursor cursor for
	select e.id_empleado from empleado e inner join pago p on e.id_empleado=p.id_empleado;
    
declare continue handler for not found set v_fin=1;

open v_cursor;
set v_bono=0;
set v_testigo=1;
set v_testigo2=0;
loop_cursor:loop
	
    fetch v_cursor into v_id_empleado;
    
    
    
    if (v_testigo!=v_id_empleado or v_fin=1) then
  
    insert into bono (id_empleado,bono) values(v_testigo2,v_bono);
    set v_bono = 0;
    set v_testigo=v_id_empleado;
    else
    set v_bono = v_bono +1;
    set v_testigo2= v_id_empleado;
	end if;
    
    
    if v_fin=1 then
    leave loop_cursor;
    end if;
    
    
end loop loop_cursor;

close v_cursor;    
END$$

DELIMITER ;
;



--------

2- Crear una funcion que retorne el balance de un cliente.
Como parametros de entrada se debe recibir el email del cliente.

# Tener en cuenta que los pagos que pudo haber hecho el cliente.
# Por cada día se debe sumar 1 al monto final.


USE `sakila_es`;
DROP function IF EXISTS `balance`;

USE `sakila_es`;
DROP function IF EXISTS `sakila_es`.`balance`;
;

DELIMITER $$
USE `sakila_es`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `balance`(p_email varchar(50)) RETURNS int(11)
BEGIN
declare dias_alquiler int;
declare pago double;
declare total double;

set dias_alquiler =(select sum(to_days(a. fecha_devolucion)- to_days(a.fecha_alquiler)) from alquiler a inner join cliente c on c.id_cliente=a.id_cliente where c.email like p_email);
set pago=(select sum(p.total) from pago p inner join cliente c on p.id_cliente=p.id_cliente where c.email like p_email);
set total=dias_alquiler-pago;

RETURN total;
END$$

DELIMITER ;
;



