<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<style>
    .button-group {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 20px;
    }
    button {
        display: inline-block;
        padding: 2px 2px;
        font-size: 24px;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        outline: none;
        color: #000000;
        background-color: #1D428A;
        border: 4px;
        border-style: outset;
        border-color: black;
        font-family: fantasy;
        font: Copperplate, Papyrus, fantasy;
    }
    button:hover {background-color: #5276be}

    button:active {
    background-color: #5276be;
    box-shadow: 0 5px #666;
    transform: translateY(4px);
    }
    a{
        display: inline-block;
        padding: 2px 2px;
        font-size: 24px;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        outline: none;
        color: #000000;
        background-color: #1D428A;
        border: 4px;
        border-style: outset;
        border-color: black;
        font-family: fantasy;
        font: Copperplate, Papyrus, fantasy;
    }
    a:active{
        background-color: #5276be;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
    }
    a:hover{
        background-color: #5276be;
    }
</style>
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