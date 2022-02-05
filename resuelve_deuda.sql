-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-02-2022 a las 03:15:09
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `resuelve_deuda`
--
CREATE DATABASE IF NOT EXISTS `resuelve_deuda` DEFAULT CHARACTER SET utf16 COLLATE utf16_spanish2_ci;
USE `resuelve_deuda`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `calculo_equipo_json`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculo_equipo_json` (IN `pParametroJson` JSON, OUT `pParametroJsonOut` JSON)  BEGIN 
    DECLARE vJsonEsValido INT;
    DECLARE vItems INT;
    DECLARE vIndex BIGINT UNSIGNED DEFAULT 0;
    
    # Variables para parseo del objeto JSON
    DECLARE vCampo1 VARCHAR(100);
    DECLARE vCampo2 VARCHAR(100);
    DECLARE vCampo3 VARCHAR(100);
	
	#
	DECLARE fnombre VARCHAR(100);
	DECLARE fgolesmensuales VARCHAR(100);
	DECLARE fsueldo DECIMAL(12,2);
	DECLARE fsueldo_completo DECIMAL(12,2);
	DECLARE fbono VARCHAR(100);
	DECLARE fcalculobonoindividual DECIMAL(12,2);
	DECLARE fnombreequipo VARCHAR(100);
    	
	DECLARE json_out JSON;
	DECLARE json_out2 JSON;
	
	SET json_out = '[]';
	SET json_out2 = '[]';
	SET pParametroJsonOut='[]';
	#--SET json_out2 = '{}';
    SET vJsonEsValido = JSON_VALID(pParametroJson);
    
    IF vJsonEsValido = 0 THEN 
        # El objeto JSON no es válido, salimos prematuramente
        #--SELECT "JSON suministrado no es válido";
		SELECT '[]' INTO pParametroJsonOut;
    ELSE 
	
        # Nuestro objeto es válido, podemos proceder
        SET vItems = JSON_LENGTH(pParametroJson);
        
        # El objeto es válido y contiene al menos un elemento
        IF vItems > 0 THEN 
            
            WHILE vIndex < vItems DO
			
                SET vCampo1 = JSON_UNQUOTE(JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].id_jugador')));
                SET vCampo2 = JSON_UNQUOTE(JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].goles')));
                SET vCampo3 = JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].sueldo_completo'));
				SET fnombre=null;
				
				SELECT 	j.nombre,den.goles_mensuales,j.sueldo,j.bono,if( ( vCampo2 /den.goles_mensuales)*(j.bono/2) <= (j.bono/2) , ( vCampo2 /den.goles_mensuales)*(j.bono/2) , (j.bono/2) ),e.nombre INTO fnombre,fgolesmensuales,fsueldo,fbono,fcalculobonoindividual,fnombreequipo FROM Jugador j INNER JOIN detalle_equipo_nivel den ON den.id_den=j.id_den AND id_jugador=vCampo1 INNER JOIN equipo e ON den.id_equipo=e.id_equipo;
				
				SET fsueldo_completo=fsueldo+fcalculobonoindividual;
                				
				SELECT JSON_OBJECT( 'nombre',fnombre,'goles_minimos',fgolesmensuales,'goles',vCampo2,'sueldo',fsueldo,'bono',fbono,'sueldo_completo',fsueldo_completo,'calculo_individual',fcalculobonoindividual,'equipo', fnombreequipo ) INTO json_out;
								
				SELECT JSON_INSERT(pParametroJsonOut, CONCAT('$[', vIndex, ']'),  json_out) INTO pParametroJsonOut;
				
				SET vIndex = vIndex + 1;
				
				#--Verificación de existencia de jugadores
				IF fnombre IS NULL THEN
					SET vIndex = vItems;
					SET pParametroJsonOut='[]';
				END IF;
				
            END WHILE;
            
        END IF;
		
		SELECT REPLACE(REPLACE(REPLACE(JSON_EXTRACT(pParametroJsonOut, '$[*]'), '"{', "{"), '}"', "}"), "\\", "") INTO pParametroJsonOut;
				
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_nivel`
--

DROP TABLE IF EXISTS `catalogo_nivel`;
CREATE TABLE `catalogo_nivel` (
  `id_cn` int(11) NOT NULL,
  `nivel` varchar(10) COLLATE utf16_spanish2_ci NOT NULL,
  `descripcion` varchar(80) COLLATE utf16_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish2_ci;

--
-- Volcado de datos para la tabla `catalogo_nivel`
--

INSERT INTO `catalogo_nivel` (`id_cn`, `nivel`, `descripcion`) VALUES
(1, 'A', 'Nivel básico de goles'),
(2, 'B', 'Nivel medio asignado a delanteros'),
(3, 'C', 'Nivel alto para goleadores promedio'),
(4, 'Cuauh', 'Nivel premium para goleadores con alto grado de efectividad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_equipo_nivel`
--

DROP TABLE IF EXISTS `detalle_equipo_nivel`;
CREATE TABLE `detalle_equipo_nivel` (
  `id_den` int(11) NOT NULL,
  `id_cn` int(11) NOT NULL,
  `id_equipo` int(11) NOT NULL,
  `goles_mensuales` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish2_ci;

--
-- Volcado de datos para la tabla `detalle_equipo_nivel`
--

INSERT INTO `detalle_equipo_nivel` (`id_den`, `id_cn`, `id_equipo`, `goles_mensuales`) VALUES
(1, 1, 1, 5),
(2, 2, 1, 10),
(3, 3, 1, 15),
(4, 4, 1, 20),
(5, 1, 2, 3),
(6, 2, 2, 5),
(7, 3, 2, 8),
(8, 4, 2, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

DROP TABLE IF EXISTS `equipo`;
CREATE TABLE `equipo` (
  `id_equipo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf16_spanish2_ci NOT NULL,
  `descripcion` varchar(50) COLLATE utf16_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish2_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id_equipo`, `nombre`, `descripcion`) VALUES
(1, 'Resuelve FC', 'Equipo de futbol de la región'),
(2, 'La Competencia', 'Equipo de futbol de la región'),
(3, 'Otro equipo', 'Equipo de futbol de la región');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

DROP TABLE IF EXISTS `jugador`;
CREATE TABLE `jugador` (
  `id_jugador` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf16_spanish2_ci NOT NULL,
  `edad` varchar(3) COLLATE utf16_spanish2_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf16_spanish2_ci NOT NULL,
  `sueldo` decimal(10,2) NOT NULL,
  `bono` decimal(10,2) NOT NULL,
  `id_den` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish2_ci;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`id_jugador`, `nombre`, `edad`, `direccion`, `sueldo`, `bono`, `id_den`) VALUES
(5, 'Juan', '22', 'Conocido', '15000.00', '5000.00', 1),
(6, 'Pedro', '20', 'Conocido', '18000.00', '4500.00', 2),
(7, 'Martin', '23', 'Conocido', '10000.00', '10000.00', 3),
(8, 'Luis', '26', 'Conocido', '25000.00', '15000.00', 4),
(9, 'Juan Fake', '20', 'Conocido', '10500.00', '3500.00', 5),
(10, 'Pedro Fake', '18', 'Conocido', '10500.00', '5500.00', 6),
(11, 'Martin Fake', '26', 'Conocido', '12500.00', '7000.00', 7),
(12, 'Luis Fake', '23', 'Conocido', '17000.00', '8000.00', 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catalogo_nivel`
--
ALTER TABLE `catalogo_nivel`
  ADD PRIMARY KEY (`id_cn`);

--
-- Indices de la tabla `detalle_equipo_nivel`
--
ALTER TABLE `detalle_equipo_nivel`
  ADD PRIMARY KEY (`id_den`),
  ADD UNIQUE KEY `id_cn` (`id_cn`,`id_equipo`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_equipo`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`id_jugador`),
  ADD KEY `id_den` (`id_den`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `catalogo_nivel`
--
ALTER TABLE `catalogo_nivel`
  MODIFY `id_cn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_equipo_nivel`
--
ALTER TABLE `detalle_equipo_nivel`
  MODIFY `id_den` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `id_jugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`id_den`) REFERENCES `detalle_equipo_nivel` (`id_den`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
