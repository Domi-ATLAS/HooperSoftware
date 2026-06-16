<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Serie">
    <%-- Vista frontend: consulta de partidos, temporadas, jornadas o playoffs con navegación y filtros. --%>
    <body>
        <h1>Serie de Partidos</h1>
        <c:if test="${not empty partidos}">
            <%-- Tabla principal de datos renderizados por JSTL. --%>
    <table>
                <tr>
                    <th>Equipo Local</th>
                    <th>Equipo Visitante</th>
                    <th>Temporada de Playoffs</th>
                    <th>Resultado</th>
                    <th>Resultado Serie</th>
                    <th></th>
                </tr>
                <c:forEach items="${partidos}" var="partido">
                    <tr>
                        <td>${partido.equipoLocal}</td>
                        <td>${partido.equipoVisitante}</td>
                        <td>${partido.temporada}</td>
                        <td>${partido.resultadoTotal}</td>
                        <td>${partido.victoriaSerie}</td>
                        <td><button onClick="window.location.href='/partido/${partido.idPartido}'">Detalles</button></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${empty partidos}">
            <p>No se encontraron partidos.</p>
        </c:if>
    </body>

</Layaout:layaout>