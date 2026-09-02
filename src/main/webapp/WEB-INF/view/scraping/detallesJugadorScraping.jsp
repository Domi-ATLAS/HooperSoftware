<%-- Vista frontend: consulta e importación visual de datos obtenidos por scraping. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalles del Jugador</title>
</head>
<body>
    <h1>Detalles del Jugador</h1>
    <c:if test="${not empty error}">
        <div class="result-note">${error}</div>
    </c:if>
    <c:if test="${not empty jugador}">
        <p>ID: ${jugador.id}</p>
        <p>Nombre: ${jugador.nombreJugador}</p>
        <p>Posición: ${jugador.posicion}</p>
        <p>Dorsal: ${jugador.dorsal}</p>
        <p>Trayectoria: ${jugador.trayectoriaJug}</p>
        <p>Año Draft: ${jugador.anoDraft}</p>
        <p>Edad: ${jugador.edadJug}</p>
        <!-- Muestra más atributos del jugador según sea necesario -->
    </c:if>
</body>
</html>
