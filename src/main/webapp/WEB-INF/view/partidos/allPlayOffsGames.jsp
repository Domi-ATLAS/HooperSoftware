<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Todos los Partidos de Playoffs">
    <div class="page-heading">
        <h1>Todos los Partidos de Playoffs</h1>
        <button class="btn" type="button" onclick="window.location.href='/allPlayOffs'">Volver a Playoffs</button>
    </div>

    <section data-filter-scope>
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

        <div class="playoff-grid">
            <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
                <c:set var="hasGames" value="false" />
                <c:forEach var="game" items="${playOffsGames}">
                    <c:if test="${game.temporada == temporada.anosTemporada}">
                        <c:set var="hasGames" value="true" />
                    </c:if>
                </c:forEach>
                <c:if test="${hasGames}">
                    <article class="playoff-card" data-filter-item data-season="${temporada.anosTemporada}">
                        <div class="page-heading">
                            <h2>Temporada ${temporada.anosTemporada}</h2>
                            <button class="toggle-button" type="button" onclick="toggleVisibility('season${loop.index}')">Mostrar/Ocultar</button>
                        </div>
                        <div id="season${loop.index}" class="vote-grid" style="display: none;">
                            <c:forEach var="game" items="${playOffsGames}">
                                <c:if test="${game.temporada == temporada.anosTemporada}">
                                    <div class="game">
                                        <div class="playoff-matchup">
                                            <span class="playoff-chip">${game.equipoLocal}</span>
                                            <strong>${game.resultadoTotal}</strong>
                                            <span class="playoff-chip">${game.equipoVisitante}</span>
                                        </div>
                                        <c:if test="${game.idPartido < 0}">
                                            <span class="data-badge is-fake">Fake ${game.temporada}</span>
                                        </c:if>
                                        <p><strong>Fecha:</strong> ${game.fecha}</p>
                                        <button class="btn" type="button" onclick="window.location.href='/partido/${game.idPartido}'">Detalles</button>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </article>
                </c:if>
            </c:forEach>
        </div>
    </section>

    <script>
        /**
         * Alterna la visibilidad de los partidos de una temporada.
         * @param {string} id Identificador del bloque de temporada.
         * @returns {void}
         */
        function toggleVisibility(id) {
            const section = document.getElementById(id);
            section.style.display = section.style.display === "none" ? "grid" : "none";
        }
    </script>
</Layaout:layaout>
