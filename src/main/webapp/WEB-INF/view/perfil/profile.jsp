<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Perfil">
    <style>
        .container {
            display: flex;
        }
        .left, .right {
            width: 50%;
            padding: 10px;
        }
        .left {
            border-right: 1px solid #ccc;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <div class="left">
        <h1 class="title">Perfil de <c:out value="${usuario.getUsername()}"/></h1>
        <c:if test="${succes}">
            <div id="succes">
                <div class="succes-notification">
                    <span>Perfil actualizado correctamente</span>
                    <button class="close-button">×</button>
                </div>
            </div>
        </c:if>
        <p class="perfil">Nombre: <c:out value="${usuario.getNombreUsuario()}"/></p>
        <p class="perfil">Email: <c:out value="${usuario.getCorreo()}"/></p>
        <div class="block">
                <c:if test="${usuario.getUsername()==principal.getName()}">
                    <a href="/usuario/edit" class="buttom">Editar mi perfil</a>
                </c:if>
                <c:if test="${usuario.getUsername()==principal.getName()}">
                    <a href="/usuario/changePassword" class="buttom">Cambiar mi contraseña</a>
                </c:if>
        </div>
    </div>
</Layaout:layaout>