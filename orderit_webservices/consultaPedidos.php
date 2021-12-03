<?php
include 'conexion.php';
$idUsuario=$_GET['idUsuario'];


$sentencia=$conexion->prepare("SELECT idPedidos, fecha, cantidad, total, nombrePlatillo, precio, nombreRest, costoEntrega, direccion FROM pedidos INNER JOIN platillos INNER JOIN restaurante WHERE Usuarios_idUsuario=? AND Platillos_idPlatillos=platillos.idPlatillos AND restaurante.idRestaurante = platillos.Restaurante_idRestaurante ORDER BY idPedidos");
$sentencia->bind_param('i',$idUsuario);
$sentencia->execute();

$resultado = $sentencia->get_result();

while ($fila = mysqli_fetch_array($resultado, MYSQLI_ASSOC)){
    $usuario[] = array_map('utf8_encode', $fila);
}

echo json_encode($usuario);

$sentencia->close();
$conexion->close();
?>
