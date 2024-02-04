CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_cliente_plan`(in dni_cliente bigint, in id_plan int, out resultado int, out desc_resultado varchar(150))
BEGIN
/*Declaración de variables para validar todas las reglas de negocio*/
declare if_cliente_plan int;
declare if_cliente_exists int;
declare if_plan_exists int;
declare cant_meses_plan int;

/*Verifico que no exista una inscripción activa*/
select count(1) into if_cliente_plan from celeste_cordoba_gimnasio.vw_cliente_plan cp where cp.dni_cliente = dni_cliente and cp.id_plan = id_plan and curdate() between cp.fecha_inicio and cp.fecha_fin;

/*En el caso que no exista valido el cliente y plan*/
if if_cliente_plan > 0 then
 set resultado = 0;
 set desc_resultado = "El cliente ya está inscripto en el plan";

else
	select count(1) into if_cliente_exists from celeste_cordoba_gimnasio.cliente cp where cp.dni = dni_cliente;
	select count(1) into if_plan_exists from celeste_cordoba_gimnasio.plan cp where cp.id_plan = id_plan;
		
        if if_cliente_exists < 1 then
			set resultado = 0;
			set desc_resultado = "El cliente no existe. Por favor verifique los datos ingresados.";

        elseif if_plan_exists < 1 then
			set resultado = 0;
			set desc_resultado = "El plan no existe. Por favor verifique los datos ingresados.";
        
		/*Si existen ambos, realizo la inserción de la inscripción correspodiente*/
		else
			
            /*Busco la duración en meses para calcular la fecha fin de la inscripción*/
            select cp.duracion into cant_meses_plan from celeste_cordoba_gimnasio.plan cp where cp.id_plan = id_plan;            
			insert into inscripcion (dni_cliente, id_plan, fecha_inicio, fecha_fin) values (dni_cliente, id_plan, curdate(), DATE_ADD(curdate(),interval cant_meses_plan MONTH));
            set resultado = 1;
			set desc_resultado = "La inscripción se realizo de forma exitosa.";
            
		end if;
end if;
END