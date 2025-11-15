-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-11-2025 a las 01:47:15
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

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `usuario_id`, `producto_id`, `cantidad`, `agregado_en`) VALUES
(135, 1, 121, 5, '2025-11-03 18:16:14'),
(136, 1, 122, 1, '2025-11-03 18:55:54');

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
  `direccion_envio` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `fecha`, `estado`, `total`, `direccion_envio`, `telefono`, `direccion`) VALUES
(37, 7, '2025-11-15 00:16:02', 'pendiente', 24900.00, NULL, '099 66 234', 'ejemplo');

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

--
-- Volcado de datos para la tabla `pedido_detalles`
--

INSERT INTO `pedido_detalles` (`id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`) VALUES
(55, 37, 89, 1, 2500.00),
(56, 37, 97, 1, 1500.00),
(57, 37, 81, 1, 1500.00),
(58, 37, 115, 1, 900.00),
(59, 37, 107, 1, 3500.00);

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
  `marca` varchar(45) NOT NULL,
  `imagen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `nombre`, `precio`, `stock`, `descripcion`, `id_categoria`, `marca`, `imagen`) VALUES
(81, 4001, 'Compensado pino elliotis 4mm 2.20x1.60mts', 1500, 20, 'Compensado pino elliotis 4mm 2.20x1.60mts', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/COMPENSADO PINO ELLIOTIS 4mm 2.20×1.60.png'),
(82, 4002, 'Fibra facil de pino', 1200, 30, 'Es un tablero de fibras de madera unidas por adhesivos urea-formaldehído. Excelente facilidad para aplicar pinturas y moldurar, permitiendo excelentes terminaciones. Variedad de espesores.', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Fibra facil pino.png'),
(83, 4003, 'Hoja de puerta variedad de medidas', 4500, 15, 'Hojas de puerta revestidas en madera virola, resistente y sin marco.\n\n', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Hoja de puerta variedad de medidas.png'),
(84, 4004, 'Lambriz pino finlandes ', 2500, 25, 'Panel Thermowood de primera calidad con un borde afilado que crea una línea de sombra de 3 mm entre los paneles. La fijación oculta permite un diseño moderno y limpio.', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Lambriz pino finlandes 19mm x 117mm x 4.8mt.png'),
(85, 4005, 'MDF Melaminico ', 3500, 18, 'Variedadde colores Medidas 18mm 2.75x1.85mts', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/MDF Melaminico variedad de colores 18mm 2.75x1.85.png'),
(86, 4006, 'Paneles OSB ', 1800, 22, 'Los paneles de OSB están formados por virutas de madera que se unen entre sí con un aglomerante mediante la aplicación de calor y presión.  Variedad de espesores.', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Paneles OSB 2.44 x 1.22.png'),
(87, 4007, 'Puerta para interior completa', 6000, 12, 'Puerta Compensada para Interior con Marco de 9.5 cm.\nMedidas con marco incluido son 75 cm x 2.10 m Derecha e izquierda.', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Puerta para interior completa.png'),
(88, 4008, 'Tirante de pino CCA cepillado', 2200, 28, 'Tirante de pino CCA cepillado en varias medidas.\n\n', 6, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Tirante de pino CCA cepillado variedad de medidas.png'),
(89, 5001, 'Angulos todas las medidas', 2500, 30, 'Ángulos de hierro, 6 metros de largo cada unidad. Ancho y espesor en pulgadas\n', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Angulos todas las medidas.png'),
(90, 5002, 'Chapa para techo aluminizada', 4800, 20, 'Chapa acanalada aluminizada o galvanizada, se comercializa en calibre 24 y 26. En diferentes opciones de largos, se confeccionan largos especiales.', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Chapa para techo variedad de medidas.png'),
(91, 5003, 'Malla electrosoldada para construccion', 3200, 25, 'Malla electrosoldada para construccion  Variedad de medidas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Malla electrosoldada para construccion.png'),
(92, 5004, 'Planchuelas lisas ', 4100, 18, 'Mallas de cercos galvanizadas Variedad de medidas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Planchuelas lisas todas las medidad.png'),
(93, 5005, 'Varilla tratada conformada', 4100, 18, 'Varilla tratada conformada Variedad de medidas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Varilla tratada conformada.png'),
(94, 5006, 'Tubos cuadrados', 3700, 28, 'Tubos cuadrados Variedad de medidas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Tubo cuadrado todas las medidas.jpg'),
(95, 5007, 'Tubos rectangulares ', 3700, 28, 'Tubos rectangulares Variedad de medidas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Tubos rectangulares todas las medidas.jpg'),
(96, 5008, 'Mallas de cercos galvanizadas', 2900, 22, 'Mallas de cercos galvanizadas', 2, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Mallas de cercos galvanizadas.png'),
(97, 6001, 'Aerosol 7cf azul 400ml', 1500, 25, 'Aerosol 7cf azul 400ml', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Aerosol 7cf azul 400ml.png'),
(98, 6002, 'Aquapisos Aqua belco', 4200, 18, 'Aquapisos Aqua belco', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Aquapisos Aqua belco.png'),
(99, 6003, 'Barniz color para madera Fácil', 2800, 22, 'Barniz color para madera Fácil', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Barniz color para madera Fácil.png'),
(100, 6004, 'Belcolux 3en1 Aqua belco', 3900, 20, 'Belcolux 3en1 Aqua belco', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Belcolux 3en1 Aqua belco.png'),
(101, 6005, 'Esmalte aerosol 7cf negro mate 400ml', 1600, 28, 'Esmalte aerosol 7cf negro mate 400ml', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Esmalte aerosol 7cf negro mate 400ml.png'),
(102, 6006, 'Laca nitro brillante Aqua belco', 3100, 24, 'Laca nitro brillante Aqua belco', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Laca nitro brillante Aqua belco.png'),
(103, 6007, 'Plastificante para pisos Aqua belco', 4500, 16, 'Plastificante para pisos Aqua belco', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Plastificante para pisos Aqua belco.png'),
(104, 6008, 'Protector de madera Aqua belco', 3700, 21, 'Protector de madera Aqua belco', 5, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Protector de madera Aqua belco.png'),
(105, 7001, 'WPC Revestimiento interior', 2200, 30, 'Variedad de colores Medida unica 16cm x 2,90m', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/WPC Revestimiento interior variedad de colores 16cm x 2,90m.png'),
(106, 7002, 'Lamina PVC imitacion marmol ', 3500, 20, 'Variedad de colores y diseños Medida unica de 1.22mts x 2.44mts', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Lamina PVC imitacion marmol variedad de colores y diseños.png'),
(107, 7003, 'Enduido bolsa de 20Kg', 3500, 20, 'Enduido plástico interior fabricado a base de resinas acrílicas y cargas seleccionadas', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Enduido bolsa de 20KG.png'),
(108, 7004, 'Pisos vinilicos SPC', 3500, 20, 'Sistema click, no requiere ashesivos Medidas 4mm 1.20 x 18cm Variedad de colores y diseños', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Pisos vinilicos SPC variedad de colores .png'),
(109, 7005, 'Soporte en L 38x50 x 50mm', 800, 40, 'SOPORTE EN L MULTIPERFORADO 38 X 50 X 50MM\n', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Soporte en L 38x50 x 50mm.png'),
(110, 7006, 'Placa yeso resistente a la humedad', 800, 40, 'Durlock 12.5mm 1.20×2.40', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Placa yeso resistente a la humedad durlock 12.5mm 1.20x2.40.png'),
(111, 7007, 'Tornillo T4 punta aguja', 800, 40, 'Tornillo T4 Punta Aguja\n', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Tornillo T4 punta aguja.png'),
(112, 7008, 'Tabilla cielorraso pvc', 4600, 15, 'TABLILLA PVC 10mm x 0.20×6.00m. BLANCO HIELO CON RANURA\n', 8, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Tabilla cielorraso pvc 10mm x 0.20x6.00mm blanco.png'),
(113, 8001, 'Cerradura exterior alianca cromada', 900, 35, 'Cerradura exterior alianca cromada', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Cerradura exterior alianca cromada.png'),
(114, 8002, 'Manija N14 de 128mm satinada', 900, 35, 'Manija N14 de 128mm satinada', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Manija N14 de 128mm satinada.png'),
(115, 8003, 'Bisagra curva 35mm con  base', 900, 35, 'Bisagra curva 35mm con  base', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Bisagra curva 35mm con base.png'),
(116, 8004, 'Bisagra 4x3x3 acero inoxidable', 900, 35, 'Bisagra 4x3x3 acero inoxidable', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Bisagra 4x3x3acero inoxidable.png'),
(117, 8005, 'Base para columna de madera', 900, 35, 'Base para columna de madera', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Base para columna de madera .png'),
(118, 8006, 'Manija N38 de 96mm estilo bronce antiguo', 1500, 20, 'Manija N38 de 96mm estilo bronce antiguo', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Manija N38 de 96mm estilo bronce antiguo .png'),
(119, 8007, 'Pomo cerradura bola mate con llave', 2200, 18, 'Pomo cerradura bola mate con llave', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Pomo cerradura bola mate con llave.png'),
(120, 8008, 'Rueda gemela de 40mm con base', 1200, 25, 'Rueda gemela de 40mm con base', 7, 'Genérica', '/maderera/Proyecto-final/imagenes_productos/Rueda gemela de 40mm con base.png'),
(121, 9101, 'Amoladora eléctrica Equus 900w', 15000, 12, 'Potencia:900W 220V / 50Hz Diametro de disco: 115mm', 1, 'Equus', '/maderera/Proyecto-final/imagenes_productos/amoladora_equus_900.jpg'),
(122, 9102, 'Caja de Herramientas', 1990, 12, 'Caja de Herramientas', 1, 'Equus', '/maderera/Proyecto-final/imagenes_productos/caja de herramientas equus.jpg'),
(123, 9103, 'Casco con protector facial y de oídos', 7500, 20, 'Casco con protector facial y de oídos Equus para Jardinería\n', 1, 'Equus', '/maderera/Proyecto-final/imagenes_productos/Casco con protector facial y de oídos Equus para Jardinería.jpg'),
(124, 9104, 'Mezclador de Pintura Profesional ', 18500, 8, '230V - 50Hz - 1300W Tamaño de la paleta: 120mm Longitud de la paleta: 590mm Volumen maximo: 80L', 1, 'Equus', '/maderera/proyecto-final/imagenes_productos/Mezclador de Pintura Profesional 1300w.jpg'),
(125, 9105, 'Pistola de Calor  Profesional', 11000, 10, 'Potencia:2000W Temperatura: I: 60 °C II: 60-350 °C III: 60-600 °C', 1, 'Equus', '/maderera/proyecto-final/imagenes_productos/Pistola de Calor Equus Profesional 2000wats 3 Niveles de Temperatura.jpg'),
(126, 9106, 'Pocera manual a nafta', 42000, 5, 'Motor 2 tiempos Potencia maxima: 1.5kw/7500rpm Capacidad tanque de combustible: 1.0L', 1, 'Equus', '/maderera/proyecto-final/imagenes_productos/Pocera manua a nafta.jpg'),
(127, 9107, 'Sierra Caladora de mano profesional', 16000, 9, 'Voltaje: 230V - 50Hz Potencia: 500W Capacidad maxima de corte: Madera 55mm, Acero 5mm', 1, 'Equus', '/maderera/proyecto-final/imagenes_productos/Sierra Caladora de Mano Equus 800W Profesional.jpg'),
(128, 9108, 'Taladro Atornillador Inalámbrico ', 19500, 7, 'Volataje: 20V 2 velocidades Mandril ajustable 0.8-10mm Maximo torque: 32NM', 1, 'Equus', '/maderera/proyecto-final/imagenes_productos/Taladro Atornillador Inalámbrico 20V Equus.jpg'),
(129, 9201, 'Abrazaderas tipo G', 2500, 25, '4/5/6 pulgadas        Material de hierro fundido', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Abrazadera G de 4 5 y 6 pulgadas.jpg'),
(130, 9202, 'Alicates de corte diagonal', 3200, 18, '6/7 pulgadas       Material CRV', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Alicates de corte diagonal.jpg'),
(131, 9203, 'Hoja de corte diamante', 4800, 30, 'Hoja de corte de diamante de 10 milimetros', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Hoja de corte de diamante de 10 milimetros.jpg'),
(132, 9204, 'Juego de cinceles de madera ', 5600, 12, '4 piezas Tamaños de 6/12/19 /25 mm', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Juego de cinceles de madera de 4 piezas.jpg'),
(133, 9205, 'Martillo de goma ', 2900, 20, 'Mango de fibra de vidrio Peso de 600grs', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Martillo de goma mango fibra de vidrio.jpg'),
(134, 9206, 'Orejera protectora para ruidos nocivos', 2100, 22, 'Ajusta fácilmente las orejeras en la diadema para un ajuste rápido, el cojín relleno de espuma suave proporciona un buen sellado para protección contra ruidos nocivos', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Orejera protectora para ruidos nocivos.jpg'),
(135, 9207, 'Pincel con mango de plastico', 800, 40, 'PET y cerdas blancas en virola de acero inoxidable\n', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Pincel con mango de plastico.jpg'),
(136, 9208, 'Sierra de mano', 3500, 15, 'Sierra de Mano fixtec', 1, 'Fixtec', '/maderera/proyecto-final/imagenes_productos/Sierra de mano 16 18 o 20 pulgadas.jpg'),
(137, 9301, 'Aspiradora Gladiator Seco-Húmedo', 28000, 6, '30L 220V-50-60Hz Potencia de 1200W Potenica de succion 190AW', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/ASPIRADORA GLADIATOR SECO-HTMEDO 30L.jpg'),
(138, 9302, 'Equipo para pintar batería recargable', 15000, 10, 'Volataje/Frecuencia: 220V - 50Hz  Potencia:360W  Capacidad de carga 800ml', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/Equipo para pintar bateria recargable.jpg'),
(139, 9303, 'Cepilladora recargable', 22000, 8, 'Capacidad: 82 x 2 mm  Potencia: 750W', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/garlopa-gladiator-pro-gr822-18-recargable-18v-maquina-sola-garlopa-gladiator-pro-gr822-18-recargable-18v-maquina-sola.jpg'),
(140, 9304, 'Llave y atornillador de impacto ', 19500, 12, '20V Torque: 350N/m Bateria:2Ah Peso: 0.88kg', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/Llave y atornillador de impacto 20v.jpg'),
(141, 9305, 'Martillo demoledor', 35000, 5, 'Voltaje/Frecuencia: 220V/50-60Hz  Potencia: 1300W Energia de impacto: 18J', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/Martillo Demoledor.jpg'),
(142, 9306, 'Medidor de distancia laser ', 12500, 15, 'Rango de trabajo: 0,05 - 100m  Alimentacion:Pilas tipo AAA 1,5v(x2)  ', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/MEDIDOR L¦SER 30MTS GLADIATOR PRO.jpg'),
(143, 9307, 'Sierra caladora ', 16000, 9, 'Volataje/Frecuencia: 220V-50Hz Potencia:600W Peso: 21kg', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/SIERRA CALADORA 70MM 600W GLADIATOR.jpg'),
(144, 9308, 'Sierra circular recargable Freedom', 27000, 7, 'Frecuencia: 50-60Hz Voltaje: 18V  Peso: 2.6kg', 1, 'Gladiator', '/maderera/proyecto-final/imagenes_productos/SIERRA CIRCULAR RECARGABLE -FREEDOM 18V.jpg'),
(145, 9401, 'Cinta Métrica Global Plus ', 2500, 30, 'Distancia 5M  Conboton de tranca y caja bi-material Resorte tratado a calor para una vida util mayor', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Cinta Métrica Global Plus 5m.jpg'),
(146, 9402, 'Cuchilla Auto-Retráctil de Seguridad', 1800, 25, 'Hoja retractil cuando no siente presión del material que se corta', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Cuchilla Auto-Retráctil de Seguridad.jpg'),
(147, 9403, 'Engrampadora Clavadora ', 7200, 10, 'Presion minima requerida: 90 psi  Peso: 700g', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Engrampadora Clavadora Stanley Tr250.jpg'),
(148, 9404, 'Espátulas para Drywall de 8 ', 3500, 18, 'Espátulas para Drywall de 8 Stanley', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Espátulas Para Drywall De 8 Stanley.jpg'),
(149, 9405, 'Juego de Formones 3 Piezas ', 5600, 12, 'Hoja de aleacion de acero, rectificaday templada en sus caras. Mango bimetria grueso', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Juego de Formones 3 Piezas Stanley.jpg'),
(150, 9406, 'Nivel de Resina Estructural ', 3100, 20, '12 pulgadas (304mm) Estructura de plastico ABS de alto impacto Diseño \"Top-Read\" con burbuja central para mayor versatilidad', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Nivel de Resina Estructural 12 pulgadas.jpg'),
(151, 9407, 'Remachadora para Trabajo Pesado Profesional', 6800, 8, 'Manija alargada para aumentar el torque en la aplicación', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Remachadora para Trabajo Pesado Profesional.jpg'),
(152, 9408, 'Tijeras de Aviación FatMax ', 4300, 14, 'Corte angulado izquierdo  Diseño de alta palanca para cortar etal de hasta calibre 18', 1, 'Stanley', '/maderera/proyecto-final/imagenes_productos/Tijeras de Aviación FatMax Corte Angulado Izquierdo.jpg'),
(227, 1, 'Producto de Ejemplo', 12, 9, 'Ejemplo de Producto', 1, 'Ejemplo', '/maderera/Proyecto-final/imagenes_productos/6917c69fc1f05_Orejera protectora para ruidos nocivos.jpg');

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
(14, 'prueba', 'prueba@gmail.com', '$2y$10$MQF9FHhLYQD0Eqd3PRcnpOBJuoLmnC8wbJCL5KDDbdQ/7UnPk2YnC', 'cliente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `carrito_ibfk_2` (`producto_id`);

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
  ADD KEY `pedido_detalles_ibfk_2` (`producto_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `pedido_detalles`
--
ALTER TABLE `pedido_detalles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

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
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `pedido_detalles`
--
ALTER TABLE `pedido_detalles`
  ADD CONSTRAINT `pedido_detalles_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `producto_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
