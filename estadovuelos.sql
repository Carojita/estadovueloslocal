-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-04-2026 a las 00:25:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `estadovuelos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aerolinea`
--
CREATE USER `api_user`@`%` IDENTIFIED BY '*6DA8A65D42F5B459ECF0745ADC7DDD52C4B5F87F';

GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `api_user`@`%` IDENTIFIED BY PASSWORD '*6DA8A65D42F5B459ECF0745ADC7DDD52C4B5F87F';

GRANT SELECT, INSERT, UPDATE, DELETE ON `estadovuelos`.* TO `api_user`@`%`;

CREATE TABLE `aerolinea` (
  `nombre` varchar(35) NOT NULL,
  `iata` varchar(4) NOT NULL,
  `nacionalidad` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aerolinea`
--

INSERT INTO `aerolinea` (`nombre`, `iata`, `nacionalidad`) VALUES
('Aeromexico', 'AM', 'Mexicana'),
('Avianca', 'AV', 'Colombiana'),
('Delta Airlines', 'DL', 'Estadounidense'),
('LATAM', 'LA', 'Colombiana'),
('JetSMART Argentina', 'WJ', 'Argentina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aeropuerto`
--

CREATE TABLE `aeropuerto` (
  `nombre` varchar(100) NOT NULL,
  `iata` varchar(4) NOT NULL,
  `ciudad` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aeropuerto`
--

INSERT INTO `aeropuerto` (`nombre`, `iata`, `ciudad`) VALUES
('Aeropuerto Internacional Gustavo Rojas Pinilla', 'ADZ', 'San Andrés'),
('Aeropuerto Internacional Ernesto Cortissoz', 'BAQ', 'Barranquilla'),
('Aeropuerto Internacional Palonegro', 'BGA', 'Bucaramanga'),
('Aeropuerto Internacional El Dorado', 'BOG', 'Bogotá'),
('Aeropuerto Internacional Alfonso Bonilla Aragón', 'CLO', 'Cali'),
('Aeropuerto Internacional Rafael Núñez', 'CTG', 'Cartagena'),
('Aeropuerto Internacional Camilo Daza', 'CUC', 'Cúcuta'),
('Aeropuerto Internacional José María Córdova', 'MDE', 'Medellín'),
('Aeropuerto Internacional Matecaña', 'PEI', 'Pereira'),
('Aeropuerto Internacional Simón Bolívar', 'SMR', 'Santa Marta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vuelo`
--

CREATE TABLE `vuelo` (
  `estado` enum('Programado','Activo','Aterrizaje Completo','Cancelado','Incidente Reportado','Desviado','N/A') NOT NULL DEFAULT 'Programado',
  `salida` datetime NOT NULL DEFAULT current_timestamp(),
  `origen` varchar(4) NOT NULL,
  `iata` varchar(8) NOT NULL,
  `destino` varchar(4) NOT NULL,
  `aerolinea` varchar(4) NOT NULL,
  `demora` int(4) DEFAULT NULL,
  `llegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vuelo`
--

INSERT INTO `vuelo` (`estado`, `salida`, `origen`, `iata`, `destino`, `aerolinea`, `demora`, `llegada`) VALUES
('Aterrizaje Completo', '2026-04-19 16:46:00', 'BOG', 'AV001', 'CLO', 'AV', NULL, '2026-04-19 17:46:00'),
('Programado', '2026-04-25 10:40:07', 'CTG', 'DL001', 'BOG', 'DL', 3, '2026-04-25 11:40:07'),
('Programado', '2026-04-25 11:19:53', 'CLO', 'DL002', 'BOG', 'DL', NULL, '2026-04-25 12:19:53'),
('Programado', '2026-04-27 15:05:00', 'CLO', 'LA001', 'ADZ', 'LA', NULL, '2026-04-27 18:05:00'),
('Programado', '2026-04-27 17:05:00', 'CLO', 'LA002', 'CTG', 'LA', NULL, '2026-04-27 19:05:00'),
('Programado', '2026-04-30 15:00:00', 'PEI', 'LA003', 'CUC', 'LA', NULL, '2026-04-30 17:00:00'),
('Programado', '2026-04-30 15:00:00', 'PEI', 'LA004', 'CUC', 'LA', NULL, '2026-04-30 17:00:00'),
('Activo', '2026-04-25 11:19:53', 'BOG', 'WJ001', 'CLO', 'WJ', 3, '2026-04-25 12:19:53');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aerolinea`
--
ALTER TABLE `aerolinea`
  ADD PRIMARY KEY (`iata`);

--
-- Indices de la tabla `aeropuerto`
--
ALTER TABLE `aeropuerto`
  ADD PRIMARY KEY (`iata`);

--
-- Indices de la tabla `vuelo`
--
ALTER TABLE `vuelo`
  ADD PRIMARY KEY (`iata`),
  ADD KEY `vuelo_aerorigen` (`origen`),
  ADD KEY `vuelo_aerodestino` (`destino`),
  ADD KEY `vuelo_aerolinea` (`aerolinea`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `vuelo`
--
ALTER TABLE `vuelo`
  ADD CONSTRAINT `vuelo_aerodestino` FOREIGN KEY (`destino`) REFERENCES `aeropuerto` (`iata`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vuelo_aerolinea` FOREIGN KEY (`aerolinea`) REFERENCES `aerolinea` (`iata`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vuelo_aerorigen` FOREIGN KEY (`origen`) REFERENCES `aeropuerto` (`iata`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
