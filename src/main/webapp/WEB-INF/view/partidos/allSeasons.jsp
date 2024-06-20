<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Temporadas">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Todas las Temporadas</title>
        <style>
            .hidden {
                display: none;
            }
            .temporada {
                margin-bottom: 20px;
                padding: 10px;
                border-bottom: 1px solid #000;
            }
            body {
                background-color: #ffffff; /* Color de fondo azulado */
                display: flex;
                height: 100vh;
                margin: 0;
            }
        </style>
        <script>
            function toggleVisibility(id) {
                var element = document.getElementById(id);
                if (element.style.display === "none") {
                    element.style.display = "block";
                } else {
                    element.style.display = "none";
                }
            }
        </script>
    </head>
    <body>
        <h1>Todas las Temporadas</h1>
        <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>
        <button onClick="window.location.href='/allGames'">Vista Partidos</button>

        <c:forEach var="temporada" items="${temporadas}" varStatus="status">
            <div class="temporada">
                <div onclick="toggleVisibility('jornadas${status.index}')">
                    <h2>Temporada: ${temporada.anosTemporada}</h2>
                    <p>Campeon Oeste: ${temporada.campeonOesteTemp}</p>
                    <p>Campeon Este: ${temporada.campeonEsteTemp}</p>
                    <p>Campeon Temporada: ${temporada.campeonNbaTemp}</p>
                    <p>MVP de la Temporada: ${temporada.mvpTemporada}</p>
                    <p>Rookie del Año en la Temporada: ${temporada.rookieTemporada}</p>
                    <p>Defensor del Año en la Temporada: ${temporada.defensorTemporada}</p>
                    <p>Mejor Sexto Hombre en la Temporada: ${temporada.sextoHombreTemporada}</p>
                    <p>Jugador mas Mejorado en la Temporada: ${temporada.jugadorMasMejoradoTemporada}</p>
                    <p>Entrenador de la Temporada: ${temporada.entrenadorTemporada}</p>
                </div>
                <div id="jornadas${status.index}" class="hidden">
                    <h2>JORNADAS:</h2>
                    <c:forEach var="jornada" items="${temporada.jornadas}" varStatus="jornadaStatus">
                        <p onclick="toggleVisibility('partidos${status.index}${jornadaStatus.index}')">Jornada numero: ${jornada.numJornada} | Fecha: ${jornada.fechaJornada}</p>
                        <div id="partidos${status.index}${jornadaStatus.index}" class="hidden">
                            <h2>PARTIDOS:</h2>
                            <c:forEach var="partido" items="${jornada.partidos}">
                                <p>Partido: ${partido.equipoLocal} VS ${partido.equipoVisitante} | Resultado: ${partido.resultadoTotal} | <button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></p>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </body>
    </html>
</Layaout:layaout>