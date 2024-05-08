<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Playoffs Partidos">
    <h1>Equipos Playoff ${temporada}</h1>
    <div class="container">
        <div class="section">
            <h2>Oeste</h2>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.primeroOeste}: 1</p>
                    <p>${clasificacion.octavoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoffs.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoffs.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div><div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
        </div>
        <div class="section">
            <h2>Este</h2>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
            <div class="group">
                <c:forEach var="este" items="${equiposEste}">
                    <h1>${este.nombreEquipo}</h1>
                </c:forEach>
            </div>
        </div>
    </div>


</Layaout:layaout>