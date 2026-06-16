<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Crear cuenta">
    <%-- Vista frontend: formularios y paneles de cuenta de usuario. --%>

<div class="profile-container">

    <%-- Panel de perfil: agrupa datos de usuario y acciones de cuenta. --%>
<div class="profile-card">

        <h1>🏀 Crear cuenta HooperSoftware</h1>

        <p class="profile-subtitle">
            Regístrate para participar en votaciones, usar el chat global y personalizar tu experiencia NBA.
        </p>

        <c:if test="${not empty errors}">
            <div class="error-box">
                <c:forEach items="${errors}" var="error">
                    <p>${error}</p>
                </c:forEach>
            </div>
        </c:if>

        <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

        <form:form
                modelAttribute="usuario"
                method="post"
                enctype="multipart/form-data">

            <div class="form-group">
                <label>Usuario</label>
                <input
                        type="text"
                        name="username"
                        class="input-large"
                        required>
            </div>

            <div class="form-group">
                <label>Contraseña</label>
                <input
                        type="password"
                        name="password"
                        class="input-large"
                        required>
            </div>

            <div class="form-group">
                <label>Nombre visible</label>
                <input
                        type="text"
                        name="nombreUsuario"
                        class="input-large"
                        required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input
                        type="email"
                        name="correo"
                        class="input-large"
                        required>
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <input
                        type="number"
                        name="numeroTelefono"
                        class="input-large">
            </div>

            <div class="form-group">
                <label>Equipo favorito</label>
                <select
                    name="equipoFavorito"
                    class="input-large">

                    <option value="">
                        Selecciona tu equipo favorito
                    </option>

                    <c:forEach var="e" items="${equipos}">

                        <option value="${e.nombreEquipo}">
                            ${e.nombreEquipo}
                        </option>

                    </c:forEach>

                </select>
            </div>

            <div class="form-group">
                <label>Foto de perfil (opcional)</label>

                <input
                        type="file"
                        name="avatar"
                        accept="image/png,image/jpeg,image/webp">
            </div>

            <button type="submit" class="search-btn">
                Crear cuenta
            </button>

        </form:form>

        <hr>

        <div style="text-align:center;">

            <p>
                ¿Ya tienes cuenta?
            </p>

            <a href="/login" class="search-btn">
                Iniciar sesión
            </a>

        </div>

    </div>

</div>

<style>

.profile-container{
    display:flex;
    justify-content:center;
    margin:50px auto;
}

.profile-card{
    background:#001a4d;
    color:white;
    padding:40px;
    border-radius:20px;
    width:700px;
    border:2px solid #2454ff;
}

.profile-card h1{
    margin-bottom:20px;
}

.profile-subtitle{
    margin-bottom:30px;
    color:#d7d7d7;
}

.form-group{
    margin-bottom:20px;
}

.form-group label{
    display:block;
    margin-bottom:8px;
    font-weight:bold;
}

.input-large{
    width:100%;
    padding:12px;
    border-radius:10px;
    border:none;
}

.error-box{
    background:#8b0000;
    padding:15px;
    border-radius:10px;
    margin-bottom:20px;
}

</style>

</Layaout:layaout>