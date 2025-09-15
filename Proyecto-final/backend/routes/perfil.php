<?php
session_start();
if (!isset($_SESSION["id"])) {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil</title>
    <!-- Bootstrap CSS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Barra de navegación -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Maderera</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
            data-bs-target="#navbarNav" aria-controls="navbarNav" 
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <span class="navbar-text text-white me-3">
            👤 <?php echo $_SESSION["nombre"]; ?>
          </span>
        </li>
        <li class="nav-item">
          <a class="btn btn-outline-light" href="logout.php">Cerrar sesión</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Contenido principal -->
<div class="container mt-5">
    <div class="card shadow-lg p-4">
        <h1 class="mb-3">Bienvenido, <?php echo $_SESSION["nombre"]; ?>!</h1>
        <p><strong>Email:</strong> <?php echo $_SESSION["email"]; ?></p>
        <p>Aquí podrás ver tu información y tus pedidos</p>
    </div>
</div>

<!-- Bootstrap JS (CDN) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
