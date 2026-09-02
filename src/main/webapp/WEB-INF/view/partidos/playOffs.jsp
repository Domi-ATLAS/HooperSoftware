<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Playoffs de la NBA">
    <%-- Vista frontend: resumen de playoffs con filtros declarativos y tarjetas visuales. --%>

    <div class="page-heading">
        <h1>Playoffs de la NBA</h1>
        <button class="btn" type="button" onclick="window.location.href='/playOffsGames'">Todos los partidos</button>
    </div>

    <section data-filter-scope>
        <div class="data-toolbar">
            <label>
                Buscar playoff
                <input type="search" data-filter-control placeholder="Temporada, finalistas, campeon...">
            </label>
            <label>
                Temporada
                <select data-filter-control data-filter-type="exact" data-filter-field="season">
                    <option value="">Todas</option>
                    <c:forEach var="playoff" items="${playOffsGames}">
                        <option value="${playoff.temporada}">${playoff.temporada}</option>
                    </c:forEach>
                </select>
            </label>
            <div class="filter-actions">
                <button type="button" data-filter-reset>Limpiar</button>
                <span class="filter-status"><span data-filter-count></span> playoffs</span>
            </div>
        </div>

        <div class="filter-empty" data-filter-empty hidden>No hay playoffs con esos filtros.</div>

        <div class="playoff-grid">
            <c:forEach var="playoff" items="${playOffsGames}">
                <article class="playoff-card" data-filter-item data-season="${playoff.temporada}">
                    <div>
                        <span class="data-badge is-online">${playoff.temporada}</span>
                        <c:if test="${playoff.idPlayOff < 0}">
                            <span class="data-badge is-fake fake-marker">Fake</span>
                        </c:if>
                        <h2>Finales NBA</h2>
                    </div>
                    <div class="playoff-matchup">
                        <span class="playoff-chip">${playoff.campeonFinalOeste}</span>
                        <strong>VS</strong>
                        <span class="playoff-chip">${playoff.campeonFinalEste}</span>
                    </div>
                    <p><strong>Campeon:</strong> ${playoff.campeonFinalNba}</p>
                    <div class="filter-actions">
                        <button class="details-button" type="button" onclick="window.location.href='/playOffsGames/${playoff.temporada}'">Detalles</button>
                    </div>
                </article>
            </c:forEach>
        </div>
    </section>
</Layaout:layaout>
