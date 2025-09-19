-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-09-2025 a las 02:56:50
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
-- Base de datos: `maderera_barrio_parque`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `agregado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(1, 'Ferreteria'),
(2, 'Hierro'),
(5, 'Pinturas'),
(6, 'Maderas'),
(7, 'Herrajes'),
(8, 'Cons en seco');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','pagado','enviado','entregado','cancelado') DEFAULT 'pendiente',
  `total` decimal(10,2) NOT NULL,
  `direccion_envio` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_detalles`
--

CREATE TABLE `pedido_detalles` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `precio` float NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `marca` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `nombre`, `precio`, `stock`, `descripcion`, `id_categoria`, `marca`) VALUES
(5, 3001, 'Sierra circular inalambrica', 18500, 15, 'Sierra circular inalámbrica Ecus 18V, disco 185mm', 1, 'Equus'),
(6, 3002, 'Prensa Sargento 6 pulgadas', 2500, 40, 'Prensa tipo sargento de 6 pulgadas, estructura reforzada', 1, 'Equus'),
(7, 3003, 'Cortador de ceramica 60cm', 9700, 10, 'Cortador manual de cerámica de 60cm, base antideslizante', 1, 'Equus'),
(8, 3004, 'Desmalezadora a nafta 52cc', 23900, 12, 'Desmalezadora a nafta Ecus 52cc, motor 2 tiempos', 1, 'Equus'),
(9, 3005, 'Mini podadora inalambrica', 12800, 20, 'Mini podadora de mano, batería de litio 20V', 1, 'Equus'),
(10, 3006, 'Kit de soldadura de estaño', 3700, 25, 'Kit de soldadura con estaño, cautín 60W incluido', 1, 'Equus'),
(11, 3007, 'Nivel laser verde 50mm', 9800, 18, 'Nivel láser verde con rango de 50m y auto-nivelación', 1, 'Equus'),
(12, 3101, 'Nivel de resina 12\"', 2200, 30, 'Nivel de resina Stanley de 12 pulgadas con base imantada', 1, 'Stanley'),
(13, 3102, 'Pinza pela cable 3 en 1', 3400, 25, 'Pinza 3 en 1 para pelar cables, cortar y crimpar', 1, 'Stanley'),
(14, 3103, 'Llave regulable 8\"', 2900, 35, 'Llave ajustable Stanley de 8 pulgadas, cuerpo de acero cromado', 1, 'Stanley'),
(15, 3104, 'Espátula tapizadora', 1700, 40, 'Espátula para aplicación de tapiz y masilla, mango ergonómico', 1, 'Stanley'),
(16, 3105, 'Juego de herramientas mecánicas', 18900, 10, 'Set completo de herramientas mecánicas Stanley de 108 piezas', 1, 'Stanley'),
(17, 3106, 'Formón para madera DynaGrip 3/8\"', 2600, 22, 'Formón DynaGrip Stanley 3/8\", hoja templada y mango bimaterial', 1, 'Stanley'),
(18, 3107, 'Martillo con mango de fibra de vidrio', 3200, 18, 'Martillo de carpintero Stanley, mango antideslizante de fibra de vidrio', 1, 'Stanley'),
(19, 3108, 'Juego de 20 destornilladores', 5800, 12, 'Juego completo de 20 destornilladores planos y philips Stanley', 1, 'Stanley'),
(20, 3000, 'Sierra Recíproca Sable Inalámbrica', 4500, 120, 'Sierra Recíproca Sable Inalámbrica marca Equus', 1, 'Equus'),
(27, 3109, 'Taladro Atornillador Recargable 18V', 8500, 20, 'Taladro/atornillador inalámbrico recargable de 18V, ideal para trabajos livianos y medianos.', 1, 'Energy'),
(28, 3110, 'Sierra Caladora 55MM 400W', 7900, 15, 'Sierra caladora de 400W con capacidad de corte de 55mm en madera, liviana y precisa.', 1, 'Energy'),
(29, 3111, 'Pistola de Pintar 550W', 6200, 18, 'Pistola de pintar eléctrica de 550W, ideal para barnices y pinturas base agua o solvente.', 1, 'Energy'),
(30, 3112, 'Soldadora Inverter MIG 160A', 23400, 10, 'Soldadora tipo MIG inverter de 160 amperes, compacta y eficiente para trabajos de herrería.', 1, 'Energy'),
(31, 3113, 'Compresor 40LTS 2HP 1500W', 29800, 8, 'Compresor de aire de 40 litros, motor de 2HP (1500W), ideal para herramientas neumáticas.', 1, 'Energy'),
(32, 3114, 'Pistola de Calor 2000W', 4300, 25, 'Pistola térmica de 2000W con control de temperatura, para trabajos de soldado, pintura, etc.', 1, 'Energy'),
(33, 3115, 'Amoladora Angular 115MM', 7200, 22, 'Amoladora angular de 115mm, ergonómica y potente para cortes y desbastes.', 1, 'Energy'),
(34, 3116, 'Taladro Percutor 13MM', 8700, 19, 'Taladro percutor de 13mm, ideal para perforaciones en mampostería, madera y metal.', 1, 'Energy'),
(51, 3117, 'Martillo para panel de yeso de 15oz', 6900, 15, 'Martillo Milwaukee de 15oz diseñado para paneles de yeso, con cabeza plana y mango ergonómico.', 1, 'Milwaukee'),
(52, 3118, 'Cinta Métrica Magnética de Hoja Ancha', 4800, 30, 'Cinta métrica de hoja ancha Milwaukee con gancho magnético y 8m de alcance.', 1, 'Milwaukee'),
(53, 3119, 'Escuadra para Cabrios de 300mm', 5200, 18, 'Escuadra para cabrios de aluminio Milwaukee de 300mm, precisión profesional.', 1, 'Milwaukee'),
(54, 3120, 'Probador de Voltaje y Continuidad', 4100, 20, 'Probador eléctrico Milwaukee para voltaje AC/DC y continuidad, pantalla LED.', 1, 'Milwaukee'),
(55, 3121, 'Juego de 15 Llaves Combinadas', 14900, 12, 'Set de 15 llaves combinadas Milwaukee en estuche, acabado satinado.', 1, 'Milwaukee'),
(56, 3122, 'Cortador de Tuberías de Trinquete', 7300, 14, 'Cortador Milwaukee con sistema de trinquete para tubos de PVC, cobre y más.', 1, 'Milwaukee'),
(57, 3123, 'Kit de Pinzas de 3 Piezas', 9800, 10, 'Kit de pinzas Milwaukee incluye pinza universal, de corte y de punta larga.', 1, 'Milwaukee'),
(58, 3124, 'Juego de 22 Llaves en L con Extremos de Bola', 8900, 11, 'Juego de llaves hexagonales Milwaukee con extremos de bola, organizador incluido.', 1, 'Milwaukee'),
(87, 44, 'remera', 300, 70, '0', 1, 'Equus');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','cliente') NOT NULL DEFAULT 'cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol`) VALUES
(1, 'Juan Perez', 'juan@correo.com', '$2y$10$eImiTXuWVxfM37uY4JANjQ==', 'cliente'),
(2, 'Ana Gomez', 'ana@correo.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye', 'cliente'),
(3, 'Carlos Ruiz', 'carlos@correo.com', '$2y$10$wHh6Q8QJQJQJQJQJQJQJQO', 'cliente'),
(7, 'Lautaro Etcheverry', 'lautaroetcheverry@gmail.com', '$2y$10$ZUrwgmv9IDhapLXQbeWbG.9BraMnKA.SglHiuZ1VbNseF95Z.tEm.', 'cliente'),
(11, 'nacho', 'nacho@gmail.com', '$2y$10$G3ToxobuDZ6.HPrUPIiXa.9f8Vgh2xoEBQusegexrsbtkJiMxpUSy', 'cliente'),
(12, 'Martin Caraballo', 'martin@gmail.com', '$2y$10$QqIB7P2mBzb.SOWuYSkH8eTvDqGuYHOc/KkX1qVQHP.gATPiDP0IG', 'admin'),
(13, 'eliseo', 'eliseo@gmail.com', '$2y$10$HCuZ7k2ClHnLcbo1tnJZVe9CrMj4rBnf8TyYuluY8Jm5a9n6/BnN.', 'cliente'),
(14, 'prueba', 'prueba@gmail.com', '$2y$10$MQF9FHhLYQD0Eqd3PRcnpOBJuoLmnC8wbJCL5KDDbdQ/7UnPk2YnC', 'cliente'),
(20, 'peterbot', 'peterbot@gmail.com', '$2y$10$YGAgKkg0nnbNbGRLgoxY0.r3g.aSJ9pLAcZ7iO1krMsMebh8GmD7K', 'cliente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `pedido_detalles`
--
ALTER TABLE `pedido_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_categoria` (`id_categoria`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedido_detalles`
--
ALTER TABLE `pedido_detalles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `pedido_detalles`
--
ALTER TABLE `pedido_detalles`
  ADD CONSTRAINT `pedido_detalles_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  ADD CONSTRAINT `pedido_detalles_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `producto_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
