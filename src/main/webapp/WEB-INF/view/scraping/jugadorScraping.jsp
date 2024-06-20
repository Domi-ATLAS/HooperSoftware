<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Jugadores</title>
</head>
<body>
    <h1>Lista de Jugadores</h1>
    <c:if test="${not empty error}">
        <div style="color:red;">${error}</div>
    </c:if>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Posición</th>
                <th>Dorsal</th>
                <!-- Agrega más columnas según los atributos de Jugador que quieras mostrar -->
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${jugadores}" var="jugador">
                <tr>
                    <td>${jugador.idJugador}</td>
                    <td>${jugador.nombreJugador}</td>
                    <td>${jugador.posicion}</td>
                    <td>${jugador.dorsal}</td>
                    <!-- Agrega más columnas según los atributos de Jugador que quieras mostrar -->
                    <td><a href="${pageContext.request.contextPath}/jugadores/${jugador.idJugador}">Ver Detalles</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
