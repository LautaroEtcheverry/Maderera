document.addEventListener('DOMContentLoaded', function() {
  const btn = document.querySelector('.ver-productos-btn');
  if (btn) {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      const target = document.querySelector('.productos-inicio');
      const offset = 140;
      const targetPosition = target.getBoundingClientRect().top + window.pageYOffset - offset;
      smoothScrollTo(window.pageXOffset, targetPosition, 900);
    });
  }

  
  function smoothScrollTo(startX, targetY, duration) {
    const startY = window.pageYOffset;
    const distanceY = targetY - startY;
    let startTime = null;

    function animation(currentTime) {
      if (!startTime) startTime = currentTime;
      const timeElapsed = currentTime - startTime;
      const progress = Math.min(timeElapsed / duration, 1);
      const ease = progress < 0.5
        ? 2 * progress * progress
        : -1 + (4 - 2 * progress) * progress;
      window.scrollTo(startX, startY + distanceY * ease);
      if (progress < 1) {
        requestAnimationFrame(animation);
      }
    }

    requestAnimationFrame(animation);
  }
});


document.addEventListener("DOMContentLoaded", () => {
  const menuToggle = document.querySelector('.menu-toggle');
  const header = document.querySelector('header');
  
  menuToggle.addEventListener('click', () => {
    header.classList.toggle('menu-open');
  });

  document.addEventListener('click', (e) => {
    if (!header.contains(e.target) && header.classList.contains('menu-open')) {
      header.classList.remove('menu-open');
    }
  });

  window.addEventListener('resize', () => {
    if (window.innerWidth > 768 && header.classList.contains('menu-open')) {
      header.classList.remove('menu-open');
    }
  });

  fetch("/maderera/Proyecto-final/backend/routes/get_user.php")
    .then(res => res.json())
    .then(data => {
      console.log("🔍 Datos de sesión:", data);
      if (data.logueado) {
        document.getElementById("logoutBtn").style.display = "inline-block";
        console.log("✅ Sesión activa, botón visible");
      } else {
        console.log("❌ No hay sesión activa");
      }
    })
    .catch(err => console.error("⚠️ Error al verificar sesión:", err));
});


