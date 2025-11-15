const API_URL = "/maderera/Proyecto-final/backend/modelo/api_productos.php";


let productosGlobal = [];
let marcaSeleccionada = null;
let USER_ROLE = "cliente";

function initProductos() {
 fetch("/maderera/Proyecto-final/backend/routes/get_user.php")
    .then(res => res.json())
    .then(user => {
      if (user.error) {
        window.location.href = "/maderera/Proyecto-final/backend/routes/login.php";
      } else {
        USER_ROLE = user.rol || "cliente";
        if (typeof categoriaActual !== "undefined") {
          listarProductosPorCategoria(categoriaActual);
        } else {
          listarProductos();
        }
      }
    })
    .catch(err => {
      console.error("Error al verificar usuario:", err);
      if (typeof categoriaActual !== "undefined") {
        listarProductosPorCategoria(categoriaActual);
      } else {
        listarProductos();
      }
    });
}

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

function listarProductosPorCategoria(categoriaId) {
  fetch(API_URL + "?categoria=" + categoriaId)
    .then(res => res.json())
    .then(data => {
      productosGlobal = data;
      mostrarFiltroMarcas(data);
      mostrarTablaProductos(filtrarPorMarca(data, marcaSeleccionada));
    })
    .catch(err => console.error("Error al obtener productos por categoría:", err));
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
    const imagenSrc = p.imagen
      ? `${p.imagen}`
      : "https://via.placeholder.com/150?text=Sin+Imagen";

    let acciones = "";
  if (USER_ROLE === "admin") {
acciones = `
  <button 
    style="background-color: red; color: white; border: none; padding: 5px 10px; cursor: pointer;"
    onclick="event.stopPropagation(); event.preventDefault(); eliminarProducto(${p.id})">
    Eliminar
  </button>
  <button 
    style="background-color: blue; color: white; border: none; padding: 5px 10px; cursor: pointer;"
    onclick="event.stopPropagation(); event.preventDefault(); abrirModal(${p.id})">
    Editar
  </button>
`;

    } else {
      acciones = `
  <button onclick="event.stopPropagation(); event.preventDefault(); agregarAlCarrito(${p.id}, 1)"
          class="btn-agregar" title="Agregar al carrito">
    Agregar al carrito
  </button>
`;
    }

    html += `
       <div class="producto-card" data-id="${p.id}">
        <img src="${imagenSrc}" alt="${p.nombre}">
  <h3 class="card-titulo">${p.nombre}</h3>
  <p class="card-precio">$${p.precio}</p>
        <div class="card-acciones">${acciones}</div>
      </div>
    `;
  });
  html += "</div>";
  container.innerHTML = html;
    const cards = container.querySelectorAll(".producto-card");
  cards.forEach(card => {
    card.addEventListener("click", () => {
      const id = card.getAttribute("data-id");
window.location.href = "/maderera/Proyecto-final/frontend/detalle_producto.html?id=" + id;
    });
  });
}

function eliminarProducto(id) {
  Swal.fire({
    title: '¿Eliminar este producto?',
    text: 'Esta acción no se puede deshacer.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Sí, eliminar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (!result.isConfirmed) return;

    fetch(API_URL + "?id=" + encodeURIComponent(id), {
      method: "DELETE",
      headers: { "Content-Type": "application/json" }
    })
      .then(res => res.json())
      .then(data => {
        if (data && data.success) {
          Swal.fire({
            icon: 'success',
            title: '¡Eliminado!',
            text: 'El producto fue eliminado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
          });
          listarProductos();
        } else {
          Swal.fire({
            icon: 'error',
            title: 'No se pudo eliminar',
            text: data && data.error ? data.error : 'Error desconocido.'
          });
        }
      })
      .catch(err => {
        console.error("Error al eliminar producto:", err);
        Swal.fire({
          icon: 'error',
          title: 'Error de conexión',
          text: 'No se pudo conectar con el servidor.'
        });
      });
  });
}


function abrirModal(id) {
  const p = productosGlobal.find(prod => prod.id === id);
  if (!p) return alert("Producto no encontrado");

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









document.addEventListener("DOMContentLoaded", () => {
  const btnGuardar = document.getElementById("btnGuardarModal");
  if (btnGuardar) {
    btnGuardar.addEventListener("click", modificarProductoDesdeModal);
  }
});

function modificarProductoDesdeModal() {
  const id = document.getElementById("idProductoModal").value.trim();
  const codigo = document.getElementById("codigoProductoModal").value.trim();
  const nombre = document.getElementById("nombreProductoModal").value.trim();
  const precio = document.getElementById("precioProductoModal").value.trim();
  const stock = document.getElementById("stockProductoModal").value.trim();
  const descripcion = document.getElementById("descripcionProductoModal").value.trim();
  const id_categoria = document.getElementById("categoriaProductoModal").value.trim();
  const marca = document.getElementById("marcaProductoModal").value.trim();

  if (!id || !codigo || !nombre || !precio || !stock || !descripcion || !id_categoria || !marca) {
    Swal.fire({
      icon: 'warning',
      title: 'Campos incompletos',
      text: '⚠️ Todos los campos son obligatorios.'
    });
    return;
  }

  console.log("🔍 Datos que se envían para modificar:", {
    id, codigo, nombre, precio, stock, descripcion, id_categoria, marca
  });

fetch("http://localhost/maderera/Proyecto-final/backend/modelo/api_productos.php", {
  method: "PUT",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    id: parseInt(id),
    codigo,
    nombre,
    precio: parseFloat(precio),
    stock: parseInt(stock),
    descripcion,
    id_categoria: parseInt(id_categoria),
    marca
  })
})
    .then(async res => {
      const texto = await res.text();
      console.log("🔍 Respuesta cruda del servidor:", texto);

      try {
        const data = JSON.parse(texto);

        if (data.success) {
          Swal.fire({
            icon: 'success',
            title: '¡Producto modificado!',
            text: 'Los cambios se han guardado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
          });

          cerrarModalFormulario();
          listarProductos();
        } else {
          Swal.fire({
            icon: 'error',
            title: 'Error al modificar',
            text: data.error || '⚠️ Ocurrió un error desconocido.'
          });
        }
      } catch (err) {
        console.error("❌ JSON inválido:", err);
        Swal.fire({
          icon: 'error',
          title: 'Respuesta inválida',
          text: '⚠️ El servidor devolvió una respuesta no válida. Revisa la consola.'
        });
      }
    })
    .catch(err => {
      console.error("❌ Error al modificar producto:", err);
      Swal.fire({
        icon: 'error',
        title: 'Error de conexión',
        text: '⚠️ No se pudo conectar con el servidor.'
      });
    });
}










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
function agregarProductoDesdeFormulario() {
  const form = document.getElementById("formProducto");

  if (!form) {
    console.error("Formulario no encontrado en el DOM");
    Swal.fire({
      icon: 'error',
      title: 'Error interno',
      text: 'No se encontró el formulario en el DOM.'
    });
    return;
  }

  const formData = new FormData(form);

  fetch("../backend/modelo/api_productos.php", {
    method: "POST",
    body: formData
  })
    .then(res => res.text())
    .then(text => {
      console.log("Respuesta del servidor:", text);

      try {
        const data = JSON.parse(text);

        if (data.success) {
          Swal.fire({
            icon: 'success',
            title: '¡Producto agregado!',
            text: 'El producto se ha guardado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
          });

          form.reset();
        } else {
          console.error("Error al agregar producto:", data);
          Swal.fire({
            icon: 'warning',
            title: 'No se pudo agregar el producto',
            text: 'Revisa la consola para más detalles.'
          });
        }
      } catch (e) {
        console.error("Respuesta no es JSON válido:", e);
        Swal.fire({
          icon: 'error',
          title: 'Respuesta inválida',
          text: 'El servidor no devolvió una respuesta válida. Ver consola.'
        });
      }
    })
    .catch(err => {
      console.error("Error al conectar con el servidor:", err);
      Swal.fire({
        icon: 'error',
        title: 'Error de conexión',
        text: 'No se pudo conectar con el servidor.'
      });
    });
}

 
document.addEventListener("DOMContentLoaded", () => {
  const formBuscar = document.getElementById("formBuscar");
  const inputBuscar = document.getElementById("buscador");

  if (!formBuscar || !inputBuscar) {
    setTimeout(() => inicializarBuscador(), 500);
  } else {
    inicializarBuscador();
  }
});

function inicializarBuscador() {
  const formBuscar = document.getElementById("formBuscar");
  const inputBuscar = document.getElementById("buscador");

  if (!formBuscar || !inputBuscar) {
    console.error("⚠️ No se encontró el formulario o el input del buscador.");
    return;
  }

  formBuscar.addEventListener("submit", (event) => {
    event.preventDefault();
    const termino = inputBuscar.value.trim().toLowerCase();
    buscarProductoPorNombre(termino);
  });

  console.log("✅ Buscador inicializado correctamente");
}

function buscarProductoPorNombre(termino) {
  const productos = document.querySelectorAll(".producto-card");
  let encontrados = 0;

  productos.forEach(card => {
    const titulo = card.querySelector(".card-titulo")?.textContent.toLowerCase() || "";
    if (titulo.includes(termino)) {
      card.style.display = "block";
      encontrados++;
    } else {
      card.style.display = "none";
    }
  });

  if (encontrados === 0) {
    mostrarMensajeSinResultados();
  } else {
    eliminarMensajeSinResultados();
  }
}

function mostrarMensajeSinResultados() {
  eliminarMensajeSinResultados();
  const contenedor = document.getElementById("productosContainer");
  if (!contenedor) return;

  const mensaje = document.createElement("div");
  mensaje.id = "mensajeSinResultados";
  mensaje.style.textAlign = "center";
  mensaje.style.padding = "40px";
  mensaje.innerHTML = `
    <img src="https://cdn-icons-png.flaticon.com/512/2748/2748558.png" width="100" alt="No results">
    <h3>No se encontraron productos</h3>
    <p>Intentá con otro nombre.</p>
  `;
  contenedor.appendChild(mensaje);
}

function eliminarMensajeSinResultados() {
  const existente = document.getElementById("mensajeSinResultados");
  if (existente) existente.remove();
}
