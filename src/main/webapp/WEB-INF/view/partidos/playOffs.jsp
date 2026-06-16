<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Playoffs de la NBA">

    <h1>Playoffs de la NBA</h1>

    <button onClick="window.location.href='/playOffsGames'">Todos los partidos de PlayOff</button>

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

    <c:forEach var="playoff" items="${playOffsGames}">
        <div class="playoff-container" data-filter-item data-season="${playoff.temporada}">
            <p>Temporada: ${playoff.temporada}</p>
            <p>${playoff.campeonFinalOeste} VS ${playoff.campeonFinalEste}</p>
            <p>Campeón de la NBA: ${playoff.campeonFinalNba}</p>
            <c:set var="lastTwoDigits" value="${playoff.temporada.substring(playoff.temporada.length() - 2)}" />
            <button class="details-button" onclick="window.location.href='/playOffsGames/${playoff.temporada}'">Detalles</button>
        </div>
    </c:forEach>
    </section>
</Layaout:layaout>
