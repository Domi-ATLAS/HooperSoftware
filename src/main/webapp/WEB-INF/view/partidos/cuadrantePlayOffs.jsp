<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Playoffs Partidos">
    <%-- Vista frontend: consulta de partidos, temporadas, jornadas o playoffs con navegación y filtros. --%>


    <h1>Equipos Playoff ${temporada}</h1>
    <div class="container">
        <div class="section">
            <h2>Oeste</h2>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.primeroOeste}: 1</p>
                    <p>${clasificacion.octavoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p>wins </p>
                    </c:if>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>

                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 4</p>
                    <p>${clasificacion.quintoOeste}: 5</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.cuartoOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.quintoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.cuartoOeste}/${clasificacion.quintoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.terceroOeste}: 3</p>
                    <p>${clasificacion.sextoOeste}: 6</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.terceroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.sextoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.terceroOeste}/${clasificacion.sextoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div><div class="group">
                <div class="team-info">
                    <p>${clasificacion.segundoOeste}: 2</p>
                    <p>${clasificacion.septimoOeste}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.segundoOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.septimoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.segundoOeste}/${clasificacion.septimoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoOeste}: 1</p>
                    <p>${clasificacion.quintoOeste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosOeste.contains(clasificacion.primeroOeste) || playoff.campeonesCuartosOeste.contains(clasificacion.octavoOeste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroOeste}/${clasificacion.octavoOeste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="section">
            <h2>Este</h2>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.primeroEste}: 1</p>
                    <p>${clasificacion.octavoEste}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosEste.contains(clasificacion.primeroEste) || playoff.campeonesCuartosEste.contains(clasificacion.octavoEste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.primeroEste}/${clasificacion.octavoEste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.cuartoEste}: 4</p>
                    <p>${clasificacion.quintoEste}: 5</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosEste.contains(clasificacion.cuartoEste) || playoff.campeonesCuartosEste.contains(clasificacion.quintoEste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.cuartoEste}/${clasificacion.quintoEste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
            <div class="group">
                <div class="team-info">
                    <p>${clasificacion.terceroEste}: 3</p>
                    <p>${clasificacion.sextoEste}: 6</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosEste.contains(clasificacion.terceroEste) || playoff.campeonesCuartosEste.contains(clasificacion.sextoEste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.terceroEste}/${clasificacion.sextoEste}'">Detalles</button>
                    </c:if>
                </div>
            </div><div class="group">
                <div class="team-info">
                    <p>${clasificacion.segundoEste}: 2</p>
                    <p>${clasificacion.septimoEste}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <c:if test="${playoff.campeonesCuartosEste.contains(clasificacion.segundoEste) || playoff.campeonesCuartosEste.contains(clasificacion.septimoEste)}">
                        <p> wins</p>
                        <button onClick="window.location.href='/temporada/2022-2023/partidos/${clasificacion.segundoEste}/${clasificacion.septimoEste}'">Detalles</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>


</Layaout:layaout>