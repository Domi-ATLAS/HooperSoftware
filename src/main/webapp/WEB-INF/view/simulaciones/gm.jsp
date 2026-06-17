<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="GM Assistant">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="sim-container">

    <a href="/simulaciones" class="search-btn">
        ← Volver al menú
    </a>

    <h1>🧠 GM Assistant</h1>

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

                </option>

            </c:forEach>

        </select>

        <br><br>

        <button class="search-btn">
            Buscar Trades
        </button>

    </form>

    <c:if test="${not empty gmTrades}">

        <hr>

        <h2>🔥 Mejores Trades Encontrados</h2>

        <c:forEach var="trade" items="${gmTrades}" varStatus="loop">

            <div class="result-card ${loop.index == 0 ? 'top1' : ''}">

                <h3>

                    <c:if test="${loop.index == 0}">
                        🏆 Mejor Opción
                    </c:if>

                    <c:if test="${loop.index > 0}">
                        Opción ${loop.index + 1}
                    </c:if>

                </h3>

                <p>

                    <strong>
                        ${trade.jugador.nombreJugador}
                    </strong>

                </p>

                <c:if test="${not empty trade.jugador.equipo}">
                    <p>
                        Equipo:
                        ${trade.jugador.equipo.nombreEquipo}
                    </p>
                </c:if>

                <p>
                    Score:
                    <strong>${trade.score}</strong>
                </p>

            </div>

        </c:forEach>

    </c:if>

</div>

</Layaout:layaout>  
