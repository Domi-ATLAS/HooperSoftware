<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<Layaout:layaout title="Partidos">
    <style>
        body {
            background-color: #0c7da3; /* Color de fondo azulado */
            display: flex;
            height: 100vh;
            margin: 0;
        }
    </style>
    <h1>Partidos</h1>

    <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>
    <button onClick="window.location.href='/allSeasons'">Vista Temporada</button>


    <table>
        <tr>
            <th>Equipo local</th>
            <th>Equipo visitante</th>
            <th>Resultado</th>
            <th>Fecha</th>
            <th></th>
        </tr>
        <c:forEach var="partido" items="${games}">
            <tr>
                <td>${partido.equipoLocal}</td>
                <td>${partido.equipoVisitante}</td>
                <td>${partido.resultadoTotal}</td>
                <td>${partido.fecha}</td>
                <td><button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></td>
            </tr>
        </c:forEach>
    </table>
</Layaout:layaout>