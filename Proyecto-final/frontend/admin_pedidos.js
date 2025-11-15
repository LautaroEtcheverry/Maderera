const tabla = document.querySelector("#tablaPedidos tbody");

fetch("../backend/modelo/api_pedidos.php?admin=1")
  .then(res => res.json())
  .then(data => {
    tabla.innerHTML = "";
    data.forEach(p => {
      tabla.innerHTML += `
        <tr>
          <td>${p.id}</td>
          <td>${p.usuario}</td>
          <td>${p.telefono || "-"}</td>
          <td>${p.direccion || "-"}</td>
          <td>${p.fecha}</td>
          <td>$${Number(p.total).toFixed(2)}</td>
          <td>
            <select class="form-select estado" data-id="${p.id}">
              <option ${p.estado === "pendiente" ? "selected" : ""}>pendiente</option>
              <option ${p.estado === "enviado" ? "selected" : ""}>enviado</option>
              <option ${p.estado === "entregado" ? "selected" : ""}>entregado</option>
              <option ${p.estado === "cancelado" ? "selected" : ""}>cancelado</option>
            </select>
          </td>
          <td>
            <button class="btn btn-sm btn-primary ver-detalles" data-id="${p.id}">Ver detalles</button>
          </td>
        </tr>`;
    });

    document.querySelectorAll(".estado").forEach(sel => {
      sel.addEventListener("change", e => {
        const pedidoId = e.target.dataset.id;
        const nuevoEstado = e.target.value;
        fetch("../backend/modelo/api_pedidos.php", {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ pedido_id: pedidoId, estado: nuevoEstado })
        });
      });
    });

    document.querySelectorAll(".ver-detalles").forEach(btn => {
      btn.addEventListener("click", e => {
        const id = e.target.dataset.id;
        fetch(`../backend/modelo/api_pedidos.php?detalles=${id}`)
          .then(res => res.json())
          .then(detalles => {
            const cont = document.querySelector("#detallesPedido");
            cont.innerHTML = "<ul class='list-group'>" + 
              detalles.map(d => `<li class='list-group-item'>${d.nombre_producto} — ${d.cantidad} × $${d.precio_unitario}</li>`).join("") + 
              "</ul>";
            new bootstrap.Modal("#modalDetalles").show();
          });
      });
    });
  });
