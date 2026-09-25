<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Jugadores">
  <div class="players-page">
  <h1>Jugadores y Entrenadores</h1>

  <div class="data-toolbar">
    <span class="filter-status">${playersWithStats} jugadores con estadísticas asociadas</span>
    <span class="filter-status">${players.size()} jugadores en base de datos</span>
  </div>

  <div class="players-layout">
    <section class="panel players-panel">
      <%-- Filtro por equipo: navega al endpoint de equipo para mostrar datos persistidos. --%>
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

      <c:choose>
        <c:when test="${empty players}">
          <div class="empty-state">
            <strong>No hay jugadores para mostrar.</strong>
            <p>Selecciona otro equipo o vuelve al listado completo.</p>
            <button class="btn" type="button" onclick="location.href='/allPlayers'">Ver todos</button>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-scroll">
          <table id="playersTable" class="table players-table">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Temporada</th>
                <th>Posición</th>
                <th>Edad</th>
                <th>Datos</th>
                <th>Detalles</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="player" items="${players}">
                <tr class="player-row">
                  <td>
                    ${player.nombreJugador}
                    <c:if test="${player.idJugador < 0}">
                      <span class="data-badge is-fake fake-marker">Fake ${player.temporadaJugador}</span>
                    </c:if>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty player.equipo}">${player.equipo.nombreEquipo}</c:when>
                      <c:otherwise>Sin equipo</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty player.temporadaJugador}">${player.temporadaJugador}</c:when>
                      <c:otherwise>Base</c:otherwise>
                    </c:choose>
                  </td>
                  <td>${player.posicion}</td>
                  <td>${player.edadJug}</td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty player.estadisticasJug}">
                        <c:choose>
                          <c:when test="${player.idJugador < 0}">
                            <span class="data-badge is-fake">Fake ${player.temporadaJugador}</span>
                          </c:when>
                          <c:otherwise>
                            <span class="data-badge is-online">Con estadísticas</span>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:otherwise>
                        <span class="data-badge">Backup</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td><button class="btn" onclick="location.href='/player/${player.idJugador}'">Detalles</button></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          </div>
        </c:otherwise>
      </c:choose>
    </section>

    <section class="panel trainers-panel">
      <%-- Filtro compartido: mantiene la misma seleccion para jugadores y entrenadores. --%>
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

      <c:choose>
        <c:when test="${empty trainers}">
          <div class="empty-state">
            <strong>No hay entrenadores para mostrar.</strong>
            <p>Selecciona otro equipo o vuelve al listado completo.</p>
            <button class="btn" type="button" onclick="location.href='/allPlayers'">Ver todos</button>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-scroll">
          <table class="table trainers-table" id="trainersTable">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Datos</th>
                <th>Detalles</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="trainer" items="${trainers}">
                <tr class="trainer-row">
                  <td>
                    ${trainer.nombeEntrenador}
                    <c:if test="${trainer.idEntrenador < 0}">
                      <span class="data-badge is-fake fake-marker">Fake</span>
                    </c:if>
                  </td>
                  <td>${trainer.edadEntr}</td>
                  <td>
                    <c:choose>
                      <c:when test="${trainer.idEntrenador < 0}">
                        <span class="data-badge is-fake">Fake</span>
                      </c:when>
                      <c:otherwise>
                        <span class="data-badge is-online">Persistido</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td><button class="btn" onclick="location.href='/trainer/${trainer.idEntrenador}'">Detalles</button></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          </div>
        </c:otherwise>
      </c:choose>
    </section>
  </div>

  <script>
    /**
     * Filtra la lista de jugadores por nombre dentro de la tabla visible.
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
     * Filtra la lista de entrenadores por nombre dentro de la tabla visible.
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
     * Redirige al listado persistido por equipo.
     * @param {Event} event Evento de envio del formulario.
     * @returns {void}
     */
    function filterByTeam(event) {
      event.preventDefault();
      const select = event.target.querySelector("select");
      if (!select || !select.value) {
        location.href = "/allPlayers";
        return;
      }
      location.href = "/allPlayers/" + select.value;
    }
  </script>
  </div>
</Layaout:layaout>
