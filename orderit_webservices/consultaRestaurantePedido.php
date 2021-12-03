<?php
include 'conexion.php';

$consulta= "SELECT idRestaurante, nombreRest, direccion, horario, tiempoEstimado, costoEntrega, idPlatillos, nombrePlatillo, precio 
            FROM restaurante INNER JOIN platillos WHERE restaurante.idRestaurante = platillos.Restaurante_idRestaurante";
$resultado = $conexion -> prepare($consulta);

$resultado->execute();

$resultado->bind_result($idRestaurante, $nombreRest, $direccion, $horario, $tiempoEstimado, $costoEntrega, $idPlatillos, $nombrePlatillo, $precio);

$restaurantes = array();

while($resultado->fetch()){
	
	$temp = array();
	$temp['idRestaurante'] = $idRestaurante;
	$temp['nombreRest'] = $nombreRest;
	$temp['direccion'] = $direccion;
	$temp['horario'] = $horario;
	$temp['tiempoEstimado'] = $tiempoEstimado;
	$temp['costoEntrega'] = $costoEntrega;
    $temp['idPlatillos'] = $idPlatillos;
    $temp['nombrePlatillo'] = $nombrePlatillo;
    $temp['precio'] = $precio;
	
	array_push($restaurantes, $temp);
    
}

echo json_encode($restaurantes);

?>