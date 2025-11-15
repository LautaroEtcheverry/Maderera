<?php
session_start();
require "../controlador/carrito.php";

header("Content-Type: application/json");

$requestMethod = $_SERVER["REQUEST_METHOD"];

if (isset($_SESSION["id_usuario"])) {
    $usuario_id = $_SESSION["id_usuario"];
} else {
    echo json_encode(["error" => "Usuario no autenticado"]);
    exit;
}

switch ($requestMethod) {
    case "GET":
        listarCarrito($usuario_id);
        break;

    case "POST":
        $data = json_decode(file_get_contents("php://input"), true);
        if (!$data || !isset($data["producto_id"])) {
            echo json_encode(["error" => "Datos incompletos"]);
            exit;
        }
        agregarAlCarrito($usuario_id, $data["producto_id"], $data["cantidad"] ?? 1);
        break;

    case "PUT":
        $data = json_decode(file_get_contents("php://input"), true);
        if (!$data || !isset($data["id"]) || !isset($data["cantidad"])) {
            echo json_encode(["error" => "Datos incompletos para actualizar"]);
            exit;
        }
        actualizarCantidad($data["id"], $data["cantidad"]);
        break;

    case "DELETE":
        if (isset($_GET["id"])) {
            eliminarDelCarrito($_GET["id"]);
        } else {
            echo json_encode(["error" => "Falta el parámetro id para eliminar"]);
        }
        break;

    default:
        echo json_encode(["error" => "Método no permitido"]);
        break;
}
?>

