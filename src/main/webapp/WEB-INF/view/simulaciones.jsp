<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
        <%@ page contentType="text/html;charset=UTF-8" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <Layaout:layaout title="Simulador NBA">
    <%-- Vista frontend: menú de entrada a las simulaciones. --%>

                    <div class="sim-container">

                        <h1>Simulador de Traspasos NBA</h1>

                        <c:if test="${not empty error}">
                            <p style="color:red;font-weight:bold;">${error}</p>
                        </c:if>

                        <!-- ================= TRADE ================= -->

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones" method="post">

                            <h2>Jugador que entregas</h2>

                            <select name="jugadorSaleId">
                                <c:forEach var="sale" items="${jugadores}">
                                    <option value="${sale.idJugador}" <c:if
                                        test="${sale.idJugador == param.jugadorSaleId}">
                                        selected</c:if>>
                                        ${sale.nombreJugador}
                                        <c:if test="${not empty sale.equipo}">
                                            (${sale.equipo.nombreEquipo})
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>

                            <h2>Jugador que recibes</h2>

                            <select name="jugadorLlegaId">
                                <c:forEach var="llega" items="${jugadores}">
                                    <option value="${llega.idJugador}" <c:if
                                        test="${llega.idJugador == param.jugadorLlegaId}">selected</c:if>>
                                        ${llega.nombreJugador}
                                        <c:if test="${not empty llega.equipo}">
                                            (${llega.equipo.nombreEquipo})
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <br><br>

                            <button type="submit" class="search-btn">
                                Simular Traspaso
                            </button>

                        </form>

                        <!-- ================= RESULTADO ================= -->

                        <c:if test="${not empty resultado}">

                            <hr>

                            <h2>Resultado</h2>

                            <div class="trade-box">

                                <p>Entregas: <strong>${sale.nombreJugador}</strong></p>
                                <p>Recibes: <strong>${llega.nombreJugador}</strong></p>

                                <div class="score-box ${resultado.color}">
                                    <div class="score-number">${resultado.score}</div>
                                    <div>/100</div>
                                </div>

                                <p>${resultado.evaluacion}</p>

                                <c:if test="${resultado.score >= 70}">
                                    <p style="color:green;">🔥 Gran trade</p>
                                </c:if>

                                <c:if test="${resultado.score >= 40 && resultado.score < 70}">
                                    <p style="color:orange;">⚖️ Trade equilibrado</p>
                                </c:if>

                                <c:if test="${resultado.score < 40}">
                                    <p style="color:red;">❌ Mala decisión</p>
                                </c:if>

                            </div>

                        </c:if>

                        <!-- ================= IMPACTO ================= -->

                        <c:if test="${not empty impacto}">

                            <h2>Impacto del traspaso</h2>

                            <div class="impact-box">

                                <p>Rating antes: ${impacto.ratingAntes}</p>
                                <p>Rating después: ${impacto.ratingDespues}</p>

                                <p>Victorias antes: ${impacto.victoriasAntes}</p>
                                <p>Victorias después: ${impacto.victoriasDespues}</p>

                                <p>
                                    Diferencia:
                                    <strong style="color:${impacto.diferencia > 0 ? 'green' : 'red'};">
                                        ${impacto.diferencia > 0 ? '+' : ''}${impacto.diferencia}
                                    </strong>
                                </p>

                            </div>

                        </c:if>

                        <!-- ================= WINS PREDICTION ================= -->

                        <c:if test="${not empty wins}">

                            <h2>Predicción de temporada</h2>

                            <div class="impact-box">

                                <p>
                                    Antes:
                                    <strong>${wins.winsAntes} wins</strong>
                                    (${wins.tierAntes})
                                </p>

                                <p>
                                    Después:
                                    <strong>${wins.winsDespues} wins</strong>
                                    (${wins.tierDespues})
                                </p>

                                <p style="font-size:22px;">
                                    Cambio:
                                    <strong style="color:${wins.diferencia > 0 ? 'green' : 'red'};">
                                        ${wins.diferencia > 0 ? '+' : ''}${wins.diferencia}
                                        wins
                                    </strong>
                                </p>

                                <hr>

                                <p style="font-size:20px;">
                                    ${wins.mensajeEvaluacion}
                                </p>

                            </div>

                        </c:if>

                        <!-- ================= SUGERENCIAS JUGADOR ================= -->

                        <hr>

                        <h2>Mejores traspasos encontrados</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/sugerir" method="post">

                            <select name="jugadorBaseId">
                                <c:forEach var="j" items="${jugadores}">
                                    <option value="${j.idJugador}">
                                        ${j.nombreJugador}
                                    </option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <button class="search-btn">Buscar</button>

                        </form>

                        <c:if test="${not empty sugerencias}">

                            <h3>Top sugerencias</h3>

                            <c:forEach var="s" items="${sugerencias}" varStatus="i">

                                <div class="result-card ${i.index == 0 ? 'top1' : ''}">

                                    <strong>${s.jugador.nombreJugador}</strong>

                                    <p>Score: ${s.score}</p>

                                    <c:if test="${i.index == 0}">
                                        🔥 Mejor opción
                                    </c:if>

                                </div>

                            </c:forEach>

                        </c:if>

                        <!-- ================= SUGERENCIAS EQUIPO ================= -->

                        <hr>

                        <h2>Qué necesita un equipo</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/equipo" method="post">

                            <select name="equipoId">
                                <c:forEach var="e" items="${equipos}">
                                    <option value="${e.idEquipo}">
                                        ${e.nombreEquipo}
                                    </option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <button class="search-btn">Analizar</button>

                        </form>

                        <c:if test="${not empty sugerenciasEquipo}">

                            <h3>Mejores fichajes</h3>

                            <c:forEach var="s" items="${sugerenciasEquipo}">

                                <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                                    <strong>${s.jugador.nombreJugador}</strong>

                                    <p>Fit: ${s.score}</p>

                                </div>

                            </c:forEach>

                        </c:if>

                        <!-- ================= PLAYOFF SIMULATION ================= -->

                        <hr style="margin:60px 0;">

                        <h2>Simulación de Playoffs</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/playoffs" method="post">

                            <select name="equipoId">
                                <c:forEach var="e" items="${equipos}">
                                    <option value="${e.idEquipo}">
                                        ${e.nombreEquipo}
                                    </option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <button class="search-btn">Simular Playoffs</button>

                        </form>

                        <c:if test="${not empty playoff}">

                            <h3>Resultados para ${equipoSeleccionado.nombreEquipo}</h3>

                            <div class="impact-box">

                                <p>Probabilidad Playoffs:
                                    <strong>${playoff.probPlayoffs}%</strong>
                                </p>

                                <p>Probabilidad Finales:
                                    <strong>${playoff.probFinales}%</strong>
                                </p>

                                <p>Probabilidad Campeón:
                                    <strong>${playoff.probCampeon}%</strong>
                                </p>

                                <hr>

                                <p style="font-size:22px;">
                                    ${playoff.tier}
                                </p>

                                <p style="font-size:18px;">
                                    ${playoff.mensaje}
                                </p>

                            </div>

                        </c:if>

                        <!-- ================= BRACKET PLAYOFFS ================= -->

                        <hr style="margin:70px 0;">

                        <h2>Simulación completa Playoffs (Bracket)</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/bracket" method="post">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <button class="search-btn">
                                Simular Playoffs completos
                            </button>

                        </form>

                        <c:if test="${not empty bracket}">

                            <div class="bracket">

                                <!-- CUARTOS -->
                                <div class="round">
                                    <h3>Cuartos</h3>

                                    <c:forEach var="p" items="${bracket.primeraRonda}">

                                        <div class="match">

                                            <div class="team">
                                                <img src="/images/${empty p.team1Siglas ? 'HS' : p.team1Siglas}.png">
                                                <span>${p.team1}</span>
                                            </div>

                                            <div class="vs">VS</div>

                                            <div class="series-score">
                                                ${p.wins1} - ${p.wins2}
                                            </div>

                                            <div class="team">
                                                <img src="/images/${empty p.team2Siglas ? 'HS' : p.team2Siglas}.png">
                                                <span>${p.team2}</span>
                                            </div>

                                            <div class="winner">
                                                🏆 ${p.winner}
                                            </div>

                                        </div>

                                    </c:forEach>

                                </div>

                                <!-- SEMIS -->
                                <div class="round">
                                    <h3>Semifinales</h3>

                                    <c:forEach var="p" items="${bracket.semifinales}">

                                        <div class="match">

                                            <div class="team">
                                                <img src="/images/${empty p.team1Siglas ? 'HS' : p.team1Siglas}.png">
                                                <span>${p.team1}</span>
                                            </div>

                                            <div class="vs">VS</div>

                                            <div class="series-score">
                                                ${p.wins1} - ${p.wins2}
                                            </div>

                                            <div class="team">
                                                <img src="/images/${empty p.team2Siglas ? 'HS' : p.team2Siglas}.png">
                                                <span>${p.team2}</span>
                                            </div>

                                            <div class="winner">
                                                🏆 ${p.winner}
                                            </div>

                                        </div>

                                    </c:forEach>

                                </div>

                                <!-- FINAL -->
                                <div class="round">
                                    <h3>Final</h3>

                                    <c:forEach var="p" items="${bracket.finales}">

                                        <div class="match">

                                            <div class="team">
                                                <img src="/images/${empty p.team1Siglas ? 'HS' : p.team1Siglas}.png">
                                                <span>${p.team1}</span>
                                            </div>

                                            <div class="vs">VS</div>

                                            <div class="series-score">
                                                ${p.wins1} - ${p.wins2}
                                            </div>

                                            <div class="team">
                                                <img src="/images/${empty p.team2Siglas ? 'HS' : p.team2Siglas}.png">
                                                <span>${p.team2}</span>
                                            </div>

                                            <div class="winner">
                                                🏆 ${p.winner}
                                            </div>

                                        </div>

                                    </c:forEach>

                                </div>

                                <!-- CAMPEÓN -->
                                <div class="round champion">

                                    <h3>🏆 Campeón</h3>

                                    <div class="champion-box">
                                        <img
                                            src="/images/${empty bracket.campeonSiglas ? 'HS' : bracket.campeonSiglas}.png">
                                        <span>${bracket.campeon}</span>
                                    </div>

                                    <p class="mvp">
                                        MVP: ${bracket.mvpFinals}
                                    </p>

                                </div>

                            </div>

                        </c:if>

                        <hr style="margin:70px 0;">

                        <h2>Simulación Temporada NBA</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/temporada" method="post">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <button class="search-btn">
                                Simular temporada completa
                            </button>

                        </form>

                        <c:if test="${not empty seasonSimulation}">

                            <div class="season-sim-container">

                                <div class="season-champion">

                                    <img src="/images/${seasonSimulation.campeonSiglas}.png">

                                    <h3>
                                        🏆 Campeón:
                                        ${seasonSimulation.campeon}
                                    </h3>

                                    <p>
                                        MVP: ${seasonSimulation.mvp}
                                    </p>

                                </div>

                                <table class="season-table">

                                    <tr>
                                        <th>#</th>
                                        <th>Equipo</th>
                                        <th>Record</th>
                                    </tr>

                                    <c:forEach var="team" items="${seasonSimulation.standings}" varStatus="loop">

                                        <tr>

                                            <td>${loop.index + 1}</td>

                                            <td class="team-cell">

                                                <img src="/images/${team.siglas}.png">

                                                ${team.nombre}

                                            </td>

                                            <td>
                                                ${team.victorias}-${team.derrotas}
                                            </td>

                                        </tr>

                                    </c:forEach>

                                </table>

                            </div>

                        </c:if>

                        <hr style="margin:70px 0;">

                        <h2>Simulación LIVE NBA</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/live" method="post">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <select name="equipo1Id">

                                <c:forEach var="e" items="${equipos}">
                                    <option value="${e.idEquipo}">
                                        ${e.nombreEquipo}
                                    </option>
                                </c:forEach>

                            </select>

                            <select name="equipo2Id">

                                <c:forEach var="e" items="${equipos}">
                                    <option value="${e.idEquipo}">
                                        ${e.nombreEquipo}
                                    </option>
                                </c:forEach>

                            </select>

                            <button class="search-btn">
                                Simular partido
                            </button>

                        </form>

                        <c:if test="${not empty liveGame}">

                            <div class="live-game-container">

                                <div class="live-teams">

                                    <div class="live-team">

                                        <img src="/images/${liveGame.siglas1}.png">

                                        <h3>${liveGame.equipo1}</h3>

                                        <span class="live-score">
                                            ${liveGame.finalA}
                                        </span>

                                    </div>

                                    <div class="live-vs">
                                        VS
                                    </div>

                                    <div class="live-team">

                                        <img src="/images/${liveGame.siglas2}.png">

                                        <h3>${liveGame.equipo2}</h3>

                                        <span class="live-score">
                                            ${liveGame.finalB}
                                        </span>

                                    </div>

                                </div>

                                <div class="quarters">

                                    <div>Q1 → ${liveGame.q1a} - ${liveGame.q1b}</div>

                                    <div>HALF → ${liveGame.q2a} - ${liveGame.q2b}</div>

                                    <div>Q3 → ${liveGame.q3a} - ${liveGame.q3b}</div>

                                    <div>FINAL → ${liveGame.finalA} - ${liveGame.finalB}</div>

                                </div>

                                <div class="live-result">

                                    🏆 Ganador:
                                    ${liveGame.ganador}

                                    <br><br>

                                    ⭐ MVP:
                                    ${liveGame.mvp}

                                </div>

                                <div class="win-probability">

                                    <h3>Win Probability</h3>

                                    <div>
                                        ${liveGame.equipo1}
                                        →
                                        ${liveGame.probabilidadA}%
                                    </div>

                                    <div>
                                        ${liveGame.equipo2}
                                        →
                                        ${liveGame.probabilidadB}%
                                    </div>

                                    <br>

                                    <div class="momentum-box">
                                        ${liveGame.momentum}
                                    </div>

                                </div>

                            </div>

                        </c:if>

                        <hr style="margin:70px 0;">

                        <h2>GM Assistant</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/gm" method="post">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <select name="jugadorId">

                                <c:forEach var="j" items="${jugadores}">
                                    <option value="${j.idJugador}">
                                        ${j.nombreJugador}
                                    </option>
                                </c:forEach>

                            </select>

                            <button class="search-btn">
                                Buscar mejores trades
                            </button>

                        </form>

                        <c:if test="${not empty gmTrades}">

                            <div class="gm-results">

                                <h3>
                                    Mejores opciones de trade
                                </h3>

                                <c:forEach var="t" items="${gmTrades}">

                                    <div class="gm-card">

                                        <b>${t.jugador}</b>

                                        <br>

                                        ${t.equipo}

                                        <br>

                                        +${t.mejoraWins} victorias

                                    </div>

                                </c:forEach>

                            </div>

                        </c:if>

                        <hr style="margin:70px 0;">

                        <h2>Dynasty Simulator</h2>

                        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                        <form action="/simulaciones/dynasty" method="post">

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <select name="equipoId">

                                <c:forEach var="e" items="${equipos}">
                                    <option value="${e.idEquipo}">
                                        ${e.nombreEquipo}
                                    </option>
                                </c:forEach>

                            </select>

                            <button class="search-btn">
                                Simular 5 temporadas
                            </button>

                        </form>

                        <c:if test="${not empty dynasty}">

                            <div class="dynasty-container">

                                <img src="/images/${dynasty.siglas}.png">

                                <h2>${dynasty.equipo}</h2>

                                <c:forEach var="t" items="${dynasty.temporadas}">
                                    <div>${t}</div>
                                </c:forEach>

                                <br>

                                <h3>
                                    🏆 ${dynasty.titulos} títulos
                                </h3>

                                <h3>
                                    📈 ${dynasty.victoriasTotales} victorias
                                </h3>

                                <h3>
                                    ⭐ Dynasty Score:
                                    ${dynasty.dynastyScore}/100
                                </h3>

                            </div>

                        </c:if>

                    </div>

                </Layaout:layaout>
