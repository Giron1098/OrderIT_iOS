<?PHP
include 'conexion.php';

$nombreUsuario=$_GET['nombreUsuario'];
$apPaterno=$_GET['apPaterno'];
$apMaterno=$_GET['apMaterno'];
$email=$_GET['email'];
$password=$_GET['password'];

$consulta="INSERT INTO usuarios VALUES(null,'".$nombreUsuario."','".$apPaterno."','".$apMaterno."','".$email."','".$password."')";

mysqli_query($conexion,$consulta) or die (mysqli_error());
mysqli_close($conexion);
?>
