DELIMITER $$
DROP FUNCTION IF EXISTS `actividad_profesor`;
CREATE DEFINER=`root`@`localhost` FUNCTION `actividad_profesor`(nombre_actividad varchar(200), dia varchar(200), id_sucursal int) RETURNS varchar(200) CHARSET latin1
BEGIN
DECLARE profesor varchar(200);
SELECT 
    CASE
        WHEN CONCAT(p.nombre, p.apellido) IS NULL THEN ''
        ELSE CONCAT(CONCAT(p.apellido, ', '), p.nombre)
    END
INTO profesor FROM
    celeste_cordoba_gimnasio.actividad a
        INNER JOIN
    celeste_cordoba_gimnasio.profesor p ON p.dni = a.dni_profesor
WHERE
    UPPER(a.nombre) LIKE UPPER(nombre_actividad)
        AND UPPER(a.dia) LIKE UPPER(dia) and a.id_sucursal = id_sucursal;
RETURN profesor;
END$$
DELIMITER ;
