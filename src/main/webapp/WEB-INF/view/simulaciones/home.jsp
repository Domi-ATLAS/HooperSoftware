<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<Layaout:layaout title="Centro de Simulaciones">
    <%-- Vista frontend: simulación NBA con formularios, resultados y paneles interactivos. --%>

<div class="simulation-center">

    <h1>Centro de Simulaciones NBA</h1>

    <div class="simulation-grid">

        <a href="/simulaciones/trade" class="sim-card">
            <h2>Simulador de traspasos</h2>
            <p>Analiza intercambios entre jugadores.</p>
        </a>

        <a href="/simulaciones/playoffs" class="sim-card">
            <h2>Predicción de playoffs</h2>
            <p>Probabilidades de playoffs.</p>
        </a>

        <a href="/simulaciones/bracket" class="sim-card">
            <h2>Cuadro de playoffs</h2>
            <p>Simulación completa del cuadro.</p>
        </a>

        <a href="/simulaciones/season" class="sim-card">
            <h2>Simulador de temporada</h2>
            <p>Temporada completa NBA.</p>
        </a>

        <a href="/simulaciones/live" class="sim-card">
            <h2>Partido en directo</h2>
            <p>Partido en directo.</p>
        </a>

        <a href="/simulaciones/gm" class="sim-card">
            <h2>Asistente de dirección deportiva</h2>
            <p>Sugerencias para encontrar trades.</p>
        </a>

        <a href="/simulaciones/analisis" class="sim-card">
            <h2>Análisis de plantilla</h2>
            <p>Diagnóstico explicable de plantilla.</p>
        </a>

        <a href="/simulaciones/tablero" class="sim-card">
            <h2>Tablero de encaje</h2>
            <p>Pista interactiva con compañeros, rivales y equipos recomendados.</p>
        </a>

        <a href="/simulaciones/comparativa" class="sim-card">
            <h2>Comparativa</h2>
            <p>Contrasta temporadas, plantillas nuevas y traspasos históricos.</p>
        </a>

        <a href="/simulaciones/dynasty" class="sim-card">
            <h2>Simulador de dinastía</h2>
            <p>Simula una dinastía NBA.</p>
        </a>

    </div>

</div>

</Layaout:layaout>
