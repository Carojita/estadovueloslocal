<?php
include 'db.php';
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json");

error_reporting(E_ERROR | E_PARSE);

$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'GET':
        if (isset($_GET['destino']) && isset($_GET['origen'])) {
            $destino = $_GET['destino'];
            $origen = $_GET['origen'];
            $result = $conn->query("SELECT vuelo.iata, vuelo.estado, CONCAT(A1.nombre, ' - ', A1.ciudad) AS origen, CONCAT(A2.nombre, ' - ', A2.ciudad) AS destino, vuelo.salida, vuelo.llegada, vuelo.demora, aerolinea.nombre AS aerolinea FROM vuelo INNER JOIN aerolinea ON vuelo.aerolinea = aerolinea.iata INNER JOIN aeropuerto AS A1 ON vuelo.origen = A1.iata INNER JOIN aeropuerto AS A2 ON vuelo.destino = A2.iata WHERE origen='$origen' AND destino ='$destino'");
            $vuelos = [];
            while ($row = $result->fetch_assoc()) {
                $vuelos[] = $row;
            }
            echo json_encode($vuelos);
        } else {
            $result = $conn->query("SELECT * FROM vuelo");
            $vuelos = [];
            while ($row = $result->fetch_assoc()) {
                $vuelos[] = $row;
            }
            echo json_encode($vuelos);
        }
        break;

    case 'POST':
        $iata = $input['iata'];
        $destino = $input['destino'];
        $origen = $input['origen'];
        $estado = $input['estado'];
        $salida = $input['salida'];
        $llegada = $input['llegada'];
        $aerolinea = $input['aerolinea'];
        $demora = $input['demora'];
        //Crea un mensaje 500 [Internal Server Error] en caso de que se intente crear un vuelo sin infomación importante
        if (!isset($input['iata']) or !isset($input['destino']) or !isset($input['origen']) or !isset($input['llegada']) or !isset($input['salida']) or !isset($input['aerolinea'])){
            $faltantes = "";
            $cant = 0;
            if (!isset($input['iata'])){
                $cant += 1;
                $faltantes .= 'iata';}
            if (!isset($input['destino'])){
                if ($cant > 0){
                    $faltantes .= ', ';
                }
                $cant += 1;
                $faltantes .= 'destino';}
            if (!isset($input['origen'])){
                if ($cant > 0){
                    $faltantes .= ', ';
                }
                $cant += 1;
                $faltantes .= 'origen';}
            if (!isset($input['salida'])){
                if ($cant > 0){
                    $faltantes .= ', ';
                }
                $cant += 1;
                $faltantes .= 'salida';}
            if (!isset($input['llegada'])){
                if ($cant > 0){
                    $faltantes .= ', ';
                }
                $cant += 1;
                $faltantes .= 'llegada';}
            if (!isset($input['aerolinea'])){
                if ($cant > 0){
                    $faltantes .= ', ';
                }
                $cant += 1;
                $faltantes .= 'aerolínea';}
        echo json_encode(["Mensaje 500" => "No es posible crear un vuelo sin ".$faltantes]);
        break;
        }

        //Revisamos si el vuelo ya existe, de ser así, retornamos 500 [Internal Server Error]
        $result = $conn->query("SELECT * FROM vuelo WHERE iata='$iata'");
        $existe = false;
        $vuelos = [];
            while ($row = $result->fetch_assoc()) {
                $existe = true;
            }
        if ($existe) {
            echo json_encode(["Mensaje 500" => "Ya existe un vuelo con código IATA ".$iata.". No puede existir más de un vuelo con el mismo código IATA."]);
        break;
        }

        $consulta = "INSERT INTO vuelo (iata, destino, origen, salida, llegada, aerolinea";
        $valores = "VALUES ('$iata', '$destino', '$origen', '$salida', '$llegada', '$aerolinea'";
        if (isset($input['estado'])) {
            $consulta .= ", estado";
            $valores .= ", '$estado'";
        }
        if (isset($input['demora'])) {
            $consulta .= ", demora";
            $valores .= ", '$demora'";
        }
        $consulta .= ")";
        $valores .= ")";

        $conn->query($consulta . $valores);
        echo json_encode(["Mensaje 201" => "El vuelo se agregó exitosamente."]);
        break;

    case 'PUT':
        $iata = $input['iata'];
        $destino = $input['destino'];
        $origen = $input['origen'];
        $estado = $input['estado'];
        $salida = $input['salida'];
        $llegada = $input['llegada'];
        $aerolinea = $input['aerolinea'];
        $demora = $input['demora'];
        $consulta = "UPDATE vuelo SET";

        //Revisamos si el vuelo existe, de lo contrario, retornamos 404 [Not Found]
        $result = $conn->query("SELECT * FROM vuelo WHERE iata='$iata'");
        $existe = false;
        $vuelos = [];
            while ($row = $result->fetch_assoc()) {
                $existe = true;
            }
        if (!$existe) {
            echo json_encode(["Mensaje 404" => "El vuelo con código IATA ".$iata." no existe."]);
        break;
        }

        if (isset($input['destino'])) {
            $consulta .= " destino='$destino'";
        }
        if (isset($input['origen'])) {
            $consulta .= " origen='$origen'";
        }
        if (isset($input['estado'])) {
            $consulta .= " estado='$estado'";
        }
        if (isset($input['salida'])) {
            $consulta .= " salida='$salida'";
        }
        if (isset($input['llegada'])) {
            $consulta .= " llegada='$llegada'";
        }
        if (isset($input['aerolinea'])) {
            $consulta .= " aerolinea='$aerolinea'";
        }
        if (isset($input['demora'])) {
            $consulta .= " demora='$demora'";
        }

        $consulta .= " WHERE iata='$iata'";

        echo json_encode(["Mensaje 204" => "El vuelo se editó exitosamente."]);
        break;

    case 'DELETE':
        $iata = $_GET['iata'];

        //Revisamos si el vuelo existe, de lo contrario, retornamos 404 [Not Found]
        $result = $conn->query("SELECT * FROM vuelo WHERE iata='$iata'");
        $existe = false;
        $vuelos = [];
            while ($row = $result->fetch_assoc()) {
                $existe = true;
            }
        if (!$existe) {
            echo json_encode(["Mensaje 404" => "El vuelo con código IATA ".$iata." no existe."]);
        break;
        }

        $conn->query("DELETE FROM vuelo WHERE iata='$iata'");
        echo json_encode(["Mensaje 204" => "El vuelo se eliminó exitosamente."]);
        break;

    default:
        echo json_encode(["Mensaje 500" => "Método de Petición Inválido"]);
        break;
}

$conn->close();
?>