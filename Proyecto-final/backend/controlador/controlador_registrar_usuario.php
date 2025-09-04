<?php
if (!empty($_POST["registro"])) {
    if (empty($_POST["nombre"]) || empty($_POST["email"]) || empty($_POST["password"])) {
        echo 'Uno de los campos está vacío';
    } else {
        $nombre   = $_POST["nombre"];
        $email    = $_POST["email"];
        $password = password_hash($_POST["password"], PASSWORD_DEFAULT);

        // consulta preparada
        $stmt = $conn->prepare("INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $nombre, $email, $password);

        if ($stmt->execute()) {
            echo "Usuario registrado con éxito";
        } else {
            echo "Error al registrar usuario: " . $stmt->error;
        }

        $stmt->close();
    }
}
?>