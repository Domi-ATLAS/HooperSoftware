<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Detalle Playoffs">

    <div class="page-heading">
        <div>
            <h1>Playoffs ${temporada}</h1>
            <p>Resumen de eliminatoria, finalistas y partidos cargados en la aplicación.</p>
        </div>
        <div class="filter-actions">
            <button class="btn" type="button" onclick="window.location.href='/allPlayOffs'">Volver a Playoffs</button>
            <button class="btn btn-secondary" type="button" onclick="window.location.href='/playOffsGames'">Todos los partidos</button>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty playoff}">
            <section class="playoff-detail-hero">
                <div>
                    <span class="data-badge is-online">${playoff.temporada}</span>
                    <c:if test="${playoff.idPlayOff < 0}">
                        <span class="data-badge is-fake fake-marker">Fake</span>
                    </c:if>
                    <h2>Finales NBA</h2>
                    <div class="playoff-matchup">
                        <span class="playoff-chip">${playoff.campeonFinalOeste}</span>
                        <strong>VS</strong>
                        <span class="playoff-chip">${playoff.campeonFinalEste}</span>
                    </div>
                </div>
                <div class="playoff-winner-card">
                    <span>Campeón NBA</span>
                    <strong>${playoff.campeonFinalNba}</strong>
                </div>
            </section>

            <section class="playoff-path-grid">
                <article class="playoff-card">
                    <h2>Conferencia Oeste</h2>
                    <div class="playoff-stage">
                        <span>Clasificados</span>
                        <p>${playoff.oeste}</p>
                    </div>
                    <div class="playoff-stage">
                        <span>Ganadores de cuartos</span>
                        <p>${playoff.campeonesCuartosOeste}</p>
                    </div>
                    <div class="playoff-stage">
                        <span>Ganadores de semifinales</span>
                        <p>${playoff.campeonesSemisOeste}</p>
                    </div>
                    <div class="playoff-stage is-winner">
                        <span>Campeón del Oeste</span>
                        <p>${playoff.campeonFinalOeste}</p>
                    </div>
                </article>

                <article class="playoff-card">
                    <h2>Conferencia Este</h2>
                    <div class="playoff-stage">
                        <span>Clasificados</span>
                        <p>${playoff.este}</p>
                    </div>
                    <div class="playoff-stage">
                        <span>Ganadores de cuartos</span>
                        <p>${playoff.campeonesCuartosEste}</p>
                    </div>
                    <div class="playoff-stage">
                        <span>Ganadores de semifinales</span>
                        <p>${playoff.campeonesSemisEste}</p>
                    </div>
                    <div class="playoff-stage is-winner">
                        <span>Campeón del Este</span>
                        <p>${playoff.campeonFinalEste}</p>
                    </div>
                </article>
            </section>

            <section class="playoff-path-grid">
                <article class="playoff-card">
                    <h2>Equipos Oeste cargados</h2>
                    <c:choose>
                        <c:when test="${not empty equiposOeste}">
                            <div class="team-chip-grid">
                                <c:forEach var="equipo" items="${equiposOeste}">
                                    <span class="playoff-chip">${equipo.nombreEquipo}</span>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>No hay equipos del Oeste vinculados a este playoff.</p>
                        </c:otherwise>
                    </c:choose>
                </article>

                <article class="playoff-card">
                    <h2>Equipos Este cargados</h2>
                    <c:choose>
                        <c:when test="${not empty equiposEste}">
                            <div class="team-chip-grid">
                                <c:forEach var="equipo" items="${equiposEste}">
                                    <span class="playoff-chip">${equipo.nombreEquipo}</span>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>No hay equipos del Este vinculados a este playoff.</p>
                        </c:otherwise>
                    </c:choose>
                </article>
            </section>

            <section data-filter-scope>
                <div class="data-toolbar">
                    <label>
                        Buscar partido
                        <input type="search" data-filter-control placeholder="Equipo, resultado, ganador...">
                    </label>
                    <div class="filter-actions">
                        <button type="button" data-filter-reset>Limpiar</button>
                        <span class="filter-status"><span data-filter-count></span> partidos</span>
                    </div>
                </div>

                <div class="filter-empty" data-filter-empty hidden>No hay partidos con esos filtros.</div>

                <div class="playoff-grid">
                    <c:forEach var="game" items="${playOffsGames}">
                        <article class="playoff-card" data-filter-item>
                            <div class="playoff-matchup">
                                <span class="playoff-chip">${game.equipoLocal}</span>
                                <strong>${game.resultadoTotal}</strong>
                                <span class="playoff-chip">${game.equipoVisitante}</span>
                            </div>
                            <p><strong>Fecha:</strong> ${game.fecha}</p>
                            <p><strong>Ganador:</strong> ${game.ganador}</p>
                            <p><strong>Serie:</strong> ${empty game.victoriaSerie ? 'Sin dato' : game.victoriaSerie}</p>
                            <div class="filter-actions">
                                <button class="details-button" type="button" onclick="window.location.href='/partido/${game.idPartido}'">Ver partido</button>
                                <button class="btn btn-secondary" type="button" onclick="window.location.href='/temporada/${temporada}/partidos/${game.equipoLocal}/${game.equipoVisitante}'">Ver serie</button>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <c:if test="${empty playOffsGames}">
                    <div class="filter-empty">Este playoff todavía no tiene partidos asociados.</div>
                </c:if>
            </section>
        </c:when>
        <c:otherwise>
            <div class="filter-empty">
                No existe un playoff cargado para la temporada ${temporada}.
            </div>
        </c:otherwise>
    </c:choose>
</Layaout:layaout>
