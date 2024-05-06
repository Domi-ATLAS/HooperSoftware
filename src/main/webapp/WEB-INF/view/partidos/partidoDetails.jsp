<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<Layaout:layaout title="Detalles Partido">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles del Partido</title>
    </head>
    <body>
        <h1>Detalles del Partido</h1>
        <p>Temporada: ${game.temporada}</p>
        <p>Resultado 1 cuarto: ${game.resultadoC1}</p>
        <p>Resultado 2 cuarto: ${game.resultadoC2}</p>
        <p>Resultado 3 cuarto: ${game.resultadoC3}</p>
        <p>Resultado 4 cuarto: ${game.resultadoC4}</p>
        <p>Resultado total: ${game.resultadoTotal}</p>
        <c:if test="${game.prorroga}">
            <p>Prórroga: Si</p>
            <p>Resultado de la prórroga: ${game.resultadoProrroga}</p>
        </c:if>
        <c:if test="${game.playOffSiONo}">
            <p>Playoff: Sí</p>
            <p>Victoria de la serie: ${game.victoriaSerie}</p>
        </c:if>
        <h2>Jugadores del equipo local</h2>
        <ul>
            <c:forEach var="jugador" items="${localJug}">
                <li>${jugador.nombreJugador}</li>
            </c:forEach>
        </ul>
        <h2>Jugadores del equipo visitante</h2>
        <ul>
            <c:forEach var="jugador" items="${visitJug}">
                <li>${jugador.nombreJugador}</li>
            </c:forEach>
        </ul>
    </body>
    </html>
</Layaout:layaout>