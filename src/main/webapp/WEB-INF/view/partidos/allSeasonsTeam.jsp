<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Temporadas">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Todas las Temporadas</title>

        <script>
            // Función para alternar la visibilidad de las temporadas y jornadas
            function toggleVisibility(id, arrowId) {
                // Buscar todos los contenedores de temporadas y flechas
                var allTemporadas = document.querySelectorAll('.temporada');
                var allArrows = document.querySelectorAll('.temporada h2 span');
                var element = document.getElementById(id);
                var arrowElement = document.getElementById(arrowId);

                // Si el contenedor de temporadas está cerrado, cerramos todos los demás y abrimos este
                if (element.style.display === "none") {
                    // Primero cerramos todos
                    allTemporadas.forEach(function(temporada) {
                        temporada.querySelector('.hidden').style.display = "none";
                    });
                    allArrows.forEach(function(arrow) {
                        arrow.classList.remove('rotated');
                    });

                    // Ahora abrimos esta temporada
                    element.style.display = "block";
                    arrowElement.classList.add('rotated'); // Rotar la flecha
                } else {
                    // Si ya está abierta, lo cerramos
                    element.style.display = "none";
                    arrowElement.classList.remove('rotated'); // Quitar la rotación de la flecha
                }
            }

            // Función para alternar la visibilidad de los partidos dentro de cada jornada
            function togglePartidos(id, arrowId) {
                var element = document.getElementById(id);
                var arrowElement = document.getElementById(arrowId);

                if (element.style.display === "none") {
                    element.style.display = "block";
                    arrowElement.classList.add('rotated'); // Rotar la flecha
                } else {
                    element.style.display = "none";
                    arrowElement.classList.remove('rotated'); // Quitar la rotación de la flecha
                }
            }
        </script>
    </head>
    <body>
        <h1>Todas las Temporadas</h1>
        
        <!-- Contenedor de botones con ID específico -->
        <div id="seasonButtons">
            <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>
            <button onClick="window.location.href='/allGames'">Vista Partidos</button>
        </div>

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
            <button type="button" onclick="clearFilters()">Limpiar Filtros</button>
        </form>

        <!-- Contenedor para las temporadas -->
        <div class="temporadas-container">
            <c:forEach var="temporada" items="${temporadas}" varStatus="status">
                <div class="temporada">
                    <div onclick="toggleVisibility('jornadas${status.index}', 'arrow${status.index}')">
                        <h2>Temporada: ${temporada.anosTemporada} 
                            <span id="arrow${status.index}">▼</span> <!-- Flecha hacia abajo -->
                        </h2>
                        <p><strong>Campeón Oeste:</strong> ${temporada.campeonOesteTemp}</p>
                        <p><strong>Campeón Este:</strong> ${temporada.campeonEsteTemp}</p>
                        <p><strong>Campeón Temporada:</strong> ${temporada.campeonNbaTemp}</p>
                        <p><strong>MVP de la Temporada:</strong> ${temporada.mvpTemporada}</p>
                        <p><strong>Rookie del Año:</strong> ${temporada.rookieTemporada}</p>
                        <p><strong>Defensor del Año:</strong> ${temporada.defensorTemporada}</p>
                        <p><strong>Mejor Sexto Hombre:</strong> ${temporada.sextoHombreTemporada}</p>
                        <p><strong>Jugador Más Mejorado:</strong> ${temporada.jugadorMasMejoradoTemporada}</p>
                        <p><strong>Entrenador de la Temporada:</strong> ${temporada.entrenadorTemporada}</p>
                    </div>

                    <div id="jornadas${status.index}" class="hidden">
                        <h2>Jornadas:</h2>
                        <c:forEach var="jornada" items="${temporada.jornadas}" varStatus="jornadaStatus">
                            <div class="jornada" onclick="togglePartidos('partidos${status.index}${jornadaStatus.index}', 'arrow${status.index}${jornadaStatus.index}')">
                                <p><strong>Jornada:</strong> ${jornada.numJornada} | <strong>Fecha:</strong> ${jornada.fechaJornada}</p>
                            </div>

                            <div id="partidos${status.index}${jornadaStatus.index}" class="hidden">
                                <h3>Partidos:</h3>
                                <c:forEach var="partido" items="${jornada.partidos}">
                                    <div class="partido">
                                        <p><strong>Partido:</strong> ${partido.equipoLocal} VS ${partido.equipoVisitante} | <strong>Resultado:</strong> ${partido.resultadoTotal}</p>
                                        <button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
    </html>
</Layaout:layaout>
<script>
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allSeasons/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allSeasons';
        }
    }

    // Función para limpiar los filtros
    function clearFilters() {
        // Redirige a la página sin ningún filtro aplicado
        window.location.href = '/allSeasons';
    }
</script>
