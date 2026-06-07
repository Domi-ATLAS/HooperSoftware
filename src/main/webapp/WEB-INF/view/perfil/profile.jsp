<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Mi Perfil">

<div style="
max-width:900px;
margin:40px auto;
padding:40px;
background:#001845;
border:2px solid #3b82f6;
border-radius:25px;
color:white;
">

    <h1 style="
    text-align:center;
    margin-bottom:30px;
    font-size:42px;
    ">
        👤 Perfil de ${usuario.username}
    </h1>

    <c:if test="${succes}">
        <div style="
        background:#16a34a;
        padding:15px;
        border-radius:10px;
        text-align:center;
        margin-bottom:25px;
        font-weight:bold;
        ">
            ✅ Perfil actualizado correctamente
        </div>
    </c:if>

    <div style="
    display:flex;
    flex-wrap:wrap;
    gap:40px;
    align-items:center;
    justify-content:center;
    ">

        <!-- FOTO -->

        <div style="text-align:center;">

            <c:choose>

                <c:when test="${not empty usuario.foto}">
                    <img
                        src="/uploads/avatars/${usuario.foto}"
                        style="
                        width:220px;
                        height:220px;
                        object-fit:cover;
                        border-radius:50%;
                        border:4px solid #3b82f6;
                        ">
                </c:when>

                <c:otherwise>
                    <img
                        src="/images/default-avatar.png"
                        style="
                        width:220px;
                        height:220px;
                        object-fit:cover;
                        border-radius:50%;
                        border:4px solid #3b82f6;
                        ">
                </c:otherwise>

            </c:choose>

        </div>

        <!-- DATOS -->

        <div style="flex:1; min-width:300px;">

            <div style="margin-bottom:20px;">
                <strong style="color:#60a5fa;">Nombre:</strong><br>
                ${usuario.nombreUsuario}
            </div>

            <div style="margin-bottom:20px;">
                <strong style="color:#60a5fa;">Email:</strong><br>
                ${usuario.correo}
            </div>

            <div style="margin-bottom:20px;">
                <strong style="color:#60a5fa;">Teléfono:</strong><br>
                ${usuario.numeroTelefono}
            </div>

            <div style="margin-bottom:20px;">
                <strong style="color:#60a5fa;">Equipo favorito:</strong><br>
                ${usuario.equipoFavorito}
            </div>

            <p class="perfil">
                📅 Miembro desde:
                <c:out value="${usuario.fechaRegistro}"/>
            </p>

            <p class="perfil">
                🗳️ Votos emitidos:
                <c:out value="${usuario.votosEmitidos}"/>
            </p>

            <p class="perfil">
                💬 Mensajes enviados:
                <c:out value="${usuario.mensajesEnviados}"/>
            </p>

            <h3>🗳️ Historial de votos</h3>

            <c:forEach items="${votos}" var="v">

                <div class="profile-vote">

                    <p>
                        Votación #${v.idVotacion}
                    </p>

                    <p>
                        Elegiste:
                        <strong>${v.opcionElegida}</strong>
                    </p>

                </div>

            </c:forEach>
            <div style="margin-bottom:20px;">
                <strong style="color:#60a5fa;">Rol:</strong><br>
                ${authority}
            </div>

        </div>

    </div>

    <hr style="
    margin:40px 0;
    border:1px solid rgba(255,255,255,0.2);
    ">

    <div style="
    display:flex;
    justify-content:center;
    gap:20px;
    flex-wrap:wrap;
    ">

        <c:if test="${usuario.username == principal.name}">
            <a href="/edit"
               style="
               background:#2563eb;
               color:white;
               padding:12px 25px;
               border-radius:10px;
               text-decoration:none;
               font-weight:bold;
               ">
                ✏️ Editar perfil
            </a>
        </c:if>

        <c:if test="${usuario.username == principal.name}">
            <a href="/changePassword"
               style="
               background:#dc2626;
               color:white;
               padding:12px 25px;
               border-radius:10px;
               text-decoration:none;
               font-weight:bold;
               ">
                🔒 Cambiar contraseña
            </a>
        </c:if>

    </div>

</div>

</Layaout:layaout>