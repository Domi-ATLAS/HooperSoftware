<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<Layaout:layaout title="Dallas Mavericks">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Dallas Mavericks</title>
    </head>
    <body>
        <img src="/images/DAL.png">
        <h1>${team.nombreEquipo}</h1>

        <div style="float: right;">
            <h2>Clasificación:</h2>
            <ul>
                <c:forEach var="equipo" items="${clasificacion}" varStatus="status">
                    <c:choose>
                        <c:when test="${equipo.nombreEquipo == team.nombreEquipo}">
                            <li style="color: rgb(101, 150, 241);">
                                ${status.index + 1}. ${equipo.nombreEquipo} - 
                                Partidos ganados: ${equipo.partidosGanados} - 
                                Partidos perdidos: ${equipo.partidosPerdidos} - 
                                Porcentaje de victorias: ${equipo.partidosGanados / (equipo.partidosGanados + equipo.partidosPerdidos)} - 
                                Balance de la temporada: ${equipo.balanceTemporada}
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                ${status.index + 1}. ${equipo.nombreEquipo} - 
                                Partidos ganados: ${equipo.partidosGanados} - 
                                Partidos perdidos: ${equipo.partidosPerdidos} - 
                                Porcentaje de victorias: ${equipo.partidosGanados / (equipo.partidosGanados + equipo.partidosPerdidos)} - 
                                Balance de la temporada: ${equipo.balanceTemporada}
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>


        <p>Ciudad: ${team.ciudad}</p>
        <p>Conferencia: ${team.conferencia}</p>
        <p>División: ${team.division}</p>
        <p>Año de fundación: ${team.anoFundacion}</p>
        <p>Años en la NBA: ${team.anosNba}</p>
        <p>Títulos de la NBA: ${team.titulosNba}</p>
        <p>Títulos de conferencia: ${team.titulosConferencia}</p>

        <h2>Esta temporada</h2>
        <p>Partidos ganados: ${team.partidosGanados}</p>
        <p>Partidos perdidos: ${team.partidosPerdidos}</p>
        <p>Balance de la temporada: ${team.balanceTemporada} en el ${team.conferencia}</p>
        
        <style>
            .right-align {
                float: right;
                width: 53%; /* Ajusta este valor según tus necesidades */
            }
        </style>
        
        <div class="right-align">
            <h2>Últimos 10 partidos:</h2>
            <ul>
                <c:forEach var="partido" items="${partidos}" varStatus="status">
                    <c:if test="${status.index < 10}">
                        <li>
                            Partido: ${partido.equipoLocal} VS ${partido.equipoVisitante} | Resultado: ${partido.resultadoTotal} 
                            <button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        
        <h2>Jugadores:</h2>
        <ul>
            <c:forEach var="jugador" items="${jugadores}">
                <li>${jugador.nombreJugador} - ${jugador.edadJug} años - ${jugador.posicion}</li>
            </c:forEach>
        </ul>
        <h2>Entrenadores:</h2>
        <ul>
            <c:forEach var="entrenador" items="${entrenadores}">
                <li>${entrenador.nombeEntrenador} - ${entrenador.edadEntr} años</li>
            </c:forEach>
        </ul>

    </body>
    </html>
</Layaout:layaout>
