<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos del Equipo">
    <%-- Vista frontend: consulta de partidos, temporadas, jornadas o playoffs con navegación y filtros. --%>

    <h1>Partidos del Equipo</h1>

    <%-- Zona filtrable declarativa: los controles data-filter-control actúan sobre elementos data-filter-item. --%>
    <section data-filter-scope>
    <!-- Formulario de filtro -->
    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>
    <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teams">Filtra por equipos:</label>
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

    <h2>Partidos del Equipo</h2>

    <%-- Barra de filtros secundarios: búsqueda local, rangos y contador de resultados. --%>
    <div class="data-toolbar">
        <label>
            Buscar partido
            <input type="search" data-filter-control placeholder="Equipo, resultado...">
        </label>
        <label>
            Desde
            <input type="date" data-filter-control data-filter-type="date-min" data-filter-field="date">
        </label>
        <label>
            Hasta
            <input type="date" data-filter-control data-filter-type="date-max" data-filter-field="date">
        </label>
        <div class="filter-actions">
            <button type="button" data-filter-reset>Limpiar</button>
            <span class="filter-status"><span data-filter-count></span> partidos</span>
        </div>
    </div>

    <div class="filter-empty" data-filter-empty hidden>No hay partidos con esos filtros.</div>

    <!-- Tabla de partidos -->
    <%-- Tabla principal de datos renderizados por JSTL. --%>
    <table>
        <tr>
            <th>Equipo local</th>
            <th>Equipo visitante</th>
            <th>Resultado</th>
            <th>Fecha</th>
            <th></th>
        </tr>
        <c:forEach var="partido" items="${gamesOfTheTeam}">
            <tr data-filter-item data-date="${partido.fecha}">
                <td>${partido.equipoLocal}</td>
                <td>${partido.equipoVisitante}</td>
                <td>${partido.resultadoTotal}</td>
                <td>${partido.fecha}</td>
                <td><button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></td>
            </tr>
        </c:forEach>
    </table>
    </section>

</Layaout:layaout>

<%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
// Función para filtrar los partidos por equipo
/**
 * Redirige o filtra la vista según el equipo seleccionado.
 * @param {Event} event Evento del formulario o control que dispara la acción.
 * @returns {void}
 */
function filterByTeam(event) {
    event.preventDefault();
    var teamId = document.getElementById("teams").value;
    if (teamId) {
        window.location.href = '/allGames/' + encodeURIComponent(teamId);
    } else {
        window.location.href = '/allGames';
    }
}

// Función para limpiar los filtros
/**
 * Limpia los filtros visuales y restaura el listado completo.
 * @returns {void}
 */
function clearFilters() {
    // Redirige a la página sin ningún filtro aplicado
    window.location.href = '/allGames';
}
</script>
