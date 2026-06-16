<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
    <%-- Vista frontend: consulta de partidos, temporadas, jornadas o playoffs con navegación y filtros. --%>

    <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
        /**
         * Alterna la visibilidad de una sección interactiva de la vista.
         * @param {string} id Identificador del elemento que se va a mostrar u ocultar.
         * @param {string} arrowId Identificador del icono usado para reflejar el estado visual.
         * @returns {void}
         */
        function togglePartidos(id, arrowId) {
            // Buscar todos los contenedores de partidos y flechas
            var allPartidos = document.querySelectorAll('.partidos-container');
            var allArrows = document.querySelectorAll('.arrow-icon');

            var element = document.getElementById(id);
            var arrowElement = document.getElementById(arrowId);

            // Si el contenedor de partidos está cerrado, cerrar todos los demás y abrir este
            if (element.style.display === "none" || element.style.display === "") {
                // Primero cerramos todos
                allPartidos.forEach(function(partidos) {
                    partidos.style.display = "none";
                });
                allArrows.forEach(function(arrow) {
                    arrow.classList.remove('arrow-up');
                    arrow.classList.add('arrow-down');
                });

                // Ahora abrimos este
                element.style.display = "block";
                arrowElement.classList.remove('arrow-down');
                arrowElement.classList.add('arrow-up');
            } else {
                // Si ya está abierto, lo cerramos
                element.style.display = "none";
                arrowElement.classList.remove('arrow-up');
                arrowElement.classList.add('arrow-down');
            }
        }
    </script>

    <h1>Jornadas</h1>

    <div id="seasonButtons">
        <button id="viewGamesBtn" onClick="window.location.href='/allGames'">Vista Partidos</button>
        <button id="viewSeasonsBtn" onClick="window.location.href='/allSeasons'">Vista Temporada</button>
    </div>

    <%-- Zona filtrable declarativa: los controles data-filter-control actúan sobre elementos data-filter-item. --%>
    <section data-filter-scope>
    <!-- Formulario de filtro -->
    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>
    <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teams">Filtra por equipo:</label>
        <select id="teams" name="teams">
            <option value="">Todos los equipos</option>
            <c:forEach var="equipo" items="${equipos}">
                <option value="${equipo.idEquipo}" 
                        <c:if test="${equipo.idEquipo == selectedTeamId}">selected</c:if>>${equipo.nombreEquipo}</option>
            </c:forEach>
        </select>
        <button type="submit">Filtrar</button>
        <button type="button" onclick="clearFilters()">Limpiar Filtros</button>
    </form>

    <%-- Barra de filtros secundarios: búsqueda local, rangos y contador de resultados. --%>
    <div class="data-toolbar">
        <label>
            Buscar jornada
            <input type="search" data-filter-control placeholder="Jornada, temporada, equipo...">
        </label>
        <div class="filter-actions">
            <button type="button" data-filter-reset>Limpiar</button>
            <span class="filter-status"><span data-filter-count></span> jornadas</span>
        </div>
    </div>

    <div class="filter-empty" data-filter-empty hidden>No hay jornadas con esos filtros.</div>

    <!-- Contenedor de jornadas -->
    <div class="jornadas-container">
        <c:forEach var="jornada" items="${jornadas}" varStatus="status">
            <div data-filter-item>
            <div class="jornada">
                <h2 onclick="togglePartidos('partidos${status.index}', 'arrow${status.index}')">
                    Jornada ${jornada.numJornada}
                    <span id="arrow${status.index}" class="arrow-icon arrow-down">&#9660;</span> <!-- Flecha hacia abajo -->
                </h2>
                <p><strong>Temporada:</strong> ${jornada.temporada}</p>
                <p><strong>Número de partido:</strong> ${jornada.numeroPartido}</p>
                <p><strong>Cancelado:</strong> ${jornada.partidoCancelado}</p>
                <p><strong>Fecha:</strong> ${jornada.fechaJornada}</p>
            </div>
            <div id="partidos${status.index}" class="partidos-container">
                <h3>Partidos:</h3>
                <c:forEach var="partido" items="${jornada.partidos}">
                    <div class="partido">
                        <p><strong>Partido:</strong> ${partido.equipoLocal} vs ${partido.equipoVisitante} | <strong>Resultado:</strong> ${partido.resultadoTotal}</p>
                        <button class="details-button" onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button>
                    </div>
                </c:forEach>
            </div>
            </div>
        </c:forEach>
    </div>
    </section>

</Layaout:layaout>
<%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
    /**
     * Redirige o filtra la vista según el equipo seleccionado.
     * @param {Event} event Evento del formulario o control que dispara la acción.
     * @returns {void}
     */
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allGames/allJornadas/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allGames/allJornadas';
        }
    }

    // Función para limpiar los filtros
    /**
     * Limpia los filtros visuales y restaura el listado completo.
     * @returns {void}
     */
    function clearFilters() {
        // Redirige a la página sin ningún filtro aplicado
        window.location.href = '/allGames/allJornadas';
    }
</script>

    
