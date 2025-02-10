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
                padding-top: 350px; /* Padding para evitar que el header se lo coma */
                padding-bottom: 350px;
            }

            h1 {
                font-size: 2rem;
                color: #1D428A;
                margin-top: 30px;
                margin-left: 20px; /* Alineación a la izquierda */
            }

            /* Contenedor de las temporadas */
            .temporadas-container {
                display: flex;
                flex-wrap: wrap; /* Para que se salten a la siguiente fila cada 3 elementos */
                justify-content: flex-start;
                margin-left: 20px; /* Alineación a la izquierda */
                width: 100%; /* Asegurarse de que ocupe todo el ancho */
            }

            .temporada {
                background-color: #fff;
                border-radius: 8px;
                margin: 15px;
                padding: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 30%; /* Ocupa el 30% del contenedor, por lo que 3 caben por fila */
                transition: transform 0.3s ease-in-out;
                margin-left: 20px; /* Alineación a la izquierda */
            }

            .temporada:hover {
                transform: scale(1.03);
            }

            /* Estilo específico para los botones de la vista de temporadas */
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

            .hidden {
                display: none;
            }

            /* Estilo para los títulos y subtítulos */
            .temporada h2 {
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

            /* Estilo para la flecha */
            .temporada h2 span {
                font-size: 20px;
                transition: transform 0.3s ease; /* Animación de rotación */
            }

            /* Rotación de la flecha */
            .rotated {
                transform: rotate(180deg);
            }

            /* Estilo para la sección de la jornada */
            .jornada {
                margin: 10px 0;
                padding: 10px;
                border-left: 3px solid #1D428A;
                background-color: #f9f9f9;
                border-radius: 5px;
                margin-left: 20px; /* Alineación a la izquierda */
            }

            .jornada p {
                margin: 5px 0;
                cursor: pointer;
            }

            /* Partidos */
            .partido {
                margin-left: 20px;
                padding: 8px;
                background-color: #eef2f9;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            /* Estilo para el contenedor de partidos */
            .partido p {
                margin: 0;
                font-size: 14px;
            }

        </style>

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
