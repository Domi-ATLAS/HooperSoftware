<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Entrenadores">
  <%-- Vista frontend: listado independiente de entrenadores con busqueda local. --%>
  <div class="players-page">
    <div class="page-heading">
      <h1>Entrenadores</h1>
      <p class="filter-status">${coaches.size()} entrenadores en base de datos</p>
    </div>

    <section class="panel trainers-panel">
      <%-- Busqueda local: filtra la tabla sin recargar la pagina. --%>
      <div class="search-bar">
        <input type="text" id="searchTrainer" placeholder="Buscar entrenador...">
        <button class="btn" type="button" onclick="filterTrainers()">Buscar</button>
      </div>

      <c:choose>
        <c:when test="${empty coaches}">
          <div class="empty-state">
            <strong>No hay entrenadores para mostrar.</strong>
            <p>Cuando existan entrenadores persistidos apareceran en este listado.</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-scroll">
            <table class="table trainers-table" id="trainersTable">
              <thead>
                <tr>
                  <th>Nombre</th>
                  <th>Equipo</th>
                  <th>Edad</th>
                  <th>Experiencia NBA</th>
                  <th>Datos</th>
                  <th>Detalles</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="trainer" items="${coaches}">
                  <tr class="trainer-row">
                    <td>
                      ${trainer.nombeEntrenador}
                      <c:if test="${trainer.idEntrenador < 0}">
                        <span class="data-badge is-fake fake-marker">Fake</span>
                      </c:if>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${not empty trainer.equipo}">${trainer.equipo.nombreEquipo}</c:when>
                        <c:when test="${not empty trainer.equipoEntr}">${trainer.equipoEntr}</c:when>
                        <c:otherwise>Sin equipo</c:otherwise>
                      </c:choose>
                    </td>
                    <td>${trainer.edadEntr}</td>
                    <td>${trainer.anosNbaEntr}</td>
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
     * Filtra los entrenadores por nombre o equipo dentro de la tabla visible.
     * @returns {void}
     */
    function filterTrainers() {
      const input = document.getElementById("searchTrainer").value.toLowerCase();
      document.querySelectorAll(".trainer-row").forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
      });
    }
  </script>
</Layaout:layaout>
