<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Mi Perfil">
    <%-- Vista frontend: resumen de cuenta, avatar, datos personales e historial de votos. --%>

    <section class="profile-card profile-page-card">
        <h1>Perfil de ${usuario.username}</h1>

        <c:if test="${succes}">
            <div class="success-box">Perfil actualizado correctamente</div>
        </c:if>

        <div class="profile-avatar">
            <c:choose>
                <c:when test="${not empty usuario.foto}">
                    <img src="/uploads/avatars/${usuario.foto}" alt="Avatar de ${usuario.username}">
                </c:when>
                <c:otherwise>
                    <img src="/images/default-avatar.png" alt="Avatar por defecto">
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${usuario.username == principal.name}">
            <div class="profile-actions">
                <a class="btn" href="/edit">Editar perfil</a>
                <a class="btn" href="/changePassword">Cambiar contraseña</a>
            </div>
        </c:if>

        <div class="profile-details">
            <div>
                <strong>Nombre</strong>
                <span>${usuario.nombreUsuario}</span>
            </div>
            <div>
                <strong>Email</strong>
                <span>${usuario.correo}</span>
            </div>
            <div>
                <strong>Teléfono</strong>
                <span>${usuario.numeroTelefono}</span>
            </div>
            <div>
                <strong>Equipo favorito</strong>
                <span>
                    <c:choose>
                        <c:when test="${not empty usuario.equipoFavorito}">${usuario.equipoFavorito}</c:when>
                        <c:otherwise>No indicado</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div>
                <strong>Rol</strong>
                <span>${authority}</span>
            </div>
            <div>
                <strong>Miembro desde</strong>
                <span><c:out value="${usuario.fechaRegistro}"/></span>
            </div>
            <div>
                <strong>Votos emitidos</strong>
                <span><c:out value="${usuario.votosEmitidos}"/></span>
            </div>
            <div>
                <strong>Mensajes enviados</strong>
                <span><c:out value="${usuario.mensajesEnviados}"/></span>
            </div>
        </div>

        <h2>Historial de votos</h2>
        <c:choose>
            <c:when test="${empty votos}">
                <div class="empty-state">
                    <strong>No hay votos registrados.</strong>
                    <p>Cuando participes en una votación aparecerán aquí.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="vote-grid">
                    <c:forEach items="${votos}" var="v">
                        <div class="profile-vote">
                            <p>Votación #${v.idVotacion}</p>
                            <p>Elegiste: <strong>${v.opcionElegida}</strong></p>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</Layaout:layaout>
