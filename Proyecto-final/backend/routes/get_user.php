<?php
session_start();
header("Content-Type: application/json");

if (isset($_SESSION["id_usuario"])) {
    echo json_encode([
        "logueado" => true,
        "id" => $_SESSION["id_usuario"],
        "nombre" => $_SESSION["nombre"],
        "rol" => $_SESSION["rol"]
    ]);
} else {
    echo json_encode([
        "logueado" => false
    ]);
}
?>