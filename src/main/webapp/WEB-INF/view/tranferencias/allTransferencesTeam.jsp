<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
/**
 * Alterna la visibilidad de una sección interactiva de la vista.
 * @param {string} id Identificador del elemento que se va a mostrar u ocultar.
 * @returns {void}
 */
function toggleTransferencia(id) {
    var element = document.getElementById(id);
    if (element.style.display === "none") {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    }
}
</script>

<Layaout:layaout title="Transferencias">

    <h1>Transferencias</h1>

    <%-- Zona filtrable declarativa: los controles data-filter-control actúan sobre elementos data-filter-item. --%>
    <section data-filter-scope>
    <!-- Formulario de filtro -->
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
        
        <!-- Botón para limpiar los filtros -->
        <button type="button" onclick="clearFilters()">Limpiar Filtros</button>
    </form>

    <%-- Barra de filtros secundarios: búsqueda local, rangos y contador de resultados. --%>
    <div class="data-toolbar">
        <label>
            Buscar transferencia
            <input type="search" data-filter-control placeholder="Equipo origen o destino...">
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
            <span class="filter-status"><span data-filter-count></span> transferencias</span>
        </div>
    </div>

    <div class="filter-empty" data-filter-empty hidden>No hay transferencias con esos filtros.</div>

    <!-- Mostrar transferencias -->
    <c:forEach var="transferencia" items="${transferencesOfTheTeam}" varStatus="status">
        <div class="transfer-item" data-filter-item data-date="${transferencia.fecha}">
            <div class="group" onClick="toggleTransferencia('transferencia${status.index}')">
                <p>
                    ${transferencia.equipoOrigen.nombreEquipo} &rarr; ${transferencia.equipoDestino.nombreEquipo}
                    <c:if test="${transferencia.idTransferencia < 0}">
                        <span class="data-badge is-fake fake-marker">Fake</span>
                    </c:if>
                </p>
                <p>Fecha: ${transferencia.fecha}</p>
                <Button type="submit">Ver Detalles</Button>
            </div>
            <div id="transferencia${status.index}" style="display: none;">
                <p>Precio: ${transferencia.precio}</p>
                <c:if test="${transferencia.rondaDraft}">
                    <p>Info Draft: ${transferencia.infoRondaDraft}</p>
                </c:if>
            </div>
        </div>
    </c:forEach>
    </section>

</Layaout:layaout>

<%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
    // Función para filtrar las transferencias por equipo
    /**
     * Redirige o filtra la vista según el equipo seleccionado.
     * @param {Event} event Evento del formulario o control que dispara la acción.
     * @returns {void}
     */
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allTranferences/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allTranferences';
        }
    }

    // Función para limpiar los filtros
    /**
     * Limpia los filtros visuales y restaura el listado completo.
     * @returns {void}
     */
    function clearFilters() {
        // Redirige a la página sin ningún filtro aplicado
        window.location.href = '/allTranferences';
    }
</script>
