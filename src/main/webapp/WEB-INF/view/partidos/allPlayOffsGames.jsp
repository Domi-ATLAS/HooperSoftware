<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Todos los Partidos de Playoffs">
    <h1>Todos los Partidos de Playoffs</h1>

    <button onClick="window.location.href='/allPlayOffs'">Volver a Playoffs</button>

    <div class="container">
        <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
            <c:set var="hasGames" value="false" />
            <c:forEach var="game" items="${playOffsGames}">
                <c:if test="${game.temporada == temporada.anosTemporada}">
                    <c:set var="hasGames" value="true" />
                </c:if>
            </c:forEach>
            <c:if test="${hasGames}">
                <h2 onclick="toggleVisibility('season${loop.index}')">Temporada: ${temporada.anosTemporada}</h2>
                <div id="season${loop.index}" style="display: none;">
                    <c:forEach var="game" items="${playOffsGames}">
                        <c:if test="${game.temporada == temporada.anosTemporada}">
                            <div class="game">
                                <h3>${game.nombrePartido}</h3>
                                <p>Jornada: ${game.jornada}</p>
                                <p>Fecha: ${game.fecha}</p>
                                <p>Resultado: ${game.resultado}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <script>
        function toggleVisibility(id) {
            var x = document.getElementById(id);
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
    </script>
</Layaout:layaout>