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
        <p class="perfil"> <c:out value="${usuario.getFoto()}"/></p>
        <p class="perfil">Nombre: <c:out value="${usuario.getNombreUsuario()}"/></p>
        <p class="perfil">Email: <c:out value="${usuario.getCorreo()}"/></p>
        <p class="perfil">Numero de Telefono: <c:out value="${usuario.getNumeroTelefono()}"/></p>
        <p class="perfil">Equipo Favorito: <c:out value="${usuario.getEquipoFavorito()}"/></p>
        
        <div class="block">
                <c:if test="${usuario.getUsername()==principal.getName()}">
                    <a href="/edit" class="buttom">Editar mi perfil</a>
                </c:if>
                <c:if test="${usuario.getUsername()==principal.getName()}">
                    <a href="/changePassword" class="buttom">Cambiar mi contraseña</a>
                </c:if>
        </div>
    </div>
</Layaout:layaout>