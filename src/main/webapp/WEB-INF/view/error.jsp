<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Error">
  <div class="panel">
    <h1>Ha ocurrido un error</h1>
    <p><strong>Mensaje:</strong> ${error}</p>

    <c:if test="${not empty stacktrace}">
      <h2>Stacktrace (desarrollo)</h2>
      <pre style="white-space:pre-wrap; max-height:400px; overflow:auto; background:#111; color:#cfc; padding:8px; border-radius:6px">
${stacktrace}
      </pre>
    </c:if>
  </div>
</Layaout:layaout>
