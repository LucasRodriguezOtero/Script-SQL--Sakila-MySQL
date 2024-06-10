USE `sakila_es`;
DROP procedure IF EXISTS `transaccion`;

DELIMITER $$
USE `sakila_es`$$
CREATE PROCEDURE `transaccion` (IN p_caja VARCHAR(10), IN p_cantidad INT)
BEGIN
    DECLARE v_usuario VARCHAR(50);
    DECLARE v_fecha TIMESTAMP;

    SET v_usuario = USER();
    SET v_fecha = CURRENT_TIMESTAMP;

    IF p_caja = 'persona' THEN
        INSERT INTO caja_persona (cantidad, usuario, fecha) VALUES (p_cantidad, v_usuario, v_fecha);
    ELSEIF p_caja = 'empresa' THEN
        INSERT INTO caja_empresa (cantidad, usuario, fecha) VALUES (p_cantidad, v_usuario, v_fecha);
    ELSEIF p_caja = 'estado' THEN
        INSERT INTO caja_estado (cantidad, usuario, fecha) VALUES (p_cantidad, v_usuario, v_fecha);
    END IF;

    COMMIT;
END;$$

DELIMITER ;

