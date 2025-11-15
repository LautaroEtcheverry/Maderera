<?php
require "conexion.php";
session_start();
header("Content-Type: application/json; charset=UTF-8");

if (!isset($_SESSION["id_usuario"])) {
    echo json_encode(["error" => "Usuario no autenticado"]);
    exit;
}
$usuario_id = $_SESSION["id_usuario"];
$requestMethod = $_SERVER["REQUEST_METHOD"];

switch ($requestMethod) {

case "GET":
    if (isset($_GET["detalles"])) {
        $pedido_id = $_GET["detalles"];
        $query = "SELECT pd.cantidad, pd.precio_unitario, pr.nombre AS nombre_producto
                  FROM pedido_detalles pd
                  JOIN productos pr ON pd.producto_id = pr.id
                  WHERE pd.pedido_id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $pedido_id);
        $stmt->execute();
        $result = $stmt->get_result();
        echo json_encode($result->fetch_all(MYSQLI_ASSOC));
        break;
    }

    if (isset($_GET["admin"])) {
$query = "SELECT p.id, u.nombre AS usuario, p.fecha, p.total, p.estado, p.telefono, p.direccion
          FROM pedidos p
          JOIN usuarios u ON p.usuario_id = u.id
          ORDER BY p.fecha DESC";
        $result = $conn->query($query);
        echo json_encode($result->fetch_all(MYSQLI_ASSOC));
        break;
    }

$query = "SELECT p.id, p.usuario_id, p.fecha, p.estado, p.total, p.telefono, p.direccion, u.nombre AS usuario
          FROM pedidos p
          JOIN usuarios u ON p.usuario_id = u.id
          WHERE p.usuario_id = ?
          ORDER BY p.fecha DESC";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $usuario_id);
$stmt->execute();
$result = $stmt->get_result();
echo json_encode($result->fetch_all(MYSQLI_ASSOC));

    break;
    
   case "POST":
    $data = json_decode(file_get_contents("php://input"), true);
    $telefono = $data['telefono'] ?? '';
    $direccion = $data['direccion'] ?? '';

    $queryCarrito = "SELECT c.producto_id, c.cantidad, p.precio 
                     FROM carrito c 
                     JOIN productos p ON c.producto_id = p.id 
                     WHERE c.usuario_id = ?";
    $stmt = $conn->prepare($queryCarrito);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo json_encode(["error" => "Tu carrito está vacío"]);
        exit;
    }

    $total = 0;
    $productos = [];
    while ($row = $result->fetch_assoc()) {
        $productos[] = $row;
        $total += $row["precio"] * $row["cantidad"];
    }

    $stmtPedido = $conn->prepare("INSERT INTO pedidos (usuario_id, total, fecha, estado, telefono, direccion) VALUES (?, ?, NOW(), 'pendiente', ?, ?)");
    $stmtPedido->bind_param("idss", $usuario_id, $total, $telefono, $direccion);
    $stmtPedido->execute();
    $pedido_id = $stmtPedido->insert_id;

    $stmtDetalle = $conn->prepare("INSERT INTO pedido_detalles (pedido_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)");
    foreach ($productos as $p) {
        $stmtDetalle->bind_param("iiid", $pedido_id, $p["producto_id"], $p["cantidad"], $p["precio"]);
        $stmtDetalle->execute();
    }

    $stmtVaciar = $conn->prepare("DELETE FROM carrito WHERE usuario_id = ?");
    $stmtVaciar->bind_param("i", $usuario_id);
    $stmtVaciar->execute();

    echo json_encode(["mensaje" => "✅ Compra confirmada correctamente", "pedido_id" => $pedido_id]);
    exit;

case "PUT":
    $data = json_decode(file_get_contents("php://input"), true);
    $pedido_id = $data["pedido_id"];
    $estado = $data["estado"];

    $stmt = $conn->prepare("UPDATE pedidos SET estado = ? WHERE id = ?");
    $stmt->bind_param("si", $estado, $pedido_id);
    $stmt->execute();

    echo json_encode(["mensaje" => "Estado actualizado"]);
    break;
}
?>
