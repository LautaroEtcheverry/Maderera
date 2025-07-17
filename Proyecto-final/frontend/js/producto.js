const API_URL = "http://localhost/Proyecto-final/backend/modelo/api_productos.php";

let productosGlobal = [];
let marcaSeleccionada = null;

// Obtener todos los productos (GET)
function listarProductos() {
  fetch(API_URL)
    .then(res => res.json())
    .then(data => {
      productosGlobal = data;
      mostrarFiltroMarcas(data);
      mostrarTablaProductos(filtrarPorMarca(data, marcaSeleccionada));
    })
    .catch(err => console.error("Error al obtener productos:", err));
}

// Mostrar productos en tabla
function mostrarTablaProductos(productos) {
  const container = document.getElementById('productosContainer');
  if (!Array.isArray(productos) || productos.length === 0) {
    container.innerHTML = '<p>No hay productos para mostrar.</p>';
    return;
  }

  let html = '<div class="productos-grid">';
  productos.forEach(p => {
    html += `
      <div class="producto-card">
        <span class="producto-codigo">#${p.codigo}</span>
        <h3 class="producto-nombre">${p.nombre}</h3>
        <p class="producto-descripcion">${p.descripcion}</p>
        <p><strong>Precio:</strong> $${p.precio}</p>
        <p><strong>Stock:</strong> ${p.stock}</p>
        <p><strong>Categoría:</strong> ${p.id_categoria}</p>
        <p><strong>Marca:</strong> ${p.marca}</p>
        <div class="producto-acciones">
          <button onclick="eliminarProducto(${p.id})">Eliminar</button>
          <button onclick="cargarProducto(${p.id}, ${p.codigo}, '${p.nombre}', ${p.precio}, ${p.stock}, '${p.descripcion}', ${p.id_categoria}, '${p.marca}')">Cargar</button>
        </div>
      </div>
    `;
  });
  html += '</div>';
  html += '<p style="text-align:center;">Total de productos: ' + productos.length + '</p>';
  container.innerHTML = html;
}

// Obtener producto por ID (opcional)
function mostrarProducto(id) {
  fetch(`${API_URL}/id/${id}`)
    .then(res => res.json())
    .then(data => console.log("Producto:", data))
    .catch(err => console.error("Error al obtener producto:", err));
}

// Agregar desde formulario
function agregarProductoDesdeFormulario() {
  const producto = obtenerDatosFormulario();
  delete producto.id;
  agregarProducto(producto);
}

// Modificar desde formulario
function modificarProductoDesdeFormulario() {
  const producto = obtenerDatosFormulario();
  modificarProducto(producto);
}

// Obtener datos desde formulario HTML
function obtenerDatosFormulario() {
  return {
    id: parseInt(document.getElementById('idProducto').value),
    codigo: parseInt(document.getElementById('codigoProducto').value),
    nombre: document.getElementById('nombreProducto').value,
    precio: parseFloat(document.getElementById('precioProducto').value),
    stock: parseInt(document.getElementById('stockProducto').value),
    descripcion: document.getElementById('descripcionProducto').value,
    id_categoria: parseInt(document.getElementById('categoriaProducto').value),
    marca: document.getElementById('marcaProducto').value
  };
}

// Agregar (POST)
function agregarProducto(producto) {
  fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(producto)
  })
    .then(res => res.json())
    .then(data => {
      console.log("Producto agregado:", data);
      listarProductos();
    })
    .catch(err => console.error("Error al agregar producto:", err));
}

// Modificar (PUT)
function modificarProducto(producto) {
  fetch(API_URL, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(producto)
  })
    .then(res => res.json())
    .then(data => {
      if (data.mensaje) {
        alert(data.mensaje);
        listarProductos();
      } else {
        alert(data.error || "Error al modificar producto");
      }
    })
    .catch(err => {
      console.error("Error al modificar producto:", err);
      alert("Error al modificar producto");
    });
}

// Eliminar (DELETE)
function eliminarProducto(id) {
  if (confirm("¿Estás seguro de que quieres eliminar este producto?")) {
    fetch(API_URL + '?id=' + id, {
      method: "DELETE"
    })
      .then(res => res.json())
      .then(data => {
        console.log("Producto eliminado:", data);
        listarProductos();
      })
      .catch(err => console.error("Error al eliminar producto:", err));
  }
}

// Cargar producto en el formulario
function cargarProducto(id, codigo, nombre, precio, stock, descripcion, id_categoria, marca) {
  // Llena el formulario del modal
  document.getElementById('idProductoModal').value = id;
  document.getElementById('codigoProductoModal').value = codigo;
  document.getElementById('nombreProductoModal').value = nombre;
  document.getElementById('precioProductoModal').value = precio;
  document.getElementById('stockProductoModal').value = stock;
  document.getElementById('descripcionProductoModal').value = descripcion;
  document.getElementById('categoriaProductoModal').value = id_categoria;
  document.getElementById('marcaProductoModal').value = marca;
  // Muestra el modal
  document.getElementById('modalFormulario').style.display = 'block';
}

function cerrarModalFormulario() {
  document.getElementById('modalFormulario').style.display = 'none';
}

// Guardar cambios desde el modal
function modificarProductoDesdeModal() {
  const producto = {
    id: parseInt(document.getElementById('idProductoModal').value),
    codigo: parseInt(document.getElementById('codigoProductoModal').value),
    nombre: document.getElementById('nombreProductoModal').value,
    precio: parseFloat(document.getElementById('precioProductoModal').value),
    stock: parseInt(document.getElementById('stockProductoModal').value),
    descripcion: document.getElementById('descripcionProductoModal').value,
    id_categoria: parseInt(document.getElementById('categoriaProductoModal').value),
    marca: document.getElementById('marcaProductoModal').value
  };
  modificarProducto(producto);
  cerrarModalFormulario();
}

// Mostrar filtro de marcas únicas
function mostrarFiltroMarcas(productos) {
  const marcas = [...new Set(productos.map(p => p.marca).filter(Boolean))];
  const filtroDiv = document.getElementById('filtroMarcas');
  filtroDiv.innerHTML = marcas.map(marca => `
    <label>
      <input type="radio" name="marcaFiltro" value="${marca}" onchange="filtrarMarcaHandler('${marca}')"
        ${marca === marcaSeleccionada ? 'checked' : ''}>
      ${marca}
    </label>
  `).join('');
}

// Maneja el cambio de filtro
function filtrarMarcaHandler(marca) {
  marcaSeleccionada = marca;
  mostrarTablaProductos(filtrarPorMarca(productosGlobal, marcaSeleccionada));
}

// Limpia el filtro
function limpiarFiltroMarca() {
  marcaSeleccionada = null;
  document.querySelectorAll('input[name="marcaFiltro"]').forEach(el => el.checked = false);
  mostrarTablaProductos(productosGlobal);
}

// Filtra productos por marca
function filtrarPorMarca(productos, marca) {
  if (!marca) return productos;
  return productos.filter(p => p.marca === marca);
}

// Ejemplos de uso
// listarProductos();
// mostrarProducto(1);
// agregarProducto("Producto X", "Descripción X", 99.99);
// modificarProducto(1, "Nuevo nombre", "Nueva descripción", 123.45);
// eliminarProducto(1);