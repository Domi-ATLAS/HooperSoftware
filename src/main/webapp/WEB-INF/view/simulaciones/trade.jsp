<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Trade Simulator">

<div class="sim-card-container">


    <a href="/simulaciones" class="back-btn">
    Volver al Simulation Center
</a>


    <h1> Trade Simulator</h1>

    <c:if test="${not empty error}">
        <p class="error-box">
            ${error}
        </p>
    </c:if>

    <!-- SIMULADOR -->


    <form action="/simulaciones" method="post">

        <h2>Jugador que entregas</h2>

        <select name="jugadorSaleId">

            <c:forEach var="sale" items="${jugadores}">

                <option value="${sale.idJugador}"
                    <c:if test="${sale.idJugador == param.jugadorSaleId}">
                        selected
                    </c:if>>

                    ${sale.nombreJugador}

                    <c:if test="${not empty sale.equipo}">
                        (${sale.equipo.nombreEquipo})
                    </c:if>
                    <c:if test="${not empty sale.temporadaJugador}">
                        - ${sale.temporadaJugador}
                    </c:if>

                </option>

            </c:forEach>

        </select>

        <h2>Jugador que recibes</h2>

        <select name="jugadorLlegaId">

            <c:forEach var="llega" items="${jugadores}">

                <option value="${llega.idJugador}"
                    <c:if test="${llega.idJugador == param.jugadorLlegaId}">
                        selected
                    </c:if>>

                    ${llega.nombreJugador}

                    <c:if test="${not empty llega.equipo}">
                        (${llega.equipo.nombreEquipo})
                    </c:if>
                    <c:if test="${not empty llega.temporadaJugador}">
                        - ${llega.temporadaJugador}
                    </c:if>

                </option>

            </c:forEach>

        </select>

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <br><br>

        <button class="search-btn">
            Simular Traspaso
        </button>

    </form>

    <c:choose>
        <c:when test="${not empty wins || not empty sugerencias || not empty sugerenciasEquipo}">
            <button type="button" class="search-btn simulation-toggle" onclick="toggleSimulationInsight(this)">
                Ver gráficas y modelo
            </button>
        </c:when>
        <c:otherwise>
            <button type="button" class="search-btn simulation-toggle" disabled>
                Ver gráficas y modelo
            </button>
        </c:otherwise>
    </c:choose>

    <!-- RESULTADO -->

    <c:if test="${not empty resultado}">

        <hr>

        <h2>Resultado</h2>

        <div class="trade-box">

            <p>
                Entregas:
                <strong>${sale.nombreJugador}</strong>
                <c:if test="${not empty sale.temporadaJugador}">
                    <span class="data-badge is-online">${sale.temporadaJugador}</span>
                </c:if>
            </p>

            <p>
                Recibes:
                <strong>${llega.nombreJugador}</strong>
                <c:if test="${not empty llega.temporadaJugador}">
                    <span class="data-badge is-online">${llega.temporadaJugador}</span>
                </c:if>
            </p>

            <div class="score-box ${resultado.color}">
                <div class="score-number">
                    ${resultado.score}
                </div>

                <div>/100</div>
            </div>

            <p>${resultado.evaluacion}</p>

            <c:if test="${resultado.score >= 70}">
                <p class="result-note">
                     Gran trade
                </p>
            </c:if>

            <c:if test="${resultado.score >= 40 && resultado.score < 70}">
                <p class="result-note">
                     Trade equilibrado
                </p>
            </c:if>

            <c:if test="${resultado.score < 40}">
                <p class="result-note">
                     Mala decisión
                </p>
            </c:if>

        </div>

        <c:if test="${sale.nombreJugador == llega.nombreJugador && sale.idJugador != llega.idJugador}">
            <section class="impact-box">
                <h2>Comparativa por temporada</h2>
                <p>
                    Se comparan dos registros del mismo jugador cargados en temporadas distintas.
                </p>
                <div class="table-scroll">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Versión</th>
                                <th>Equipo</th>
                                <th>Partidos</th>
                                <th>Puntos</th>
                                <th>Asistencias</th>
                                <th>Rebotes</th>
                                <th>Robos</th>
                                <th>Tapones</th>
                                <th>Triples</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${empty sale.temporadaJugador ? 'Base' : sale.temporadaJugador}</td>
                                <td>${empty sale.equipo ? 'Sin equipo' : sale.equipo.nombreEquipo}</td>
                                <td>${sale.estadisticasJug.partidosJugadosJug}</td>
                                <td>${sale.estadisticasJug.puntosTotales}</td>
                                <td>${sale.estadisticasJug.asistenciasTotales}</td>
                                <td>${sale.estadisticasJug.rebotesTotales}</td>
                                <td>${sale.estadisticasJug.robosTotales}</td>
                                <td>${sale.estadisticasJug.taponesTotales}</td>
                                <td>${sale.estadisticasJug.triplesAnotados}</td>
                            </tr>
                            <tr>
                                <td>${empty llega.temporadaJugador ? 'Base' : llega.temporadaJugador}</td>
                                <td>${empty llega.equipo ? 'Sin equipo' : llega.equipo.nombreEquipo}</td>
                                <td>${llega.estadisticasJug.partidosJugadosJug}</td>
                                <td>${llega.estadisticasJug.puntosTotales}</td>
                                <td>${llega.estadisticasJug.asistenciasTotales}</td>
                                <td>${llega.estadisticasJug.rebotesTotales}</td>
                                <td>${llega.estadisticasJug.robosTotales}</td>
                                <td>${llega.estadisticasJug.taponesTotales}</td>
                                <td>${llega.estadisticasJug.triplesAnotados}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </c:if>

    </c:if>

    <!-- IMPACTO -->

    <c:if test="${not empty impacto}">

        <h2>Impacto del traspaso</h2>

        <div class="impact-box">

            <p>Rating antes: ${impacto.ratingAntes}</p>
            <p>Rating después: ${impacto.ratingDespues}</p>

            <p>Victorias antes: ${impacto.victoriasAntes}</p>
            <p>Victorias después: ${impacto.victoriasDespues}</p>

            <p>

                Diferencia:

                <strong>

                    ${impacto.diferencia > 0 ? '+' : ''}
                    ${impacto.diferencia}

                </strong>

            </p>

        </div>

    </c:if>

    <!-- WINS -->

    <c:if test="${not empty wins}">

        <h2>Predicción de temporada</h2>

        <div class="impact-box">

            <p>

                Antes:
                <strong>
                    ${wins.winsAntes} wins
                </strong>

                (${wins.tierAntes})

            </p>

            <p>

                Después:
                <strong>
                    ${wins.winsDespues} wins
                </strong>

                (${wins.tierDespues})

            </p>

            <p style="font-size:22px;">

                Cambio:

                <strong>

                    ${wins.diferencia > 0 ? '+' : ''}
                    ${wins.diferencia}

                    wins

                </strong>

            </p>

            <hr>

            <p style="font-size:20px;">
                ${wins.mensajeEvaluacion}
            </p>

        </div>

        <section class="simulation-insight" data-simulation-insight hidden>
            <h2>Comparativa del traspaso</h2>
            <div class="simulation-chart">
                <div class="chart-row">
                    <span class="chart-label">Victorias antes</span>
                    <span class="chart-track"><span class="chart-fill is-muted" style="--value:${wins.winsAntes * 100 / 82};"></span></span>
                    <span class="chart-value">${wins.winsAntes}</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Victorias despues</span>
                    <span class="chart-track"><span class="chart-fill is-good" style="--value:${wins.winsDespues * 100 / 82};"></span></span>
                    <span class="chart-value">${wins.winsDespues}</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Encaje trade</span>
                    <span class="chart-track"><span class="chart-fill" style="--value:${resultado.score};"></span></span>
                    <span class="chart-value">${resultado.score}%</span>
                </div>
            </div>
        </section>

    </c:if>

    <!-- SUGERENCIAS DE TRADES -->

    <hr>

    <h2>Mejores traspasos encontrados</h2>


    <form action="/simulaciones/sugerir" method="post">

        <select name="jugadorBaseId">

            <c:forEach var="j" items="${jugadores}">

                <option value="${j.idJugador}">
                    ${j.nombreJugador}
                    <c:if test="${not empty j.temporadaJugador}">
                        - ${j.temporadaJugador}
                    </c:if>
                </option>

            </c:forEach>

        </select>

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <button class="search-btn">
            Buscar
        </button>

    </form>

    <c:if test="${not empty sugerencias}">

        <h3>Top sugerencias</h3>

        <c:forEach var="s"
                   items="${sugerencias}"
                   varStatus="i">

            <div class="result-card ${i.index == 0 ? 'top1' : ''}">

                <strong>
                    ${s.jugador.nombreJugador}
                </strong>

                <p>
                    Score: ${s.score}
                </p>

                <c:if test="${i.index == 0}">
                     Mejor opción
                </c:if>

            </div>

        </c:forEach>

        <section class="simulation-insight" data-simulation-insight hidden>
            <h2>Lectura de sugerencias</h2>
        </section>

    </c:if>

    <hr>

<h2>Qué necesita un equipo</h2>


<form action="/simulaciones/equipo" method="post">

    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}" />

    <select name="equipoId">

        <c:forEach var="e" items="${equipos}">
            <option value="${e.idEquipo}" <c:if test="${e.idEquipo == equipoId}">selected</c:if>>
                ${e.nombreEquipo}
            </option>
        </c:forEach>

    </select>

    <button class="search-btn">
        Analizar
    </button>

</form>

<c:if test="${not empty sugerenciasEquipo}">

    <div class="impact-box team-needs-result">

        <h3>
            ${equipoSeleccionado.nombreEquipo}
        </h3>

        <p class="small-muted">
            Jugadores que encajan mejor por equilibrio de plantilla, posición y aportación estadística.
        </p>

        <div class="team-needs-grid">
            <c:forEach var="s" items="${sugerenciasEquipo}">
                <article class="team-need-card">
                    <div>
                        <strong>${s.jugador.nombreJugador}</strong>
                        <p>
                            <c:choose>
                                <c:when test="${not empty s.jugador.equipo}">
                                    ${s.jugador.equipo.nombreEquipo}
                                </c:when>
                                <c:otherwise>Sin equipo</c:otherwise>
                            </c:choose>
                            <span> | </span>
                            <c:choose>
                                <c:when test="${not empty s.jugador.posicion}">
                                    ${s.jugador.posicion}
                                </c:when>
                                <c:otherwise>Posición no indicada</c:otherwise>
                            </c:choose>
                            <c:if test="${not empty s.jugador.temporadaJugador}">
                                <span> | </span>${s.jugador.temporadaJugador}
                            </c:if>
                        </p>
                    </div>
                    <div class="team-need-score">
                        <span>Encaje ${s.score}</span>
                        <span class="chart-track">
                            <span class="chart-fill" style="--value:${s.score};"></span>
                        </span>
                    </div>
                    <button class="btn" type="button" onclick="location.href='/player/${s.jugador.idJugador}'">
                        Ver jugador
                    </button>
                </article>
            </c:forEach>
        </div>

    </div>

    <section class="simulation-insight" data-simulation-insight hidden>
        <h2>Comparativa de necesidad</h2>
    </section>

</c:if>

</div>

</Layaout:layaout>

