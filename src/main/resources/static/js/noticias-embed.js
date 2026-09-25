document.addEventListener('DOMContentLoaded', () => {
  /**
   * Tarjetas de noticias embebidas.
   *
   * Cargan el iframe solo bajo demanda y ofrecen un enlace externo cuando
   * el proveedor bloquea la incrustación en la página.
   */
  const cards = document.querySelectorAll('.embed-card');

  cards.forEach(card => {
    const toggle = card.querySelector('.embed-toggle');
    const body = card.querySelector('.embed-body');
    const iframe = card.querySelector('.embed-iframe');
    const fallback = card.querySelector('.embed-fallback');
    const openLink = card.querySelector('.embed-open');

    /**
     * Calcula una altura responsive razonable para el iframe de la tarjeta.
     *
     * @returns {number} Altura en píxeles limitada entre 260px y 800px.
     */
    function targetHeight() {
      // 60vh con mínimo de 260px y máximo de 800px.
      const h = Math.min(window.innerHeight * 0.6, 800);
      return Math.max(h, 260);
    }

    /**
     * Expande la tarjeta y carga el iframe la primera vez que se abre.
     *
     * @returns {void}
     */
    function open() {
      // Expande la tarjeta y prepara la zona visible del embed.
      body.style.height = targetHeight() + 'px';
      body.classList.add('open');
      body.setAttribute('aria-hidden', 'false');
      toggle.textContent = 'Ocultar';

      // Carga diferida: se evita descargar iframes que el usuario no abre.
      if (!iframe.dataset.loaded) {
        const src = iframe.dataset.src;
        iframe.src = src;
        iframe.dataset.loaded = '1';

        // Intenta detectar bloqueos de iframe por el proveedor externo.
        iframe.addEventListener('load', function onLoad() {
          // Same-origin permite inspeccionar; cross-origin se trata con fallback.
          try {
            const doc = iframe.contentDocument || iframe.contentWindow.document;
            if (!doc || !doc.body || doc.body.innerHTML.trim().length === 0) {
              showFallback();
            } else {
              // Embed cargado correctamente.
              fallback.classList.add('hidden');
            }
          } catch (e) {
            // Cross-origin no se puede leer desde el cliente; se muestra
            // un fallback para que el usuario pueda abrir la noticia fuera.
            setTimeout(() => {
              showFallback();
            }, 800);
          } finally {
            iframe.removeEventListener('load', onLoad);
          }
        });
      }
    }

    /**
     * Contrae la tarjeta conservando el iframe ya cargado.
     *
     * @returns {void}
     */
    function close() {
      body.style.height = '0px';
      body.classList.remove('open');
      body.setAttribute('aria-hidden', 'true');
      toggle.textContent = 'Abrir';
      // Se conserva el src para evitar recargas innecesarias al reabrir.
      // iframe.src = '';
      // delete iframe.dataset.loaded;
    }

    /**
     * Muestra el enlace externo de respaldo cuando el iframe no se puede usar.
     *
     * @returns {void}
     */
    function showFallback() {
      fallback.classList.remove('hidden');
      // Mantiene el enlace directo al contenido original.
      const src = iframe.dataset.src || card.dataset.src;
      if (openLink) openLink.href = src;
    }

    /**
     * Alterna la apertura de la tarjeta actual.
     */
    toggle.addEventListener('click', (e) => {
      const isOpen = body.classList.contains('open');
      if (isOpen) close(); else open();
    });

    /**
     * Recalcula la altura si el usuario redimensiona la ventana con la tarjeta abierta.
     */
    window.addEventListener('resize', () => {
      if (body.classList.contains('open')) {
        body.style.height = targetHeight() + 'px';
      }
    });
  });
});
