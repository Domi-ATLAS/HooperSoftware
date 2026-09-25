<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Predicción Playoffs">

<div class="sim-page">

    <div class="sim-card">

        <a href="/simulaciones" class="back-btn">
        Volver a Simulaciones
    </a>

        <h1> Predicción de Playoffs NBA</h1>


        <form action="/simulaciones/playoffs" method="post">

            <select name="equipoId">

                <c:forEach var="e" items="${equipos}">
                    <option value="${e.idEquipo}">
                        ${e.nombreEquipo}
                    </option>
                </c:forEach>

            </select>

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}" />

            <button class="search-btn">
                Simular Playoffs
            </button>

        </form>

        <c:choose>
            <c:when test="${not empty playoff}">
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

        <c:if test="${not empty playoff}">

            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                <h2>
                    ${equipoSeleccionado.nombreEquipo}
                </h2>

                <div class="playoff-stat">
                     Playoffs:
                    <strong>${playoff.probPlayoffs}%</strong>
                </div>

                <div class="playoff-stat">
                     Finales:
                    <strong>${playoff.probFinales}%</strong>
                </div>

                <div class="playoff-stat">
                     Campeón:
                    <strong>${playoff.probCampeon}%</strong>
                </div>

                <hr>

                <h3>${playoff.tier}</h3>

                <p>
                    ${playoff.mensaje}
                </p>

            </div>

            <section class="simulation-insight" data-simulation-insight hidden>
                <h2>Comparativa de proyeccion</h2>
                <div class="simulation-chart">
                    <div class="chart-row">
                        <span class="chart-label">Playoffs</span>
                        <span class="chart-track"><span class="chart-fill is-good" style="--value:${playoff.probPlayoffs};"></span></span>
                        <span class="chart-value">${playoff.probPlayoffs}%</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">Finales</span>
                        <span class="chart-track"><span class="chart-fill" style="--value:${playoff.probFinales};"></span></span>
                        <span class="chart-value">${playoff.probFinales}%</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">Campeon</span>
                        <span class="chart-track"><span class="chart-fill is-warning" style="--value:${playoff.probCampeon};"></span></span>
                        <span class="chart-value">${playoff.probCampeon}%</span>
                    </div>
                    <div class="chart-row">
                        <span class="chart-label">Victorias app</span>
                        <span class="chart-track"><span class="chart-fill is-muted" style="--value:${equipoSeleccionado.partidosGanados * 100 / 82};"></span></span>
                        <span class="chart-value">${equipoSeleccionado.partidosGanados}</span>
                    </div>
                </div>
            </section>

        </c:if>

    </div>

</div>

</Layaout:layaout>

