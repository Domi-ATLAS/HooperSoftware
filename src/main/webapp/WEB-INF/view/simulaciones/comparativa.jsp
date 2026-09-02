<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Comparativa">
  <%-- Vista frontend: comparación histórica entre temporadas, plantillas y traspasos. --%>

  <section class="comparison-page">
    <a href="/simulaciones" class="back-btn">Volver a Simulaciones</a>

    <div class="comparison-header">
      <p class="eyebrow">Simulación histórica</p>
      <h1>Comparativa</h1>
      <p>
        Compara temporadas cargadas, acota equipos y jugadores, crea una plantilla nueva
        o sustituye un jugador para estimar cómo cambiaría una temporada.
      </p>
    </div>

    <c:if test="${empty temporadas}">
      <div class="empty-state">
        <strong>No hay temporadas importadas para comparar.</strong>
        <p>Carga primero datos NBA desde el selector del header.</p>
      </div>
    </c:if>

    <c:if test="${not empty temporadas}">
      <details class="comparison-section panel comparison-accordion" <c:if test="${not empty comparativaTemporadas}">open</c:if>>
        <summary class="comparison-accordion-summary">
          <span>Comparativa de temporadas</span>
          <small>Comparar datos globales de dos años</small>
        </summary>
        <div class="comparison-accordion-body">
        <%-- Comparativa global: resume jugadores y partidos de dos temporadas. --%>
        <form action="/simulaciones/comparativa/temporadas" method="post" class="comparison-form" data-comparison-form>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

          <div class="comparison-form-grid">
            <label>
              Temporada A
              <select name="temporadaA">
                <c:forEach var="temporada" items="${temporadas}">
                  <option value="${temporada}" <c:if test="${temporada == temporadaA || (empty temporadaA && temporada == defaultTemporadaA)}">selected</c:if>>
                    ${fn:substringAfter(temporada, '-')}
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Temporada B
              <select name="temporadaB">
                <c:forEach var="temporada" items="${temporadas}">
                  <option value="${temporada}" <c:if test="${temporada == temporadaB || (empty temporadaB && temporada == defaultTemporadaB)}">selected</c:if>>
                    ${fn:substringAfter(temporada, '-')}
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Jugadores visibles
              <input type="number" name="limiteJugadores" min="5" max="50" value="${empty limiteJugadores ? 15 : limiteJugadores}">
            </label>
          </div>

          <div class="comparison-options">
            <label class="check-option">
              <input type="checkbox" name="incluirJugadores" value="true" <c:if test="${incluirJugadores != false}">checked</c:if>>
              Incluir jugadores
            </label>
            <label class="check-option">
              <input type="checkbox" name="incluirPartidos" value="true" <c:if test="${incluirPartidos != false}">checked</c:if>>
              Incluir partidos
            </label>
          </div>

          <details class="comparison-filter-box">
            <summary>Acotar por equipos</summary>
            <div class="team-check-grid">
              <c:forEach var="equipo" items="${equipos}">
                <label class="check-option">
                  <input type="checkbox"
                         name="equiposIncluidos"
                         value="${equipo.idEquipo}"
                         data-comparison-team-check
                         <c:if test="${empty equiposIncluidos || equiposIncluidos.contains(equipo.idEquipo)}">checked</c:if>>
                  ${equipo.nombreEquipo}
                </label>
              </c:forEach>
            </div>
          </details>

          <div class="comparison-actions">
            <button class="btn" type="submit">Cargar y comparar temporadas</button>
            <button class="btn btn-secondary" type="button" data-download-comparison-chart <c:if test="${empty comparativaTemporadas}">disabled</c:if>>
              Descargar gráfica
            </button>
          </div>
        </form>

        <c:if test="${not empty comparativaTemporadas}">
          <div class="comparison-result">
            <h2>${comparativaTemporadas.temporadaA} frente a ${comparativaTemporadas.temporadaB}</h2>
            <p>${comparativaTemporadas.resumen}</p>

            <div class="comparison-kpis">
              <div>
                <span>${comparativaTemporadas.temporadaA}</span>
                <strong>${comparativaTemporadas.temporadaATotals.jugadores}</strong>
                <p>jugadores</p>
              </div>
              <div>
                <span>${comparativaTemporadas.temporadaB}</span>
                <strong>${comparativaTemporadas.temporadaBTotals.jugadores}</strong>
                <p>jugadores</p>
              </div>
              <div>
                <span>${comparativaTemporadas.temporadaA}</span>
                <strong>${comparativaTemporadas.temporadaATotals.partidos}</strong>
                <p>partidos</p>
              </div>
              <div>
                <span>${comparativaTemporadas.temporadaB}</span>
                <strong>${comparativaTemporadas.temporadaBTotals.partidos}</strong>
                <p>partidos</p>
              </div>
            </div>

            <div class="comparison-chart"
                 data-comparison-chart
                 data-chart-title="Comparativa ${comparativaTemporadas.temporadaA} vs ${comparativaTemporadas.temporadaB}"
                 data-series-a="${comparativaTemporadas.temporadaA}"
                 data-series-b="${comparativaTemporadas.temporadaB}">
              <c:forEach var="row" items="${comparativaTemporadas.chartRows}">
                <div class="comparison-chart-row" data-label="${row.label}" data-a="${row.displayA}" data-b="${row.displayB}">
                  <span class="chart-label">${row.label}</span>
                  <span class="dual-bars">
                    <span class="dual-bar is-a" style="--value:${row.valueA};"></span>
                    <span class="dual-bar is-b" style="--value:${row.valueB};"></span>
                  </span>
                  <span class="chart-value">${row.displayA} / ${row.displayB}</span>
                </div>
              </c:forEach>
            </div>

            <div class="comparison-tables">
              <div class="table-scroll">
                <h3>Equipos</h3>
                <table class="table">
                  <thead>
                    <tr>
                      <th>Equipo</th>
                      <th>Jugadores A</th>
                      <th>Jugadores B</th>
                      <th>Puntos A</th>
                      <th>Puntos B</th>
                      <th>Partidos A</th>
                      <th>Partidos B</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="row" items="${comparativaTemporadas.teamRows}">
                      <tr>
                        <td>${row.equipo}</td>
                        <td>${row.jugadoresA}</td>
                        <td>${row.jugadoresB}</td>
                        <td>${row.puntosA}</td>
                        <td>${row.puntosB}</td>
                        <td>${row.partidosA}</td>
                        <td>${row.partidosB}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>

              <div class="table-scroll">
                <h3>Jugadores coincidentes</h3>
                <table class="table">
                  <thead>
                    <tr>
                      <th>Jugador</th>
                      <th>Equipo A</th>
                      <th>Equipo B</th>
                      <th>Puntos A</th>
                      <th>Puntos B</th>
                      <th>Asist. A</th>
                      <th>Asist. B</th>
                      <th>Reb. A</th>
                      <th>Reb. B</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="row" items="${comparativaTemporadas.playerRows}">
                      <tr>
                        <td>${row.jugador}</td>
                        <td>${row.equipoA}</td>
                        <td>${row.equipoB}</td>
                        <td>${row.puntosA}</td>
                        <td>${row.puntosB}</td>
                        <td>${row.asistenciasA}</td>
                        <td>${row.asistenciasB}</td>
                        <td>${row.rebotesA}</td>
                        <td>${row.rebotesB}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </c:if>
        </div>
      </details>

      <details class="comparison-section panel comparison-accordion" <c:if test="${not empty plantillaResultado || not empty plantillaError}">open</c:if>>
        <summary class="comparison-accordion-summary">
          <span>Nuevo equipo</span>
          <small>Crear una plantilla y compararla con un equipo real</small>
        </summary>
        <div class="comparison-accordion-body">
        <%-- Simulación de plantilla: entre 8 y 12 jugadores frente a un equipo real. --%>
        <form action="/simulaciones/comparativa/plantilla" method="post" class="comparison-form" data-roster-form>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

          <div class="comparison-form-grid">
            <label>
              Temporada de referencia
              <select name="temporada" data-roster-season>
                <c:forEach var="temporada" items="${temporadas}">
                  <option value="${temporada}" <c:if test="${temporada == plantillaTemporada || (empty plantillaTemporada && temporada == defaultTemporadaB)}">selected</c:if>>
                    ${fn:substringAfter(temporada, '-')}
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Equipo a comparar
              <select name="equipoReferenciaId" data-roster-team>
                <c:forEach var="equipo" items="${equipos}">
                  <option value="${equipo.idEquipo}" <c:if test="${equipo.idEquipo == plantillaEquipoReferenciaId}">selected</c:if>>
                    ${equipo.nombreEquipo}
                  </option>
                </c:forEach>
              </select>
            </label>
          </div>

          <label>
            Selecciona de 8 a 12 jugadores
            <select name="jugadorIds" multiple size="12" data-roster-player-select class="native-player-select">
              <c:forEach var="jugador" items="${jugadores}">
                <option value="${jugador.idJugador}"
                        data-team-id="${empty jugador.equipo ? '' : jugador.equipo.idEquipo}"
                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                        <c:if test="${not empty plantillaJugadorIds && plantillaJugadorIds.contains(jugador.idJugador)}">selected</c:if>>
                  ${jugador.nombreJugador}
                  <c:if test="${not empty jugador.equipo}"> - ${jugador.equipo.nombreEquipo}</c:if>
                  <c:if test="${not empty jugador.temporadaJugador}"> - ${jugador.temporadaJugador}</c:if>
                </option>
              </c:forEach>
            </select>
          </label>

          <p class="filter-status" data-roster-count>0 jugadores seleccionados</p>
          <c:if test="${not empty plantillaError}">
            <p class="error-box">${plantillaError}</p>
          </c:if>

          <div class="comparison-actions">
            <button class="btn" type="submit">Simular plantilla</button>
            <button class="btn btn-secondary" type="button" data-download-scenario-chart <c:if test="${empty plantillaResultado}">disabled</c:if>>
              Descargar gráfica
            </button>
          </div>
        </form>

        <c:if test="${not empty plantillaResultado}">
          <div class="scenario-result"
               data-scenario-chart
               data-chart-title="Nuevo equipo ${plantillaResultado.temporada}"
               data-series-a="Equipo referencia"
               data-series-b="Plantilla simulada">
            <h3>${plantillaResultado.titulo}</h3>
            <p>${plantillaResultado.resumen}</p>
            <div class="comparison-kpis">
              <div>
                <span>Rating referencia</span>
                <strong>${plantillaResultado.ratingReferencia}</strong>
                <p>${plantillaResultado.equipoReferencia}</p>
              </div>
              <div>
                <span>Rating simulado</span>
                <strong>${plantillaResultado.ratingSimulado}</strong>
                <p>${plantillaResultado.jugadores} jugadores</p>
              </div>
              <div>
                <span>Victorias</span>
                <strong>${plantillaResultado.victoriasSimuladas}</strong>
                <p>${plantillaResultado.diferenciaVictorias > 0 ? '+' : ''}${plantillaResultado.diferenciaVictorias} frente al original</p>
              </div>
              <div>
                <span>Defensa</span>
                <strong>${plantillaResultado.defensaSimulada}</strong>
                <p>rebotes, robos y tapones ponderados</p>
              </div>
            </div>
            <div class="comparison-chart">
              <div class="comparison-chart-row" data-label="Rating" data-a="${plantillaResultado.ratingReferencia}" data-b="${plantillaResultado.ratingSimulado}">
                <span class="chart-label">Rating</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${plantillaResultado.ratingReferencia};"></span>
                  <span class="dual-bar is-b" style="--value:${plantillaResultado.ratingSimulado};"></span>
                </span>
                <span class="chart-value">${plantillaResultado.ratingReferencia} / ${plantillaResultado.ratingSimulado}</span>
              </div>
              <div class="comparison-chart-row" data-label="Victorias" data-a="${plantillaResultado.victoriasReferencia}" data-b="${plantillaResultado.victoriasSimuladas}">
                <span class="chart-label">Victorias</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${plantillaResultado.victoriasReferencia * 100 / 82};"></span>
                  <span class="dual-bar is-b" style="--value:${plantillaResultado.victoriasSimuladas * 100 / 82};"></span>
                </span>
                <span class="chart-value">${plantillaResultado.victoriasReferencia} / ${plantillaResultado.victoriasSimuladas}</span>
              </div>
              <div class="comparison-chart-row" data-label="Puntos" data-a="${plantillaResultado.puntosReferencia}" data-b="${plantillaResultado.puntosSimulados}">
                <span class="chart-label">Puntos</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${plantillaResultado.puntosReferencia * 100 / ((plantillaResultado.puntosSimulados > plantillaResultado.puntosReferencia ? plantillaResultado.puntosSimulados : plantillaResultado.puntosReferencia) + 1)};"></span>
                  <span class="dual-bar is-b" style="--value:${plantillaResultado.puntosSimulados * 100 / ((plantillaResultado.puntosSimulados > plantillaResultado.puntosReferencia ? plantillaResultado.puntosSimulados : plantillaResultado.puntosReferencia) + 1)};"></span>
                </span>
                <span class="chart-value">${plantillaResultado.puntosReferencia} / ${plantillaResultado.puntosSimulados}</span>
              </div>
              <div class="comparison-chart-row" data-label="Defensa" data-a="${plantillaResultado.defensaReferencia}" data-b="${plantillaResultado.defensaSimulada}">
                <span class="chart-label">Defensa</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${plantillaResultado.defensaReferencia * 100 / ((plantillaResultado.defensaSimulada > plantillaResultado.defensaReferencia ? plantillaResultado.defensaSimulada : plantillaResultado.defensaReferencia) + 1)};"></span>
                  <span class="dual-bar is-b" style="--value:${plantillaResultado.defensaSimulada * 100 / ((plantillaResultado.defensaSimulada > plantillaResultado.defensaReferencia ? plantillaResultado.defensaSimulada : plantillaResultado.defensaReferencia) + 1)};"></span>
                </span>
                <span class="chart-value">${plantillaResultado.defensaReferencia} / ${plantillaResultado.defensaSimulada}</span>
              </div>
            </div>
            <details class="comparison-filter-box">
              <summary>Jugadores seleccionados</summary>
              <ul class="comparison-list">
                <c:forEach var="nombre" items="${plantillaResultado.jugadoresSeleccionados}">
                  <li>${nombre}</li>
                </c:forEach>
              </ul>
            </details>
          </div>
        </c:if>
        </div>
      </details>

      <details class="comparison-section panel comparison-accordion" <c:if test="${not empty traspasoResultado}">open</c:if>>
        <summary class="comparison-accordion-summary">
          <span>Traspaso sobre una temporada</span>
          <small>Sustituir un jugador y medir el cambio estimado</small>
        </summary>
        <div class="comparison-accordion-body">
        <%-- Simulación de traspaso histórico: cambia un jugador de una plantilla concreta. --%>
        <form action="/simulaciones/comparativa/traspaso" method="post" class="comparison-form" data-trade-form>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

          <div class="comparison-form-grid">
            <label>
              Temporada
              <select name="temporada" data-trade-season>
                <c:forEach var="temporada" items="${temporadas}">
                  <option value="${temporada}" <c:if test="${temporada == traspasoTemporada || (empty traspasoTemporada && temporada == defaultTemporadaB)}">selected</c:if>>
                    ${fn:substringAfter(temporada, '-')}
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Equipo
              <select name="equipoId" data-trade-team>
                <c:forEach var="equipo" items="${equipos}">
                  <option value="${equipo.idEquipo}" <c:if test="${equipo.idEquipo == traspasoEquipoId}">selected</c:if>>
                    ${equipo.nombreEquipo}
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Jugador que sale
              <input type="search" class="player-select-search" data-player-search="sale" placeholder="Buscar jugador del equipo...">
              <select name="jugadorSaleId" data-trade-sale>
                <c:forEach var="jugador" items="${jugadores}">
                  <option value="${jugador.idJugador}"
                          data-team-id="${empty jugador.equipo ? '' : jugador.equipo.idEquipo}"
                          data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                          <c:if test="${jugador.idJugador == jugadorSaleId}">selected</c:if>>
                    ${jugador.nombreJugador}
                    <c:if test="${not empty jugador.temporadaJugador}"> - ${jugador.temporadaJugador}</c:if>
                  </option>
                </c:forEach>
              </select>
            </label>

            <label>
              Jugador que entra
              <input type="search" class="player-select-search" data-player-search="arrive" placeholder="Buscar jugador por nombre o equipo...">
              <select name="jugadorLlegaId" data-trade-arrive>
                <c:forEach var="jugador" items="${jugadores}">
                  <option value="${jugador.idJugador}"
                          data-team-id="${empty jugador.equipo ? '' : jugador.equipo.idEquipo}"
                          data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                          <c:if test="${jugador.idJugador == jugadorLlegaId}">selected</c:if>>
                    ${jugador.nombreJugador}
                    <c:if test="${not empty jugador.equipo}"> - ${jugador.equipo.nombreEquipo}</c:if>
                    <c:if test="${not empty jugador.temporadaJugador}"> - ${jugador.temporadaJugador}</c:if>
                  </option>
                </c:forEach>
              </select>
            </label>
          </div>

          <div class="comparison-actions">
            <button class="btn" type="submit">Comparar traspaso</button>
            <button class="btn btn-secondary" type="button" data-download-scenario-chart <c:if test="${empty traspasoResultado}">disabled</c:if>>
              Descargar gráfica
            </button>
          </div>
        </form>

        <c:if test="${not empty traspasoResultado}">
          <div class="scenario-result"
               data-scenario-chart
               data-chart-title="Traspaso ${traspasoResultado.temporada}"
               data-series-a="Equipo original"
               data-series-b="Con traspaso">
            <h3>${traspasoResultado.titulo}</h3>
            <p>${traspasoResultado.resumen}</p>
            <div class="comparison-kpis">
              <div>
                <span>Rating original</span>
                <strong>${traspasoResultado.ratingReferencia}</strong>
                <p>${traspasoResultado.equipoReferencia}</p>
              </div>
              <div>
                <span>Rating con traspaso</span>
                <strong>${traspasoResultado.ratingSimulado}</strong>
                <p>${traspasoResultado.jugadores} jugadores</p>
              </div>
              <div>
                <span>Victorias simuladas</span>
                <strong>${traspasoResultado.victoriasSimuladas}</strong>
                <p>${traspasoResultado.diferenciaVictorias > 0 ? '+' : ''}${traspasoResultado.diferenciaVictorias} frente al original</p>
              </div>
              <div>
                <span>Defensa simulada</span>
                <strong>${traspasoResultado.defensaSimulada}</strong>
                <p>rebotes, robos y tapones ponderados</p>
              </div>
            </div>
            <div class="comparison-chart">
              <div class="comparison-chart-row" data-label="Rating" data-a="${traspasoResultado.ratingReferencia}" data-b="${traspasoResultado.ratingSimulado}">
                <span class="chart-label">Rating</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${traspasoResultado.ratingReferencia};"></span>
                  <span class="dual-bar is-b" style="--value:${traspasoResultado.ratingSimulado};"></span>
                </span>
                <span class="chart-value">${traspasoResultado.ratingReferencia} / ${traspasoResultado.ratingSimulado}</span>
              </div>
              <div class="comparison-chart-row" data-label="Victorias" data-a="${traspasoResultado.victoriasReferencia}" data-b="${traspasoResultado.victoriasSimuladas}">
                <span class="chart-label">Victorias</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${traspasoResultado.victoriasReferencia * 100 / 82};"></span>
                  <span class="dual-bar is-b" style="--value:${traspasoResultado.victoriasSimuladas * 100 / 82};"></span>
                </span>
                <span class="chart-value">${traspasoResultado.victoriasReferencia} / ${traspasoResultado.victoriasSimuladas}</span>
              </div>
              <div class="comparison-chart-row" data-label="Puntos" data-a="${traspasoResultado.puntosReferencia}" data-b="${traspasoResultado.puntosSimulados}">
                <span class="chart-label">Puntos</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${traspasoResultado.puntosReferencia * 100 / ((traspasoResultado.puntosSimulados > traspasoResultado.puntosReferencia ? traspasoResultado.puntosSimulados : traspasoResultado.puntosReferencia) + 1)};"></span>
                  <span class="dual-bar is-b" style="--value:${traspasoResultado.puntosSimulados * 100 / ((traspasoResultado.puntosSimulados > traspasoResultado.puntosReferencia ? traspasoResultado.puntosSimulados : traspasoResultado.puntosReferencia) + 1)};"></span>
                </span>
                <span class="chart-value">${traspasoResultado.puntosReferencia} / ${traspasoResultado.puntosSimulados}</span>
              </div>
              <div class="comparison-chart-row" data-label="Defensa" data-a="${traspasoResultado.defensaReferencia}" data-b="${traspasoResultado.defensaSimulada}">
                <span class="chart-label">Defensa</span>
                <span class="dual-bars">
                  <span class="dual-bar is-a" style="--value:${traspasoResultado.defensaReferencia * 100 / ((traspasoResultado.defensaSimulada > traspasoResultado.defensaReferencia ? traspasoResultado.defensaSimulada : traspasoResultado.defensaReferencia) + 1)};"></span>
                  <span class="dual-bar is-b" style="--value:${traspasoResultado.defensaSimulada * 100 / ((traspasoResultado.defensaSimulada > traspasoResultado.defensaReferencia ? traspasoResultado.defensaSimulada : traspasoResultado.defensaReferencia) + 1)};"></span>
                </span>
                <span class="chart-value">${traspasoResultado.defensaReferencia} / ${traspasoResultado.defensaSimulada}</span>
              </div>
            </div>
          </div>
        </c:if>
        </div>
      </details>
    </c:if>
  </section>

  <script src="/js/comparativa.js"></script>
</Layaout:layaout>
