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
        </style>
    </head>
    <body>
    <h1>Jugadores y Entrenadores</h1>
    <div class="container">
        <div class="left">
            <h2>Todos los jugadores</h2>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Posicion</th>
                    <th>Edad</th>
                    <th>Detalles</th>
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
        </div>
        <div class="right">
            <h2>Todos los Entrenadores</h2>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Edad</th>
                    <th>Detalles</th>
                </tr>
                <c:forEach var="trainer" items="${trainers}">
                    <tr>
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
</Layaout:layaout>
