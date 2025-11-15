<?php
session_start();

if (!empty($_POST["login"])) {
    if (empty($_POST["email"]) || empty($_POST["password"])) {
        echo "Uno de los campos está vacío";
    } else {
        $email = $_POST["email"];
        $password = $_POST["password"];

        $stmt = $conn->prepare("SELECT * FROM usuarios WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        $usuario = $result->fetch_assoc();

        if ($usuario && password_verify($password, $usuario["password"])) {
            $_SESSION["id_usuario"] = $usuario["id"];
            $_SESSION["nombre"] = $usuario["nombre"];
            $_SESSION["rol"] = $usuario["rol"];

            if ($_SESSION["rol"] === "admin") {
                header("Location: /maderera/Proyecto-final/frontend/inicio/inicio.html");
            } else {
                header("Location: /maderera/Proyecto-final/frontend/inicio/inicio.html");
            }
            exit;
        } else {
            echo "Email o contraseña incorrectos";
        }
    }
}
?>
