-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 30-11-2025 a las 23:49:21
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Proyecto_final`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradoras`
--

CREATE TABLE `aseguradoras` (
  `idAseguradora` varchar(3) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `contacto` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aseguradoras`
--

INSERT INTO `aseguradoras` (`idAseguradora`, `nombre`, `contacto`) VALUES
('A01', 'Seguros Norte', '7771234567'),
('A02', 'Seguros Sur', '7772345678'),
('A03', 'Seguros Este', '7773456789'),
('A04', 'Solidez MX', '7774567890'),
('A05', 'Mega Seguros', '7775678901');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bienes`
--

CREATE TABLE `bienes` (
  `idBien` varchar(8) NOT NULL,
  `idCliente` varchar(5) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `valorAsegurado` varchar(10) NOT NULL,
  `tipoBien` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bienes`
--

INSERT INTO `bienes` (`idBien`, `idCliente`, `descripcion`, `valorAsegurado`, `tipoBien`) VALUES
('B0000001', 'C001', 'Automóvil sedan 2020', '250000.00', 'Auto'),
('B0000002', 'C002', 'Casa habitación 2 pisos', '1800000.00', 'Casa'),
('B0000003', 'C003', 'Oficina corporativa', '3500000.00', 'Negocio'),
('B0000004', 'C004', 'Motocicleta Yamaha', '90000.00', 'Moto'),
('B0000005', 'C005', 'Departamento Torre 22', '1400000.00', 'Departamento'),
('B0000006', 'C002', 'Camioneta SUV 2022', '400000.00', 'Auto'),
('B0000007', 'C003', 'Local comercial', '1700000.00', 'Negocio'),
('B0000008', 'C005', 'Casa campo', '950000.00', 'Casa'),
('B0000009', 'C002', 'Automóvil sedan 2025', '0', 'Auto'),
('B0000010', 'C002', 'Automóvil sedan 2020', '0', 'Auto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` varchar(5) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `direccion` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombre`, `fechaNacimiento`, `direccion`) VALUES
('C001', 'Juan Pérez', '1990-01-23', 'Av. Reforma 123, Centro, CDMX'),
('C002', 'Ana Gómez', '1985-10-07', 'Av. Juárez 280, Sur, CDMX'),
('C003', 'Luis Morales', '1978-06-15', 'Calle 5 No. 18, Este, CDMX'),
('C004', 'Sofía Fernández', '1983-03-22', 'Los Pinos 8, Centro, CDMX'),
('C005', 'Ricardo Díaz', '1996-09-11', 'Lago Mayor 40, Norte, CDMX');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `siniestros/eventos`
--

CREATE TABLE `siniestros/eventos` (
  `idSiniestro` varchar(7) NOT NULL,
  `idBien` varchar(8) NOT NULL,
  `idRiesgo` varchar(3) NOT NULL,
  `idAseguradora` varchar(3) NOT NULL,
  `fecha` date NOT NULL,
  `monto` varchar(10) NOT NULL,
  `zona` varchar(40) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `siniestros/eventos`
--

INSERT INTO `siniestros/eventos` (`idSiniestro`, `idBien`, `idRiesgo`, `idAseguradora`, `fecha`, `monto`, `zona`, `descripcion`) VALUES
('Prueba', 'B0000002', 'R01', 'A03', '2025-11-27', '37000.0', 'Norte', 'Prueba de registro'),
('Prueba2', 'B0000009', 'R02', 'A04', '2025-11-27', '43000.0', 'Sur', 'Prueba 2 de registro'),
('Prueba3', 'B0000010', 'R02', 'A02', '2025-11-27', '45000.0', 'Este', 'Prueba 3 registro'),
('S000001', 'B0000001', 'R03', 'A01', '2025-01-14', '12000.00', 'Centro', 'Accidente menor en tránsito'),
('S000002', 'B0000002', 'R01', 'A02', '2024-11-20', '55000.00', 'Sur', 'Incendio en cocina'),
('S000003', 'B0000003', 'R02', 'A03', '2025-07-02', '90000.00', 'Este', 'Robo de equipo de cómputo'),
('S000004', 'B0000004', 'R03', 'A05', '2025-03-05', '17500.00', 'Centro', 'Caída de motocicleta'),
('S000005', 'B0000005', 'R04', 'A02', '2025-06-15', '22000.00', 'Norte', 'Inundación por lluvia'),
('S000006', 'B0000006', 'R02', 'A03', '2024-12-08', '15000.00', 'Sur', 'Robo de camioneta en exterior'),
('S000007', 'B0000007', 'R05', 'A04', '2025-08-21', '8000.00', 'Centro', 'Rotura de vidrios por vandalismo'),
('S000008', 'B0000008', 'R01', 'A05', '2025-09-12', '65000.00', 'Campo', 'Fuego por accidente doméstico'),
('S000009', 'B0000001', 'R01', 'A01', '2025-02-10', '35000.00', 'Centro', 'Incendio parcial en motor.'),
('S000010', 'B0000002', 'R01', 'A02', '2025-03-18', '60000.00', 'Sur', 'Incendio en sala de estar.'),
('S000011', 'B0000003', 'R02', 'A03', '2025-04-05', '42000.00', 'Este', 'Robo de mercancía.'),
('S000012', 'B0000004', 'R03', 'A01', '2025-05-22', '18000.00', 'Centro', 'Accidente en carretera.'),
('S000013', 'B0000005', 'R01', 'A02', '2025-06-09', '75000.00', 'Norte', 'Incendio en cocina.'),
('S000014', 'B0000006', 'R02', 'A03', '2025-07-14', '25000.00', 'Sur', 'Robo de auto estacionado.'),
('S000015', 'B0000007', 'R03', 'A04', '2025-08-01', '31000.00', 'Centro', 'Accidente en bodega.'),
('S000016', 'B0000008', 'R01', 'A05', '2025-09-19', '82000.00', 'Campo', 'Incendio en casa de campo.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposRiesgo`
--

CREATE TABLE `tiposRiesgo` (
  `idRiesgo` varchar(3) NOT NULL,
  `nombreRiesgo` varchar(60) NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tiposRiesgo`
--

INSERT INTO `tiposRiesgo` (`idRiesgo`, `nombreRiesgo`, `descripcion`) VALUES
('R01', 'Incendio', 'Daños por fuego'),
('R02', 'Robo', 'Pérdida por robo'),
('R03', 'Accidente', 'Daños por accidente automovilístico'),
('R04', 'Inundación', 'Daños por agua'),
('R05', 'Vandalismo', 'Daños materiales por actos vandálicos');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aseguradoras`
--
ALTER TABLE `aseguradoras`
  ADD PRIMARY KEY (`idAseguradora`);

--
-- Indices de la tabla `bienes`
--
ALTER TABLE `bienes`
  ADD PRIMARY KEY (`idBien`),
  ADD KEY `idCliente` (`idCliente`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `siniestros/eventos`
--
ALTER TABLE `siniestros/eventos`
  ADD PRIMARY KEY (`idSiniestro`),
  ADD KEY `idBien` (`idBien`,`idRiesgo`,`idAseguradora`),
  ADD KEY `idRiesgo` (`idRiesgo`),
  ADD KEY `idAseguradora` (`idAseguradora`);

--
-- Indices de la tabla `tiposRiesgo`
--
ALTER TABLE `tiposRiesgo`
  ADD PRIMARY KEY (`idRiesgo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bienes`
--
ALTER TABLE `bienes`
  ADD CONSTRAINT `bienes_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `siniestros/eventos`
--
ALTER TABLE `siniestros/eventos`
  ADD CONSTRAINT `siniestros/eventos_ibfk_1` FOREIGN KEY (`idBien`) REFERENCES `bienes` (`idBien`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `siniestros/eventos_ibfk_2` FOREIGN KEY (`idRiesgo`) REFERENCES `tiposRiesgo` (`idRiesgo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `siniestros/eventos_ibfk_3` FOREIGN KEY (`idAseguradora`) REFERENCES `aseguradoras` (`idAseguradora`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
