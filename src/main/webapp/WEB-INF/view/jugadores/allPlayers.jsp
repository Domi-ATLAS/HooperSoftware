<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores">
    <%-- Vista frontend: jugadores y entrenadores con listados, fichas y datos de perfil. --%>
  <h1>Jugadores y Entrenadores</h1>

  <div class="split-2">
    <!-- Columna izquierda: Jugadores -->
    <section class="panel">
      <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>
      <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teamsL">Filtra por equipos:</label>
        <select id="teamsL" name="teams">
          <option value="">Todos los equipos</option>
          <c:forEach var="equipo" items="${equipos}">
            <option value="${equipo.idEquipo}" <c:if test="${equipo.idEquipo == selectedTeamId}">selected</c:if>>
              ${equipo.nombreEquipo}
            </option>
          </c:forEach>
        </select>
        <button type="submit" class="btn">Filtrar</button>
      </form>

      <h2>Todos los jugadores</h2>
      <div class="search-bar">
        <input type="text" id="searchPlayer" placeholder="Buscar jugador...">
        <button class="btn" type="button" onclick="filterPlayers()">Buscar</button>
      </div>

      <table id="playersTable" class="table">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Posición</th>
            <th>Edad</th>
            <th>Detalles</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="player" items="${players}">
            <tr class="player-row">
              <td>${player.nombreJugador}</td>
              <td>${player.posicion}</td>
              <td>${player.edadJug}</td>
              <td><button class="btn" onclick="location.href='/player/${player.idJugador}'">Detalles</button></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </section>

    <!-- Columna derecha: Entrenadores -->
    <section class="panel">
      <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>
      <form class="filter-form" onsubmit="filterByTeam(event)">
        <label for="teamsR">Filtra por equipos:</label>
        <select id="teamsR" name="teams">
          <option value="">Todos los equipos</option>
          <c:forEach var="equipo" items="${equipos}">
            <option value="${equipo.idEquipo}" <c:if test="${equipo.idEquipo == selectedTeamId}">selected</c:if>>
              ${equipo.nombreEquipo}
            </option>
          </c:forEach>
        </select>
        <button type="submit" class="btn">Filtrar</button>
      </form>

      <h2>Todos los entrenadores</h2>
      <div class="search-bar">
        <input type="text" id="searchTrainer" placeholder="Buscar entrenador...">
        <button class="btn" type="button" onclick="filterTrainers()">Buscar</button>
      </div>

      <table class="table" id="trainersTable">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Edad</th>
            <th>Detalles</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="trainer" items="${trainers}">
            <tr class="trainer-row">
              <td>${trainer.nombeEntrenador}</td>
              <td>${trainer.edadEntr}</td>
              <td><button class="btn" onclick="location.href='/trainer/${trainer.idEntrenador}'">Detalles</button></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </section>
  </div>

  <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>
    /**
     * Filtra la lista de jugadores según los criterios activos.
     * @returns {void}
     */
    function filterPlayers() {
      const input = document.getElementById("searchPlayer").value.toLowerCase();
      document.querySelectorAll(".player-row").forEach(row => {
        const nombre = row.cells[0].textContent.toLowerCase();
        row.style.display = nombre.includes(input) ? "" : "none";
      });
    }
    /**
     * Filtra la lista de entrenadores según los criterios activos.
     * @returns {void}
     */
    function filterTrainers() {
      const input = document.getElementById("searchTrainer").value.toLowerCase();
      document.querySelectorAll(".trainer-row").forEach(row => {
        const nombre = row.cells[0].textContent.toLowerCase();
        row.style.display = nombre.includes(input) ? "" : "none";
      });
    }
    /**
     * Redirige o filtra la vista según el equipo seleccionado.
     * @param {Event} e Evento del formulario o control que dispara la acción.
     * @returns {void}
     */
    function filterByTeam(e){ e.preventDefault(); /* aquí podrás enganchar tu lógica */ }
  </script>
</Layaout:layaout>
