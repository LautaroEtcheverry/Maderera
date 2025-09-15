<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../frontend/login/registro.css">
    <title>Registro</title>
</head>
<body>
    <div class="container">
        <form action="" method="post" class="formulario">
            <h2 class="titulo">REGISTRAR</h2>

            <?php
            include __DIR__ . '/../modelo/conexion.php';
            include __DIR__ . '/../controlador/controlador_registrar_usuario.php';
            ?>

            <div class="padre">
                <div class="nombre">
                    <label for="nombre">Nombre</label>
                    <input type="text" name="nombre" id="nombre" required>
                </div>
                <div class="email"> 
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email" required>
                </div>
                <div class="clave">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" required>
                </div>
                <div class="cuenta">
                    <input class="boton" type="submit" value="Registrar" name="registro">
                    <a href="login.php">Salir</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
