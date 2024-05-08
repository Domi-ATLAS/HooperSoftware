<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Votaciones Oficiales">
    <h1>Votaciones Oficiales</h1>

    <button type="button" onclick="location.href='/allVotes'">Todas las Votaciones</button>
    <button type="button" onclick="location.href='/allVotes/inCourse'">Votaciones en Curso</button>



    <div class="container">
        <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
            <c:set var="hasOfficialVote" value="false" />
            <c:forEach var="vote" items="${votes}">
                <c:if test="${vote.oficial && vote.temporada == temporada.anosTemporada}">
                    <c:set var="hasOfficialVote" value="true" />
                </c:if>
            </c:forEach>
            <c:if test="${hasOfficialVote}">
                <h2 onclick="toggleVisibility('season${loop.index}')">Temporada: ${temporada.anosTemporada}</h2>
                <div id="season${loop.index}" style="display: none;">
                    <c:forEach var="vote" items="${votes}">
                        <c:if test="${vote.oficial && vote.temporada == temporada.anosTemporada}">
                            <div class="vote">
                                <h3>${vote.categotiaVotacion}</h3>
                                <p>Jornada: ${vote.jornada}</p>
                                <p>Fecha: ${vote.fecha}</p>
                                <ul>
                                    <c:forEach var="voto" items="${vote.opcionesVotacion}">
                                        <li>${voto}</li>
                                    </c:forEach>
                                </ul>
                                <p style="color: red;">Ganador: ${vote.ganador}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <script>
        function toggleVisibility(id) {
            var x = document.getElementById(id);
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
    </script>
</Layaout:layaout>