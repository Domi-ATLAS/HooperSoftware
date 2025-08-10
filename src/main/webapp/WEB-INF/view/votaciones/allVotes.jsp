<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Todas las Votaciones">

    <style>
        .container {
            max-width: 800px;
            padding: 20px;
        }

        .vote {
            background-color: white;
            color: black;
            padding: 15px;
            margin: 15px 0;
            border-radius: 10px;
            border: 2px solid black;
            text-align: left;
        }

        .season-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #1D428A;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-top: 15px;
            cursor: pointer;
        }

        .toggle-button {
            background-color: #ffcc00;
            color: black;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }

        .toggle-button:hover {
            background-color: #e6b800;
        }
    </style>

    <h1>Todas las Votaciones</h1>

    <button type="button" onclick="location.href='/allVotes/inCourse'">Votaciones en Curso</button>
    <button type="button" onclick="location.href='/allVotes/oficial'">Votaciones Oficiales</button>

    <!-- Formulario de Filtrado -->
    <form class="filter-form" onsubmit="applyFilters(event)">
        <label for="category">Categoría:</label>
        <select id="category" name="category">
            <option value="">Todas</option>
            <c:forEach var="categoria" items="${categorias}">
                <option value="${categoria}">${categoria}</option>
            </c:forEach>
        </select>

        <label for="date">Fecha anterior a:</label>
        <input type="date" id="date" name="date">

        <button type="submit">Filtrar</button>
        <button type="button" onclick="clearFilters()">Limpiar Filtros</button>
    </form>

    <div class="container">
        <c:forEach var="temporada" items="${temporadas}" varStatus="loop">
            <c:set var="hasVotes" value="false" />
            <c:forEach var="vote" items="${votes}">
                <c:if test="${vote.temporada == temporada.anosTemporada}">
                    <c:set var="hasVotes" value="true" />
                </c:if>
            </c:forEach>
            <c:if test="${hasVotes}">
                <div class="season-header">
                    <h2>Temporada: ${temporada.anosTemporada}</h2>
                    <button class="toggle-button" onclick="toggleVisibility('season${loop.index}')">Mostrar/Ocultar</button>
                </div>
                <div id="season${loop.index}" class="season-votes" style="display: none;">
                    <c:forEach var="vote" items="${votes}">
                        <c:if test="${vote.temporada == temporada.anosTemporada}">
                            <div class="vote"
                                 data-category="${vote.categotiaVotacion}"
                                 data-date="${vote.fecha}">
                                <h3>${vote.categotiaVotacion}</h3>
                                <p>Jornada: ${vote.jornada}</p>
                                <p>Fecha: ${vote.fecha}</p>
                                <p style="color: red;">Ganador: ${vote.ganador}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <script>
        function toggleVisibility(id) {
            var section = document.getElementById(id);
            section.style.display = (section.style.display === "none" || section.style.display === "") ? "block" : "none";
        }

        function clearFilters() {
            document.getElementById("category").value = "";
            document.getElementById("date").value = "";
            
            // Mostrar todas las votaciones
            var votes = document.querySelectorAll(".vote");
            votes.forEach(function(vote) {
                vote.style.display = "block";
            });

            // Mostrar todas las temporadas
            var seasons = document.querySelectorAll(".season-votes");
            seasons.forEach(function(season) {
                season.style.display = "block";
            });
        }


        function applyFilters(event) {
            event.preventDefault(); // Evita el envío del formulario

            var category = document.getElementById("category").value.trim().toLowerCase();
            var selectedDate = document.getElementById("date").value;

            var votes = document.querySelectorAll(".vote");

            votes.forEach(function(vote) {
                var voteCategory = vote.getAttribute("data-category").trim().toLowerCase();
                var voteDate = vote.getAttribute("data-date");

                var matchCategory = (category === "" || voteCategory === category);
                var matchDate = (selectedDate === "" || (voteDate && new Date(voteDate) < new Date(selectedDate)));

                vote.style.display = (matchCategory && matchDate) ? "block" : "none";
            });

            // Ocultar temporadas sin votaciones visibles
            var seasons = document.querySelectorAll(".season-votes");
            seasons.forEach(function(season) {
                var votesInSeason = season.querySelectorAll(".vote");
                var hasVisibleVote = Array.from(votesInSeason).some(vote => vote.style.display !== "none");
                season.style.display = hasVisibleVote ? "block" : "none";
            });
        }
    </script>

</Layaout:layaout>
