<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="CUPES" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <div>
        <button onclick="location.href='login.jsp'">Iniciar sesión</button>
        <button onclick="location.href='register.jsp'">Registrarse</button>
        <button onclick="location.href='start.jsp'">Empezar sin logearme</button>
    </div>

    <div>
        <h2>Contenedor con 6 apartados</h2>
        <div>Apartado 1</div>
        <div>Apartado 2</div>
        <div>Apartado 3</div>
        <div>Apartado 4</div>
        <div>Apartado 5</div>
        <div>Apartado 6</div>
    </div>

    <div>
        <h2>Contenedor con 30 apartados</h2>
        <c:forEach var="i" begin="1" end="30">
            <div>Apartado ${i}</div>
        </c:forEach>
    </div>
</body>
</html>