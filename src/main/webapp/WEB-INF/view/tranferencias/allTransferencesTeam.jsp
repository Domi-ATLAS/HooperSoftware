<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
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

    <!-- Mostrar transferencias -->
    <c:forEach var="transferencia" items="${transferencesOfTheTeam}" varStatus="status">
        <div class="group" onClick="toggleTransferencia('transferencia${status.index}')">
            <p>${transferencia.equipoOrigen.nombreEquipo} &rarr; ${transferencia.equipoDestino.nombreEquipo}</p>
            <p>Fecha: ${transferencia.fecha}</p>
            <Button type="submit">Ver Detalles</Button>
        </div>
        <div id="transferencia${status.index}" style="display: none;">
            <p>Precio: ${transferencia.precio}</p>
            <c:if test="${transferencia.rondaDraft}">
                <p>Info Draft: ${transferencia.infoRondaDraft}</p>
            </c:if>
        </div>
    </c:forEach>

</Layaout:layaout>

<script>
    // Función para filtrar las transferencias por equipo
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
    function clearFilters() {
        // Redirige a la página sin ningún filtro aplicado
        window.location.href = '/allTranferences';
    }
</script>
