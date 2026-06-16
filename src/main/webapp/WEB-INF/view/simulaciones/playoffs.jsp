<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Predicción Playoffs">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-page">

    <div class="sim-card">

        <a href="/simulaciones" class="back-btn">
        ← Volver a Simulaciones
    </a>

        <h1>🏀 Predicción de Playoffs NBA</h1>

        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

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

        <c:if test="${not empty playoff}">

            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                <h2>
                    ${equipoSeleccionado.nombreEquipo}
                </h2>

                <div class="playoff-stat">
                    🏀 Playoffs:
                    <strong>${playoff.probPlayoffs}%</strong>
                </div>

                <div class="playoff-stat">
                    🏆 Finales:
                    <strong>${playoff.probFinales}%</strong>
                </div>

                <div class="playoff-stat">
                    👑 Campeón:
                    <strong>${playoff.probCampeon}%</strong>
                </div>

                <hr>

                <h3>${playoff.tier}</h3>

                <p>
                    ${playoff.mensaje}
                </p>

            </div>

        </c:if>

    </div>

</div>

</Layaout:layaout>