<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<Layaout:layaout title="Partidos">
    <h1>Todos los partidos</h1>

    <button onClick="window.location.href='/allGames/allJornadas'">Vista Jornada</button>

    <table>
        <tr>
            <th>Equipo local</th>
            <th>Equipo visitante</th>
            <th>Resultado</th>
            <th>Fecha</th>
        </tr>
        <c:forEach var="partido" items="${games}">
            <tr>
                <td>${partido.equipoLocal}</td>
                <td>${partido.equipoVisitante}</td>
                <td>${partido.resultadoTotal}</td>
            </tr>
        </c:forEach>
    </table>
</Layaout:layaout>