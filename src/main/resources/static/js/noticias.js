document.addEventListener('DOMContentLoaded', function () {
  /**
   * Zona de standings embebidos.
   *
   * Abre/cierra el iframe y muestra un aviso cuando el proveedor externo
   * no permite cargarlo dentro de la página.
   */
  const btn = document.getElementById('toggleStandings');
  const container = document.getElementById('embedContainer');
  const iframe = document.getElementById('standingsIframe');
  const notice = document.getElementById('embedNotice');
  const openInTab = document.getElementById('openInTab');

  /**
   * Expande el iframe de standings y prepara la detección de bloqueo externo.
   *
   * @returns {void}
   */
  function openEmbed(){
    // Altura responsive para que el embed no ocupe toda la pantalla.
    const h = Math.min(window.innerHeight * 0.6, 800);
    container.style.height = h + 'px';
    container.classList.add('open');
    container.setAttribute('aria-hidden', 'false');
    notice.style.display = 'none';

    // Forzar recarga del iframe solo la primera vez para ahorrar recursos
    if (!iframe.dataset.loaded) {
      iframe.dataset.loaded = 'true';
      // Detección defensiva de iframes bloqueados por cabeceras externas.
      iframe.addEventListener('load', function onLoad() {
        // Same-origin se puede inspeccionar; cross-origin se resuelve con fallback.
        try {
          const doc = iframe.contentDocument || iframe.contentWindow.document;
          // Si el documento tiene contenido, el embed se considera cargado.
          if (!doc || !doc.body || doc.body.innerHTML.trim().length === 0) {
            showNotice();
          } else {
            // Embed válido: no hace falta mostrar aviso.
            notice.style.display = 'none';
          }
        } catch (e) {
          // Cross-origin no permite leer el contenido; se deja un margen antes
          // de mostrar el aviso de apertura externa.
          setTimeout(() => {
            showNotice();
          }, 1200);
        }
        iframe.removeEventListener('load', onLoad);
      }, { once: true });
    }
  }

  /**
   * Contrae el iframe de standings sin descargar el contenido cargado.
   *
   * @returns {void}
   */
  function closeEmbed(){
    container.style.height = '0px';
    container.classList.remove('open');
    container.setAttribute('aria-hidden', 'true');
  }

  /**
   * Muestra el aviso con alternativa para abrir el contenido fuera del iframe.
   *
   * @returns {void}
   */
  function showNotice(){
    notice.style.display = 'block';
    // El enlace para abrir en nueva pestaña ya está definido en la vista.
  }

  /**
   * Alterna la visibilidad del bloque de standings desde el botón principal.
   */
  btn.addEventListener('click', function () {
    if (container.classList.contains('open')) {
      closeEmbed();
      btn.textContent = 'Mostrar standings NBA';
    } else {
      openEmbed();
      btn.textContent = 'Ocultar standings NBA';
    }
  });
});
