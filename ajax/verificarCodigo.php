<?php
include '../config/conexion.php';

if (isset($_POST['codigo'])) {
    $codigo = mysqli_real_escape_string($conexion, $_POST['codigo']);
    
    $sql = "SELECT codigo FROM producto WHERE codigo = '$codigo'";
    $result = mysqli_query($conexion, $sql);
    
    if (mysqli_num_rows($result) > 0) {
        echo "existe";
    } else {
        echo "unico";
    }
} else {
    echo "error";
}

mysqli_close($conexion);
?>
