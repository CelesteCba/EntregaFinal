-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 24-11-2023 a las 01:54:43
-- Versión del servidor: 5.7.36
-- Versión de PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

DROP DATABASE IF EXISTS Celeste_Cordoba_Gimnasio;
CREATE database Celeste_Cordoba_Gimnasio;

USE Celeste_Cordoba_Gimnasio;
--
-- Base de datos: gimnasio
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla actividad
--

DROP TABLE IF EXISTS actividad;
CREATE TABLE IF NOT EXISTS actividad (
  id_actividad int NOT NULL AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  dia varchar(200) NOT NULL,
  duracion int NOT NULL,
  id_plan int NOT NULL,
  id_sucursal int NOT NULL,
  dni_profesor bigint NOT NULL,
  PRIMARY KEY (id_actividad)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente
--

DROP TABLE IF EXISTS cliente;
CREATE TABLE IF NOT EXISTS cliente (
  dni bigint NOT NULL,
  nombre varchar(200) NOT NULL,
  apellido varchar(200) NOT NULL,
  telefono varchar(200) NOT NULL,
  correo varchar(20) NOT NULL,
  PRIMARY KEY (dni)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla inscripcion
--

DROP TABLE IF EXISTS inscripcion;
CREATE TABLE IF NOT EXISTS inscripcion (
  id_inscripcion int NOT NULL AUTO_INCREMENT,
  dni_cliente bigint NOT NULL,
  id_plan int NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,  
  PRIMARY KEY (id_inscripcion)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla plan
--

DROP TABLE IF EXISTS plan;
CREATE TABLE IF NOT EXISTS plan (
  id_plan int NOT NULL AUTO_INCREMENT,
  nombre varchar(200) DEFAULT NULL,
  duracion int DEFAULT NULL,
  PRIMARY KEY (id_plan)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla profesor
--

DROP TABLE IF EXISTS profesor;
CREATE TABLE IF NOT EXISTS profesor (
  dni bigint NOT NULL,
  nombre varchar(200) NOT NULL,
  apellido varchar(200) NOT NULL,
  telefono varchar(200) NOT NULL,
  PRIMARY KEY (dni)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla sucursal
--

DROP TABLE IF EXISTS sucursal;
CREATE TABLE IF NOT EXISTS sucursal (
  id_sucursal int NOT NULL AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  PRIMARY KEY (id_sucursal)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

ALTER TABLE actividad
ADD CONSTRAINT fk_act_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal) ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT fk_act_dni_profesor FOREIGN KEY (dni_profesor) REFERENCES profesor (dni) ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT fk_act_id_plan FOREIGN KEY (id_plan) REFERENCES plan (id_plan) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE inscripcion
ADD CONSTRAINT fk_insc_id_plan FOREIGN KEY (id_plan) REFERENCES plan (id_plan) ON DELETE RESTRICT ON UPDATE CASCADE,
ADD CONSTRAINT fk_insc_dni_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente (dni) ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE `inscripcion_audit` (
  `id_inscripcion_audit` int(11) NOT NULL AUTO_INCREMENT,
  `id_inscripcion` int(11) NOT NULL,
  `dni_cliente` bigint(20) DEFAULT NULL,
  `id_plan` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `cuando` datetime DEFAULT NULL,
  `accion` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id_inscripcion_audit`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `actividad_audit` (
  `id_actividad_audit` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `dia` varchar(200) DEFAULT NULL,
  `duracion` int(20) DEFAULT NULL,
  `id_plan` int(11) DEFAULT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  `dni_profesor` bigint(20) DEFAULT NULL,
  `cuando` datetime DEFAULT NULL,
  `accion` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id_actividad_audit`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
