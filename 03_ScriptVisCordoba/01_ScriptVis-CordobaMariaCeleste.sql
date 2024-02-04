USE celeste_cordoba_gimnasio;
/*Visualizar el cliente con el nombre del plan y la duración del mismo*/
CREATE OR REPLACE VIEW vw_cliente_plan AS
    SELECT 
        `c`.`dni` AS `dni_cliente`,
        `c`.`apellido` AS `apellido_cliente`,
        `c`.`nombre` AS `nombre_cliente`,
        `p`.`nombre` AS `nombre_plan`,
        `p`.`duracion` AS duracion_en_meses,
        i.fecha_inicio AS fecha_inicio,
        i.fecha_fin AS fecha_fin,
        i.id_plan AS id_plan
    FROM
        ((celeste_cordoba_gimnasio.inscripcion i
        JOIN celeste_cordoba_gimnasio.plan p ON ((p.id_plan = i.id_plan)))
        JOIN celeste_cordoba_gimnasio.cliente c ON ((c.dni = i.dni_cliente)));
/*Visualizar el nombre y apellido del profesor con la actividad y la duración de la actividad*/        
CREATE OR REPLACE VIEW vw_actividad_profesor AS
    SELECT 
        `p`.`dni` AS `dni_profesor`,
        `p`.`apellido` AS `apellido_profesor`,
        `p`.`nombre` AS `nombre_profesor`,
        `a`.`id_actividad` AS `id_actividad`,
        `a`.`nombre` AS `nombre_actividad`,
        `a`.`dia` AS `dia_actividad`,
        `a`.`duracion` AS `duracion_hora`,
        `s`.`id_sucursal` AS `id_sucursal`,
        `s`.`nombre` AS `nombre_sucursal`,
        `pl`.`id_plan` AS `id_plan`,
        `pl`.`nombre` AS `nombre_plan`
    FROM
        (((`celeste_cordoba_gimnasio`.`actividad` `a`
        JOIN `celeste_cordoba_gimnasio`.`profesor` `p` ON ((`p`.`dni` = `a`.`dni_profesor`)))
        JOIN `celeste_cordoba_gimnasio`.`sucursal` `s` ON ((`s`.`id_sucursal` = `a`.`id_sucursal`)))
        JOIN `celeste_cordoba_gimnasio`.`plan` `pl` ON ((`pl`.`id_plan` = `a`.`id_plan`)));
/*Visualizar la cantidad de inscripciones por plan*/        
CREATE OR REPLACE VIEW vw_inscripciones_plan AS
    SELECT 
        COUNT(DISTINCT i.dni_cliente) AS 'cantidad_inscripciones',
        p.nombre AS 'nombre_plan'
    FROM
        celeste_cordoba_gimnasio.inscripcion i
            INNER JOIN
        celeste_cordoba_gimnasio.plan p ON p.id_plan = i.id_plan
    GROUP BY p.nombre;
/*Visualizar las actividades de las sucursales con sus horarios*/    
CREATE OR REPLACE VIEW vw_actividad_sucursal AS
    SELECT 
        s.nombre AS 'nombre_sucursal',
        a.nombre AS 'nombre_actividad',
        a.dia AS 'dia_actividad',
        a.duracion AS 'duracion_hora'
    FROM
        celeste_cordoba_gimnasio.actividad a
            INNER JOIN
        celeste_cordoba_gimnasio.sucursal s ON s.id_sucursal = a.id_sucursal;
/*Visualizar la cantidad de profesores por sucursal*/        
CREATE OR REPLACE VIEW vw_profesores_sucursal AS
    SELECT 
        COUNT(DISTINCT p.dni) AS 'cantidad_profesores',
        s.nombre AS 'nombre_sucursal'
    FROM
        celeste_cordoba_gimnasio.actividad a
            INNER JOIN
        celeste_cordoba_gimnasio.sucursal s ON s.id_sucursal = a.id_sucursal
            INNER JOIN
        celeste_cordoba_gimnasio.profesor p ON p.dni = a.dni_profesor
    GROUP BY s.nombre;