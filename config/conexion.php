<?php
$host = 'localhost'; 
$usuario = 'root';
$contraseña = '';
$nombre_db = 'Desis';

$conexion = mysqli_connect($host, $usuario, $contraseña, $nombre_db);

if (!$conexion) {
    die("Conexión fallida: " . mysqli_connect_error());
}

?>