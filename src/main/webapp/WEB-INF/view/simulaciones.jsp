<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Simulador NBA">

<div class="sim-container">

<h1>Simulador de Traspasos NBA</h1>

<c:if test="${not empty error}">
<p style="color:red;font-weight:bold;">${error}</p>
</c:if>

<!-- ================= TRADE ================= -->

<form action="/simulaciones" method="post">

<h2>Jugador que entregas</h2>

<select name="jugadorSaleId">
<c:forEach var="sale" items="${jugadores}">
<option value="${sale.idJugador}"
<c:if test="${sale.idJugador == param.jugadorSaleId}">selected</c:if>>
${sale.nombreJugador}
<c:if test="${not empty sale.equipo}">
(${sale.equipo.nombreEquipo})
</c:if>
</option>
</c:forEach>
</select>

<h2>Jugador que recibes</h2>

<select name="jugadorLlegaId">
<c:forEach var="llega" items="${jugadores}">
<option value="${llega.idJugador}"
<c:if test="${llega.idJugador == param.jugadorLlegaId}">selected</c:if>>
${llega.nombreJugador}
<c:if test="${not empty llega.equipo}">
(${llega.equipo.nombreEquipo})
</c:if>
</option>
</c:forEach>
</select>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<br><br>

<button type="submit" class="search-btn">
Simular Traspaso
</button>

</form>

<!-- ================= RESULTADO ================= -->

<c:if test="${not empty resultado}">

<hr>

<h2>Resultado</h2>

<div class="trade-box">

<p>Entregas: <strong>${sale.nombreJugador}</strong></p>
<p>Recibes: <strong>${llega.nombreJugador}</strong></p>

<div class="score-box ${resultado.color}">
    <div class="score-number">${resultado.score}</div>
    <div>/100</div>
</div>

<p>${resultado.evaluacion}</p>

<c:if test="${resultado.score >= 70}">
<p style="color:green;">🔥 Gran trade</p>
</c:if>

<c:if test="${resultado.score >= 40 && resultado.score < 70}">
<p style="color:orange;">⚖️ Trade equilibrado</p>
</c:if>

<c:if test="${resultado.score < 40}">
<p style="color:red;">❌ Mala decisión</p>
</c:if>

</div>

</c:if>

<!-- ================= IMPACTO ================= -->

<c:if test="${not empty impacto}">

<h2>Impacto del traspaso</h2>

<div class="impact-box">

<p>Rating antes: ${impacto.ratingAntes}</p>
<p>Rating después: ${impacto.ratingDespues}</p>

<p>Victorias antes: ${impacto.victoriasAntes}</p>
<p>Victorias después: ${impacto.victoriasDespues}</p>

<p>
Diferencia:
<strong style="color:${impacto.diferencia > 0 ? 'green' : 'red'};">
${impacto.diferencia > 0 ? '+' : ''}${impacto.diferencia}
</strong>
</p>

</div>

</c:if>

<!-- ================= WINS PREDICTION ================= -->

<c:if test="${not empty wins}">

<h2>Predicción de temporada</h2>

<div class="impact-box">

<p>
Antes:
<strong>${wins.winsAntes} wins</strong>
(${wins.tierAntes})
</p>

<p>
Después:
<strong>${wins.winsDespues} wins</strong>
(${wins.tierDespues})
</p>

<p style="font-size:22px;">
Cambio:
<strong style="color:${wins.diferencia > 0 ? 'green' : 'red'};">
${wins.diferencia > 0 ? '+' : ''}${wins.diferencia}
wins
</strong>
</p>

<hr>

<p style="font-size:20px;">
${wins.mensajeIA}
</p>

</div>

</c:if>

<!-- ================= SUGERENCIAS JUGADOR ================= -->

<hr>

<h2>IA: Mejores traspasos</h2>

<form action="/simulaciones/sugerir" method="post">

<select name="jugadorBaseId">
<c:forEach var="j" items="${jugadores}">
<option value="${j.idJugador}">
${j.nombreJugador}
</option>
</c:forEach>
</select>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<button class="search-btn">Buscar</button>

</form>

<c:if test="${not empty sugerencias}">

<h3>Top sugerencias</h3>

<c:forEach var="s" items="${sugerencias}" varStatus="i">

<div class="result-card ${i.index == 0 ? 'top1' : ''}">

<strong>${s.jugador.nombreJugador}</strong>

<p>Score: ${s.score}</p>

<c:if test="${i.index == 0}">
🔥 Mejor opción
</c:if>

</div>

</c:forEach>

</c:if>

<!-- ================= SUGERENCIAS EQUIPO ================= -->

<hr>

<h2>IA: Qué necesita un equipo</h2>

<form action="/simulaciones/equipo" method="post">

<select name="equipoId">
<c:forEach var="e" items="${equipos}">
<option value="${e.idEquipo}">
${e.nombreEquipo}
</option>
</c:forEach>
</select>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<button class="search-btn">Analizar</button>

</form>

<c:if test="${not empty sugerenciasEquipo}">

<h3>Mejores fichajes</h3>

<c:forEach var="s" items="${sugerenciasEquipo}">

<div class="result-card">

<strong>${s.jugador.nombreJugador}</strong>

<p>Fit: ${s.score}</p>

</div>

</c:forEach>

</c:if>

<!-- ================= PLAYOFF SIMULATION ================= -->

<hr style="margin:60px 0;">

<h2>Simulación de Playoffs</h2>

<form action="/simulaciones/playoffs" method="post">

<select name="equipoId">
<c:forEach var="e" items="${equipos}">
<option value="${e.idEquipo}">
${e.nombreEquipo}
</option>
</c:forEach>
</select>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<button class="search-btn">Simular Playoffs</button>

</form>

<c:if test="${not empty playoff}">

<h3>Resultados para ${equipoSeleccionado.nombreEquipo}</h3>

<div class="impact-box">

<p>Probabilidad Playoffs:
<strong>${playoff.probPlayoffs}%</strong></p>

<p>Probabilidad Finales:
<strong>${playoff.probFinales}%</strong></p>

<p>Probabilidad Campeón:
<strong>${playoff.probCampeon}%</strong></p>

<hr>

<p style="font-size:22px;">
${playoff.tier}
</p>

<p style="font-size:18px;">
${playoff.mensaje}
</p>

</div>

</c:if>

</div>

</Layaout:layaout>