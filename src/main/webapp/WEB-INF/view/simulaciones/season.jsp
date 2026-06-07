<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Temporada NBA">

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        ← Volver al menú
    </a>

    <h1>📅 Simulación de Temporada NBA</h1>

    <form action="/simulaciones/temporada" method="post">

        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}" />

        <button class="search-btn">
            Simular temporada completa
        </button>

    </form>

    <c:if test="${not empty seasonSimulation}">

        <div class="season-sim-container">

            <div class="season-champion">

                <img src="/images/${empty seasonSimulation.campeonSiglas ? 'HS' : seasonSimulation.campeonSiglas}.png">

                <h2>
                    🏆 Campeón NBA
                </h2>

                <h3>
                    ${seasonSimulation.campeon}
                </h3>

                <p>
                    ⭐ MVP:
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

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </c:if>

</div>

</Layaout:layaout>