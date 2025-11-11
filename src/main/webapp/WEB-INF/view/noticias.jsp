<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Noticias de Baloncesto">
  <div class="container">
    <div class="noticias">
      <h1>Noticias</h1>
      <div>
        <h2>Niveles de los playoffs de la NBA de 2024</h2>
        <p>Resumen y artículos destacados sobre los equipos que siguen en la carrera por el anillo.</p>
      </div>
    </div>

    <div class="derecha">
      <div class="marcador">
        <h2>Marcador</h2>
        <p>Marcador en construcción...</p>
      </div>

      <div class="chat">
        <h2>Chat</h2>
        <p>Chat en construcción...</p>
      </div>

      <!-- VISOR ÚNICO -->
      <div class="embed-card" style="margin-top:18px; padding:12px;">
        <div class="embed-header" style="align-items:center; gap:12px;">
          <h3 style="margin:0;">Visor — Fuentes externas</h3>

          <!-- botones para cambiar la fuente -->
          <div style="margin-left:12px; display:flex; gap:8px; flex-wrap:wrap;">
            <button class="btn embed-switch" data-src="https://www.basketball-reference.com/">Basketball-Reference</button>
            <button class="btn embed-switch" data-src="https://es.wikipedia.org/wiki/National_Basketball_Association">Wikipedia (NBA)</button>
            <button class="btn embed-switch" data-src="https://www.eurohoops.net/es/">Eurohoops</button>
            <button class="btn embed-reload" title="Recargar fuente actual">Recargar</button>
            <a class="btn" id="open-new-tab" href="#" target="_blank" rel="noopener">Abrir en nueva pestaña</a>
          </div>
        </div>

        <!-- visor (cuerpo) -->
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
            <p id="single-embed-fallback-text">La web no se puede mostrar embebida. <a id="single-embed-openlink" href="#" target="_blank" rel="noopener">Abrir en nueva pestaña</a></p>
          </div>
        </div>
      </div>
      <!-- /VISOR ÚNICO -->

    </div>
  </div>

  <!-- JS: controlador del visor único -->
  <script>
    (function () {
      document.addEventListener('DOMContentLoaded', () => {
        const iframe = document.getElementById('single-embed-iframe');
        const body = document.getElementById('single-embed-body');
        const fallback = document.getElementById('single-embed-fallback');
        const fallbackText = document.getElementById('single-embed-fallback-text');
        const openNewTab = document.getElementById('open-new-tab');

        // botones para cambiar fuente
        const switches = document.querySelectorAll('.embed-switch');
        const reloadBtn = document.querySelector('.embed-reload');

        // ajustes de altura
        const vhRatio = 0.85;
        const reservedPx = 64;
        function computePx() {
          return Math.max(Math.floor(window.innerHeight * vhRatio) - reservedPx, 260);
        }

        // abre el body (fuerza altura en px)
        function openBody() {
          const h = computePx();
          body.style.maxHeight = h + 'px';
          body.style.height = h + 'px';
          body.style.opacity = '1';
          body.classList.add('open');
          body.setAttribute('aria-hidden', 'false');
        }
        function closeBody() {
          body.style.maxHeight = null;
          body.style.height = null;
          body.style.opacity = '0';
          body.classList.remove('open');
          body.setAttribute('aria-hidden', 'true');
        }

        function showFallback(msg, src) {
          if (msg) {
            fallbackText.innerHTML = msg + ' <a id="single-embed-openlink" href="' + src + '" target="_blank" rel="noopener">Abrir en nueva pestaña</a>';
          } else {
            fallbackText.innerHTML = 'La web no se puede mostrar embebida. <a id="single-embed-openlink" href="' + src + '" target="_blank" rel="noopener">Abrir en nueva pestaña</a>';
          }
          fallback.classList.add('visible');
          fallback.style.display = 'block';
        }
        function hideFallback() {
          fallback.classList.remove('visible');
          fallback.style.display = 'none';
        }

        // función para cargar una nueva URL en el iframe (no recarga si misma URL)
        function loadSrc(src) {
          // abrir el contenedor
          openBody();
          // actualizar link "abrir en nueva pestaña"
          openNewTab.href = src;

          // si el iframe ya está con la misma src (o data-src igual), no forzamos recarga,
          // pero si no estaba cargado lo cargamos
          if (iframe.dataset.loaded && iframe.src === src) {
            hideFallback();
            return;
          }

          // asignamos src y marcamos cargado
          iframe.dataset.loaded = '1';
          iframe.src = src;

          // ocultar fallback hasta que haya verdadera señal de error o comprobación same-origin
          hideFallback();

          // manejar error de carga (red/registro)
          iframe.addEventListener('error', function onErr() {
            showFallback('Error al cargar la página. Puedes abrirla en una pestaña nueva.', src);
            iframe.removeEventListener('error', onErr);
          }, { once: true });

          // si same-origin: comprobamos si el cuerpo está vacío
          iframe.addEventListener('load', function onLoad() {
            try {
              const doc = iframe.contentDocument || iframe.contentWindow.document;
              if (doc && doc.body) {
                const textLen = doc.body.innerText.trim().length;
                if (textLen === 0) {
                  showFallback('La página cargó pero aparece vacía en este contexto.', src);
                } else {
                  hideFallback();
                }
              } else {
                hideFallback();
              }
            } catch (e) {
              // cross-origin -> no forzamos fallback automático
              hideFallback();
            } finally {
              iframe.removeEventListener('load', onLoad);
            }
          }, { once: true });
        }

        // inicial: cargar basketball-reference por defecto
        const defaultSrc = iframe.dataset.src || 'https://www.basketball-reference.com/';
        loadSrc(defaultSrc);

        // manejadores de botones
        switches.forEach(btn => {
          btn.addEventListener('click', () => {
            const src = btn.dataset.src;
            if (!src) return;
            loadSrc(src);
          });
        });

        // recargar
        reloadBtn.addEventListener('click', () => {
          const current = iframe.src || iframe.dataset.src;
          if (current) {
            // forzamos recarga
            iframe.src = current;
            hideFallback();
          }
        });

        // resize -> si body está abierto, recomputar altura
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
