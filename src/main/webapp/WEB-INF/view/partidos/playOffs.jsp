<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Playoffs de la NBA">

    <h1>Playoffs de la NBA</h1>

    <button onClick="window.location.href='/playOffsGames'">Todos los partidos de PlayOff</button>

    <c:forEach var="playoff" items="${playOffsGames}">
        <div class="playoff-container">
            <p>Temporada: ${playoff.temporada}</p>
            <p>${playoff.campeonFinalOeste} VS ${playoff.campeonFinalEste}</p>
            <p>Campeón de la NBA: ${playoff.campeonFinalNba}</p>
            <c:set var="lastTwoDigits" value="${playoff.temporada.substring(playoff.temporada.length() - 2)}" />
            <button class="details-button" onclick="window.location.href='/playOffsGames/${playoff.temporada}'">Detalles</button>
        </div>
    </c:forEach>
</Layaout:layaout>