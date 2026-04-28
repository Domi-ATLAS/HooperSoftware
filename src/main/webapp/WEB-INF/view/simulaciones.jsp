<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Simulador NBA">

<div class="sim-container">

<h1>Simulador de Traspasos NBA</h1>

<form action="/simulaciones" method="post">

<h2>Jugador que entrega tu equipo</h2>

<select name="jugadorSaleId">

<c:forEach var="sale" items="${jugadores}">

<option value="${sale.idJugador}">
${sale.nombreJugador}
<c:if test="${not empty sale.equipo}">
(${sale.equipo.nombreEquipo})
</c:if>
</option>

</c:forEach>

</select>



<h2>Jugador que recibirás</h2>

<select name="jugadorLlegaId">

<c:forEach var="llega" items="${jugadores}">

<option value="${llega.idJugador}">
${llega.nombreJugador}
<c:if test="${not empty llega.equipo}">
(${llega.equipo.nombreEquipo})
</c:if>
</option>

</c:forEach>

</select>


<!-- CSRF TOKEN (arregla el 403) -->
<input
type="hidden"
name="${_csrf.parameterName}"
value="${_csrf.token}"/>


<br><br>

<button type="submit" class="search-btn">
Simular Traspaso
</button>

</form>



<c:if test="${not empty resultado}">

<hr style="margin:50px 0;">


<h2>Resultado del análisis</h2>


<div class="trade-box">

<p>
Entregas:

<strong>
${sale.nombreJugador}
</strong>
</p>


<p>
Recibes:

<strong>
${llega.nombreJugador}
</strong>
</p>


<div class="trade-score ${resultado.color}">
Trade Score:
${resultado.score}/100
</div>


<p style="margin-top:20px;font-size:20px;">
${resultado.evaluacion}
</p>

</div>

</c:if>


</div>

</Layaout:layaout>