// frontend/js/producto.js
// API de productos + control de rol desde get_user.php
const API_URL = "../backend/modelo/api_productos.php";

let productosGlobal = [];
let marcaSeleccionada = null;
let USER_ROLE = "cliente"; // por defecto

// ======================
// Inicializar
// ======================
function initProductos() {
  fetch("../backend/routes/get_user.php")
    .then(res => res.json())
    .then(user => {
      if (user.error) {
        window.location.href = "../backend/routes/login.php";
      } else {
        USER_ROLE = user.rol || "cliente";
        listarProductos();
      }
    })
    .catch(err => {
      console.error("Error al verificar usuario:", err);
      listarProductos();
    });
}

// ======================
// CRUD / listado productos
// ======================
function listarProductos() {
  fetch(API_URL)
    .then(res => res.json())
    .then(data => {
      productosGlobal = Array.isArray(data) ? data : [];
      mostrarFiltroMarcas(productosGlobal);
      mostrarTablaProductos(filtrarPorMarca(productosGlobal, marcaSeleccionada));
    })
    .catch(err => console.error("Error al obtener productos:", err));
}

function mostrarTablaProductos(productos) {
  const container = document.getElementById("productosContainer");
  if (!container) return;

  if (!Array.isArray(productos) || productos.length === 0) {
    container.innerHTML = "<p>No hay productos para mostrar.</p>";
    return;
  }

  let html = '<div class="productos-grid">';
  productos.forEach((p) => {
    const nombreSafe = JSON.stringify(p.nombre || "");
    const descripcionSafe = JSON.stringify(p.descripcion || "");
    const marcaSafe = JSON.stringify(p.marca || "");

    let acciones = "";
    if (USER_ROLE === "admin") {
      acciones = `
        <button onclick="eliminarProducto(${p.id})">Eliminar</button>
        <button onclick="abrirModal(${p.id})">Editar</button>
      `;
    } else {
      acciones = `
        <button onclick="agregarAlCarrito(${p.id}, 1)">🛒 Agregar al carrito</button>
      `;
    }

    html += `
      <div class="producto-card">
        <span>#${p.codigo}</span>
        <h3>${p.nombre}</h3>
        <p>${p.descripcion}</p>
        <p><strong>Precio:</strong> $${p.precio}</p>
        <p><strong>Stock:</strong> ${p.stock}</p>
        <p><strong>Categoría:</strong> ${p.id_categoria}</p>
        <p><strong>Marca:</strong> ${p.marca}</p>
        <div>${acciones}</div>
      </div>
    `;
  });
  html += "</div>";
  container.innerHTML = html;
}

// ======================
// Funciones auxiliares CRUD
// ======================
function agregarProducto(producto) {
  fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(producto),
  })
    .then((res) => res.json())
    .then(() => listarProductos())
    .catch((err) => console.error("Error al agregar producto:", err));
}

function modificarProducto(producto) {
  fetch(API_URL, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(producto),
  })
    .then((res) => res.json())
    .then(() => listarProductos())
    .catch((err) => console.error("Error al modificar producto:", err));
}

function eliminarProducto(id) {
  fetch(API_URL + "?id=" + id, { method: "DELETE" })
    .then((res) => res.json())
    .then(() => listarProductos())
    .catch((err) => console.error("Error al eliminar producto:", err));
}

// ======================
// Modal
// ======================
function cargarProducto(id, codigo, nombre, precio, stock, descripcion, id_categoria, marca) {
  console.log("Cargando producto:", id, nombre);
  document.getElementById("idProductoModal").value = id;
  document.getElementById("codigoProductoModal").value = codigo;
  document.getElementById("nombreProductoModal").value = nombre;
  document.getElementById("precioProductoModal").value = precio;
  document.getElementById("stockProductoModal").value = stock;
  document.getElementById("descripcionProductoModal").value = descripcion;
  document.getElementById("categoriaProductoModal").value = id_categoria;
  document.getElementById("marcaProductoModal").value = marca;
  document.getElementById("modalFormulario").style.display = "block";
}

function cerrarModalFormulario() {
  document.getElementById("modalFormulario").style.display = "none";
}

// ======================
// Filtros de marcas
// ======================
function mostrarFiltroMarcas(productos) {
  const marcas = [...new Set(productos.map((p) => p.marca).filter(Boolean))];
  const filtroDiv = document.getElementById("filtroMarcas");
  if (!filtroDiv) return;

  filtroDiv.innerHTML = marcas
    .map(
      (marca) => `
    <label>
      <input type="radio" name="marcaFiltro" value="${marca}" onchange="filtrarMarcaHandler('${marca}')"
      ${marca === marcaSeleccionada ? "checked" : ""}>
      ${marca}
    </label>
  `
    )
    .join("");
}

function filtrarMarcaHandler(marca) {
  marcaSeleccionada = marca;
  mostrarTablaProductos(filtrarPorMarca(productosGlobal, marcaSeleccionada));
}

function limpiarFiltroMarca() {
  marcaSeleccionada = null;
  document.querySelectorAll('input[name="marcaFiltro"]').forEach((el) => (el.checked = false));
  mostrarTablaProductos(productosGlobal);
}

function filtrarPorMarca(productos, marca) {
  if (!marca) return productos;
  return productos.filter((p) => p.marca === marca);
}
function abrirModal(id) {
  const p = productosGlobal.find(prod => prod.id === id);
  if (!p) {
    alert("Producto no encontrado");
    return;
  }

  document.getElementById("idProductoModal").value = p.id;
  document.getElementById("codigoProductoModal").value = p.codigo;
  document.getElementById("nombreProductoModal").value = p.nombre;
  document.getElementById("precioProductoModal").value = p.precio;
  document.getElementById("stockProductoModal").value = p.stock;
  document.getElementById("descripcionProductoModal").value = p.descripcion;
  document.getElementById("categoriaProductoModal").value = p.id_categoria;
  document.getElementById("marcaProductoModal").value = p.marca;

  document.getElementById("modalFormulario").style.display = "block";
}
function cerrarModalFormulario() {
  document.getElementById("modalFormulario").style.display = "none";
}
document.addEventListener('DOMContentLoaded', () => {
  const btn = document.getElementById('btnGuardarModal');
  if (btn) btn.addEventListener('click', modificarProductoDesdeModal);
});
// función que toma los valores del modal y llama al endpoint de modificación
function modificarProductoDesdeModal() {
  console.log("modificarProductoDesdeModal invoked"); // debug
  const id = parseInt(document.getElementById('idProductoModal').value, 10) || 0;
  const producto = {
    id: id,
    codigo: parseInt(document.getElementById('codigoProductoModal').value, 10) || 0,
    nombre: document.getElementById('nombreProductoModal').value || '',
    precio: parseFloat(document.getElementById('precioProductoModal').value) || 0,
    stock: parseInt(document.getElementById('stockProductoModal').value, 10) || 0,
    descripcion: document.getElementById('descripcionProductoModal').value || '',
    id_categoria: parseInt(document.getElementById('categoriaProductoModal').value, 10) || 0,
    marca: document.getElementById('marcaProductoModal').value || ''
  };

  // Llamada al API de modificación (usa tu función existente)
  modificarProducto(producto);

  // Cerrar modal después de pedir la modificación
  cerrarModalFormulario();
}


