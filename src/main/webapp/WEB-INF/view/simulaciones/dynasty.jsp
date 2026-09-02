<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Dynasty Simulator">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        Volver al menú
    </a>

    <h1> Dynasty Simulator</h1>

    <p>
        Simula una dinastía NBA durante los próximos años y descubre
        cuántos anillos podría ganar tu franquicia.
    </p>

    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

    <form action="/simulaciones/dynasty" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <select name="equipoId">

            <c:forEach var="e" items="${equipos}">

                <option value="${e.idEquipo}">
                    ${e.nombreEquipo}
                </option>

            </c:forEach>

        </select>

        <br><br>

        <button class="search-btn">
            Simular Dinastía
        </button>

    </form>

    <c:choose>
        <c:when test="${not empty dynasty}">
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

    <c:if test="${not empty dynasty}">

        <hr>

        <div class="season-champion">

            <img src="/images/${empty dynasty.siglas ? 'HS' : dynasty.siglas}.png">

            <h2>
                ${dynasty.equipo}
            </h2>

            <p>
                Dynasty Score:
                <strong>${dynasty.dynastyScore}</strong>
            </p>

        </div>

        <div class="impact-box">

            <h3> Títulos Ganados</h3>

            <p style="font-size:28px;">
                ${dynasty.titulos}
            </p>

            <h3> Victorias Totales</h3>

            <p style="font-size:28px;">
                ${dynasty.victoriasTotales}
            </p>

        </div>

        <br>

        <div class="impact-box">

            <h3> Evolución de la Dinastía</h3>

            <ul style="text-align:left;max-width:600px;margin:auto;">

                <c:forEach var="temp" items="${dynasty.temporadas}">

                    <li>
                        ${temp}
                    </li>

                </c:forEach>

            </ul>

        </div>

        <br>

        <div class="impact-box">

            <c:choose>

                <c:when test="${dynasty.dynastyScore >= 90}">
                    <h2 class="result-note">
                        🐐 Dinastía Legendaria
                    </h2>
                </c:when>

                <c:when test="${dynasty.dynastyScore >= 75}">
                    <h2 class="result-note">
                         Dinastía Histórica
                    </h2>
                </c:when>

                <c:when test="${dynasty.dynastyScore >= 50}">
                    <h2 class="result-note">
                         Contender Constante
                    </h2>
                </c:when>

                <c:otherwise>
                    <h2 class="result-note">
                         Proyecto Fallido
                    </h2>
                </c:otherwise>

            </c:choose>

        </div>

        <section class="simulation-insight" data-simulation-insight hidden>
            <h2>Comparativa de dinastia</h2>
            <div class="simulation-chart">
                <div class="chart-row">
                    <span class="chart-label">Dynasty score</span>
                    <span class="chart-track"><span class="chart-fill is-good" style="--value:${dynasty.dynastyScore};"></span></span>
                    <span class="chart-value">${dynasty.dynastyScore}</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Titulos</span>
                    <span class="chart-track"><span class="chart-fill is-warning" style="--value:${dynasty.titulos * 25};"></span></span>
                    <span class="chart-value">${dynasty.titulos}</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Victorias</span>
                    <span class="chart-track"><span class="chart-fill" style="--value:${dynasty.victoriasTotales / 5};"></span></span>
                    <span class="chart-value">${dynasty.victoriasTotales}</span>
                </div>
            </div>
        </section>

    </c:if>

</div>

</Layaout:layaout>

