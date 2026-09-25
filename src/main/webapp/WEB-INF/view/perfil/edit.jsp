<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Editar Perfil">

<div class="profile-edit-container">

<div class="profile-edit-card">

    <a href="/profile/${usuario.username}" class="back-link">
        ← Volver al perfil
    </a>

    <h1>Editar Perfil</h1>

    <c:if test="${not empty errors}">
        <div class="error-box">

            <c:forEach items="${errors}" var="error">
                <div class="error-item">
                    ${error}
                </div>
            </c:forEach>

        </div>
    </c:if>


    <form:form
            modelAttribute="usuario"
            method="post"
            enctype="multipart/form-data">

        <div class="profile-grid">

            <div class="form-group">

                <label>Usuario</label>

                <input
                        type="text"
                        value="${usuario.username}"
                        disabled>

            </div>

            <div class="form-group">

                <label>Nombre</label>

                <input
                        type="text"
                        id="nombreUsuario"
                        name="nombreUsuario"
                        value="${usuario.nombreUsuario}"
                        required>

            </div>

            <div class="form-group">

                <label>Email</label>

                <input
                        type="email"
                        id="correo"
                        name="correo"
                        value="${usuario.correo}"
                        required>

            </div>

            <div class="form-group">

                <label>Teléfono</label>

                <input
                        type="number"
                        id="numeroTelefono"
                        name="numeroTelefono"
                        value="${usuario.numeroTelefono}">

            </div>

            <div class="form-group">

                <label>Equipo Favorito</label>

                <select
                    id="equipoFavorito"
                    name="equipoFavorito"
                    class="input-large">

                    <option value="">
                        Selecciona un equipo
                    </option>

                    <c:forEach var="e" items="${equipos}">

                        <option
                            value="${e.nombreEquipo}"

                            <c:if test="${e.nombreEquipo == usuario.equipoFavorito}">
                                selected
                            </c:if>>

                            ${e.nombreEquipo}

                        </option>

                    </c:forEach>

                </select>

            </div>

            <div class="form-group">

                <label>Nueva foto de perfil</label>

                <input
                        type="file"
                        name="avatar"
                        accept=".png,.jpg,.jpeg,.webp">

            </div>

        </div>

        <c:if test="${not empty usuario.foto}">

            <div class="avatar-preview">

                <p>Foto actual</p>

                <img
                        src="/uploads/avatars/${usuario.foto}"
                        alt="Avatar">

            </div>

        </c:if>

        <button
                type="submit"
                class="save-btn">

            Guardar cambios

        </button>

    </form:form>

</div>

</div>

<style>

.profile-edit-container{
    display:flex;
    justify-content:center;
    margin-top:40px;
    margin-bottom:40px;
}

.profile-edit-card{
    background:#00153d;
    border:2px solid #2d6cff;
    border-radius:25px;
    width:900px;
    padding:40px;
    color:white;
}

.profile-edit-card h1{
    margin-bottom:30px;
    color:white;
}

.back-link{
    color:#4d8dff;
    text-decoration:none;
    font-weight:bold;
}

.back-link:hover{
    color:white;
}

.profile-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:25px;
}

.form-group{
    display:flex;
    flex-direction:column;
}

.form-group label{
    margin-bottom:8px;
    font-weight:bold;
}

.form-group input{
    padding:12px;
    border-radius:10px;
    border:2px solid #2d6cff;
    font-size:15px;
}

.avatar-preview{
    margin-top:30px;
    text-align:center;
}

.avatar-preview img{
    width:140px;
    height:140px;
    border-radius:50%;
    object-fit:cover;
    border:3px solid #2d6cff;
}

.save-btn{
    margin-top:30px;
    padding:15px 30px;
    border:none;
    border-radius:12px;
    background:#2d6cff;
    color:white;
    font-weight:bold;
    font-size:16px;
    cursor:pointer;
}

.save-btn:hover{
    background:#4d8dff;
}

.error-box{
    margin-bottom:20px;
}

.error-item{
    background:#a00000;
    padding:10px;
    border-radius:8px;
    margin-bottom:8px;
}

</style>

<script src="/js/error_script.js"></script>

</Layaout:layaout>
