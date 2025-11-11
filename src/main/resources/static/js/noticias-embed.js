document.addEventListener('DOMContentLoaded', () => {
  const cards = document.querySelectorAll('.embed-card');

  cards.forEach(card => {
    const toggle = card.querySelector('.embed-toggle');
    const body = card.querySelector('.embed-body');
    const iframe = card.querySelector('.embed-iframe');
    const fallback = card.querySelector('.embed-fallback');
    const openLink = card.querySelector('.embed-open');

    // calcular height a usar (responsive)
    function targetHeight() {
      // 60vh máximo y mínimo 260px
      const h = Math.min(window.innerHeight * 0.6, 800);
      return Math.max(h, 260);
    }

    function open() {
      // set height
      body.style.height = targetHeight() + 'px';
      body.classList.add('open');
      body.setAttribute('aria-hidden', 'false');
      toggle.textContent = 'Ocultar';

      // cargar iframe solo la primera vez
      if (!iframe.dataset.loaded) {
        const src = iframe.dataset.src;
        iframe.src = src;
        iframe.dataset.loaded = '1';

        // escucha load para intentar detectar bloqueo
        iframe.addEventListener('load', function onLoad() {
          // Intento heurístico: si same-origin puedo inspeccionar el documento; si cross-origin el acceso lanza excepción.
          try {
            const doc = iframe.contentDocument || iframe.contentWindow.document;
            if (!doc || !doc.body || doc.body.innerHTML.trim().length === 0) {
              showFallback();
            } else {
              // todo ok
              fallback.classList.add('hidden');
            }
          } catch (e) {
            // cross-origin: no podemos inspeccionar; comprobamos visualmente tras un timeout
            setTimeout(() => {
              // Si el iframe sigue vacío visualmente, mostramos fallback (heurístico)
              // No hay forma fiable de inspeccionar cross-origin; mostramos fallback para seguridad.
              // En la práctica, si la web bloquea el frame, el navegador mostrará una página en blanco o un mensaje nativo.
              // Aquí enseñamos el fallback por si el iframe está bloqueado.
              showFallback();
            }, 800);
          } finally {
            iframe.removeEventListener('load', onLoad);
          }
        });
      }
    }

    function close() {
      body.style.height = '0px';
      body.classList.remove('open');
      body.setAttribute('aria-hidden', 'true');
      toggle.textContent = 'Abrir';
      // no borramos src para evitar recargas innecesarias; si quieres liberar recursos, descomenta:
      // iframe.src = '';
      // delete iframe.dataset.loaded;
    }

    function showFallback() {
      fallback.classList.remove('hidden');
      // aseguramos que link apunte al src original
      const src = iframe.dataset.src || card.dataset.src;
      if (openLink) openLink.href = src;
    }

    toggle.addEventListener('click', (e) => {
      const isOpen = body.classList.contains('open');
      if (isOpen) close(); else open();
    });

    // cerrar al redimensionar para recalcular altura limpia
    window.addEventListener('resize', () => {
      if (body.classList.contains('open')) {
        body.style.height = targetHeight() + 'px';
      }
    });
  });
});
