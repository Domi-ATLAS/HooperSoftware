<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <title>Chicago Bulls</title>
</head>
<body>
    <img src="/images/bulls.png">
    <h1>${chicagoBulls.nombreEquipo}</h1>
    <p>Ciudad: ${chicagoBulls.ciudad}</p>
    <p>Conferencia: ${chicagoBulls.conferencia}</p>
    <p>División: ${chicagoBulls.division}</p>
    <p>Año de fundación: ${chicagoBulls.anoFundacion}</p>
    <p>Años en la NBA: ${chicagoBulls.anosNba}</p>
    <p>Títulos de la NBA: ${chicagoBulls.titulosNba}</p>
    <p>Títulos de conferencia: ${chicagoBulls.titulosConferencia}</p>

    <h2>Esta temporada</h2>
    <p>Partidos ganados: ${chicagoBulls.partidosGanados}</p>
    <p>Partidos perdidos: ${chicagoBulls.partidosPerdidos}</p>
    <p>Balance de la temporada: ${chicagoBulls.balanceTemporada} en el Este</p>
    <ul>
        <c:forEach var="jugador" items="${jugadores}">
            <li>${jugador.nombreJugador} - ${jugador.edadJug} años - ${jugador.posicion}</li>
        </c:forEach>
    </ul>
    <h2>Entrenadores:</h2>
    <ul>
        <c:forEach var="entrenador" items="${entrenadores}">
            <li>${entrenador.nombeEntrenador} - ${entrenador.edadEntr} años</li>
        </c:forEach>
    </ul>

</body>
</html>