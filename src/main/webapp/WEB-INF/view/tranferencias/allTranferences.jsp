<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
function toggleTransferencia(id) {
    var element = document.getElementById(id);
    if (element.style.display === "none") {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    }
}
</script>

<Layaout:layaout title="Transferencias">
    <h1>Transferencias</h1>
    <c:forEach var="transferencia" items="${transferences}" varStatus="status">
        <div onClick="toggleTransferencia('transferencia${status.index}')">
            <p>${transferencia.equipoOrigen} &rarr; ${transferencia.equipoDestino}</p>
            <p>Fecha: ${transferencia.fecha}</p>
        </div>
        <div id="transferencia${status.index}" style="display: none;">
            <p>Precio: ${transferencia.precio}</p>
            <c:if test="${transferencia.rondaDraft}">
                <p>Info Draft: ${transferencia.infoRondaDraft}</p>
            </c:if>
        </div>
    </c:forEach>
</Layaout:layaout>