<?PHP
include 'conexion.php';
$idUsuario=$_GET['idUsuario'];
$nombreUsuario=$_GET['nombreUsuario'];
$apPaterno=$_GET['apPaterno'];
$apMaterno=$_GET['apMaterno'];
$email=$_GET['email'];
$password=$_GET['password'];


$consulta="UPDATE usuarios SET nombreUsuario='".$nombreUsuario."', apPaterno='".$apPaterno."', apMaterno='".$apMaterno."', email='".$email."', password='".$password."' WHERE idUsuario='".$idUsuario."'";
echo ($consulta);

mysqli_query($conexion,$consulta) or die (mysqli_error());
echo ("Exito");
mysqli_close($conexion);
?>