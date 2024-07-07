<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jornadas">
    <style>
        body {
            background-color: #ffffff; /* Color de fondo azulado */
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #ffffff;
            background-color: #1D428A;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #5276be;
        }
        button:active {
            background-color: #0d2e5f;
        }
        .filter-form {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .filter-form select {
            padding: 10px;
            font-size: 16px;
            margin-right: 10px;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
        }
        th, td {
            border: 1px solid #000000;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #1D428A;
            color: white;
        }
    </style>

    <h1>Jornadas</h1>
    <button onClick="window.location.href='/allGames'">Vista Partidos</button>
    <button onClick="window.location.href='/allSeasons'">Vista Temporada</button>

    <form class="filter-form" method="get" action="/allGames/jornadas">
        <label for="teams">Filtra por equipo:</label>
        <select id="teams" name="teamId">
            <option value="">Todos los equipos</option>
            <c:forEach var="equipo" items="${equipos}">
                <option value="${equipo.id}" <c:if test="${equipo.id == selectedTeamId}">selected</c:if>>${equipo.nombreEquipo}</option>
            </c:forEach>
        </select>
        <button type="submit">Filtrar</button>
    </form>

    <c:forEach var="jornada" items="${jornadas}" varStatus="status">
        <div>
            <h2>Jornada ${jornada.numJornada}</h2>
            <p>Temporada: ${jornada.temporada}</p>
            <p>Número de partido: ${jornada.numeroPartido}</p>
            <p>Cancelado: ${jornada.partidoCancelado}</p>
            <p>Fecha: ${jornada.fechaJornada}</p>
            <div>
                <h3>Partidos:</h3>
                <ul>
                    <c:forEach var="partido" items="${jornada.partidos}">
                        <li>${partido.equipoLocal} vs ${partido.equipoVisitante} : ${partido.resultadoTotal}
                            <button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>
</Layaout:layaout>
