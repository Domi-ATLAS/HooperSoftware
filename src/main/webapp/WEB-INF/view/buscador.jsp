<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
            <%@ page contentType="text/html;charset=UTF-8" %>

                <Layaout:layaout title="Buscador NBA">
    <%-- Vista frontend: buscador global de contenido de la aplicación. --%>

                    <div class="search-page">

                        <h1>Buscador Global NBA</h1>

                        <div class="search-container">

                            <%-- Formulario principal de la vista: recoge la acción del usuario y mantiene los campos enviados al backend. --%>

                            <form action="/buscador" method="get">

                                <input type="text" name="query" value="${query}" class="search-box"
                                    placeholder="Busca jugadores, equipos, entrenadores o partidos..."
                                    autocomplete="off" />
                                <div id="autocomplete-results"></div>
                                <button type="submit" class="search-btn">
                                    Buscar
                                </button>

                            </form>

                        </div>


                        <c:if test="${not searched}">
                            <div class="search-empty">
                                <h3>¿Qué puedes buscar?</h3>

                                <ul>
                                    <li>Jugadores (Ej: LeBron, Jordan)</li>
                                    <li>Equipos (Ej: Lakers, Miami)</li>
                                    <li>Entrenadores (Ej: Spoelstra)</li>
                                    <li>Partidos relacionados por equipo</li>
                                </ul>

                            </div>
                        </c:if>



                        <c:if test="${searched}">

                            <h3 class="query-title">
                                Resultados para "<strong>${query}</strong>"
                            </h3>

                            <div class="results-wrapper">

                                <!-- EQUIPOS -->

                                <c:if test="${not empty equipos}">
                                    <div class="result-group">

                                        <h2>
                                            Equipos (${fn:length(equipos)})
                                        </h2>

                                        <c:forEach var="equipo" items="${equipos}">

                                            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                                                <a href="/equipos/${fn:replace(equipo.nombreEquipo,' ','')}">
                                                    🏀 ${equipo.nombreEquipo}
                                                </a>

                                            </div>

                                        </c:forEach>

                                    </div>
                                </c:if>




                                <!-- JUGADORES -->

                                <c:if test="${not empty jugadores}">
                                    <div class="result-group">

                                        <h2>
                                            Jugadores (${fn:length(jugadores)})
                                        </h2>

                                        <c:forEach var="jugador" items="${jugadores}">

                                            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                                                <a href="/player/${jugador.idJugador}">
                                                    ⛹ ${jugador.nombreJugador}
                                                </a>

                                                <c:if test="${not empty jugador.equipo}">
                                                    <span class="meta">
                                                        - ${jugador.equipo.nombreEquipo}
                                                    </span>
                                                </c:if>

                                            </div>

                                        </c:forEach>

                                    </div>
                                </c:if>





                                <!-- ENTRENADORES -->

                                <c:if test="${not empty entrenadores}">
                                    <div class="result-group">

                                        <h2>
                                            Entrenadores (${fn:length(entrenadores)})
                                        </h2>

                                        <c:forEach var="entrenador" items="${entrenadores}">

                                            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                                                <a href="/trainer/${entrenador.idEntrenador}">
                                                    🎯 ${entrenador.nombeEntrenador}
                                                </a>

                                                <c:if test="${not empty entrenador.equipo}">
                                                    <span class="meta">
                                                        - ${entrenador.equipo.nombreEquipo}
                                                    </span>
                                                </c:if>

                                            </div>

                                        </c:forEach>

                                    </div>
                                </c:if>






                                <!-- PARTIDOS -->

                                <c:if test="${not empty partidos}">
                                    <div class="result-group">

                                        <h2>
                                            Partidos (${fn:length(partidos)})
                                        </h2>

                                        <c:forEach var="partido" items="${partidos}" begin="0" end="7">

                                            <%-- Resultado de la simulación o consulta: se muestra solo cuando el controlador envía datos. --%>
            <div class="result-card">

                                                <a href="/partido/${partido.idPartido}">
                                                    🏆
                                                    ${partido.equipoLocal}
                                                    vs
                                                    ${partido.equipoVisitante}
                                                </a>

                                                <c:if test="${not empty partido.fecha}">
                                                    <span class="meta">
                                                        - ${partido.fecha}
                                                    </span>
                                                </c:if>

                                            </div>

                                        </c:forEach>

                                        <c:if test="${fn:length(partidos) > 8}">
                                            <p class="more-results">
                                                Mostrando 8 partidos de ${fn:length(partidos)} resultados
                                            </p>
                                        </c:if>

                                    </div>
                                </c:if>




                                <!-- SIN RESULTADOS -->

                                <c:if test="
empty entrenadores
and empty equipos
and empty jugadores
and empty partidos">

                                    <div class="search-empty">
                                        No se encontraron resultados para
                                        <strong>${query}</strong>
                                    </div>

                                </c:if>


                            </div>

                        </c:if>

                    </div>
                    <%-- Scripts propios de esta vista: interacción local sin cambiar la lógica del servidor. --%>
<script>

                        const input = document.querySelector(".search-box");
                        const box = document.getElementById("autocomplete-results");

                        let currentFocus = -1;

                        input.addEventListener("keyup", function (e) {

                            if (["ArrowDown", "ArrowUp", "Enter"].includes(e.key)) {
                                return;
                            }

                            let q = this.value;

                            if (q.length < 2) {
                                box.innerHTML = "";
                                return;
                            }

                            fetch("/buscador/autocomplete?term=" + q)
                                .then(r => r.json())
                                .then(data => {

                                    box.innerHTML = "";
                                    currentFocus = -1;

                                    data.forEach(item => {

                                        let div = document.createElement("div");

                                        div.className = "autocomplete-item";
                                        div.innerText = item;

                                        div.onclick = function () {

                                            input.value = item.split(" (")[0];
                                            box.innerHTML = "";

                                        };

                                        box.appendChild(div);

                                    });

                                });

                        });

                        input.addEventListener("keydown", function (e) {

                            let items = document.querySelectorAll(".autocomplete-item");

                            if (e.key === "ArrowDown") {
                                currentFocus++;
                                addActive(items);
                            }

                            if (e.key === "ArrowUp") {
                                currentFocus--;
                                addActive(items);
                            }

                            if (e.key === "Enter" && currentFocus > -1) {

                                e.preventDefault();

                                if (items[currentFocus]) {
                                    items[currentFocus].click();
                                }

                            }

                        });

                        /**
                         * Marca como activo el elemento de autocompletado seleccionado.
                         * @param {*} items Colección de elementos del autocompletado.
                         * @returns {void}
                         */
                        function addActive(items) {

                            if (!items.length) return;

                            removeActive(items);

                            if (currentFocus >= items.length) {
                                currentFocus = 0;
                            }

                            if (currentFocus < 0) {
                                currentFocus = items.length - 1;
                            }

                            items[currentFocus].classList.add("autocomplete-active");

                        }

                        /**
                         * Elimina el estado activo de los elementos de autocompletado.
                         * @param {*} items Colección de elementos del autocompletado.
                         * @returns {void}
                         */
                        function removeActive(items) {

                            items.forEach(
                                i => i.classList.remove("autocomplete-active")
                            );

                        }

                        document.addEventListener("click", function (e) {

                            if (e.target !== input) {
                                box.innerHTML = "";
                            }

                        });

                    </script>

                </Layaout:layaout>