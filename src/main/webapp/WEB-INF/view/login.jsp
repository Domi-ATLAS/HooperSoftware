<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<Layaout:layaout title="Iniciar sesión">
    <div class="register">
        <h1 class="title">Iniciar sesión</h1>
        <c:if test="${not empty errors}">
            <div id="error-notifications">
                <c:forEach items="${errors}" var="error">
                    <div class="error-notification">
                        <span><c:out value="${error}"/></span>
                        <button class="close-button">×</button>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <form:form modelAttribute="usuario" method="post">
            <div>
                <label for="username">Usuario:</label>
            </div>
            <div>
                <input class="input-large" type="text" id="username" name="username" required>
            </div>
            <div class="errors" style="color:red">
                <c:out value="${existsError}"/>
                <c:out value="${usernameError}"/>
            </div>
            <br>
            <div>
                <label for="password">Contraseña:</label>
                <i id="iconoMostrar" class="fas fa-eye"></i>
            </div>
            <div>
                <input type="password" class="input-large" id="password" name="password">
            </div>
            <div class="errors" style="color:red">
                <c:out value="${password}"/>
            </div>
            <br>
            <button class="buttom" type="submit">Iniciar Sesión</button>
        </form:form>
        <div>
            <p class="profile">¿Aún no tienes cuenta? <a href="/new" class="buttom-positive">Registrate</a></p>
        </div>
    </div>
</Layaout:layaout>