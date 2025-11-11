document.addEventListener('DOMContentLoaded', function () {
  const btn = document.getElementById('toggleStandings');
  const container = document.getElementById('embedContainer');
  const iframe = document.getElementById('standingsIframe');
  const notice = document.getElementById('embedNotice');
  const openInTab = document.getElementById('openInTab');

  function openEmbed(){
    // altura responsive: 60vh o 600px máximo
    const h = Math.min(window.innerHeight * 0.6, 800);
    container.style.height = h + 'px';
    container.classList.add('open');
    container.setAttribute('aria-hidden', 'false');
    notice.style.display = 'none';

    // Forzar recarga del iframe solo la primera vez para ahorrar recursos
    if (!iframe.dataset.loaded) {
      iframe.dataset.loaded = 'true';
      // Si el src es externo y está bloqueado por X-Frame-Options, el iframe puede disparar "load" igual;
      // aquí intentamos detectar bloqueo chequeando acceso a contenido si es same-origin.
      iframe.addEventListener('load', function onLoad() {
        // Si el iframe está same-origin podremos leer su contentDocument; si no, será cross-origin y el acceso lanzará excepción.
        try {
          const doc = iframe.contentDocument || iframe.contentWindow.document;
          // si el documento tiene título y contenido, asumimos correcto
          if (!doc || !doc.body || doc.body.innerHTML.trim().length === 0) {
            showNotice();
          } else {
            // todo OK: oculta el aviso
            notice.style.display = 'none';
          }
        } catch (e) {
          // Si llegamos aquí, es muy probablemente cross-origin (embed bloqueado or allowed); no podemos inspeccionar,
          // así que comprobamos si el iframe está vacío después de un tiempo
          setTimeout(() => {
            // si el iframe sigue sin mostrar nada visual (imposible medir sin lectura), enseñamos aviso
            // Nota: esto es heurístico; lo correcto es revisar cabeceras en servidor.
            showNotice();
          }, 1200);
        }
        iframe.removeEventListener('load', onLoad);
      }, { once: true });
    }
  }

  function closeEmbed(){
    container.style.height = '0px';
    container.classList.remove('open');
    container.setAttribute('aria-hidden', 'true');
  }

  function showNotice(){
    notice.style.display = 'block';
    // Enlace a abrir en nueva pestaña ya está predefinido en la vista
  }

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
