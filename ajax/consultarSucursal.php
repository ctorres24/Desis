<?php
include '../config/conexion.php';
$codigo_bodega = $_POST['codigo'];
$sql = "SELECT codigo, nombre FROM sucursal WHERE cod_bodega = '$codigo_bodega'";
$result = mysqli_query($conexion, $sql);
$option = "<option value=''></option>";
if (mysqli_num_rows($result) > 0) {
    while($row = mysqli_fetch_assoc($result)) {
        $option .= "<option value='" . $row["codigo"] . "'>" . $row["nombre"] . "</option>";
    }
}
echo $option;

?>
