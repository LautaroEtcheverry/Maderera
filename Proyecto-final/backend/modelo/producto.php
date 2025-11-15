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

    public function obtenerPorCategoria($categoriaId) {
        $stmt = $this->conn->prepare("SELECT * FROM productos WHERE id_categoria = ?");
        $stmt->bind_param("i", $categoriaId);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function agregar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $fileUrl) {
        $stmt = $this->conn->prepare("INSERT INTO productos (codigo, nombre, precio, stock, descripcion, id_categoria, marca, imagen) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("isdissss", $codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $fileUrl);
        return $stmt->execute();
    }
public function modificar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $id) {
    $stmt = $this->conn->prepare(
        "UPDATE productos SET codigo=?, nombre=?, precio=?, stock=?, descripcion=?, id_categoria=?, marca=? WHERE id=?"
    );
    $stmt->bind_param("ssdisisi", $codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $id);
    $stmt->execute();

    return $stmt->affected_rows > 0;
}

    public function eliminar($id) {
        $stmt = $this->conn->prepare("DELETE FROM productos WHERE id=?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}
?>

