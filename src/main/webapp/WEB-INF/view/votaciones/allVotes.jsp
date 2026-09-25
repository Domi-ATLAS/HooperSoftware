<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Todas las Votaciones">


    <h1>Todas las Votaciones</h1>

    <button type="button" onclick="location.href='/allVotes/inCourse'">Votaciones en Curso</button>
    <button type="button" onclick="location.href='/allVotes/oficial'">Votaciones Oficiales</button>

    <sec:authorize access="hasAuthority('admin')">
        <section class="admin-create-card">
            <h2>Crear nueva votación</h2>
            <form class="filter-form" action="/allVotes/new" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="filter-field">
                    <label for="new-category">Categoría</label>
                    <select id="new-category" name="categoria" required>
                        <c:forEach var="categoria" items="${categorias}">
                            <option value="${categoria}">${categoria.displayName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-field">
                    <label for="new-season">Temporada</label>
                    <select id="new-season" name="temporada" required>
                        <c:forEach var="temporada" items="${temporadas}">
                            <option value="${temporada.anosTemporada}">${temporada.anosTemporada}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-field">
                    <label for="new-options">Opciones</label>
                    <input id="new-options" name="opcionesVotacion" type="text" placeholder="Jugador 1, Jugador 2, Jugador 3" required>
                </div>

                <div class="filter-field">
                    <label for="new-date">Fecha</label>
                    <input id="new-date" name="fecha" type="date">
                </div>

                <div class="filter-field">
                    <label for="new-round">Jornada</label>
                    <input id="new-round" name="jornada" type="text" placeholder="Regular season, Playoffs...">
                </div>

                <div class="filter-field">
                    <label for="new-winner">Ganador</label>
                    <input id="new-winner" name="ganador" type="text" placeholder="Opcional">
                </div>

                <div class="filter-field">
                    <label for="new-duration">Duración</label>
                    <input id="new-duration" name="duracionVotacion" type="number" min="1" placeholder="Días">
                </div>

                <label class="checkbox-line">
                    <input type="checkbox" name="enCurso" value="true" checked>
                    En curso
                </label>

                <label class="checkbox-line">
                    <input type="checkbox" name="oficial" value="true">
                    Oficial
                </label>

                <div class="filter-actions">
                    <button type="submit">Crear votación</button>
                </div>
            </form>
        </section>
    </sec:authorize>

    <%-- Filtros de la vista: agrupan controles antes de renderizar el listado principal. --%>
    <form class="filter-form" onsubmit="applyFilters(event)">
        <div class="filter-field">
            <label for="category">Categoría:</label>
            <select id="category" name="category">
                <option value="">Todas</option>
                <c:forEach var="categoria" items="${categorias}">
                    <option value="${categoria}">${categoria.displayName}</option>
                </c:forEach>
            </select>
        </div>

        <div class="filter-field">
            <label for="date">Fecha anterior a:</label>
            <input type="date" id="date" name="date">
        </div>

        <div class="filter-actions">
            <button type="submit">Filtrar</button>
            <button type="button" onclick="clearFilters()">Limpiar Filtros</button>
        </div>
    </form>

    <div class="container">
        <c:choose>
            <c:when test="${empty votes}">
                <div class="empty-state">
                    <strong>No hay votaciones registradas.</strong>
                    <p>Cuando existan votaciones aparecerán agrupadas por temporada.</p>
                    <button type="button" onclick="location.href='/allVotes/inCourse'">Ver votaciones en curso</button>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
                    <c:set var="hasVotes" value="false" />
                    <c:forEach var="vote" items="${votes}">
                        <c:if test="${vote.temporada == temporada.anosTemporada}">
                            <c:set var="hasVotes" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasVotes}">
                        <div class="season-header">
                            <h2>Temporada: ${temporada.anosTemporada}</h2>
                            <button class="toggle-button" onclick="toggleVisibility('season${loop.index}')">Mostrar/Ocultar</button>
                        </div>
                        <div id="season${loop.index}" class="season-votes" style="display: none;">
                            <c:forEach var="vote" items="${votes}">
                                <c:if test="${vote.temporada == temporada.anosTemporada}">
                                    <div class="vote"
                                         data-category="${vote.categotiaVotacion}"
                                         data-date="${vote.fecha}">
                                        <h3>
                                            ${vote.categotiaVotacion.displayName}
                                            <c:if test="${vote.idVotacion < 0}">
                                                <span class="data-badge is-fake fake-marker">Fake</span>
                                            </c:if>
                                        </h3>
                                        <p>Jornada: ${vote.jornada}</p>
                                        <p>Fecha: ${vote.fecha}</p>
                                        <p class="result-note">Ganador: ${vote.ganador}</p>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
        /**
         * Alterna la visibilidad de una sección interactiva de la vista.
         * @param {string} id Identificador del elemento que se va a mostrar u ocultar.
         * @returns {void}
         */
        function toggleVisibility(id) {
            var section = document.getElementById(id);
            section.style.display = (section.style.display === "none" || section.style.display === "") ? "block" : "none";
        }

        /**
         * Limpia los filtros visuales y restaura el listado completo.
         * @returns {void}
         */
        function clearFilters() {
            document.getElementById("category").value = "";
            document.getElementById("date").value = "";
            
            // Mostrar todas las votaciones
            var votes = document.querySelectorAll(".vote");
            votes.forEach(function(vote) {
                vote.style.display = "block";
            });

            // Mostrar todas las temporadas
            var seasons = document.querySelectorAll(".season-votes");
            seasons.forEach(function(season) {
                season.style.display = "block";
            });
        }


        /**
         * Aplica los filtros seleccionados sobre los elementos visibles de la vista.
         * @param {Event} event Evento del formulario o control que dispara la acción.
         * @returns {void}
         */
        function applyFilters(event) {
            event.preventDefault(); // Evita el envío del formulario

            var category = document.getElementById("category").value.trim().toLowerCase();
            var selectedDate = document.getElementById("date").value;

            var votes = document.querySelectorAll(".vote");

            votes.forEach(function(vote) {
                var voteCategory = vote.getAttribute("data-category").trim().toLowerCase();
                var voteDate = vote.getAttribute("data-date");

                var matchCategory = (category === "" || voteCategory === category);
                var matchDate = (selectedDate === "" || (voteDate && new Date(voteDate) < new Date(selectedDate)));

                vote.style.display = (matchCategory && matchDate) ? "block" : "none";
            });

            // Ocultar temporadas sin votaciones visibles
            var seasons = document.querySelectorAll(".season-votes");
            seasons.forEach(function(season) {
                var votesInSeason = season.querySelectorAll(".vote");
                var hasVisibleVote = Array.from(votesInSeason).some(vote => vote.style.display !== "none");
                season.style.display = hasVisibleVote ? "block" : "none";
            });
        }
    </script>

</Layaout:layaout>
