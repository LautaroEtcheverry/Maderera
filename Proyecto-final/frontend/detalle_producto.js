const DETALLE_API_URL = "/maderera/Proyecto-final/backend/modelo/api_productos.php";

const params = new URLSearchParams(window.location.search);
const idProducto = params.get("id");

if (!idProducto) {
  document.getElementById("productoDetalle").innerHTML = "<p>❌ ID de producto no especificado.</p>";
} else {
  fetch(`${DETALLE_API_URL}?id=${idProducto}`)
    .then(res => res.json())
    .then(producto => {
      if (producto.error) {
        document.getElementById("productoDetalle").innerHTML = `<p>❌ ${producto.error}</p>`;
        return;
      }

      const html = `
        <div class="producto-detalle">
          <img src="${producto.imagen || 'https://via.placeholder.com/300?text=Sin+imagen'}" alt="${producto.nombre}" />
          <div class="producto-info">
            <h1>${producto.nombre}</h1>
            <p><strong>Precio:</strong> $${producto.precio}</p>
            <p><strong>Stock:</strong> ${producto.stock}</p>
            <p><strong>Marca:</strong> ${producto.marca}</p>
            <p><strong>Descripción:</strong><br>${producto.descripcion}</p>

            <div class="botones">
              <button onclick="agregarAlCarritoDesdeDetalle()">
                <i class="bi bi-cart-plus"></i> Agregar al carrito
              </button>
              <a href="productos.html">
                <i class="bi bi-arrow-left"></i> Volver
              </a>
            </div>
          </div>
        </div>
      `;

      document.getElementById("productoDetalle").innerHTML = html;
    })
    .catch(err => {
      console.error(err);
      document.getElementById("productoDetalle").innerHTML = "<p>❌ Error al cargar el producto.</p>";
    });
}

function agregarAlCarritoDesdeDetalle() {
  const id = new URLSearchParams(window.location.search).get("id");

  if (!id) {
    alert("❌ No se encontró el ID del producto.");
    return;
  }

  fetch(API_CARRITO, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ producto_id: id, cantidad: 1 })
  })
  .then(res => res.json())
.then(data => {
  if (data.error) {
    Swal.fire({
      toast: true,
      position: "bottom-end",
      icon: "error",
      title: "❌ Error al agregar: " + data.error,
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true
    });
  } else {
    Swal.fire({
      toast: true,
      position: "bottom-end",
      icon: "success",
      title: "Producto agregado al carrito",
      showConfirmButton: false,
      timer: 2500,
      timerProgressBar: true
    });

    if (typeof contarCarrito === "function") contarCarrito();
  }
})
}

