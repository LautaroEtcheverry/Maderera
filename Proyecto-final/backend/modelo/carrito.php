<?php
class Carrito {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function obtenerPorUsuario($usuario_id) {
        $stmt = $this->conn->prepare("
            SELECT c.id, c.producto_id, c.cantidad, p.nombre, p.precio, p.marca
            FROM carrito c
            INNER JOIN productos p ON c.producto_id = p.id
            WHERE c.usuario_id = ?
        ");
        $stmt->bind_param("i", $usuario_id);
        $stmt->execute();
        $res = $stmt->get_result();
        return $res->fetch_all(MYSQLI_ASSOC);
    }

    public function agregar($usuario_id, $producto_id, $cantidad) {
        // si ya existe, actualizar cantidad
        $stmt = $this->conn->prepare("SELECT id, cantidad FROM carrito WHERE usuario_id=? AND producto_id=?");
        $stmt->bind_param("ii", $usuario_id, $producto_id);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            $row = $res->fetch_assoc();
            $nuevaCantidad = $row["cantidad"] + $cantidad;
            $update = $this->conn->prepare("UPDATE carrito SET cantidad=? WHERE id=?");
            $update->bind_param("ii", $nuevaCantidad, $row["id"]);
            return $update->execute();
        } else {
            $stmt = $this->conn->prepare("INSERT INTO carrito (usuario_id, producto_id, cantidad) VALUES (?, ?, ?)");
            $stmt->bind_param("iii", $usuario_id, $producto_id, $cantidad);
            return $stmt->execute();
        }
    }

    public function eliminar($id) {
        $stmt = $this->conn->prepare("DELETE FROM carrito WHERE id=?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }

    public function vaciar($usuario_id) {
        $stmt = $this->conn->prepare("DELETE FROM carrito WHERE usuario_id=?");
        $stmt->bind_param("i", $usuario_id);
        return $stmt->execute();
    }
}
?>
