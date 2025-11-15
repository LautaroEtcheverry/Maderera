<?php
session_start();
session_destroy();
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Sesión cerrada</title>
  <meta http-equiv="refresh" content="3;url=/maderera/Proyecto-final/frontend/inicio/inicio.html">
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      margin-top: 80px;
      background-color: #f5f5f5;
    }
    img {
      width: 120px;
      margin-bottom: 20px;
    }
    h1 {
      color: #333;
    }
    p {
      color: #666;
    }
  </style>
</head>
<body>
  <img src="https://cdn-icons-png.flaticon.com/512/1828/1828479.png" alt="Logout icon">
  <h1>Sesión cerrada correctamente</h1>
  <p>Serás redirigido a la pagina de inicio en unos segundos...</p>
</body>
</html>
