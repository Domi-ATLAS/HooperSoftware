<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores">
    <html>
    <head>
        <title>Todos los Jugadores</title>
    </head>
    <body>
    <h1>Todos los jugadores</h1>
    <table>
        <tr>
            <th>Nombre</th>
            <th>Posicion</th>
            <th>Edad</th>
        </tr>
        <c:forEach var="player" items="${players}">
            <tr>
                <td>${player.nombreJugador}</td>
                <td>${player.posicion}</td>
                <td>${player.edadJug}</td>
                <td><button onClick="window.location.href='/player/${player.idJugador}'">Detalles</button></td>
            </tr>
        </c:forEach>
    </table>
    </body>
    </html>
</Layaout:layaout>