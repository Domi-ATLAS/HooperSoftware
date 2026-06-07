<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Live Game Simulator">

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        ← Volver al menú
    </a>

    <h1>🏀 Simulación LIVE NBA</h1>

    <c:if test="${not empty errorLive}">
        <p style="color:red;font-weight:bold;">
            ${errorLive}
        </p>
    </c:if>

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
                    🏆 Ganador
                </h2>

                <h3>
                    ${liveGame.ganador}
                </h3>

                <br>

                <h2>
                    ⭐ MVP
                </h2>

                <h3>
                    ${liveGame.mvp}
                </h3>

            </div>

        </div>

    </c:if>

</div>

</Layaout:layaout>