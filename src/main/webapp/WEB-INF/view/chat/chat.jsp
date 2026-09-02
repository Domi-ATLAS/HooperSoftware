<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Chat Global NBA">
    <%-- Vista frontend: pantalla dedicada al chat NBA. --%>

<div class="sim-container">

    <h1> Chat Global NBA</h1>

    <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

    <form action="/chat/send" method="post">

        <input
            type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}" />

        <input
            type="text"
            name="mensaje"
            placeholder="Escribe un mensaje..."
            required>

        <button type="submit">
            Enviar
        </button>

    </form>

    <hr>

    <c:forEach items="${mensajes}" var="m">

        <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

            <strong>
                ${m.username}
            </strong>

            <p>
                ${m.mensaje}
            </p>

            <small>
                ${m.fecha}
            </small>

        </div>

    </c:forEach>

</div>

</Layaout:layaout>