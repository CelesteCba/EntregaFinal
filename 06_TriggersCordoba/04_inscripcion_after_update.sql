CREATE DEFINER=`root`@`localhost` TRIGGER `celeste_cordoba_gimnasio`.`inscripcion_after_update` AFTER UPDATE ON `inscripcion` FOR EACH ROW
BEGIN
INSERT into `celeste_cordoba_gimnasio`.`inscripcion_audit` (id_inscripcion, dni_cliente, id_plan, fecha_inicio, fecha_fin, cuando, accion) VALUES (old.dni_cliente, old.id_plan, old.fecha_inicio, old.fecha_fin, sysdate(),"U");
END