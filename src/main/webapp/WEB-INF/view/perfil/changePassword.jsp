<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Cambiar contraseña">
        <div class="block">
                <h1 class="title">Cambiar contraseña</h1>
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
                <form:form modelAttribute="changePasswordForm">
                    <div>
                        <label for="oldPassword">Antigua contraseña:</label>
                        <i id="iconoMostrar" class="fas fa-eye"></i>
                    </div>
                    <div>
                        <input type="password" class ="input-large" id="password" name="oldPassword" required>
                    </div>

                    <div>
                        <label for="oldPassword">Nueva contraseña:</label>
                        <i id="iconoMostrar" class="fas fa-eye"></i>
                    </div>
                    <div>
                        <input type="password" class ="input-large" id="password" name="newPassword" required>
                    </div>
                    <div class="block">
                        <button class="buttom" type="submit">Cambiar</button>
                    </div>
                </form:form>

        <script src="/js/error_script.js"></script>
        <script src="/js/show_pasword.js"></script>
    </div>
</Layaout:layaout>