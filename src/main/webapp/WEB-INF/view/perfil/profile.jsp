<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Perfil">
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