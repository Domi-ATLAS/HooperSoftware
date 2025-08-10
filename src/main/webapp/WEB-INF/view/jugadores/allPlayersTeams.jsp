<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores y Entrenadores">
<html>
<head>
    <title>Jugadores y Entrenadores</title>
    <style>
        .container { display: flex; }
        .left, .right { width: 50%; padding: 10px; }
        .left { border-right: 1px solid #ccc; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .search-container { display: flex; margin-bottom: 10px; }
        .search-container input { flex: 1; padding: 8px; border: 1px solid #ccc; margin-right: 8px; }
        .search-container button { padding: 8px; background-color: #1D428A; color: white; border: none; cursor: pointer; }
        .search-container button:hover { background-color: #5276be; }
    </style>
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
                <tr><th>Nombre</th><th>Posición</th><th>Edad</th><th>Detalles</th></tr>
                <c:forEach var="player" items="${players}">
                    <tr class="player-row">
                        <td>${player.nombreJugador}</td>
                        <td>${player.posicion}</td>
                        <td>${player.edadJug}</td>
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
            <table>
                <tr><th>Nombre</th><th>Edad</th><th>Detalles</th></tr>
                <c:forEach var="trainer" items="${trainers}">
                    <tr class="trainer-row">
                        <td>${trainer.nombeEntrenador}</td>
                        <td>${trainer.edadEntr}</td>
                        <td><button onClick="window.location.href='/trainer/${trainer.idEntrenador}'">Detalles</button></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <script>
        function updateFilters() {
            document.getElementById("filterForm").submit();
        }

        function filterPlayers() {
            let input = document.getElementById("searchPlayer").value.toLowerCase();
            let rows = document.querySelectorAll(".player-row");
            rows.forEach(row => {
                let nombre = row.cells[0].textContent.toLowerCase();
                row.style.display = nombre.includes(input) ? "" : "none";
            });
        }

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
