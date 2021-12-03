<?PHP
include 'conexion.php';
$Usuario_idUsuario=$_GET['Usuario_idUsuario'];
$Platillos_idPlatillos=$_GET['Platillos_idPlatillos'];
$fecha=$_GET['fecha'];
$cantidad=$_GET['cantidad'];
$total=$_GET['total'];


$consulta="INSERT INTO pedidos VALUES(null,'".$fecha."','".$cantidad."','".$total."','".$Platillos_idPlatillos."','".$Usuario_idUsuario."')";
echo ($consulta);

mysqli_query($conexion,$consulta) or die (mysqli_error($conexion));
echo ("Exito");
mysqli_close($conexion);
?>
