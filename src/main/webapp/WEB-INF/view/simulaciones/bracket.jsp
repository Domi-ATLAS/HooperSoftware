<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="NBA Playoff Bracket">

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        ← Volver al menú
    </a>

    <h1>🏆 Simulación completa Playoffs NBA</h1>

    <form action="/simulaciones/bracket" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <button class="search-btn">
            Simular Playoffs completos
        </button>

    </form>

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
                            🏆 ${p.winner}
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
                            🏆 ${p.winner}
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
                            🏆 ${p.winner}
                        </div>

                    </div>

                </c:forEach>

            </div>

            <!-- CAMPEÓN -->

            <div class="round champion">

                <h2>🏆 Campeón NBA</h2>

                <div class="champion-box">

                    <img src="/images/${empty bracket.campeonSiglas ? 'HS' : bracket.campeonSiglas}.png">

                    <h3>${bracket.campeon}</h3>

                </div>

                <p class="mvp">

                    ⭐ MVP Finals

                    <br><br>

                    ${bracket.mvpFinals}

                </p>

            </div>

        </div>

    </c:if>

</div>

</Layaout:layaout>