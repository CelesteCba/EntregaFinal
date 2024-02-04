CREATE DEFINER=`root`@`localhost` TRIGGER `celeste_cordoba_gimnasio`.`actividad_after_delete` AFTER DELETE ON `actividad` FOR EACH ROW
BEGIN
INSERT into `celeste_cordoba_gimnasio`.`actividad_audit` (id_actividad, nombre, dia, duracion, id_plan, id_sucursal, dni_profesor, cuando, accion) VALUES (old.id_actividad, old.nombre, old.dia, old.duracion, old.id_plan, old.id_sucursal, old.dni_profesor, sysdate(),"D");
END