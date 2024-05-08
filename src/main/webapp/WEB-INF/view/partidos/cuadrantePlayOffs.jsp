<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Equipos Playoffs 23">
    <!-- Estilos omitidos para brevedad -->

    <h1>Equipos Playoffs 23</h1>
    <div class="container">
        <c:forEach var="partido" items="${partidos}">
            <div class="section">
                <h2>${partido.nombre}</h2>
                <div class="group">
                    <c:forEach var="equipo" items="${equipos}">
                        <c:if test="${equipo.partidoId == partido.id}">
                            <div class="team-info">
                                <p>${equipo.nombreEquipo}: ${equipo.posicion}</p>
                            </div>
                            <div class="vs">
                                <p>VS</p>
                            </div>
                            <div class="result">
                                <p>${partido.resultado}</p>
                                <button onClick="window.location.href='/temporada/${partido.temporada}/partidos/${equipo.nombreEquipo}'">Detalles</button>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
</Layaout:layaout>