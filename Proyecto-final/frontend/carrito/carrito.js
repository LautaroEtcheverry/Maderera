const API_CARRITO = "http://localhost/maderera/Proyecto-final/backend/modelo/api_carrito.php";

function listarCarrito() {
  fetch(API_CARRITO)
    .then(res => res.json())
    .then(data => {
      mostrarCarrito(data);
    })
    .catch(err => console.error("Error al obtener carrito:", err));
}

function mostrarCarrito(productos) {
  const container = document.getElementById("carritoContainer");
  if (!Array.isArray(productos) || productos.length === 0) {
    container.innerHTML = "<p>🛒 Tu carrito está vacío.</p>";
    return;
  }

  let html = `<table class="table table-bordered">
    <tr>
      <th>Producto</th>
      <th>Marca</th>
      <th>Precio unitario</th>
      <th>Cantidad</th>
      <th>Subtotal</th>
      <th>Acciones</th>
    </tr>`;
  let total = 0;

  productos.forEach(p => {
    const subtotal = p.precio * p.cantidad;
    total += subtotal;
    html += `
      <tr>
        <td>${p.nombre}</td>
        <td>${p.marca}</td>
        <td>$${p.precio}</td>
        <td>${p.cantidad}</td>
        <td>$${subtotal}</td>
        <td>
          <button class="btn btn-danger btn-sm" onclick="eliminarDelCarrito(${p.id})">Eliminar</button>
        </td>
      </tr>`;
  });

  html += `
    <tr>
      <td colspan="4" class="text-end"><strong>Total:</strong></td>
      <td colspan="2"><strong>$${total}</strong></td>
    </tr>
  </table>
  <button class="btn btn-success" onclick="confirmarCompra()">Finalizar compra</button>`;

  container.innerHTML = html;
}

function contarCarrito() {
  fetch(API_CARRITO)
    .then(res => res.json())
    .then(data => {
      const contador = data.reduce((acc, p) => acc + p.cantidad, 0);
      const badge = document.getElementById("carritoBadge");
      if (badge) {
        badge.textContent = contador;
      }
    })
    .catch(err => console.error("Error al contar carrito:", err));
}

function agregarAlCarrito(producto_id, cantidad = 1) {
  fetch(API_CARRITO, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ producto_id, cantidad })
  })
    .then(res => res.json())
    .then(data => {
      console.log(data);
      contarCarrito(); 
      mostrarToast("✅ Producto agregado al carrito"); // 👈 ALERTA
    })
    .catch(err => console.error("Error al agregar producto:", err));
}

// 🔥 Función para mostrar un toast con Bootstrap
function mostrarToast(mensaje) {
  const toastEl = document.getElementById("liveToast");
  const toastBody = document.querySelector("#liveToast .toast-body");
  toastBody.textContent = mensaje;

  const toast = new bootstrap.Toast(toastEl);
  toast.show();
}

function eliminarDelCarrito(id) {
  fetch(`${API_CARRITO}?id=${id}`, { method: "DELETE" })
    .then(res => res.json())
    .then(data => {
      console.log(data);
      listarCarrito();
    })
    .catch(err => console.error("Error al eliminar producto:", err));
}

function confirmarCompra() {
  // 🚨 este endpoint lo haremos en api_pedidos.php
  fetch("http://localhost/Proyecto-final/backend/modelo/api_pedidos.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({}) // en el backend se usará el usuario_id de sesión
  })
    .then(res => res.json())
    .then(data => {
      alert(data.mensaje || data.error);
      listarCarrito();
    })
    .catch(err => console.error("Error al confirmar compra:", err));
}
