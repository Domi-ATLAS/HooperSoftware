<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Tablero de encaje NBA">
    <%-- Vista frontend: tablero de pista para comparar quintetos, encaje por equipo y recomendaciones. --%>

    <section class="lineup-page">
        <a href="/simulaciones" class="back-btn">Volver a Simulaciones</a>

        <div class="lineup-header">
            <p class="eyebrow">Simulación de quinteto</p>
            <h1>Tablero de encaje NBA</h1>
            <p>
                Coloca jugadores sobre la pista, filtra por nombre o equipo y calcula compañeros,
                rivales favorables y destinos donde el perfil encaja mejor.
            </p>
        </div>

        <form class="lineup-shell" action="/simulaciones/tablero" method="post" data-lineup-board>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <aside class="lineup-panel lineup-controls">
                <%-- Filtros de ayuda: reducen las opciones de los selectores sin recargar la pagina. --%>
                <h2>Buscar</h2>

                <label for="lineup-player-search">Jugador</label>
                <input id="lineup-player-search"
                       type="search"
                       placeholder="Nombre del jugador"
                       autocomplete="off"
                       data-lineup-search>
                <div id="lineup-autocomplete-results" class="lineup-autocomplete-results"></div>

                <label for="lineup-team-filter">Equipo</label>
                <select id="lineup-team-filter" data-lineup-team>
                    <option value="">Todos los equipos</option>
                    <c:forEach var="equipo" items="${equipos}">
                        <option value="${equipo.nombreEquipo}">${equipo.nombreEquipo}</option>
                    </c:forEach>
                </select>

                <label for="jugadorBaseId">Jugador principal</label>
                <select id="jugadorBaseId" name="jugadorBaseId" data-player-select>
                    <option value="">Sin jugador principal</option>
                    <c:forEach var="jugador" items="${jugadores}">
                        <option value="${jugador.idJugador}"
                                data-name="${jugador.nombreJugador}"
                                data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                data-position="${jugador.posicion}"
                                <c:if test="${jugador.idJugador == jugadorBaseId}">selected</c:if>>
                            ${jugador.nombreJugador}
                            <c:if test="${not empty jugador.equipo}">
                                - ${jugador.equipo.nombreEquipo}
                            </c:if>
                            <c:if test="${not empty jugador.temporadaJugador}">
                                - ${jugador.temporadaJugador}
                            </c:if>
                        </option>
                    </c:forEach>
                </select>
                <p class="lineup-help">
                    El jugador principal marca el enfoque del análisis: se usa para medir encaje,
                    compañeros y equipos recomendados aunque no esté colocado en una casilla.
                </p>
                <div class="lineup-control-actions">
                    <button type="button" class="btn-secondary" data-lineup-place-main>Colocar en pista</button>
                    <button type="button" class="btn-secondary" data-lineup-reset>Reiniciar tablero</button>
                </div>

                <label for="equipoObjetivoId">Equipo objetivo</label>
                <select id="equipoObjetivoId" name="equipoObjetivoId">
                    <option value="">Sin equipo objetivo</option>
                    <c:forEach var="equipo" items="${equipos}">
                        <option value="${equipo.idEquipo}"
                                <c:if test="${equipo.idEquipo == equipoObjetivoId}">selected</c:if>>
                            ${equipo.nombreEquipo}
                        </option>
                    </c:forEach>
                </select>

                <button class="search-btn" type="submit">Calcular encaje</button>
            </aside>

            <div class="lineup-court-wrap">
                <%-- Pista visual: cada casilla representa una posicion del quinteto. --%>
                <div class="lineup-court" aria-label="Pista NBA para construir quinteto" data-lineup-court>
                    <div class="lineup-court-team" data-lineup-court-team>NBA</div>
                    <div class="court-half court-top"></div>
                    <div class="court-half court-bottom"></div>
                    <div class="court-center"></div>
                    <div class="court-line"></div>

                    <div class="lineup-slot slot-pg">
                        <span>Base</span>
                        <select name="baseId" data-player-select>
                            <option value="">Elegir jugador</option>
                            <c:forEach var="jugador" items="${jugadores}">
                                <option value="${jugador.idJugador}"
                                        data-name="${jugador.nombreJugador}"
                                        data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                        data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                        data-position="${jugador.posicion}"
                                        <c:if test="${jugador.idJugador == baseId}">selected</c:if>>
                                    ${jugador.nombreJugador}
                                    <c:if test="${not empty jugador.temporadaJugador}">
                                        - ${jugador.temporadaJugador}
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="lineup-slot slot-sg">
                        <span>Escolta</span>
                        <select name="escoltaId" data-player-select>
                            <option value="">Elegir jugador</option>
                            <c:forEach var="jugador" items="${jugadores}">
                                <option value="${jugador.idJugador}"
                                        data-name="${jugador.nombreJugador}"
                                        data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                        data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                        data-position="${jugador.posicion}"
                                        <c:if test="${jugador.idJugador == escoltaId}">selected</c:if>>
                                    ${jugador.nombreJugador}
                                    <c:if test="${not empty jugador.temporadaJugador}">
                                        - ${jugador.temporadaJugador}
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="lineup-slot slot-sf">
                        <span>Alero</span>
                        <select name="aleroId" data-player-select>
                            <option value="">Elegir jugador</option>
                            <c:forEach var="jugador" items="${jugadores}">
                                <option value="${jugador.idJugador}"
                                        data-name="${jugador.nombreJugador}"
                                        data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                        data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                        data-position="${jugador.posicion}"
                                        <c:if test="${jugador.idJugador == aleroId}">selected</c:if>>
                                    ${jugador.nombreJugador}
                                    <c:if test="${not empty jugador.temporadaJugador}">
                                        - ${jugador.temporadaJugador}
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="lineup-slot slot-pf">
                        <span>Ala-pivot</span>
                        <select name="alaPivotId" data-player-select>
                            <option value="">Elegir jugador</option>
                            <c:forEach var="jugador" items="${jugadores}">
                                <option value="${jugador.idJugador}"
                                        data-name="${jugador.nombreJugador}"
                                        data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                        data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                        data-position="${jugador.posicion}"
                                        <c:if test="${jugador.idJugador == alaPivotId}">selected</c:if>>
                                    ${jugador.nombreJugador}
                                    <c:if test="${not empty jugador.temporadaJugador}">
                                        - ${jugador.temporadaJugador}
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="lineup-slot slot-c">
                        <span>Pivot</span>
                        <select name="pivotId" data-player-select>
                            <option value="">Elegir jugador</option>
                            <c:forEach var="jugador" items="${jugadores}">
                                <option value="${jugador.idJugador}"
                                        data-name="${jugador.nombreJugador}"
                                        data-team="${empty jugador.equipo ? 'Sin equipo' : jugador.equipo.nombreEquipo}"
                                        data-team-logo="${empty jugador.equipo ? 'HS' : jugador.equipo.siglas}"
                                        data-season="${empty jugador.temporadaJugador ? 'Base' : jugador.temporadaJugador}"
                                        data-position="${jugador.posicion}"
                                        <c:if test="${jugador.idJugador == pivotId}">selected</c:if>>
                                    ${jugador.nombreJugador}
                                    <c:if test="${not empty jugador.temporadaJugador}">
                                        - ${jugador.temporadaJugador}
                                    </c:if>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <aside class="lineup-panel lineup-analysis">
                <%-- Panel de resultados: resume el encaje y reparte recomendaciones en bloques escaneables. --%>
                <h2>Análisis</h2>

                <c:choose>
                    <c:when test="${not empty analisisTablero}">
                        <p class="lineup-summary">${analisisTablero.resumen}</p>

                        <div class="lineup-metrics">
                            <div>
                                <span>Ataque</span>
                                <strong>${analisisTablero.ratingOfensivo}%</strong>
                            </div>
                            <div>
                                <span>Tiro</span>
                                <strong>${analisisTablero.spacing}%</strong>
                            </div>
                            <div>
                                <span>Defensa</span>
                                <strong>${analisisTablero.defensa}%</strong>
                            </div>
                            <div>
                                <span>Equilibrio</span>
                                <strong>${analisisTablero.equilibrio}%</strong>
                            </div>
                        </div>

                        <button type="button" class="search-btn simulation-toggle" onclick="toggleSimulationInsight(this)">
                            Ver gráficas y modelo
                        </button>

                        <section class="simulation-insight" data-simulation-insight hidden>
                            <h2>Comparativa del quinteto</h2>
                            <div class="simulation-chart">
                                <div class="chart-row">
                                    <span class="chart-label">Ataque</span>
                                    <span class="chart-track"><span class="chart-fill is-good" style="--value:${analisisTablero.ratingOfensivo};"></span></span>
                                    <span class="chart-value">${analisisTablero.ratingOfensivo}%</span>
                                </div>
                                <div class="chart-row">
                                    <span class="chart-label">Tiro</span>
                                    <span class="chart-track"><span class="chart-fill" style="--value:${analisisTablero.spacing};"></span></span>
                                    <span class="chart-value">${analisisTablero.spacing}%</span>
                                </div>
                                <div class="chart-row">
                                    <span class="chart-label">Defensa</span>
                                    <span class="chart-track"><span class="chart-fill is-muted" style="--value:${analisisTablero.defensa};"></span></span>
                                    <span class="chart-value">${analisisTablero.defensa}%</span>
                                </div>
                                <div class="chart-row">
                                    <span class="chart-label">Equilibrio</span>
                                    <span class="chart-track"><span class="chart-fill is-warning" style="--value:${analisisTablero.equilibrio};"></span></span>
                                    <span class="chart-value">${analisisTablero.equilibrio}%</span>
                                </div>
                            </div>
                        </section>

                        <div class="lineup-result-block">
                            <h3>Jugadores colocados</h3>
                            <c:forEach var="pick" items="${analisisTablero.seleccionados}">
                                <div class="lineup-mini-card">
                                    <strong>${pick.slot}: ${pick.jugador}</strong>
                                    <span>${pick.equipo} · ${pick.posicion} · tiro ${pick.tiroEstimado}%</span>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="lineup-result-block">
                            <h3>Mejores compañeros</h3>
                            <c:forEach var="item" items="${analisisTablero.mejoresCompaneros}">
                                <div class="lineup-mini-card">
                                    <strong>${item.jugador} <em>${item.porcentaje}%</em></strong>
                                    <span>${item.equipo} · ${item.posicion}</span>
                                    <p>${item.motivo}</p>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="lineup-result-block">
                            <h3>Rivales favorables</h3>
                            <c:forEach var="item" items="${analisisTablero.rivalesFavorables}">
                                <div class="lineup-mini-card">
                                    <strong>${item.jugador} <em>${item.porcentaje}%</em></strong>
                                    <span>${item.equipo} · ${item.posicion}</span>
                                    <p>${item.motivo}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="lineup-empty">
                            Selecciona jugadores en la pista y pulsa calcular para ver compañeros,
                            rivales y equipos recomendados.
                        </p>
                        <button type="button" class="search-btn simulation-toggle" disabled>
                            Ver gráficas y modelo
                        </button>
                    </c:otherwise>
                </c:choose>
            </aside>
        </form>

        <c:if test="${not empty analisisTablero}">
            <section class="lineup-lower-grid">
                <%-- Bloques complementarios: destinos recomendados y sugerencias para huecos libres. --%>
                <div class="lineup-panel">
                    <h2>Equipos donde encaja</h2>
                    <c:forEach var="team" items="${analisisTablero.encajeEquipos}">
                        <div class="lineup-team-fit">
                            <img src="/images/${empty team.siglas ? 'HS' : team.siglas}.png" alt="${team.equipo}">
                            <div>
                                <strong>${team.equipo} · ${team.encaje}%</strong>
                                <p>${team.motivo}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="lineup-panel">
                    <div class="lineup-panel-title">
                        <h2>Sugerencias para casillas libres</h2>
                        <button type="button" class="btn-secondary" data-lineup-fill-all>Añadir todas</button>
                    </div>
                    <c:choose>
                        <c:when test="${not empty analisisTablero.sugerenciasCasillas}">
                            <c:forEach var="slot" items="${analisisTablero.sugerenciasCasillas}">
                                <div class="lineup-mini-card">
                                    <strong>${slot.slot}: ${slot.jugador} <em>${slot.encaje}%</em></strong>
                                    <span>${slot.equipo}</span>
                                    <p>${slot.motivo}</p>
                                    <c:if test="${not empty slot.jugadorId}">
                                        <button type="button"
                                                class="btn-secondary lineup-add-suggestion"
                                                data-lineup-suggestion
                                                data-slot="${slot.slot}"
                                                data-player-id="${slot.jugadorId}">
                                            Añadir
                                        </button>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="lineup-empty">El quinteto está completo.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </c:if>
    </section>

    <script src="/js/lineup_board.js"></script>
</Layaout:layaout>

