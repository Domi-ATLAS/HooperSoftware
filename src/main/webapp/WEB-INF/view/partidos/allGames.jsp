<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<Layaout:layaout title="Partidos">
    <style>
        body {
            background-color: #ffffff; /* Color de fondo azulado */
            display: flex;
            height: 100vh;
            margin: 0;
        }
        button {
            display: inline-block;
            padding: 2px 2px;
            font-size: 24px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #000000;
            background-color: #1D428A;
            border: 4px;
            border-style: outset;
            border-color: black;
            font-family: fantasy;
            font: Copperplate, Papyrus, fantasy;
        }
        button:hover {background-color: #5276be}
    
        button:active {
        background-color: #5276be;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
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