<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Noticias de Baloncesto">
    <%-- Vista frontend: noticias NBA y contenido externo embebido. --%>
  <div class="container">
    <!-- Columna izquierda: noticias -->
    <div class="noticias">
      <h1>Noticias</h1>
    </div>

    <!-- Columna derecha: marcador + chat + visor -->
    <div class="derecha">
      <!-- ===== MARCADOR ===== -->
      <div class="marcador panel">
        <h2>Marcador</h2>

        <div id="scores-root">
          <div id="scores-controls" style="display:flex; gap:8px; align-items:center; margin-bottom:8px;">
            <button id="refresh-scores" class="btn">Refrescar</button>
            <small class="small-muted">Última actualización: <span id="scores-last">-</span></small>
          </div>

          <div id="scores-content">
            <p>Cargando marcadores…</p>
          </div>
        </div>
      </div>

      <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
  (function(){
    const endpoint = '/api/nba/scores';
    const container = document.getElementById('scores-content');
    const lastEl = document.getElementById('scores-last');
    const refreshBtn = document.getElementById('refresh-scores');

    /**
     * Convierte una fecha ISO en un texto legible para la interfaz.
     * @param {string} iso Fecha en formato ISO.
     * @returns {string} Fecha formateada para mostrar en la interfaz.
     */
    function friendlyDate(iso) {
      try {
        const dt = new Date(iso);
        return dt.toLocaleString('es-ES', {
          hour: '2-digit',
          minute: '2-digit',
          day: '2-digit',
          month: '2-digit'
        });
      } catch(e) { return iso; }
    }

    // Si ambos son 0 -> "vs", si no -> "XX — YY"
    /**
     * Formatea el marcador de un partido para mostrarlo en la tarjeta.
     * @param {*} g Objeto con datos de un partido.
     * @returns {string} Marcador listo para pintar en la tarjeta.
     */
    function formatScore(g) {
      var hs = g.home_score || 0;
      var vs = g.visitor_score || 0;
      if (hs === 0 && vs === 0) {
        return 'vs';
      }
      return hs + ' — ' + vs;
    }

    /**
     * Renderiza en pantalla los datos recibidos por JavaScript.
     * @param {*} games Colección de partidos que se van a pintar en la vista.
     * @returns {void}
     */
    function render(games) {
      if (!games || games.length === 0) {
        container.innerHTML = '<p>No hay partidos para hoy / próximas horas.</p>';
        return;
      }

      // ahora consideramos más estados como "en juego"
      const live = games.filter(function(g){
        return /in progress|1st qtr|2nd qtr|3rd qtr|4th qtr|ot/i.test(g.status);
      });
      const finished = games.filter(function(g){
        return /final/i.test(g.status);
      });
      const scheduled = games.filter(function(g){
        return live.indexOf(g) === -1 && finished.indexOf(g) === -1;
      });

      let html = '';

      // EN DIRECTO
      if (live.length) {
        html += '<div class="panel"><h3 class="section-title">En directo</h3><ul class="list">';
        live.forEach(function(g){
          html += '<li class="row live-row">' +
                    '<div>' +
                      '<strong>' + g.home_team + '</strong> ' +
                      formatScore(g) + ' ' +
                      '<strong>' + g.visitor_team + '</strong> ' +
                      '<span class="live-pill">LIVE</span>' +
                    '</div>' +
                    '<span class="small-muted">' + g.status + '</span>' +
                  '</li>';
        });
        html += '</ul></div>';
      }

      // PROGRAMADOS (ahora también muestran marcador si lo hay)
      if (scheduled.length) {
        html += '<div class="panel" style="margin-top:8px;"><h3 class="section-title">Programados</h3><ul class="list">';
        scheduled.forEach(function(g){
          html += '<li class="row">' +
                    '<span>' + friendlyDate(g.date) + '</span> ' +
                    '<strong>' + g.home_team + '</strong> ' +
                    formatScore(g) + ' ' +
                    '<strong>' + g.visitor_team + '</strong> ' +
                    '<span class="small-muted">(' + g.status + ')</span>' +
                  '</li>';
        });
        html += '</ul></div>';
      }

      // FINALIZADOS
      if (finished.length) {
        html += '<div class="panel" style="margin-top:8px;"><h3 class="section-title">Finalizados</h3><ul class="list">';
        finished.forEach(function(g){
          html += '<li class="row">' +
                    '<strong>' + g.home_team + '</strong> ' +
                    formatScore(g) + ' ' +
                    '<strong>' + g.visitor_team + '</strong> ' +
                    '<span class="small-muted">(' + g.status + ')</span>' +
                  '</li>';
        });
        html += '</ul></div>';
      }

      container.innerHTML = html;
    }

    /**
     * Solicita datos externos y vuelve a renderizar la zona correspondiente.
     * @returns {Promise<void>}
     */
    async function fetchAndRender() {
      try {
        const res = await fetch(endpoint, { cache: 'no-store' });
        if (!res.ok) throw new Error('Error ' + res.status);
        const data = await res.json();
        render(data);
        lastEl.textContent = new Date().toLocaleTimeString('es-ES');
      } catch (err) {
        container.innerHTML =
          '<p style="color:crimson">No se pudieron cargar los marcadores: ' +
          err.message + '</p>';
      }
    }

    // refresco cada 10s
    let timer = setInterval(fetchAndRender, 10000);

    refreshBtn.addEventListener('click', function() {
      fetchAndRender();
    });

    fetchAndRender();

    window.addEventListener('beforeunload', function() {
      clearInterval(timer);
    });
  })();
</script>

      <!-- ===== FIN MARCADOR ===== -->

      <!-- VISOR ÚNICO (lo dejo como lo tenías) -->
      <div class="embed-card" style="margin-top:18px; padding:12px;">
        <div class="embed-header" style="align-items:center; gap:12px;">
          <h3 style="margin:0;">Visor — Fuentes externas</h3>

          <div style="margin-left:12px; display:flex; gap:8px; flex-wrap:wrap;">
            <button class="btn embed-switch" data-src="https://www.basketball-reference.com/">Basketball-Reference</button>
            <button class="btn embed-switch" data-src="https://es.wikipedia.org/wiki/National_Basketball_Association">Wikipedia (NBA)</button>
            <button class="btn embed-switch" data-src="https://www.eurohoops.net/es/">Eurohoops</button>
            <button class="btn embed-reload" title="Recargar fuente actual">Recargar</button>
            <a class="btn" id="open-new-tab" href="#" target="_blank" rel="noopener">Abrir en nueva pestaña</a>
          </div>
        </div>

        <div id="single-embed-body" class="embed-body" aria-hidden="true"
             style="max-height:0; overflow:hidden; transition: max-height 320ms ease, opacity 220ms ease; opacity:0; margin-top:8px;">
          <div class="embed-frame-wrap" style="width:100%; height:100%; min-height:360px; border-radius:6px; overflow:hidden; background:#f8f8f8;">
            <iframe id="single-embed-iframe"
                    class="embed-iframe"
                    src=""
                    data-src="https://www.basketball-reference.com/"
                    loading="lazy"
                    frameborder="0"
                    sandbox="allow-same-origin allow-scripts allow-forms"
                    style="width:100%; height:100%; border:0; display:block;"></iframe>
          </div>

          <div id="single-embed-fallback" class="embed-fallback" style="display:none; margin-top:8px; background:#fff7c2; border-radius:6px; padding:8px; border:1px solid #f0e68c; color:#333;">
            <p id="single-embed-fallback-text">La web no se puede mostrar embebida.
              <a id="single-embed-openlink" href="#" target="_blank" rel="noopener">Abrir en nueva pestaña</a>
            </p>
          </div>
        </div>
      </div>
      <!-- /VISOR ÚNICO -->
    </div> <!-- /.derecha -->
  </div>   <!-- /.container -->

  <!-- JS visor único (igual que lo tenías) -->
  <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
    (function () {
      document.addEventListener('DOMContentLoaded', () => {
        const iframe = document.getElementById('single-embed-iframe');
        const body = document.getElementById('single-embed-body');
        const fallback = document.getElementById('single-embed-fallback');
        const fallbackText = document.getElementById('single-embed-fallback-text');
        const openNewTab = document.getElementById('open-new-tab');

        const switches = document.querySelectorAll('.embed-switch');
        const reloadBtn = document.querySelector('.embed-reload');

        const vhRatio = 0.85;
        const reservedPx = 64;

        /**
         * Calcula una medida responsive en píxeles para el bloque embebido.
         * @returns {number} Altura calculada en píxeles.
         */
        function computePx() {
          return Math.max(Math.floor(window.innerHeight * vhRatio) - reservedPx, 260);
        }

        /**
         * Abre el cuerpo desplegable del bloque embebido.
         * @returns {void}
         */
        function openBody() {
          const h = computePx();
          body.style.maxHeight = h + 'px';
          body.style.height = h + 'px';
          body.style.opacity = '1';
          body.classList.add('open');
          body.setAttribute('aria-hidden', 'false');
        }

        /**
         * Muestra una alternativa visual cuando el contenido embebido no carga.
         * @param {string} msg Mensaje que se mostrará como fallback.
         * @param {string} src URL del recurso externo que se intenta cargar.
         * @returns {void}
         */
        function showFallback(msg, src) {
          const text = msg ?
            msg :
            'La web no se puede mostrar embebida.';
          fallbackText.innerHTML = text +
            ' <a id="single-embed-openlink" href="' + src +
            '" target="_blank" rel="noopener">Abrir en nueva pestaña</a>';
          fallback.style.display = 'block';
        }

        /**
         * Oculta el fallback del contenido embebido.
         * @returns {void}
         */
        function hideFallback() {
          fallback.style.display = 'none';
        }

        /**
         * Carga dinámicamente la URL de un iframe o recurso embebido.
         * @param {string} src URL del recurso externo que se intenta cargar.
         * @returns {void}
         */
        function loadSrc(src) {
          openBody();
          openNewTab.href = src;

          if (iframe.dataset.loaded && iframe.src === src) {
            hideFallback();
            return;
          }

          iframe.dataset.loaded = '1';
          iframe.src = src;
          hideFallback();

          iframe.addEventListener('error', function onErr() {
            showFallback('Error al cargar la página. Puedes abrirla en una pestaña nueva.', src);
            iframe.removeEventListener('error', onErr);
          }, { once: true });

          iframe.addEventListener('load', function onLoad() {
            try {
              const doc = iframe.contentDocument || iframe.contentWindow.document;
              if (doc && doc.body) {
                const textLen = (doc.body.innerText || '').trim().length;
                if (textLen === 0) {
                  showFallback('La página cargó pero aparece vacía en este contexto.', src);
                } else {
                  hideFallback();
                }
              }
            } catch (e) {
              hideFallback();
            } finally {
              iframe.removeEventListener('load', onLoad);
            }
          }, { once: true });
        }

        const defaultSrc = iframe.dataset.src || 'https://www.basketball-reference.com/';
        loadSrc(defaultSrc);

        switches.forEach(btn => {
          btn.addEventListener('click', () => {
            const src = btn.getAttribute('data-src');
            if (!src) return;
            loadSrc(src);
          });
        });

        reloadBtn.addEventListener('click', () => {
          const current = iframe.src || iframe.dataset.src;
          if (current) {
            iframe.src = current;
            hideFallback();
          }
        });

        window.addEventListener('resize', () => {
          if (body.classList.contains('open')) {
            const newH = computePx();
            body.style.maxHeight = newH + 'px';
            body.style.height = newH + 'px';
          }
        });
      });
    })();
  </script>
</Layaout:layaout>
