<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
    <h1>Partidos</h1>

    <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>
    <button onClick="window.location.href='/allSeasons'">Vista Temporada</button>

    <%-- Zona filtrable declarativa: los controles data-filter-control actúan sobre elementos data-filter-item. --%>
    <section data-filter-scope>
    <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teams">Filtra por equipos:</label>
        <select id="teams" name="teams">
            <option value="">Todos los equipos</option>
            <c:forEach var="equipo" items="${equipos}">
                <option value="${equipo.idEquipo}">${equipo.nombreEquipo}</option>
            </c:forEach>
        </select>
        <button type="submit">Filtrar</button>
    </form>

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

    <c:choose>
        <c:when test="${empty games}">
            <div class="empty-state">
                <strong>No hay partidos disponibles.</strong>
                <p>Prueba otra temporada, jornada o equipo desde la navegación superior.</p>
                <button type="button" onclick="location.href='/allSeasons'">Ver temporadas</button>
            </div>
        </c:when>
        <c:otherwise>
            <%-- Tabla principal de datos renderizados por JSTL. --%>
            <table>
                <tr>
                    <th>Equipo local</th>
                    <th>Equipo visitante</th>
                    <th>Resultado</th>
                    <th>Fecha</th>
                    <th>Datos</th>
                    <th></th>
                </tr>
                <c:forEach var="partido" items="${games}">
                    <tr data-filter-item data-date="${partido.fecha}">
                        <td>${partido.equipoLocal}</td>
                        <td>${partido.equipoVisitante}</td>
                        <td>${partido.resultadoTotal}</td>
                        <td>${partido.fecha}</td>
                        <td>
                            <c:if test="${partido.idPartido < 0}">
                                <span class="data-badge is-fake">Fake ${partido.temporada}</span>
                            </c:if>
                        </td>
                        <td><button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
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
        window.location.href = '/allGames/' + encodeURIComponent(teamId);
    } else {
        window.location.href = '/allGames';
    }
}
</script>
