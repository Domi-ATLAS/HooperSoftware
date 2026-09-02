<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Live Game Simulator">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        Volver al menú
    </a>

    <h1> Simulación LIVE NBA</h1>

    <c:if test="${not empty errorLive}">
        <p class="error-box">
            ${errorLive}
        </p>
    </c:if>

    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

    <form action="/simulaciones/live" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <h3>Equipo Local</h3>

        <select name="equipo1Id">

            <c:forEach var="e" items="${equipos}">
                <option value="${e.idEquipo}">
                    ${e.nombreEquipo}
                </option>
            </c:forEach>

        </select>

        <h3>Equipo Visitante</h3>

        <select name="equipo2Id">

            <c:forEach var="e" items="${equipos}">
                <option value="${e.idEquipo}">
                    ${e.nombreEquipo}
                </option>
            </c:forEach>

        </select>

        <br><br>

            <button class="search-btn">
                Simular Partido
            </button>

        </form>

        <c:choose>
            <c:when test="${not empty liveGame}">
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

    <c:if test="${not empty liveGame}">

        <hr>

        <div class="live-game-container">

            <div class="live-teams">

                <div class="live-team">

                    <img src="/images/${empty liveGame.siglas1 ? 'HS' : liveGame.siglas1}.png">

                    <h3>
                        ${liveGame.equipo1}
                    </h3>

                    <span class="live-score">
                        ${liveGame.finalA}
                    </span>

                </div>

                <div class="live-vs">
                    VS
                </div>

                <div class="live-team">

                    <img src="/images/${empty liveGame.siglas2 ? 'HS' : liveGame.siglas2}.png">

                    <h3>
                        ${liveGame.equipo2}
                    </h3>

                    <span class="live-score">
                        ${liveGame.finalB}
                    </span>

                </div>

            </div>

            <div class="quarters">

                <div>
                    Q1 → ${liveGame.q1a} - ${liveGame.q1b}
                </div>

                <div>
                    HALF → ${liveGame.q2a} - ${liveGame.q2b}
                </div>

                <div>
                    Q3 → ${liveGame.q3a} - ${liveGame.q3b}
                </div>

                <div>
                    FINAL → ${liveGame.finalA} - ${liveGame.finalB}
                </div>

            </div>

            <br>

            <div class="impact-box">

                <h3>Probabilidades Iniciales</h3>

                <p>
                    ${liveGame.equipo1}
                    →
                    <strong>${liveGame.probabilidadA}%</strong>
                </p>

                <p>
                    ${liveGame.equipo2}
                    →
                    <strong>${liveGame.probabilidadB}%</strong>
                </p>

            </div>

            <br>

            <div class="impact-box">

                <h3>Momentum del Partido</h3>

                <p style="font-size:20px;">
                    ${liveGame.momentum}
                </p>

            </div>

            <br>

            <div class="live-result">

                <h2>
                     Ganador
                </h2>

                <h3>
                    ${liveGame.ganador}
                </h3>

                <br>

                <h2>
                     MVP
                </h2>

                <h3>
                    ${liveGame.mvp}
                </h3>

            </div>

            <section class="simulation-insight" data-simulation-insight hidden>
                <h2>Comparativa del partido</h2>
                <div class="simulation-chart">
                    <div class="chart-row">
                        <span class="chart-label">${liveGame.siglas1} prob.</span>
                        <span class="chart-track"><span class="chart-fill" style="--value:${liveGame.probabilidadA};"></span></span>
                        <span class="chart-value">${liveGame.probabilidadA}%</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">${liveGame.siglas2} prob.</span>
                        <span class="chart-track"><span class="chart-fill is-muted" style="--value:${liveGame.probabilidadB};"></span></span>
                        <span class="chart-value">${liveGame.probabilidadB}%</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">${liveGame.siglas1} puntos</span>
                        <span class="chart-track"><span class="chart-fill is-good" style="--value:${liveGame.finalA * 100 / 140};"></span></span>
                        <span class="chart-value">${liveGame.finalA}</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">${liveGame.siglas2} puntos</span>
                        <span class="chart-track"><span class="chart-fill is-warning" style="--value:${liveGame.finalB * 100 / 140};"></span></span>
                        <span class="chart-value">${liveGame.finalB}</span>
                    </div>
                </div>
            </section>

        </div>

    </c:if>

</div>

</Layaout:layaout>

