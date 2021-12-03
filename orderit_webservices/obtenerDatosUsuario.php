<?php
include 'conexion.php';
$email=$_GET['email'];
$password=$_GET['password'];

$sentencia=$conexion->prepare("SELECT * FROM usuarios WHERE email=? and password=?");
$sentencia->bind_param('ss', $email, $password);
$sentencia->execute();

$resultado = $sentencia->get_result();

while ($fila = mysqli_fetch_array($resultado, MYSQLI_ASSOC)){
    $usuario[] = array_map('utf8_encode', $fila);
}

echo json_encode($usuario);

$sentencia->close();
$conexion->close();
?>