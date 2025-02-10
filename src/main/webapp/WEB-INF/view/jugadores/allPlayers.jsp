<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores">
    <html>
    <head>
        <title>Jugadores y Entrenadores</title>
        <style>
            .container {
                display: flex;
            }
            .left, .right {
                width: 50%;
                padding: 10px;
            }
            .left {
                border-right: 1px solid #ccc;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }

            /* Estilos para los buscadores */
            .search-container {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            .search-container input {
                flex: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 8px;
            }
            .search-container button {
                padding: 8px 12px;
                background-color: #1D428A;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .search-container button:hover {
                background-color: #5276be;
            }
        </style>
    </head>
    <body>
    <h1>Jugadores y Entrenadores</h1>
    <div class="container">
        <div class="left">
            <h2>Todos los jugadores</h2>
            <div class="search-container">
                <input type="text" id="searchPlayer" placeholder="Buscar jugador...">
                <button onclick="filterPlayers()">Buscar Jugador</button>
            </div>
            <table id="playersTable">
                <tr>
                    <th>Nombre</th>
                    <th>Posición</th>
                    <th>Edad</th>
                    <th>Detalles</th>
                </tr>
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

        
        <div class="right">
            <h2>Todos los Entrenadores</h2>

            <div class="search-container">
                <input type="text" id="searchTrainer" placeholder="Buscar entrenador...">
                <button onclick="filterTrainers()" type="button">Buscar Entrenador</button>
            </div>

            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Edad</th>
                    <th>Detalles</th>
                </tr>
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
    </body>
    </html>
    <script>
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
</Layaout:layaout>
