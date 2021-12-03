<?PHP
include 'conexion.php';
$idUsuario=$_POST['idUsuario'];
$nombreUsuario=$_POST['nombreUsuario'];
$apPaterno=$_POST['apPaterno'];
$apMaterno=$_POST['apMaterno'];
$email=$_POST['email'];
$password=$_POST['password'];

$consulta="INSERT INTO usuarios VALUES('".null."','".$nombreUsuario."','".$apPaterno."','".$apMaterno."','".$email."','".$password."')";

mysqli_query($conexion,$consulta) or die (mysqli_error());
mysqli_close($conexion);
?>