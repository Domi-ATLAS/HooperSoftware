<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Todos los Partidos de Playoffs">
    <%-- Vista frontend: consulta de partidos, temporadas, jornadas o playoffs con navegación y filtros. --%>
    <h1>Todos los Partidos de Playoffs</h1>

    <button onClick="window.location.href='/allPlayOffs'">Volver a Playoffs</button>

    <%-- Zona filtrable declarativa: los controles data-filter-control actúan sobre elementos data-filter-item. --%>
    <section data-filter-scope>
    <%-- Barra de filtros secundarios: búsqueda local, rangos y contador de resultados. --%>
    <div class="data-toolbar">
        <label>
            Buscar partido
            <input type="search" data-filter-control placeholder="Equipo, resultado...">
        </label>
        <label>
            Temporada
            <select data-filter-control data-filter-type="exact" data-filter-field="season">
                <option value="">Todas</option>
                <c:forEach var="temporada" items="${temporadas}">
                    <option value="${temporada.anosTemporada}">${temporada.anosTemporada}</option>
                </c:forEach>
            </select>
        </label>
        <div class="filter-actions">
            <button type="button" data-filter-reset>Limpiar</button>
            <span class="filter-status"><span data-filter-count></span> temporadas</span>
        </div>
    </div>

    <div class="filter-empty" data-filter-empty hidden>No hay partidos de playoffs con esos filtros.</div>

    <div class="container">
        <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
            <c:set var="hasGames" value="false" />
            <c:forEach var="game" items="${playOffsGames}">
                <c:if test="${game.temporada == temporada.anosTemporada}">
                    <c:set var="hasGames" value="true" />
                </c:if>
            </c:forEach>
            <c:if test="${hasGames}">
                <div data-filter-item data-season="${temporada.anosTemporada}">
                <h2 onclick="toggleVisibility('season${loop.index}')">Temporada: ${temporada.anosTemporada}</h2>
                <div id="season${loop.index}" style="display: none;">
                    <c:forEach var="game" items="${playOffsGames}">
                        <c:if test="${game.temporada == temporada.anosTemporada}">
                            <div class="game">
                                <p>Equipo Local:${game.equipoLocal}</p>
                                <p>Equipo Visitante: ${game.equipoVisitante}</p>
                                <p>Resultado Final: ${game.resultadoTotal}</p>
                                <p>Fecha: ${game.fecha}</p>
                                <p><button onClick="window.location.href='/partido/${game.idPartido}'">Detalles</button></p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    </section>

    <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
        /**
         * Alterna la visibilidad de una sección interactiva de la vista.
         * @param {string} id Identificador del elemento que se va a mostrar u ocultar.
         * @returns {void}
         */
        function toggleVisibility(id) {
            var x = document.getElementById(id);
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
    </script>
</Layaout:layaout>
