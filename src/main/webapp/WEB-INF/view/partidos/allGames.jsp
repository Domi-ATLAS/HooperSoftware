<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
    <h1>Partidos</h1>

    <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>
    <button onClick="window.location.href='/allSeasons'">Vista Temporada</button>

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

    <table>
        <tr>
            <th>Equipo local</th>
            <th>Equipo visitante</th>
            <th>Resultado</th>
            <th>Fecha</th>
            <th></th>
        </tr>
        <c:forEach var="partido" items="${games}">
            <tr>
                <td>${partido.equipoLocal}</td>
                <td>${partido.equipoVisitante}</td>
                <td>${partido.resultadoTotal}</td>
                <td>${partido.fecha}</td>
                <td><button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></td>
            </tr>
        </c:forEach>
    </table>
</Layaout:layaout>

<script>
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
