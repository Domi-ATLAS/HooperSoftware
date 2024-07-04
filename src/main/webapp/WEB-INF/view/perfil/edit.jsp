<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Editar mi perfil">
        <div class="block">
                <h1 class="title">Editar mi perfil</h1>
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
                <form:form modelAttribute="usuario">
                    <div>
                        <p class="profile">Nombre de usuario: <c:out value="${usuario.getUsername()}"/></p>
                    </div>
                    <div class="block">
                        <div>
                            <label for="name">Nombre:</label>
                        </div>
                        <div>
                            <input class="input-large" type="text" id="nombreUsuario" name="nombreUsuario" value=<c:out value='${usuario.getNombreUsuario()}'/> required>
                        </div>
                        <div>
                            <label for="mail">Email:</label>
                        </div>
                        <div>
                            <input class="input-large" type="text" id="correo" name="correo" value=<c:out value='${usuario.getCorreo()}'/> required>
                        </div>
                    </div>
                    <div class="block">
                        <button class="buttom" type="submit">Editar</button>
                    </div>
                </form:form>

        <script src="/js/error_script.js"></script>
        <script src="/js/show_pasword.js"></script>
    </div>
</Layaout:layaout>