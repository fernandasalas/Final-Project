-- phpMyAdmin SQL Dump
-- https://www.phpmyadmin.net/
-- Servidor: 127.0.0.1


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


-- Base de datos dblaravel








-- TABLA DE LOS ARTÍCULOS


CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(512) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- DATOS DE CADA ARTÍCULO
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `estado`) VALUES
(11, 10, '1111', 'Kombucha', 37, NULL, 'kombucha.jpeg', 'Activo'),
(12, 10, '2222', 'Jarabe de miel', 2, NULL, 'jarabes1.jpg', 'Activo'),
(13, 11, '3333', 'Kéfir de leche', 11, NULL, 'leche1.jpg', 'Activo'),
(14, 10, '4444', 'Kéfir de agua', 26, NULL, 'agua1.png', 'Activo'),
(15, 10, '5555', 'Vinagre de kombucha', 20, NULL, 'vinagre.jpg', 'Activo'),
(16, 10, '6666', 'Jun', 60, NULL, 'jun1.png', 'Activo'),



--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--ingreso tabla

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 31, 13, 13, '900.00', '1300.00'),
(2, 32, 14, 14, '100.00', '200.00'),
(3, 33, 11, 11, '800.00', '1000.00'),
(4, 34, 15, 15, '400.00', '500.00'),
(5, 35, 12, 12, '300.00', '500.00'),
(6, 36, 18, 5, '600.00', '900.00'),
(7, 37, 18, 18, '300.00', '500.00'),
(8, 38, 12, 5, '700.00', '900.00'),
(9, 39, 13, 8, '800.00', '900.00'),
(10, 40, 11, 6, '888.00', '900.00');

-- ingreso

DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
     UPDATE articulo SET stock = stock + NEW.cantidad
        WHERE articulo.idarticulo =NEW.idarticulo;
END
$$
DELIMITER ;




-- tabla venta


CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 8, 12, 3, '300.00', '0.00'),
(2, 9, 13, 12, '560.00', '0.00'),
(3, 10, 18, 8, '120.00', '0.00'),
(4, 11, 13, 3, '746.00', '0.00');


DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN 
 	UPDATE articulo SET stock = stock - 
NEW.cantidad
	WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;



CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `estado`) VALUES
(31, 12, 'Factura', '0000', '0001', '2020-11-23 03:15:51', '16.00', 'A'),
(32, 12, 'Ticket', '0000', '0002', '2020-11-23 03:16:58', '16.00', 'A'),
(33, 11, 'Boleta', '0000', '0003', '2020-11-23 03:18:31', '16.00', 'A'),
(34, 13, 'Ticket', '0001|', '0004', '2020-11-23 03:19:25', '16.00', 'C'),
(35, 11, 'Factura', '4444', '4444', '2020-11-23 03:46:35', '16.00', 'A'),
(36, 13, 'Ticket', '0022', '9090', '2020-11-23 19:10:01', '16.00', 'A'),
(37, 12, 'Ticket', '5656', '7777', '2020-11-25 05:20:33', '16.00', 'A'),
(38, 12, 'Factura', '8989', '0007', '2020-11-25 05:23:49', '16.00', 'A'),
(39, 12, 'Factura', '9999', '8888', '2020-11-25 05:27:53', '16.00', 'A'),
(40, 12, 'Ticket', '6767', '8888', '2020-11-25 05:41:27', '16.00', 'A');



-- tabla `migrations`


CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- datos de migración


INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1);



-- `password_resets`


CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Volcado de datos para la tabla `password_resets`


INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('fergiesavi@gmail.com', '$2y$10$MlQG.6JZ1Eq3FMSXMS0hDekdz0n6cgof2tBMukLwgeFmkAn/jCiWC', '2020-05-23 03:21:32'),
('fergiesavi@hotmail.com', '$2y$10$BVZ.5yToDL8yTixU9H2h5OW6X2kLkKgCHA0rIXc9AE40/jioovYya', '2020-05-23 03:22:49');




-- Estructura de tabla para la tabla `persona`


CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(15) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(11, 'Proveedor', 'Te de la India', 'Visa', '100200', NULL, '36367860', 'teyfermentos@gmail.com'),
(12, 'Proveedor', 'miel natural', 'INE', '200300', 'Netzacualcoyotl 300', '35356789', 'naturistal@nat.com'),
(13, 'Cliente', 'Claudia Yañez', 'INE', '233455', NULL, '3324566', NULL),
(14, 'Cliente', 'Pablo Salas', 'Licencia de Conducir', '44567', NULL, '6677845', 'dr.pablosalas@gmail.com'),
(15, 'Cliente', 'Teresa Villaseñor', 'INE', '700670', 'Av. Mexico', '672394039', 'claussvi@gmail.com');


--  tabla `users`


CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'Fernanda Salas', 'fergiesavi@hotmail.com', NULL, '$2y$10$wHYaejKVPbwf.SGCJdJfCOB4kL5bINWSMG8n6UsmwuTciK0auQToG', 'nJ9tEWCimjhd2rvpRaelk0eMnywO1h8huIHZhKclQO9ddSkumuSecwyb2zLO', '2020-11-23 03:22:17', '2020-11-23 03:22:17'),
(5, 'admin', 'admin@hotmail.com', NULL, '$2y$10$jS01GDqkM8VKdgOkE98r2uv.3VH/d0m8xt0sYin8uIVaG31VzZ9fK', NULL, '2020-11-25 21:12:22', '2020-11-25 21:12:22');




--  tabla `venta`


CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` date NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(8, 15, 'Ticket', '7878', '9999', '2020-11-25', '16.00', '2100.00', 'A'),
(9, 16, 'Factura', '9090', '0777', '2020-11-25', '16.00', '13200.00', 'A'),
(10, 15, 'Factura', '6777', '8888', '2020-11-25', '16.00', '5600.00', 'A'),
(11, 14, 'Boleta', '9090', '0988', '2020-11-25', '16.00', '3300.00', 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD KEY `idcategoria` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `idingreso` (`idingreso`),
  ADD KEY `idarticulo` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `idarticulo` (`idarticulo`),
  ADD KEY `idventa` (`idventa`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `idproveedor` (`idproveedor`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `idcliente` (`idcliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `articulo_ibfk_1` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`),
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `detalle_ingreso_ibfk_1` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`),
  ADD CONSTRAINT `detalle_ingreso_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `detalle_venta_ibfk_3` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`),
  ADD CONSTRAINT `detalle_venta_ibfk_4` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`),
  ADD CONSTRAINT `fk_detalle_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ingreso_ibfk_1` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
