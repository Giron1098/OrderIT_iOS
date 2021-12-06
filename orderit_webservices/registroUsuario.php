<?PHP
error_reporting(E_ERROR | E_PARSE);
include 'conexion.php';
$idUsuario=$_GET['idUsuario'];
$nombreUsuario=$_GET['nombreUsuario'];
$apPaterno=$_GET['apPaterno'];
$apMaterno=$_GET['apMaterno'];
$email=$_GET['email'];
$password=$_GET['password'];

if($email != "") {
    $sentencia=$conexion->prepare("SELECT * FROM usuarios WHERE email=?");
	$sentencia->bind_param('s',$email);
	$sentencia->execute();
	$resultado = $sentencia->get_result();
    $num_rows = mysqli_num_rows($resultado);
    if($num_rows >= 1){
		$msg = new stdClass();
		$msg->mensaje = "Correo ya registrado";
		$msgJSON = json_encode($msg,JSON_UNESCAPED_UNICODE);

		echo $msgJSON;
    }else{
		$msg = new stdClass();
		$msg->mensaje = "Usuario registrado exitosamente";
		$msgJSON = json_encode($msg,JSON_UNESCAPED_UNICODE);

		echo $msgJSON;

        $consulta="INSERT INTO usuarios VALUES(null,'".$nombreUsuario."','".$apPaterno."','".$apMaterno."','".$email."','".$password."')";
        mysqli_query($conexion,$consulta) or die (mysqli_error($conexion));
		mysqli_close($conexion);
    }
}
?>
