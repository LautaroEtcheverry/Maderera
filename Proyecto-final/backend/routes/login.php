<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../frontend/login/login.css">
    <title>Iniciar Sesión</title>
</head>

<body>
    <div class="container">
        <form action="" method="post" class="formulario">
            <h2 class="titulo">INICIAR SESIÓN</h2>

            <?php
            include __DIR__ . '/../modelo/conexion.php';
            include __DIR__ . '/../controlador/controlador_login.php';
            ?>

            <div class="email"> 
                <label for="email">Email</label>
                <input type="email" name="email" id="email" required>
            </div>
            <div class="clave">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required>
            </div>
            <div class="cuenta">
                <input class="boton" type="submit" value="Ingresar" name="login">
                <a href="registro_usuario.php">Registrarse</a>
            </div>
        </form>
    </div>
</body>
</html>
