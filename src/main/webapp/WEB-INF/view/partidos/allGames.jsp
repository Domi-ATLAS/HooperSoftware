<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
    <style>
        body {
            background-color: #ffffff; /* Color de fondo azulado */
            display: flex;
            height: 100vh;
            margin: 0;
        }
        button {
            display: inline-block;
            padding: 2px 2px;
            font-size: 24px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #000000;
            background-color: #1D428A;
            border: 4px;
            border-style: outset;
            border-color: black;
            font-family: fantasy;
            font: Copperplate, Papyrus, fantasy;
        }
        button:hover {background-color: #5276be}
    
        button:active {
            background-color: #5276be;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
        .filter-form {
            margin-bottom: 20px;
        }
        .row-container {
            border: 4px solid black; /* Ajustado: borde claro */
            margin: 10px 0;
            padding: 10px;
            background-color: #ffffff;
        }

        /* Aplicar borde y espaciado a las celdas */
        td {
            border: 1px solid #000000; /* Borde a las celdas */
            padding: 8px;
            text-align: center;
        }

        th {
            border: 1px solid #000000; /* Borde a las cabeceras */
            padding: 8px;
            background-color: #f2f2f2;
        }
        tr:nth-child(odd) {
            background-color: #f2f2f2; /* Color de fondo para las filas impares */
        }

        /* Filas pares */
        tr:nth-child(even) {
            background-color: #ffffff; /* Color de fondo para las filas pares */
        }
    </style>
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
