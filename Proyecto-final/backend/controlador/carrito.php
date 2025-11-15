<?php
require_once __DIR__ . '/../modelo/conexion.php';
require_once __DIR__ . '/../modelo/carrito.php';

$carritoModel = new Carrito($conn);

function listarCarrito($usuario_id) {
    global $carritoModel;
    echo json_encode($carritoModel->obtenerPorUsuario($usuario_id));
}

function agregarAlCarrito($usuario_id, $producto_id, $cantidad) {
    global $carritoModel;
    if ($carritoModel->agregar($usuario_id, $producto_id, $cantidad)) {
        echo json_encode(["mensaje" => "Producto agregado al carrito"]);
    } else {
        echo json_encode(["error" => "No se pudo agregar"]);
    }
}

function actualizarCantidad($id, $nuevaCantidad) {
    global $carritoModel;
    if ($carritoModel->actualizar($id, $nuevaCantidad)) {
        echo json_encode(["mensaje" => "Cantidad actualizada"]);
    } else {
        echo json_encode(["error" => "No se pudo actualizar"]);
    }
}

function eliminarDelCarrito($id) {
    global $carritoModel;
    if ($carritoModel->eliminar($id)) {
        echo json_encode(["mensaje" => "Producto eliminado del carrito"]);
    } else {
        echo json_encode(["error" => "No se pudo eliminar"]);
    }
}
?>
