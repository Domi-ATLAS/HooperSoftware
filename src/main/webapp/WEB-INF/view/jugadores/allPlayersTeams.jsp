<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores y Entrenadores">
<html>
<head>
    <title>Jugadores y Entrenadores</title>
</head>
<body>
    <h1>Jugadores y Entrenadores</h1>

    <!-- Formulario de Filtros -->
    <form class="filter-form" id="filterForm" action="/allPlayers/${selectedTeamId}" method="get">
        <label for="teams">Filtrar por equipo:</label>
        <select id="teams" name="teamId" onchange="updateFilters()">
            <option value="">Todos los equipos</option>
            <c:forEach var="equipo" items="${equipos}">
                <option value="${equipo.idEquipo}" ${equipo.idEquipo == selectedTeamId ? 'selected' : ''}>${equipo.nombreEquipo}</option>
            </c:forEach>
        </select>
        
        <!-- Checkboxes para seleccionar Jugadores y Entrenadores -->
        <label><input type="checkbox" name="jugadores" id="jugadoresCheckbox" value="true" ${jugadores ? 'checked' : ''} onchange="updateFilters()"> Mostrar Jugadores</label>
        <label><input type="checkbox" name="entrenadores" id="entrenadoresCheckbox" value="true" ${entrenadores ? 'checked' : ''} onchange="updateFilters()"> Mostrar Entrenadores</label>
    </form>

    <div class="container">
        <!-- Lista de Jugadores -->
        <div class="left" id="jugadoresSection" style="display: ${jugadores ? 'block' : 'none'};">
            <h2>Jugadores</h2>
            <div class="search-container">
                <input type="text" id="searchPlayer" placeholder="Buscar jugador...">
                <button onclick="filterPlayers()">Buscar</button>
            </div>
            <table id="playersTable">
                <tr><th>Nombre</th><th>Temporada</th><th>Posición</th><th>Edad</th><th>Datos</th><th>Detalles</th></tr>
                <c:forEach var="player" items="${players}">
                    <tr class="player-row">
                        <td>
                            ${player.nombreJugador}
                            <c:if test="${player.idJugador < 0}">
                                <span class="data-badge is-fake fake-marker">Fake ${player.temporadaJugador}</span>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty player.temporadaJugador}">${player.temporadaJugador}</c:when>
                                <c:otherwise>Base</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${player.posicion}</td>
                        <td>${player.edadJug}</td>
                        <td>
                            <c:choose>
                                <c:when test="${player.idJugador < 0}">
                                    <span class="data-badge is-fake">Fake ${player.temporadaJugador}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="data-badge is-online">Persistido</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><button onClick="window.location.href='/player/${player.idJugador}'">Detalles</button></td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- Lista de Entrenadores -->
        <div class="right" id="entrenadoresSection" style="display: ${entrenadores ? 'block' : 'none'};">
            <h2>Entrenadores</h2>
            <div class="search-container">
                <input type="text" id="searchTrainer" placeholder="Buscar entrenador...">
                <button onclick="filterTrainers()">Buscar</button>
            </div>
            <%-- Tabla principal de datos renderizados por JSTL. --%>
    <table>
                <tr><th>Nombre</th><th>Edad</th><th>Datos</th><th>Detalles</th></tr>
                <c:forEach var="trainer" items="${trainers}">
                    <tr class="trainer-row">
                        <td>
                            ${trainer.nombeEntrenador}
                            <c:if test="${trainer.idEntrenador < 0}">
                                <span class="data-badge is-fake fake-marker">Fake</span>
                            </c:if>
                        </td>
                        <td>${trainer.edadEntr}</td>
                        <td>
                            <c:choose>
                                <c:when test="${trainer.idEntrenador < 0}">
                                    <span class="data-badge is-fake">Fake</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="data-badge is-online">Persistido</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><button onClick="window.location.href='/trainer/${trainer.idEntrenador}'">Detalles</button></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
        /**
         * Actualiza los controles dependientes antes de aplicar el filtrado.
         * @returns {void}
         */
        function updateFilters() {
            document.getElementById("filterForm").submit();
        }

        /**
         * Filtra la lista de jugadores según los criterios activos.
         * @returns {void}
         */
        function filterPlayers() {
            let input = document.getElementById("searchPlayer").value.toLowerCase();
            let rows = document.querySelectorAll(".player-row");
            rows.forEach(row => {
                let nombre = row.cells[0].textContent.toLowerCase();
                row.style.display = nombre.includes(input) ? "" : "none";
            });
        }

        /**
         * Filtra la lista de entrenadores según los criterios activos.
         * @returns {void}
         */
        function filterTrainers() {
            let input = document.getElementById("searchTrainer").value.toLowerCase();
            let rows = document.querySelectorAll(".trainer-row");
            rows.forEach(row => {
                let nombre = row.cells[0].textContent.toLowerCase();
                row.style.display = nombre.includes(input) ? "" : "none";
            });
        }
    </script>
</body>
</html>
</Layaout:layaout>
