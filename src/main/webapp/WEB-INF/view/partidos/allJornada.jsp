<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Partidos">
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

    <h1>Todas las jornadas</h1>

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
                    <li>${partido.equipoLocal} vs ${partido.equipoVisitante} : ${partido.resultadoTotal}</li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</Layaout:layaout>