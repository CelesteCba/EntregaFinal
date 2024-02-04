DELIMITER $$
DROP FUNCTION IF EXISTS `cantidad_plan_cliente`;
CREATE DEFINER=`root`@`localhost` FUNCTION `cantidad_plan_cliente`(id_plan int) RETURNS int(11)
BEGIN
DECLARE v_count_cliente int;
SELECT 
    COUNT(DISTINCT i.dni_cliente)
INTO v_count_cliente FROM
    celeste_cordoba_gimnasio.inscripcion i
WHERE
    i.id_plan = id_plan;
return v_count_cliente;
END$$
DELIMITER ;
