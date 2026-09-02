<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="NBA Playoff Bracket">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        Volver al menú
    </a>

    <h1> Simulación completa Playoffs NBA</h1>

    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

    <form action="/simulaciones/bracket" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <button class="search-btn">
            Simular Playoffs completos
        </button>

    </form>

    <c:choose>
        <c:when test="${not empty bracket}">
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

    <c:if test="${not empty bracket}">

        <div class="bracket">

            <!-- CUARTOS -->

            <div class="round">

                <h2>Cuartos de Final</h2>

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
                             ${p.winner}
                        </div>

                    </div>

                </c:forEach>

            </div>

            <!-- SEMIFINALES -->

            <div class="round">

                <h2>Semifinales</h2>

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
                             ${p.winner}
                        </div>

                    </div>

                </c:forEach>

            </div>

            <!-- FINAL NBA -->

            <div class="round">

                <h2>Final NBA</h2>

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
                             ${p.winner}
                        </div>

                    </div>

                </c:forEach>

            </div>

            <!-- CAMPEÓN -->

            <div class="round champion">

                <h2> Campeón NBA</h2>

                <div class="champion-box">

                    <img src="/images/${empty bracket.campeonSiglas ? 'HS' : bracket.campeonSiglas}.png">

                    <h3>${bracket.campeon}</h3>

                </div>

                <p class="mvp">

                     MVP Finals

                    <br><br>

                    ${bracket.mvpFinals}

                </p>

            </div>

        </div>

        <section class="simulation-insight bracket-insight" data-simulation-insight hidden>
            <h2>Comparativa del bracket</h2>
            <div class="simulation-chart">
                <div class="chart-row">
                    <span class="chart-label">Rondas simuladas</span>
                    <span class="chart-track"><span class="chart-fill is-good" style="--value:100;"></span></span>
                    <span class="chart-value">3</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Series R1</span>
                    <span class="chart-track"><span class="chart-fill" style="--value:${fn:length(bracket.primeraRonda) * 25};"></span></span>
                    <span class="chart-value">${fn:length(bracket.primeraRonda)}</span>
                </div>
                <div class="chart-row">
                    <span class="chart-label">Semifinales</span>
                    <span class="chart-track"><span class="chart-fill is-warning" style="--value:${fn:length(bracket.semifinales) * 50};"></span></span>
                    <span class="chart-value">${fn:length(bracket.semifinales)}</span>
                </div>
            </div>
        </section>

    </c:if>

</div>

</Layaout:layaout>

