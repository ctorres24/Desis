<?php
include '../config/conexion.php';

header('Content-Type: application/json');

function enviarRespuesta($success, $message) {
    echo json_encode(['success' => $success, 'message' => $message]);
    exit();
}



$codigo = mysqli_real_escape_string($conexion, trim($_POST['codigo']));
$nombre = mysqli_real_escape_string($conexion, trim($_POST['nombre']));
$bodega = mysqli_real_escape_string($conexion, $_POST['bodega']);
$sucursal = mysqli_real_escape_string($conexion, $_POST['sucursal']);
$moneda = mysqli_real_escape_string($conexion, $_POST['moneda']);
$precio = mysqli_real_escape_string($conexion, trim($_POST['precio']));
$descripcion = mysqli_real_escape_string($conexion, trim($_POST['descripcion']));
$materiales = $_POST['materiales'];




mysqli_autocommit($conexion, false);

try {
    $sqlProducto = "INSERT INTO producto (codigo, nombre, cod_bodega, cod_sucursal, cod_moneda, precio, descripcion) 
                    VALUES ('$codigo', '$nombre', '$bodega', '$sucursal', '$moneda', '$precio', '$descripcion')";
    
    if (!mysqli_query($conexion, $sqlProducto)) {
        throw new Exception('Error al insertar el producto: ' . mysqli_error($conexion));
    }
    
    foreach ($materiales as $material) {
        $materialLimpio = mysqli_real_escape_string($conexion, $material);
        $sqlMaterial = "INSERT INTO material_producto (cod_producto, cod_material) VALUES ('$codigo', '$materialLimpio')";
        
        if (!mysqli_query($conexion, $sqlMaterial)) {
            throw new Exception('Error al insertar material: ' . mysqli_error($conexion));
        }
    }


    
    mysqli_commit($conexion);
    enviarRespuesta(true, 'Producto guardado exitosamente.');
    
} catch (Exception $e) {
    mysqli_rollback($conexion);
    enviarRespuesta(false, $e->getMessage());
} finally {
    mysqli_close($conexion);
}
?>
