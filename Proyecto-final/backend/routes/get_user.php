<?php
session_start();
if (!isset($_SESSION["id_usuario"])) {
  echo json_encode(["error" => "no_logueado"]);
  exit;
}
echo json_encode([
  "id" => $_SESSION["id_usuario"],
  "nombre" => $_SESSION["nombre"],
  "rol" => $_SESSION["rol"]
]);
?>