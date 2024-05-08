<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .column {
        float: left;
        width: 50%;
    }
    /* Clear floats after the columns */
    .row:after {
        content: "";
        display: table;
        clear: both;
    }
</style>

<Layaout:layaout title="Votaciones">
    <h1>Votaciones</h1>

    <style>
        .container {
            display: flex;
            justify-content: space-between;
        }
        .column {
            flex: 1;
            margin: 0 10px;
        }
    </style>
    
    <div class="container">
        <div class="column">
            <h2>Todas las votaciones</h2>
            <table>
                <c:forEach var="vote" items="${votes}">
                    <tr>
                        <th>${vote.categotiaVotacion}</th>
                    </tr>
                    <tr>
                        <td>Temporada: ${vote.temporada}</td>
                    </tr>
                    <tr>
                        <td>Jornada: ${vote.jornada}</td>
                    </tr>
                    <tr>
                        <td>Fecha: ${vote.fecha}</td>
                    </tr>
                    <c:forEach var="voto" items="${vote.opcionesVotacion}">
                        <tr>
                            <td>${voto}</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td style="color: red;">${vote.ganador}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    
        <div class="column">
            <h2>Votaciones en activo</h2>
            <table>
                <c:forEach var="vote" items="${votes}">
                    <c:if test="${vote.enCurso && !vote.oficial}">
                        <tr>
                            <th>${vote.categotiaVotacion}</th>
                        </tr>
                        <tr>
                            <td>Temporada: ${vote.temporada}</td>
                        </tr>
                        <tr>
                            <td>Jornada: ${vote.jornada}</td>
                        </tr>
                        <tr>
                            <td>Fecha: ${vote.fecha}</td>
                        </tr>
                        <c:forEach var="voto" items="${vote.opcionesVotacion}">
                            <tr>
                                <td>${voto}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>
                                <button type="button" onclick="location.href=''">Votar</button>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    
        <div class="column">
            <h2>Votaciones oficiales</h2>
            <table>
                <c:forEach var="vote" items="${votes}">
                    <c:if test="${vote.oficial}">
                        <tr>
                            <th>${vote.categotiaVotacion}</th>
                        </tr>
                        <tr>
                            <td>Temporada: ${vote.temporada}</td>
                        </tr>
                        <tr>
                            <td>Jornada: ${vote.jornada}</td>
                        </tr>
                        <tr>
                            <td>Fecha: ${vote.fecha}</td>
                        </tr>
                        <c:forEach var="voto" items="${vote.opcionesVotacion}">
                            <tr>
                                <td>${voto}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td style="color: red;">${vote.ganador}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    </div>  
</Layaout:layaout>