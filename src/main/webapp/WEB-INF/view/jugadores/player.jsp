<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Detalles Jugador">
    <%-- Vista frontend: jugadores y entrenadores con listados, fichas y datos de perfil. --%>
    

    <button onClick="window.location.href='/allPlayers'">Volver a Jugadores y Entrenadores</button>

    <div class="container">
        <h1>
            Detalles del Jugador
            <c:if test="${player.idJugador < 0}">
                <span class="data-badge is-fake fake-marker">Fake ${player.temporadaJugador}</span>
            </c:if>
        </h1>
        <p>Nombre: ${player.nombreJugador}</p>
        <p>Posición: ${player.posicion}</p>
        <p>Equipo: ${equipo.nombreEquipo}</p>
        <p>
            Temporada:
            <c:choose>
                <c:when test="${not empty player.temporadaJugador}">${player.temporadaJugador}</c:when>
                <c:otherwise>Base</c:otherwise>
            </c:choose>
        </p>
        <p>Edad: ${player.edadJug}</p>
        <p>Dorsal: ${player.dorsal}</p>
        <p>Año del Draft: ${player.anoDraft}</p>
        <p>Años All Star: ${player.anosAllStarJug}</p>
        <p>Años en la NBA: ${player.anosNbaJug}</p>
        <p>Años en otras Ligas: ${player.anosOtraLigaJug}</p>
        <p>Leyenda:</p>
    </div>

    <div class="container">
        <h1>Foto Jugador</h1>
    </div>

    <div class="container">
        <h1>Estadisticas Jugador</h1>
        <p>Puntos Totales: ${estadisticas.puntosTotales}</p>
        <p>Asistencias Totales: ${estadisticas.asistenciasTotales}</p>
        <p>Rebotes Totales: ${estadisticas.rebotesTotales}</p>
        <p>Tapones Totales: ${estadisticas.taponesTotales}</p>
        <p>Robos Totales: ${estadisticas.robosTotales}</p>
        <p>Partidos Totales: ${estadisticas.partidosJugadosJug}</p>
        <p>Partidos Ganados Totales: ${estadisticas.partidosGanadosJug}</p>
        <p>Partidos Perdidos Totales: ${estadisticas.partidosPerdidosJug}</p>
        <p>Triples Anotados Totales: ${estadisticas.triplesAnotados}</p>
        <p>Tiros Libres Anotados Totales: ${estadisticas.tirosLibresAnotados}</p>
        <p>Tiros de Campo Anotados Totales: ${estadisticas.tirosDeCampoAnotados}</p>
        <p>Minutos Totales: ${estadisticas.minutosTotales}</p>
        <p>Titulos Ganados NBA: ${estadisticas.titulosGanadoNbaJug}</p>
        <p>Titulos Perdidos NBA: ${estadisticas.titulosPerdidosNbaJug}</p>
        <p>Titulos Ganados Conferencia: ${estadisticas.titulosGanadoConferenciaJug}</p>
        <p>Titulos Perdidos Conferencia: ${estadisticas.titulosPerdidosConferenciaJug}</p>
    </div>
    
</Layaout:layaout>
