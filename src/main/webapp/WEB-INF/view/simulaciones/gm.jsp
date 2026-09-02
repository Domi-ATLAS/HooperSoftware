<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="GM Assistant">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        Volver al menú
    </a>

    <h1> GM Assistant</h1>

    <p>
        Selecciona un jugador y se mostrarán los mejores
        traspasos disponibles.
    </p>

    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

    <form action="/simulaciones/gm" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <select name="jugadorId">

            <c:forEach var="j" items="${jugadores}">

                <option value="${j.idJugador}">
                    ${j.nombreJugador}

                    <c:if test="${not empty j.equipo}">
                        (${j.equipo.nombreEquipo})
                    </c:if>
                    <c:if test="${not empty j.temporadaJugador}">
                        - ${j.temporadaJugador}
                    </c:if>

                </option>

            </c:forEach>

        </select>

        <br><br>

        <button class="search-btn">
            Buscar Trades
        </button>

    </form>

    <c:choose>
        <c:when test="${not empty gmTrades}">
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

    <c:if test="${not empty gmTrades}">

        <hr>

        <h2>Mejores traspasos encontrados</h2>

        <c:forEach var="trade" items="${gmTrades}" varStatus="loop">

            <div class="result-card ${loop.index == 0 ? 'top1' : ''}">

                <h3>

                    <c:if test="${loop.index == 0}">
                        Mejor opcion
                    </c:if>

                    <c:if test="${loop.index > 0}">
                        Opción ${loop.index + 1}
                    </c:if>

                </h3>

                <p>

                    <strong>
                        ${trade.jugador}
                    </strong>

                </p>

                <p>
                    Equipo:
                    ${trade.equipo}
                </p>

                <p>
                    Mejora estimada:
                    <strong>+${trade.mejoraWins} victorias</strong>
                </p>

            </div>

        </c:forEach>

        <section class="simulation-insight" data-simulation-insight hidden>
            <h2>Comparativa de candidatos</h2>
            <div class="simulation-chart">
                <c:forEach var="trade" items="${gmTrades}">
                    <div class="chart-row">
                        <span class="chart-label">${trade.jugador}</span>
                        <span class="chart-track"><span class="chart-fill is-good" style="--value:${trade.mejoraWins * 10};"></span></span>
                        <span class="chart-value">+${trade.mejoraWins}</span>
                    </div>
                </c:forEach>
            </div>
        </section>

    </c:if>

</div>

</Layaout:layaout>  

