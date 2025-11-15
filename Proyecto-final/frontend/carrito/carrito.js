const API_CARRITO = "http://localhost/maderera/Proyecto-final/backend/modelo/api_carrito.php";

function listarCarrito() {
  fetch(API_CARRITO)
    .then(res => res.json())
    .then(data => mostrarCarrito(data))
    .catch(err => console.error("Error al obtener carrito:", err));
}

function mostrarCarrito(productos) {
  const layout = document.getElementById("carritoLayout");
  const vacio = document.getElementById("carritoVacio");
  const itemsContainer = document.getElementById("carritoItems");
  const itemsCount = document.getElementById("itemsCount");
  
  if (!Array.isArray(productos) || productos.length === 0) {
    layout.style.display = "none";
    vacio.style.display = "block";
    return;
  }
  
  layout.style.display = "grid";
  vacio.style.display = "none";
  
  let totalItems = 0;
  let totalPrecio = 0;
  
  productos.forEach(p => {
    totalItems += p.cantidad;
    totalPrecio += p.precio * p.cantidad;
  });
  
  itemsCount.textContent = `${totalItems} producto${totalItems !== 1 ? 's' : ''}`;
  
  let html = '';
  productos.forEach(p => {
    const subtotal = p.precio * p.cantidad;
    
 const rutaImagen = p.imagen 
  ? `${p.imagen}`
  : 'http://via.placeholder.com/150?text=Sin+Imagen';

  
    html += `
      <div class="carrito-item" data-id="${p.id}">
        <button class="btn-eliminar" onclick="eliminarDelCarrito(${p.id})" title="Eliminar producto">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="3 6 5 6 21 6"></polyline>
            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
          </svg>
        </button>
        
        <div class="item-imagen">
          <img src="${rutaImagen}" alt="${p.nombre}">
        </div>
        
        <div class="item-info">
          <h4 class="item-nombre">${p.nombre}</h4>
          <p class="item-marca">${p.marca}</p>
          <p class="item-precio-mobile">$${p.precio}</p>
        </div>
        
        <div class="item-precio">
          <span class="precio-label">Precio unitario</span>
          <span class="precio-valor">$${p.precio}</span>
        </div>
        
        <div class="item-cantidad">
          <span class="cantidad-label">Cantidad</span>
          <div class="cantidad-controles">
            <button class="btn-cantidad" onclick="cambiarCantidad(${p.id}, ${p.cantidad - 1})" ${p.cantidad <= 1 ? 'disabled' : ''}>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                <line x1="5" y1="12" x2="19" y2="12"></line>
              </svg>
            </button>
            <span class="cantidad-valor">${p.cantidad}</span>
            <button class="btn-cantidad" onclick="cambiarCantidad(${p.id}, ${p.cantidad + 1})">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <line x1="5" y1="12" x2="19" y2="12"></line>
              </svg>
            </button>
          </div>
        </div>
        
        <div class="item-subtotal">
          <span class="subtotal-label">Subtotal</span>
          <span class="subtotal-valor">$${subtotal}</span>
        </div>
      </div>
    `;
  });
  
  itemsContainer.innerHTML = html;
  
  document.getElementById("resumenSubtotal").textContent = `$${totalPrecio}`;
  document.getElementById("resumenTotal").textContent = `$${totalPrecio}`;
}


function cambiarCantidad(carritoItemId, nuevaCantidad) {
  if (nuevaCantidad < 1) {
    eliminarDelCarrito(carritoItemId);
    return;
  }
  
  fetch(API_CARRITO, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id: carritoItemId, cantidad: nuevaCantidad })
  })
  .then(res => res.json())
  .then(() => {
    listarCarrito();
    contarCarrito();
  })
  .catch(err => console.error("Error al actualizar cantidad:", err));
}

function contarCarrito() {
  fetch(API_CARRITO)
    .then(res => res.json())
    .then(data => {
      const contador = data.reduce((acc, p) => acc + p.cantidad, 0);
      const badge = document.getElementById("carritoBadge");
      if (badge) badge.textContent = contador;
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
        title: "✅ Producto agregado al carrito",
        showConfirmButton: false,
        timer: 2500,
        timerProgressBar: true
      });

      if (typeof contarCarrito === "function") contarCarrito();
    }
  })
  .catch(err => {
    console.error("Error al agregar producto:", err);
    Swal.fire({
      toast: true,
      position: "bottom-end",
      icon: "error",
      title: "❌ No se pudo agregar el producto.",
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true
    });
  });
}

function eliminarDelCarrito(id) {
  Swal.fire({
    title: "¿Eliminar producto?",
    text: "Se quitará del carrito",
    icon: "question",
    showCancelButton: true,
    confirmButtonText: "Sí, eliminar",
    cancelButtonText: "Cancelar",
    confirmButtonColor: "#d33",
    cancelButtonColor: "#6c757d"
  }).then((result) => {
    if (result.isConfirmed) {
      fetch(`${API_CARRITO}?id=${id}`, { method: "DELETE" })
        .then(res => res.json())
        .then(() => {
          Swal.fire({
            toast: true,
            position: "bottom-end",
            icon: "success",
            title: "Producto eliminado",
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
          });
          listarCarrito();
          contarCarrito();
        })
        .catch(err => console.error("Error al eliminar producto:", err));
    }
  });
}

function confirmarCompra() {
  const modal = new bootstrap.Modal(document.getElementById("modalPago"));
  modal.show();
}

document.addEventListener("DOMContentLoaded", () => {
  listarCarrito();
  contarCarrito();

  const form = document.getElementById("formPago");
  if (!form) return;

  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const nombre = document.getElementById("nombreTarjeta").value.trim();
    const numero = document.getElementById("numeroTarjeta").value.trim();
    const vencimiento = document.getElementById("vencimiento").value.trim();
    const cvv = document.getElementById("cvv").value.trim();
    const telefono = document.getElementById("telefono").value.trim();
    const direccion = document.getElementById("direccion").value.trim();

    if (!nombre || !numero || !vencimiento || !cvv || !telefono || !direccion) {
      Swal.fire({
        icon: "error",
        title: "Campos incompletos",
        text: "Por favor completa todos los campos antes de continuar.",
        confirmButtonColor: "#d33"
      });
      return;
    }

    Swal.fire({
      title: "¿Confirmar compra?",
      text: "Se procederá a realizar el pago simulado.",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Sí, pagar",
      cancelButtonText: "Cancelar",
      confirmButtonColor: "#1d6b1d",
      cancelButtonColor: "#6c757d"
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire({
          title: "Procesando pago...",
          text: "Por favor espera unos segundos.",
          allowOutsideClick: false,
          didOpen: () => {
            Swal.showLoading();
          }
        });

        setTimeout(() => {
          const datosCompra = { telefono, direccion, tarjeta: { nombre, numero, vencimiento, cvv } };

          fetch("http://localhost/maderera/Proyecto-final/backend/modelo/api_pedidos.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            credentials: "include",
            body: JSON.stringify(datosCompra)
          })
          .then(res => res.json())
          .then(data => {
            Swal.close();
            Swal.fire({
              icon: "success",
              title: "¡Pago exitoso! 🎉",
              text: data.mensaje || "Tu compra fue registrada correctamente.",
              confirmButtonColor: "#1d6b1d"
            });

            listarCarrito();
            contarCarrito();
            const modal = bootstrap.Modal.getInstance(document.getElementById("modalPago"));
            modal.hide();
            form.reset();
          })
          .catch(err => {
            Swal.close();
            Swal.fire({
              icon: "error",
              title: "Error al confirmar compra",
              text: "Ocurrió un problema al conectar con el servidor.",
              confirmButtonColor: "#d33"
            });
            console.error("Error al confirmar compra:", err);
          });
        }, 1500);
      }
    });
  });
});
