<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Análisis de equipo NBA">

<div class="sim-page">

    <div class="sim-card">

        <a href="/simulaciones" class="back-btn">
            ← Volver a Simulaciones
        </a>

        <h1>Análisis de Equipo</h1>

        <p>
            Motor experto que analiza la plantilla con datos de la aplicación:
            edad, experiencia NBA, All-Star, rating estimado y proyección de victorias.
        </p>

        <%-- Formulario principal de la vista: selecciona el equipo que se evaluará. --%>
        <form action="/simulaciones/analisis" method="post">

            <select name="equipoId">
                <c:forEach var="e" items="${equipos}">
                    <option value="${e.idEquipo}"
                            <c:if test="${e.idEquipo == equipoId}">selected</c:if>>
                        ${e.nombreEquipo}
                    </option>
                </c:forEach>
            </select>

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}" />

            <button class="search-btn">
                Generar análisis
            </button>

        </form>

        <c:choose>
            <c:when test="${not empty informeAnalisis}">
                <button type="button" class="search-btn simulation-toggle" onclick="toggleSimulationInsight(this)">
                    Ver gráficas y modelo
                </button>
            </c:when>
            <c:otherwise>
                <button type="button" class="search-btn simulation-toggle" disabled>
                    Ver gráficas y modelo
                </button>
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty informeAnalisis}">

            <div class="ai-report">

                <div class="ai-report-header">
                    <img src="/images/${empty informeAnalisis.siglas ? 'HS' : informeAnalisis.siglas}.png"
                         alt="${informeAnalisis.equipo}">
                    <div>
                        <h2>${informeAnalisis.equipo}</h2>
                        <p>${informeAnalisis.tier} · ${informeAnalisis.victoriasEstimadas} victorias estimadas</p>
                    </div>
                </div>

                <div class="ai-metrics">
                    <div>
                        <span>Rating</span>
                        <strong>${informeAnalisis.rating}</strong>
                    </div>
                    <div>
                        <span>Edad media</span>
                        <strong>${informeAnalisis.edadMedia}</strong>
                    </div>
                    <div>
                        <span>Experiencia</span>
                        <strong>${informeAnalisis.experienciaMedia}</strong>
                    </div>
                    <div>
                        <span>All-Star</span>
                        <strong>${informeAnalisis.allStars}</strong>
                    </div>
                    <div>
                        <span>Confianza</span>
                        <strong>${informeAnalisis.confianza}%</strong>
                    </div>
                </div>

                <div class="ai-explain">
                    <h3>Diagnóstico</h3>
                    <p>${informeAnalisis.diagnostico}</p>

                    <h3>Recomendación</h3>
                    <p>${informeAnalisis.recomendacion}</p>
                </div>

                <div class="ai-factors">
                    <h3>Factores utilizados en el análisis</h3>
                    <ul>
                        <c:forEach var="factor" items="${informeAnalisis.factores}">
                            <li>${factor}</li>
                        </c:forEach>
                    </ul>
                </div>

                <section class="simulation-insight" data-simulation-insight hidden>
                    <h2>Comparativa del informe</h2>
                    <div class="simulation-chart">
                        <div class="chart-row">
                            <span class="chart-label">Rating</span>
                            <span class="chart-track"><span class="chart-fill" style="--value:${informeAnalisis.rating};"></span></span>
                            <span class="chart-value">${informeAnalisis.rating}</span>
                        </div>
                        <div class="chart-row">
                            <span class="chart-label">Victorias</span>
                            <span class="chart-track"><span class="chart-fill is-good" style="--value:${informeAnalisis.victoriasEstimadas * 100 / 82};"></span></span>
                            <span class="chart-value">${informeAnalisis.victoriasEstimadas}</span>
                        </div>
                        <div class="chart-row">
                            <span class="chart-label">Confianza</span>
                            <span class="chart-track"><span class="chart-fill is-warning" style="--value:${informeAnalisis.confianza};"></span></span>
                            <span class="chart-value">${informeAnalisis.confianza}%</span>
                        </div>
                    </div>
                </section>

            </div>

        </c:if>

    </div>

</div>

</Layaout:layaout>

