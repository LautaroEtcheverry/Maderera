<?php
session_start();

if (!empty($_POST["login"])) {
    if (empty($_POST["email"]) || empty($_POST["password"])) {
        echo "Debes completar todos los campos";
    } else {
        $email = $_POST["email"];
        $password = $_POST["password"];

        // consulta preparada para buscar usuario por email
        $stmt = $conn->prepare("SELECT id, nombre, password FROM usuarios WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $resultado = $stmt->get_result();

        if ($resultado->num_rows > 0) {
            $usuario = $resultado->fetch_assoc();

            // verificar la contraseña
            if (password_verify($password, $usuario["password"])) {
                // guardar sesión
                $_SESSION["id"] = $usuario["id"];
                $_SESSION["nombre"] = $usuario["nombre"];
                $_SESSION["email"] = $email;

                header("Location: perfil.php");
                exit();
            } else {
                echo "Contraseña incorrecta";
            }
        } else {
            echo "El usuario no existe";
        }

        $stmt->close();
    }
}
?>
