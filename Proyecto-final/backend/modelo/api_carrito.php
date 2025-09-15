<?php
require "../controlador/carrito.php";

header("Content-Type: application/json");

$requestMethod = $_SERVER["REQUEST_METHOD"];
$usuario_id = 1; // ⚠️ por ahora fijo, después lo tomamos de $_SESSION["id"]

if ($requestMethod == "GET") {
    listarCarrito($usuario_id);
} 
elseif ($requestMethod == "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    agregarAlCarrito($usuario_id, $data["producto_id"], $data["cantidad"]);
}
elseif ($requestMethod == "DELETE") {
    if (isset($_GET["id"])) {
        eliminarDelCarrito($_GET["id"]);
    } else {
        echo json_encode(["error" => "Falta el parámetro id para eliminar"]);
    }
}
else {
    echo json_encode(["error" => "Método no permitido"]);
}
?>
