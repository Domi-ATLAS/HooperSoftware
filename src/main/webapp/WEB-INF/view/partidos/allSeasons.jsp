<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Todas las Temporadas</title>
    <style>
        .hidden {
            display: none;
        }
    </style>
    <script>
        function toggleVisibility(id) {
            var element = document.getElementById(id);
            if (element.style.display === "none") {
                element.style.display = "block";
            } else {
                element.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <h1>Todas las Temporadas</h1>
    <c:forEach var="temporada" items="${temporadas}" varStatus="status">
        <p onclick="toggleVisibility('jornadas${status.index}')">${temporada}</p>
        <div id="jornadas${status.index}" class="hidden">
            <c:forEach var="jornada" items="${jornadas[status.index]}">
                <p onclick="toggleVisibility('partidos${status.index}${jornada.id}')">${jornada.nombre}</p>
                <div id="partidos${status.index}${jornada.id}" class="hidden">
                    <c:forEach var="partido" items="${partidos[status.index][jornada.id]}">
                        <p>${partido}</p>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </c:forEach>
</body>
</html>