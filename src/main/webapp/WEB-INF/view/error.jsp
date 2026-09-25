<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Error">
  <section class="error-page">
    <div class="error-card">
      <p class="eyebrow">HooperSoftware</p>
      <h1>No se ha podido cargar la página</h1>
      <p>
        La aplicación ha encontrado un problema al resolver esta pantalla.
        Puedes volver a una zona estable o usar el buscador para continuar.
      </p>

      <c:if test="${not empty error}">
        <div class="error-message">
          <strong>Detalle:</strong> ${error}
        </div>
      </c:if>

      <div class="error-actions">
        <button type="button" onclick="location.href='/welcome'">Ir al inicio</button>
        <button type="button" onclick="location.href='/noticias'">Ver noticias</button>
        <button type="button" class="btn-secondary" onclick="location.href='/buscador'">Abrir buscador</button>
      </div>
    </div>

    <c:if test="${not empty stacktrace}">
      <details class="error-debug">
        <summary>Stacktrace de desarrollo</summary>
        <pre>
${stacktrace}
        </pre>
      </details>
    </c:if>
  </section>
</Layaout:layaout>
