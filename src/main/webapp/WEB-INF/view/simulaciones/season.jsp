<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Temporada NBA">

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        Volver al menú
    </a>

    <h1> Simulación de Temporada NBA</h1>


    <form action="/simulaciones/temporada" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <button class="search-btn">
            Simular temporada completa
        </button>

    </form>

    <c:choose>
        <c:when test="${not empty seasonSimulation}">
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

    <c:if test="${not empty seasonSimulation}">

        <div class="season-sim-container">

            <div class="season-champion">

                <img src="/images/${empty seasonSimulation.campeonSiglas ? 'HS' : seasonSimulation.campeonSiglas}.png">

                <h2>
                     Campeón NBA
                </h2>

                <h3>
                    ${seasonSimulation.campeon}
                </h3>

                <p>
                     MVP:
                    ${seasonSimulation.mvp}
                </p>

            </div>

            <h2>Clasificación Final</h2>

            <table class="season-table">

                <thead>

                    <tr>
                        <th>#</th>
                        <th>Equipo</th>
                        <th>Record</th>
                        <th>Victorias app</th>
                        <th>Diferencia</th>
                    </tr>

                </thead>

                <tbody>

                    <c:forEach var="team"
                               items="${seasonSimulation.standings}"
                               varStatus="loop">

                        <tr>

                            <td>
                                ${loop.index + 1}
                            </td>

                            <td class="team-cell">

                                <img src="/images/${empty team.siglas ? 'HS' : team.siglas}.png">

                                ${team.nombre}

                            </td>

                            <td>
                                ${team.victorias}-${team.derrotas}
                            </td>

                            <td>
                                ${team.victoriasRegistradas}
                            </td>

                            <td>
                                ${team.diferenciaVictorias > 0 ? '+' : ''}${team.diferenciaVictorias}
                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

            <section class="simulation-insight" data-simulation-insight hidden>
                <h2>Comparativa de temporada</h2>
                <div class="simulation-chart">
                    <c:forEach var="team" items="${seasonSimulation.standings}" varStatus="loop">
                        <c:if test="${loop.index < 6}">
                            <div class="chart-row">
                                <span class="chart-label">${team.siglas}</span>
                                <span class="chart-track"><span class="chart-fill" style="--value:${team.victorias * 100 / 82};"></span></span>
                                <span class="chart-value">${team.victorias}</span>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </section>

        </div>

    </c:if>

</div>

</Layaout:layaout>

