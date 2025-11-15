<?php
require_once "../modelo/pedido.php";

function crearPedido($usuario_id) {
    $pedidoModel = new Pedido();
    return $pedidoModel->crearPedido($usuario_id);
}
?>

