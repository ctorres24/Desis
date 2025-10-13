                


ESTRUCTURA DE ARCHIVOS:
-----------------------
desis/
├── index.php              # Formulario principal
├── conexion.php           # Configuración de base de datos
├── consultarSucursal.php  # AJAX para cargar sucursales
├── verificarCodigo.php    # AJAX para verificar códigos únicos
├── guardarProducto.php    # Procesamiento del formulario
└── README.txt             # Este archivo

VERSIÓN:
PHP: 8.2.4
MySQL
INSTALACIÓN:




1. CONFIGURAR BASE DE DATOS:
   - Abrir phpMyAdmin (http://localhost/phpmyadmin)
   - Crear una nueva base de datos llamada "desis"
   - Ejecutar las siguientes consultas SQL O si utiliza phpmyadmin se puede cargar directamente el archivo desis.sql :

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
    (1, 'asd123', 2),
    (2, 'asd123', 3),
    (3, 'asd1234', 3),
    (4, 'asd1234', 4);

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
    ('asd123', 'asd123asd', 1, 1, 1, 12.31, 'asdasdqwdqwdwqwddwqdwwdq dqxxdqdq'),
    ('asd1234', 'asdasd', 1, 2, 1, 12, 'asdsadsadasadsadsadsadssd');

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
    ADD UNIQUE KEY `cod_producto` (`cod_producto`,`cod_material`),
    ADD KEY `cod_material` (`cod_material`);

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
    ADD UNIQUE KEY `cod_bodega` (`cod_bodega`,`cod_sucursal`,`cod_moneda`),
    ADD KEY `cod_sucursal` (`cod_sucursal`),
    ADD KEY `cod_moneda` (`cod_moneda`);

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
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  

2. CONFIGURAR CONEXIÓN A BASE DE DATOS:
   - Abrir el archivo conexion.php
   - Verificar/ajustar los parámetros de conexión:
     $servidor = "localhost";
     $usuario = "root"; //Usuario que se tenga configurado donde se ejecute el proyecto.
     $password = ""; //password que se tenga configurado donde se ejecute el proyecto.
     $baseDatos = "Desis";

3. COPIAR ARCHIVOS:
   - Copiar todos los archivos del proyecto a (Siempre y cuando se utilice xampp, para otros gestores va depender de como como este configurado):
     C:\xampp\htdocs\desis\ (desis)
     /Applications/XAMPP/htdocs/dasis/ (Mac)
     /opt/lampp/htdocs/desis/ (Linux)

EJECUCIÓN CON XAMPP:


1. INICIAR SERVICIOS:
   - Abrir el panel de control de XAMPP
   - Iniciar Apache y MySQL
  

2. ACCEDER AL SISTEMA:
   - Abrir navegador web
   - Ir a: http://localhost/desis/


