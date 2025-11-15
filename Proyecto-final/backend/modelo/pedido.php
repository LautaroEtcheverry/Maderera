<?php
require_once "conexion.php";

class Pedido {
    private $conn;

    public function __construct() {
        $this->conn = conectarDB();
    }

    public function crearPedido($usuario_id) {
        $stmt = $this->conn->prepare("INSERT INTO pedidos (usuario_id, fecha, estado) VALUES (?, NOW(), 'pendiente')");
        $stmt->bind_param("i", $usuario_id);
        if (!$stmt->execute()) {
            return false;
        }

        $pedido_id = $this->conn->insert_id;

        $sqlCarrito = "SELECT producto_id, cantidad, precio FROM carrito WHERE usuario_id = ?";
        $stmtCarrito = $this->conn->prepare($sqlCarrito);
        $stmtCarrito->bind_param("i", $usuario_id);
        $stmtCarrito->execute();
        $result = $stmtCarrito->get_result();

        if ($result->num_rows === 0) {
            return false;
        }

        $sqlDetalle = "INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
        $stmtDetalle = $this->conn->prepare($sqlDetalle);

        while ($row = $result->fetch_assoc()) {
            $stmtDetalle->bind_param("iiid", $pedido_id, $row["producto_id"], $row["cantidad"], $row["precio"]);
            $stmtDetalle->execute();
        }

        $this->conn->query("DELETE FROM carrito WHERE usuario_id = $usuario_id");

        return $pedido_id;
    }
}
?>
