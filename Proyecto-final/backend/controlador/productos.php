<?php
session_start();

require_once __DIR__ . '/../modelo/conexion.php'; 
require_once __DIR__ . '/../modelo/producto.php';


$productoModel = new Producto($conn); 

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

function agregarProducto($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $fileUrl = null) { 
    global $productoModel;
    return $productoModel->agregar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $fileUrl);
}



function modificarProducto($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $idProducto) {
    global $productoModel;
    return $productoModel->modificar($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $idProducto);
}


function eliminarProducto($id) {
    global $productoModel;
    return $productoModel->eliminar($id);
}



function mostrarProductosPorCategoria($categoriaId) {
    global $productoModel;
    $productos = $productoModel->obtenerPorCategoria($categoriaId);
    echo json_encode($productos);
}

?>
