<?php 
require "../controlador/productos.php"; 


$requestMethod = $_SERVER["REQUEST_METHOD"];

if ($requestMethod == "GET") {
    if (isset($_GET['id'])) {
        mostrarProducto($_GET['id']); 
    } else {
        listarProductos(); 
    }
} 
elseif ($requestMethod == "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    agregarProducto(
        $data['codigo'],
        $data['nombre'],
        $data['precio'],
        $data['stock'],
        $data['descripcion'],
        $data['id_categoria'],
        $data['marca']
    );
} 
elseif ($requestMethod == "PUT") {
    $data = json_decode(file_get_contents("php://input"), true);
    modificarProducto(
        $data['id'],
        $data['codigo'],
        $data['nombre'],
        $data['precio'],
        $data['stock'],
        $data['descripcion'],
        $data['id_categoria'],
        $data['marca']
    );
}
elseif ($requestMethod == "DELETE") {
    if (isset($_GET['id'])) {
        eliminarProducto($_GET['id']);
    } else {
        echo json_encode(["error" => "Falta el parámetro id para eliminar"]);
    }
}
else {
    echo json_encode(["error" => "Método no permitido"]);
}
?>


