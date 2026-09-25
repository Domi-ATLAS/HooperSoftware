<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Detalles Entrenador">
    

    <button onClick="window.location.href='/allPlayers'">Volver a Jugadores y Entrenadores</button>

    <div class="container">
        <h1>
            Detalles del Entrenador
            <c:if test="${trainer.idEntrenador < 0}">
                <span class="data-badge is-fake fake-marker">Fake</span>
            </c:if>
        </h1>
        <p>Nombre: ${trainer.nombeEntrenador}</p>
        <p>Equipo: ${trainer.equipoEntr}</p>
        <p>Edad: ${trainer.edadEntr}</p>
        <p>Años All Star: ${trainer.anosAllStarEntr}</p>
        <p>Años en la NBA: ${trainer.anosNbaEntr}</p>
        <p>Años en otras Ligas: ${trainer.anosOtrasLigasEntr}</p>
        <p>Trayectoria: ${trainer.trayectoriaEntr}</p>
        <p>Leyenda:</p>
    </div>

    <div class="container">
        <h1>Foto Entrenador</h1>
    </div>

    <div class="container">
        <h1>Estadisticas Entrenador</h1>
        <p>Partidos Totales: ${estadisticas.partidosJugadosEntr}</p>
        <p>Partidos Ganados Totales: ${estadisticas.partidosGanadosEntr}</p>
        <p>Partidos Perdidos Totales: ${estadisticas.partidosPerdidosEntr}</p>
        <p>Titulos Ganados NBA: ${estadisticas.titulosGanadoNbaEntr}</p>
        <p>Titulos Perdidos NBA: ${estadisticas.titulosPerdidosNbaEntr}</p>
        <p>Titulos Ganados Conferencia: ${estadisticas.titulosGanadoConferenciaEntr}</p>
        <p>Titulos Perdidos Conferencia: ${estadisticas.titulosPerdidosConferenciaEntr}</p>
    </div>
    
</Layaout:layaout>
