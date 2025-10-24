-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 24-10-2025 a las 22:32:25
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
-- Base de datos: `Desis`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodega`
--

CREATE TABLE `bodega` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `bodega`
--

INSERT INTO `bodega` (`codigo`, `nombre`) VALUES
(1, 'Bodega1'),
(2, 'Bodega2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`codigo`, `nombre`) VALUES
(1, 'plastico'),
(2, 'metal'),
(3, 'madera'),
(4, 'vidrio'),
(5, 'textil');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material_producto`
--

CREATE TABLE `material_producto` (
  `id` int(11) NOT NULL,
  `cod_producto` varchar(15) NOT NULL,
  `cod_material` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `material_producto`
--

INSERT INTO `material_producto` (`id`, `cod_producto`, `cod_material`) VALUES
(9, '1EJAJBI7', 3),
(10, '1EJAJBI7', 4),
(11, '1EJAJBI7asd', 2),
(12, '1EJAJBI7asd', 3),
(13, 'a1EJAJBI7', 3),
(14, 'a1EJAJBI7', 4),
(1, 'asd123', 2),
(2, 'asd123', 3),
(5, 'asd12312', 3),
(6, 'asd12312', 4),
(3, 'asd1234', 3),
(4, 'asd1234', 4),
(7, 'pl285', 2),
(8, 'pl285', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`codigo`, `nombre`) VALUES
(1, 'moneda1'),
(2, 'moneda2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `codigo` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `cod_bodega` int(3) NOT NULL,
  `cod_sucursal` int(3) NOT NULL,
  `cod_moneda` int(3) NOT NULL,
  `precio` float NOT NULL,
  `descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codigo`, `nombre`, `cod_bodega`, `cod_sucursal`, `cod_moneda`, `precio`, `descripcion`) VALUES
('1EJAJBI7', 'ZACARIAS JARA', 1, 1, 2, 21.31, 'madera de color cafe'),
('1EJAJBI7asd', 'CRISTIAN ALEJANDRO TORRES TORRES', 1, 2, 2, 12.31, 'asdasdsadadsaddsadsadadsads'),
('a1EJAJBI7', 'Prueba', 2, 3, 1, 12.31, 'madera de prueba12'),
('asd123', 'asd123asd', 1, 1, 1, 12.31, 'asdasdqwdqwdwqwddwqdwwdq dqxxdqdq'),
('asd12312', 'asdasdasdas', 2, 4, 2, 12.31, 'wdqqlwdlqwkljdqwjkldwqdjqdjkqjlkwljkdqwlkjdqwklj'),
('asd1234', 'asdasd', 1, 2, 1, 12, 'asdsadsadasadsadsadsadssd'),
('pl285', 'Salmon', 2, 3, 1, 23.58, 'caja 400 lote 1500');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `codigo` int(3) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `cod_bodega` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`codigo`, `nombre`, `cod_bodega`) VALUES
(1, 'sucursal1', 1),
(2, 'sucursal2', 1),
(3, 'sucursal3', 2),
(4, 'sucursal4', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `material_producto`
--
ALTER TABLE `material_producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cod_material` (`cod_material`),
  ADD KEY `cod_producto` (`cod_producto`,`cod_material`) USING BTREE;

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `cod_sucursal` (`cod_sucursal`),
  ADD KEY `cod_moneda` (`cod_moneda`),
  ADD KEY `cod_bodega` (`cod_bodega`,`cod_sucursal`,`cod_moneda`) USING BTREE;

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `material_producto`
--
ALTER TABLE `material_producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `material_producto`
--
ALTER TABLE `material_producto`
  ADD CONSTRAINT `material_producto_ibfk_1` FOREIGN KEY (`cod_material`) REFERENCES `materiales` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_producto_ibfk_2` FOREIGN KEY (`cod_producto`) REFERENCES `producto` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`cod_sucursal`) REFERENCES `sucursal` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`cod_moneda`) REFERENCES `moneda` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`cod_bodega`) REFERENCES `bodega` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
