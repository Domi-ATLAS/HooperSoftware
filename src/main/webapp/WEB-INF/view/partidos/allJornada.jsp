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
    <script>
    function togglePartidos(id) {
        var element = document.getElementById(id);
        if (element.style.display === "none") {
            element.style.display = "block";
        } else {
            element.style.display = "none";
        }
    }
    </script>

    <h1>Jornadas</h1>
    <button onClick="window.location.href='/allGames'">Vista Partidos</button>
    <button onClick="window.location.href='/allSeasons'">Vista Temporada</button>


    <c:forEach var="jornada" items="${jornadas}" varStatus="status">
        <div onClick="togglePartidos('partidos${status.index}')">
            <h2>Jornada ${jornada.numJornada}</h2>
            <p>Temporada: ${jornada.temporada}</p>
            <p>Número de partido: ${jornada.numeroPartido}</p>
            <p>Cancelado: ${jornada.partidoCancelado}</p>
            <p>Fecha: ${jornada.fechaJornada}</p>
        </div>
        <div id="partidos${status.index}" style="display: none;">
            <h3>Partidos:</h3>
            <ul>
                <c:forEach var="partido" items="${jornada.partidos}">
                    <li>${partido.equipoLocal} vs ${partido.equipoVisitante} : ${partido.resultadoTotal} <button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</Layaout:layaout>