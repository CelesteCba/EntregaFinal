CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_profesor_actividad`(in dni_profesor bigint, in nombre_actividad varchar(200), in dia_actividad varchar(200), in id_sucursal int, in id_plan int, out resultado int, out desc_resultado varchar(150))
BEGIN
/*Declaración de variables para validar todas las reglas de negocio*/
declare if_profesor_actividad int;
declare if_profesor_exists int;
declare if_actividad_exists int;
declare if_sucursal_exists int;
declare if_plan_exists int;

/*Verifico si existe la actividad*/
select count(1) into if_profesor_actividad from celeste_cordoba_gimnasio.vw_actividad_profesor ap where ap.dni_profesor = dni_profesor and ap.dia_actividad = dia_actividad and ap.id_sucursal = id_sucursal and ap.id_plan = id_plan and ap.nombre_actividad = nombre_actividad;

/*Si la actividad existe, retorno la descripción correspodiente*/
if if_profesor_actividad > 0 then
 set resultado = 0;
 set desc_resultado = "El profesor ya dicta la actividad";

else
	select count(1) into if_profesor_exists from celeste_cordoba_gimnasio.profesor p where p.dni = dni_profesor;
    select count(1) into if_plan_exists from celeste_cordoba_gimnasio.plan pl where pl.id_plan = id_plan;
    select count(1) into if_sucursal_exists from celeste_cordoba_gimnasio.sucursal s where s.id_sucursal = id_sucursal;
		
        /*Verifico si existe el profesor*/
        if if_profesor_exists < 1 then
			set resultado = 0;
			set desc_resultado = "El profesor no existe. Por favor verifique los datos ingresados.";
        
        /*Verifico si existe el plan*/
        elseif if_plan_exists < 1 then
			set resultado = 0;
			set desc_resultado = "El plan no existe. Por favor verifique los datos ingresados.";
        
        /*Verifico si existe la sucursal*/
		elseif if_sucursal_exists < 1 then
			set resultado = 0;
			set desc_resultado = "La sucursal no existe. Por favor verifique los datos ingresados.";                        
            
		else
        
			/*Realizo la inserción de la actividad correspodiente*/
			insert into actividad (nombre, dia, duracion, id_plan, id_sucursal, dni_profesor) values (nombre_actividad, dia_actividad,60,id_plan, id_sucursal, dni_profesor);
            set resultado = 1;
			set desc_resultado = "La actividad se registro correctamente.";
            
		end if;
end if;
END