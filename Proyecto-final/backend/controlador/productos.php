<?php
// Controlador para manejar productos genéricos
require_once __DIR__ . '/../modelo/conexion.php'; // <-- Agrega esta línea
require_once __DIR__ . '/../modelo/producto.php';


$productoModel = new Producto($conn); // Instancia del modelo

function listarProductos() {
    global $productoModel;
    echo json_encode($productoModel->obtenerTodos());
}

function mostrarProducto($id) {
    global $productoModel;
    $producto = $productoModel->obtenerPorId($id);
    if ($producto) {
        echo json_encode($producto);
    } else {
        echo json_encode(["error" => "Producto no encontrado"]);
    }
}

function agregarProducto($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca) {
    global $productoModel;
    if ($productoModel->agregar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca)) {
        echo json_encode(["mensaje" => "Producto agregado"]);
    } else {
        echo json_encode(["error" => "No se pudo agregar"]);
    }
}


function modificarProducto($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $idProducto) {
    global $productoModel;
    if ($productoModel->modificar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $idProducto)) {
        echo json_encode(["mensaje" => "Producto modificado", "id" => $idProducto]);
    } else {
        echo json_encode(["error" => "No se pudo modificar"]);
    }
}

function eliminarProducto($id) {
    global $productoModel;
    if ($productoModel->eliminar($id)) {
        echo json_encode(["mensaje" => "Producto eliminado", "id" => $id]);
    } else {
        echo json_encode(["error" => "No se pudo eliminar"]);
    }
}
?>