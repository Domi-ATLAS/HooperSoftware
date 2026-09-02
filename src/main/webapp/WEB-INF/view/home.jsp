<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<Layaout:layaout title="Bienvenido">
    <%-- Vista frontend: portada y accesos principales de la aplicación. --%>
  <section class="home-dashboard">
    <div class="home-hero">
      <p class="eyebrow">HooperSoftware</p>
      <h1>Centro NBA</h1>
      <p>
        Consulta partidos, transferencias, votaciones y simulaciones desde una
        experiencia unificada.
      </p>

      <div class="home-actions">
        <button class="btn" onclick="location.href='/noticias'">Entrar a noticias</button>
        <button class="btn" onclick="location.href='/allGames'">Ver partidos</button>
        <sec:authorize access="!isAuthenticated()">
          <button class="btn btn-secondary" onclick="location.href='/login'">Iniciar sesión</button>
        </sec:authorize>
      </div>
    </div>

    <div class="dashboard-grid">
      <a class="dashboard-card" href="/allGames">
        <strong>Partidos</strong>
        <p>Resultados, jornadas, temporadas y detalle de encuentros.</p>
      </a>

      <a class="dashboard-card" href="/allTranferences">
        <strong>Transferencias</strong>
        <p>Movimientos entre equipos con filtros por fecha y franquicia.</p>
      </a>

      <a class="dashboard-card" href="/allVotes">
        <strong>Votaciones</strong>
        <p>Votaciones activas, oficiales e historial por temporada.</p>
      </a>

      <a class="dashboard-card" href="/allPlayers">
        <strong>Plantillas</strong>
        <p>Jugadores, entrenadores y fichas individuales de consulta.</p>
      </a>

      <a class="dashboard-card" href="/buscador">
        <strong>Buscador</strong>
        <p>Acceso rápido a equipos, jugadores, entrenadores y partidos.</p>
      </a>

      <sec:authorize access="hasAuthority('admin')">
        <a class="dashboard-card" href="/simulaciones">
          <strong>Simulaciones</strong>
          <p>Trade machine, predicciones, bracket y escenarios de temporada.</p>
        </a>
      </sec:authorize>
    </div>
  </section>
</Layaout:layaout>
