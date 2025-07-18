<?php
require_once __DIR__ . '../conexion.php'; 

class Producto {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function obtenerTodos() {
        $stmt = $this->conn->prepare("SELECT * FROM productos");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function obtenerPorId($id) {
        $stmt = $this->conn->prepare("SELECT * FROM productos WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

public function agregar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca) {
    $stmt = $this->conn->prepare("INSERT INTO productos (codigo, nombre, precio, stock, descripcion, id_categoria, marca) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("isdiiss", $codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca);
    return $stmt->execute();
}


public function modificar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $id) {
    $stmt = $this->conn->prepare("UPDATE productos SET codigo=?, nombre=?, precio=?, stock=?, descripcion=?, id_categoria=?, marca=? WHERE id=?");
    $stmt->bind_param("isdiissi", $codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $id);
    return $stmt->execute();
}

    public function eliminar($id) {
        $stmt = $this->conn->prepare("DELETE FROM productos WHERE id=?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}
?>
