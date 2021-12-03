<?php
include 'conexion.php';

$consulta = "SELECT nombreRest, nombrePlatillo, precio FROM platillos LEFT JOIN restaurante ON restaurante.idRestaurante=platillos.Restaurante_idRestaurante";
$resultado = $conexion -> query($consulta);

while($fila=$resultado -> fetch_array()){
    $producto[] = array_map('utf8_encode', $fila);
}

echo json_encode($producto);
$resultado->close();
?>