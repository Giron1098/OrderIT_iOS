<?php
include 'conexion.php';

$consulta= "SELECT idRestaurante, nombreRest, direccion, horario, tiempoEstimado, costoEntrega FROM restaurante";
$resultado = $conexion -> prepare($consulta);

$resultado->execute();

$resultado->bind_result($idRestaurante, $nombreRest, $direccion, $horario, $tiempoEstimado, $costoEntrega);

$restaurantes = array();

while($resultado->fetch()){
	
	$temp = array();
	$temp['idRestaurante'] = $idRestaurante;
	$temp['nombreRest'] = $nombreRest;
	$temp['direccion'] = $direccion;
	$temp['horario'] = $horario;
	$temp['tiempoEstimado'] = $tiempoEstimado;
	$temp['costoEntrega'] = $costoEntrega;
	
	array_push($restaurantes, $temp);
    
}

echo json_encode($restaurantes);

?>