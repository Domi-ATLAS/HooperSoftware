<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags  " %>


<Layaout:layaout title="Login">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Login</title>
    </head>
    <body>

        <h1>
            Bienvenido a la aplicación de Spring Security
        </h1>
    <hr>

    <h3>Hemos llegado</h3>

    <p>
        Usuario: <security:authentication property="principal.username" />
        <br/>
        <br/>
        Rol: <security:authentication property="principal.authorities" />
    </p>

        <h2>Login</h2>
        <form:form action="${pageContext.request.contextPath}/logout" method="POST">
            <input type="submit" value="Logout">
        </form:form>
    </body>
    </html>
</Layaout:layaout> -->