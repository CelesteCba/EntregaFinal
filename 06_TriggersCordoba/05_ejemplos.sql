/*Inscripción*/
select * from celeste_cordoba_gimnasio.inscripcion;
/*Ejemplo del trigger inscripcion_after_update*/
update celeste_cordoba_gimnasio.inscripcion set id_plan = 2, fecha_fin = DATE("2023-04-22") where id_inscripcion = 9;
/*Ejemplo del trigger inscripcion_after_delete*/
delete from celeste_cordoba_gimnasio.inscripcion where id_inscripcion = 10;
/*Consulta en la tabla de auditoria de inscripcion*/
select * from celeste_cordoba_gimnasio.inscripcion_audit;

/*Actividad*/
select * from celeste_cordoba_gimnasio.actividad;
/*Ejemplo del trigger actividad_after_update*/
update celeste_cordoba_gimnasio.actividad set id_sucursal = 2 where id_actividad = 19;
/*Ejemplo del trigger actividad_after_delete*/
delete from celeste_cordoba_gimnasio.actividad where id_actividad = 30;
/*Consulta en la tabla de auditoria de actividad*/
select * from celeste_cordoba_gimnasio.actividad_audit;