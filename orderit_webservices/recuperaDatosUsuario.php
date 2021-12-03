<?php
include 'conexion.php';
$email_log=$_GET['email'];
$password_log=$_GET['password'];


$sentencia=$conexion->prepare("SELECT * FROM usuarios WHERE email=? and password=?");
$sentencia->bind_param('ss',$email_log,$password_log);
$sentencia->execute();

$resultado = $sentencia->get_result();

while ($fila = $resultado->fetch_assoc()){
    $usuario[] = array_map('utf8_encode', $fila);
}

echo json_encode($usuario);

$sentencia->close();
$conexion->close();
?>