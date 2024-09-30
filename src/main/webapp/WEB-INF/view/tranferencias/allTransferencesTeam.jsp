<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
function toggleTransferencia(id) {
    var element = document.getElementById(id);
    if (element.style.display === "none") {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    }
}
</script>

<Layaout:layaout title="Transferencias">
    <style>
        body {
            background-color: #ffffff; /* Color de fondo azulado */
            display: flex;
            height: 100vh;
            margin: 0;
        }
        .group {
            background-color: #1D428A   ; /* Color de fondo azulado claro */
            border: 4px;
            border-style: outset;
            border-color: black;
            margin: 10px 0;
            padding: 10px;
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
    <h1>Transferencias</h1>


    
    <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teams">Filtra por equipos:</label>
        <select id="teams" name="teams">
            <option value="">Todos los equipos</option>
            <c:forEach var="equipo" items="${equipos}">
                <option value="${equipo.idEquipo}">${equipo.nombreEquipo}</option>
            </c:forEach>
        </select>
        <button type="submit">Filtrar</button>
    </form>

    
    <c:forEach var="transferencia" items="${transferencesOfTheTeam}" varStatus="status">
        <div class="group" onClick="toggleTransferencia('transferencia${status.index}')">
            <p>${transferencia.equipoOrigenString} &rarr; ${transferencia.equipoDestinoString}</p>
            <p>Fecha: ${transferencia.fecha}</p>
        </div>
        <div id="transferencia${status.index}" style="display: none;">
            <p>Precio: ${transferencia.precio}</p>
            <c:if test="${transferencia.rondaDraft}">
                <p>Info Draft: ${transferencia.infoRondaDraft}</p>
            </c:if>
        </div>
    </c:forEach>
</Layaout:layaout>

<script>
    function filterByTeam(event) {
        event.preventDefault();
        var teamId = document.getElementById("teams").value;
        if (teamId) {
            window.location.href = '/allTranferences/' + encodeURIComponent(teamId);
        } else {
            window.location.href = '/allTranferences';
        }
    }
    </script>