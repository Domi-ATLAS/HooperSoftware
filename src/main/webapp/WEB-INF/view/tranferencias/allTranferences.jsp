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

    <c:forEach var="transferencia" items="${transferences}" varStatus="status">
        <div class="transfer-item" data-filter-item data-date="${transferencia.fecha}">
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
        </div>
    </c:forEach>
    </section>
</Layaout:layaout>


<script>
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allTranferences/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allTranferences';
        }
    }
    </script>
