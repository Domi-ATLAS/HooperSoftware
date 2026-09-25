<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Cambiar Contraseña">

<div class="password-container">

<div class="password-card">

    <a href="/profile/${usuario.username}" class="back-link">
        ← Volver al perfil
    </a>

    <h1>Cambiar Contraseña</h1>

    <c:if test="${not empty errors}">

        <div class="error-box">

            <c:forEach items="${errors}" var="error">

                <div class="error-item">
                    ${error}
                </div>

            </c:forEach>

        </div>

    </c:if>


    <form:form modelAttribute="changePasswordForm">

        <div class="form-group">

            <label>Contraseña actual</label>

            <input
                    type="password"
                    id="oldPassword"
                    name="oldPassword"
                    required>

        </div>

        <div class="form-group">

            <label>Nueva contraseña</label>

            <input
                    type="password"
                    id="newPassword"
                    name="newPassword"
                    required>

        </div>

        <button
                type="submit"
                class="save-btn">

            Cambiar contraseña

        </button>

    </form:form>

</div>

</div>

<style>

.password-container{
    display:flex;
    justify-content:center;
    margin-top:40px;
    margin-bottom:40px;
}

.password-card{
    width:700px;
    background:#001845;
    border:2px solid #3b82f6;
    border-radius:25px;
    padding:40px;
    color:white;
}

.password-card h1{
    margin-bottom:30px;
    text-align:center;
}

.back-link{
    color:#60a5fa;
    text-decoration:none;
    font-weight:bold;
}

.back-link:hover{
    color:white;
}

.form-group{
    display:flex;
    flex-direction:column;
    margin-bottom:25px;
}

.form-group label{
    margin-bottom:10px;
    font-weight:bold;
}

.form-group input{
    padding:14px;
    border-radius:10px;
    border:2px solid #3b82f6;
    font-size:15px;
}

.save-btn{
    width:100%;
    padding:15px;
    border:none;
    border-radius:12px;
    background:#2563eb;
    color:white;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
}

.save-btn:hover{
    background:#3b82f6;
}

.error-box{
    margin-bottom:25px;
}

.error-item{
    background:#dc2626;
    padding:12px;
    border-radius:8px;
    margin-bottom:10px;
}

</style>

</Layaout:layaout>
