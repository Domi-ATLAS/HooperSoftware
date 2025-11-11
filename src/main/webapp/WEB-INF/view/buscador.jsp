<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Buscador">


    <h1>Buscador</h1>

    <div class="search-container">
        <form action="/buscador" method="get">
            <input type="text" name="query" value="${query}" class="search-box" placeholder="Busca equipos, jugadores, partidos o entrenadores...">
            <button type="submit" class="search-btn">Buscar</button>
        </form>
    </div>

    <div class="result-section">

        <!-- Entrenadores -->
        <c:if test="${not empty entrenadores}">
            <div class="result-group">
                <h3>Entrenadores</h3>
                <c:forEach var="entrenador" items="${entrenadores}">
                    <div class="result-item">
                        <p><strong>${entrenador.nombre}</strong> - ${entrenador.equipo.nombreEquipo}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Equipos -->
        <c:if test="${not empty equipos}">
            <div class="result-group">
                <h3>Equipos</h3>
                <c:forEach var="equipo" items="${equipos}">
                    <div class="result-item">
                        <p><strong>${equipo.nombreEquipo}</strong></p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Partidos -->
        <c:if test="${not empty partidos}">
            <div class="result-group">
                <h3>Partidos</h3>
                <c:forEach var="partido" items="${partidos}">
                    <div class="result-item">
                        <p><strong>${partido.equipoLocal}</strong> vs <strong>${partido.equipoVisitante}</strong> - ${partido.fecha}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Jugadores -->
        <c:if test="${not empty jugadores}">
            <div class="result-group">
                <h3>Jugadores</h3>
                <c:forEach var="jugador" items="${jugadores}">
                    <div class="result-item">
                        <p><strong>${jugador.nombre}</strong> - ${jugador.equipo.nombreEquipo}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Mensaje si no se encuentran resultados -->
        <c:if test="${empty entrenadores && empty equipos && empty partidos && empty jugadores}">
            <p>No se encontraron resultados para "<strong>${query}</strong>". Intenta con otro término.</p>
        </c:if>

    </div>

</Layaout:layaout>
