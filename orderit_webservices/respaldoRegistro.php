<?PHP
$hostname_localhost="localhost";
$database_localhost="db_orderit";
$username_localhost="root";
$password_localhost="";

$json=array();

if(isset($_GET["idUsuario"]) && isset($_GET["nombreUsuario"]) && isset($_GET["apPaterno"]) && isset($_GET["apMaterno"]) && isset($_GET["email"]) && isset($_GET["password"])){
    $idUsuario=$_GET['idUsuario'];
    $nombreUsuario=$_GET['nombreUsuario'];
    $apPaterno=$_GET['apPaterno'];
    $apMaterno=$_GET['apMaterno'];
    $email=$_GET['email'];
    $password=$_GET['password'];

    $conexion=mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

    $insert="INSERT INTO usuarios(idUsuario, nombreUsuario, apPaterno, apMaterno, email, password) VALUES ('$idUsuario','$nombreUsuario','$apPaterno','$apMaterno','$email','$password')";
    $resultado_insert=mysqli_query($conexion,$insert);

    if($resultado_insert){
        $consulta="SELECT * FROM usuarios WHERE idUsuario = '{$idUsuario}'";
        $resultado=mysqli_query($conexion,$consulta);

        if($registro=mysqli_fetch_array($resultado)){
            $json['usuarios'][]=$registro;
        }
        mysqli_close($conexion);
        echo json_encode($json);
    }
    else{
        $resulta["idUsuario"]=0;
        $resulta["nombreUsuario"]='No registra';
        $resulta["apPaterno"]='No registra';
        $resulta["apMaterno"]='No registra';
        $resulta["email"]='No registra';
        $resulta["password"]='No registra';
        $json['usuarios'][]=$resulta;
        echo json_encode($json);
    }

}
else{
    $resulta["idUsuario"]=0;
        $resulta["nombreUsuario"]='WS No registra';
        $resulta["apPaterno"]='WS No registra';
        $resulta["apMaterno"]='WS No registra';
        $resulta["email"]='WS No registra';
        $resulta["password"]='WS No registra';
        $json['usuarios'][]=$resulta;
        echo json_encode($json);
}
?>