<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Registrarse">
            <div class="register">
                <h1 class="title">Registrarse</h1>
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
                        <input class="input-large"type="text" id="username" name="username" required>
                    </div>
                    <div>
                        <label for="password">Contraseña:</label>
                        <i id="iconoMostrar" class="fas fa-eye"></i>
                    </div>
                    <div>
                        
                        <input type="password" class ="input-large" id="password" name="password" required>
                    </div>
                    <div class="errors" style="color:red">
                        <c:out value="${passwordError}"/>
                    </div>

                    <div>
                        <label for="nombreUsuario">Nombre:</label>
                    </div>
                    <div>
                        <input class="input-large"type="text" id="nombreUsuario" name="nombreUsuario" required>
                    </div>

                    <div>
                        <label for="correo">Email:</label>
                    </div>
                    <div>
                        <input class="input-large"type="text" id="correo" name="correo" required>
                    </div>

                    <button class="buttom" type="submit">Registrarme</button>
                </form:form>
                <div class="registerInfo">
                    <p class="register">Regístrate por si quieres guardar informacion personal y poder conversar con otras personas</p>
                    <p class="register">Tambien puedes no hacerlo :|, y aunque no nos gustaria puedes tener acceso a toda la información de la web</p>
                    <a class="buttom" href="/noticias">Acceso a la web</a>
                </div>
                <p class="register">¿Ya tienes una cuenta?<a href="/login" class="buttom-positive">Iniciar sesión</a> </p>
            </div>

        <script src="/js/error_script.js"></script>
        <script src="/js/show_password.js"></script>

</Layaout:layaout>