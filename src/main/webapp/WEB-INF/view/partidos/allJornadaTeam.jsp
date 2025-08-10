<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa; /* Fondo claro */
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* Alineación a la izquierda */
            padding-top: 350px; /* Padding superior aumentado */
            padding-bottom: 350px; /* Padding inferior aumentado */
        }

        h1 {
            font-size: 2rem;
            color: #1D428A;
            margin-top: 30px;
            margin-left: 20px; /* Alineación a la izquierda */
        }

        /* Contenedor de los botones */
        #seasonButtons button {
            background-color: #1D428A;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        #seasonButtons button:hover {
            background-color: #5276be;
        }

        /* Estilos para el filtro */
        .filter-form {
            margin-left: 20px;
            margin-top: 20px;
        }

        .filter-form label {
            margin-right: 10px;
        }

        /* Contenedor de las jornadas */
        .jornadas-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin-left: 20px;
            width: 100%;
        }

        .jornada {
            background-color: #fff;
            border-radius: 8px;
            margin: 15px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 30%;
            transition: transform 0.3s ease-in-out;
        }

        .jornada:hover {
            transform: scale(1.03);
        }

        /* Estilo de los títulos y detalles de cada jornada */
        .jornada h2 {
            color: white;
            background-color: #1D428A;
            padding: 10px;
            border-radius: 5px;
            font-size: 1.2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        /* Estilo de la flecha para desplegar */
        .arrow-icon {
            font-size: 20px;
            transition: transform 0.3s;
        }

        .arrow-down {
            transform: rotate(0deg);
        }

        .arrow-up {
            transform: rotate(180deg);
        }

        /* Partidos dentro de la jornada (ahora debajo) */
        .partidos-container {
            margin-top: 10px;
            padding-left: 20px;
            display: none; /* Inicialmente oculto */
        }

        .partido {
            background-color: #eef2f9;
            border-radius: 5px;
            padding: 8px;
            margin-bottom: 10px;
        }

        .partido p {
            margin: 0;
            font-size: 14px;
        }

        /* Botón de detalles */
        .details-button {
            background-color: #1D428A;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 5px;
            transition: background-color 0.3s;
        }

        .details-button:hover {
            background-color: #5276be;
        }

        .details-button:active {
            background-color: #5276be;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }

        /* Botón oculto */
        .hidden {
            display: none;
        }

    </style>

    <script>
        function togglePartidos(id, arrowId) {
            // Buscar todos los contenedores de partidos y flechas
            var allPartidos = document.querySelectorAll('.partidos-container');
            var allArrows = document.querySelectorAll('.arrow-icon');

            var element = document.getElementById(id);
            var arrowElement = document.getElementById(arrowId);

            // Si el contenedor de partidos está cerrado, cerrar todos los demás y abrir este
            if (element.style.display === "none" || element.style.display === "") {
                // Primero cerramos todos
                allPartidos.forEach(function(partidos) {
                    partidos.style.display = "none";
                });
                allArrows.forEach(function(arrow) {
                    arrow.classList.remove('arrow-up');
                    arrow.classList.add('arrow-down');
                });

                // Ahora abrimos este
                element.style.display = "block";
                arrowElement.classList.remove('arrow-down');
                arrowElement.classList.add('arrow-up');
            } else {
                // Si ya está abierto, lo cerramos
                element.style.display = "none";
                arrowElement.classList.remove('arrow-up');
                arrowElement.classList.add('arrow-down');
            }
        }
    </script>

    <h1>Jornadas</h1>

    <div id="seasonButtons">
        <button id="viewGamesBtn" onClick="window.location.href='/allGames'">Vista Partidos</button>
        <button id="viewSeasonsBtn" onClick="window.location.href='/allSeasons'">Vista Temporada</button>
    </div>

    <!-- Formulario de filtro -->
    <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teams">Filtra por equipo:</label>
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

    <!-- Contenedor de jornadas -->
    <div class="jornadas-container">
        <c:forEach var="jornada" items="${jornadas}" varStatus="status">
            <div class="jornada">
                <h2 onclick="togglePartidos('partidos${status.index}', 'arrow${status.index}')">
                    Jornada ${jornada.numJornada}
                    <span id="arrow${status.index}" class="arrow-icon arrow-down">&#9660;</span> <!-- Flecha hacia abajo -->
                </h2>
                <p><strong>Temporada:</strong> ${jornada.temporada}</p>
                <p><strong>Número de partido:</strong> ${jornada.numeroPartido}</p>
                <p><strong>Cancelado:</strong> ${jornada.partidoCancelado}</p>
                <p><strong>Fecha:</strong> ${jornada.fechaJornada}</p>
            </div>
            <div id="partidos${status.index}" class="partidos-container">
                <h3>Partidos:</h3>
                <c:forEach var="partido" items="${jornada.partidos}">
                    <div class="partido">
                        <p><strong>Partido:</strong> ${partido.equipoLocal} vs ${partido.equipoVisitante} | <strong>Resultado:</strong> ${partido.resultadoTotal}</p>
                        <button class="details-button" onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

</Layaout:layaout>
<script>
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allGames/allJornadas/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allGames/allJornadas';
        }
    }

    // Función para limpiar los filtros
    function clearFilters() {
        // Redirige a la página sin ningún filtro aplicado
        window.location.href = '/allGames/allJornadas';
    }
</script>

    
