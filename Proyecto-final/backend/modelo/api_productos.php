<?php
require "../controlador/productos.php";

$requestMethod = $_SERVER["REQUEST_METHOD"];

header("Content-Type: application/json; charset=UTF-8");

switch ($requestMethod) {

    case "GET":
        if (isset($_GET['id'])) {
            mostrarProducto($_GET['id']);
        } elseif (isset($_GET['categoria'])) {
            $categoria = intval($_GET['categoria']);
            mostrarProductosPorCategoria($categoria);
        } else {
            listarProductos();
        }
        break;

case "POST":
    if (ob_get_length()) ob_clean();
    header("Content-Type: application/json; charset=UTF-8");

    if (isset($_FILES['imagen'])) {
        $codigo = $_POST['codigo'];
        $nombre = $_POST['nombre'];
        $precio = $_POST['precio'];
        $stock = $_POST['stock'];
        $descripcion = $_POST['descripcion'];
        $id_categoria = $_POST['id_categoria'];
        $marca = $_POST['marca'];

        $uploadDir = __DIR__ . "/../../imagenes_productos/";
        if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

        $fileName = uniqid() . "_" . basename($_FILES["imagen"]["name"]);
        $filePath = $uploadDir . $fileName;
        $fileUrl = "/maderera/Proyecto-final/imagenes_productos/" . $fileName;

        if (move_uploaded_file($_FILES["imagen"]["tmp_name"], $filePath)) {
            $ok = agregarProducto($codigo, $nombre, $precio, $stock, $descripcion, $id_categoria, $marca, $fileUrl);
            echo json_encode([
                "success" => $ok,
                "mensaje" => $ok ? "✅ Producto agregado con imagen" : "❌ Error al agregar producto",
                "imagen" => $ok ? $fileUrl : null
            ], JSON_UNESCAPED_UNICODE);
        } else {
            echo json_encode(["success" => false, "error" => "Error al subir la imagen"]);
        }
    } else {
        $data = json_decode(file_get_contents("php://input"), true);
        if ($data) {
            $ok = agregarProducto(
                $data['codigo'],
                $data['nombre'],
                $data['precio'],
                $data['stock'],
                $data['descripcion'],
                $data['id_categoria'],
                $data['marca']
            );
            echo json_encode([
                "success" => $ok,
                "mensaje" => $ok ? "✅ Producto agregado (sin imagen)" : "❌ Error al agregar producto"
            ], JSON_UNESCAPED_UNICODE);
        } else {
            echo json_encode(["success" => false, "error" => "Datos inválidos"]);
        }
    }
    exit;
    break;

        
case "DELETE":
    if (ob_get_length()) ob_clean();
    header("Content-Type: application/json; charset=UTF-8");

    if (isset($_GET['id'])) {
        $id = intval($_GET['id']);
        $ok = eliminarProducto($id);

        echo json_encode([
            "success" => $ok,
            "mensaje" => $ok 
                ? "✅ Producto eliminado correctamente" 
                : "❌ Error al eliminar el producto"
        ], JSON_UNESCAPED_UNICODE);
    } else {
        echo json_encode([
            "success" => false,
            "error" => "Falta el parámetro id"
        ], JSON_UNESCAPED_UNICODE);
    }

    exit;
    break;




case "PUT":
    if (ob_get_length()) ob_clean();
    header("Content-Type: application/json; charset=UTF-8");

    $data = json_decode(file_get_contents("php://input"), true);

    if ($data && isset($data['id'])) {
        $ok = modificarProducto(
            $data['codigo'],
            $data['nombre'],
            $data['precio'],
            $data['stock'],
            $data['descripcion'],
            $data['id_categoria'],
            $data['marca'],
            $data['id']
        );

        echo json_encode([
            "success" => $ok,
            "mensaje" => $ok 
                ? "✅ Producto modificado correctamente" 
                : "❌ Error al modificar el producto"
        ], JSON_UNESCAPED_UNICODE);
    } else {
        echo json_encode([
            "success" => false,
            "error" => "Datos inválidos o incompletos"
        ], JSON_UNESCAPED_UNICODE);
    }

    exit;
    break;

}
?>
