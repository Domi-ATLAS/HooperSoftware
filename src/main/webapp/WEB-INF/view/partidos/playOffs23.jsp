<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Equipos Playoffs 23">
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            border: 4px;
            border-style: outset;
            border-color: black;
            margin: 10px 0;
            padding: 10px;
            background-color: #ffffff;
        }
        .section {
            width: 19%;
        }
        .group {
            border: 4px;
            border-style: outset;
            border-color: black;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #5276be;
            font-family: fantasy;
            font: Copperplate, Papyrus, fantasy;
        }
        .team-info {
            width: 40%;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .vs {
            text-shadow: 2px 2px 5px #000000;
            color: #1D428A;
            width: 80%;
            text-align: left;
        }
        .details {
            width: 40%;
            text-align: right;
        }
        .section {
            width: 19%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .group p:nth-child(2) {
            text-align: right;
        }
    </style>

    <h1>Equipos Playoffs 23</h1>
    <div class="container">
        <div class="section">
            <h2>Oeste</h2>
            <!-- 1 vs 8 Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${denver.nombreEquipo}: 1</p>
                    <p>${timberwolves.nombreEquipo}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>DEN wins 4-1</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Denver Nuggets/Minnesota Timberwolves'">Detalles</button>
                </div>
            </div>
            <!-- 4 vs 5 Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${phoenix.nombreEquipo}: 4</p>
                    <p>${clippers.nombreEquipo}: 5</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>PHX wins 4-1</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Phoenix Suns/Los Angeles Clippers'">Detalles</button>
                </div>
            </div>
            <!-- 3 vs 6 Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${sacramento.nombreEquipo}: 3</p>
                    <p>${goldenState.nombreEquipo}: 6</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>GSW wins 4-3</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Sacramento Kings/Golden State Warriors'">Detalles</button>
                </div>
            </div>
            <!-- 2 vs 7 Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${memphis.nombreEquipo}: 2</p>
                    <p>${lakers.nombreEquipo}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>LAL wins 4-2</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Memphis Grizzlies/Los Angeles Lakers'">Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
            <!-- 1 Semifinal Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${denver.nombreEquipo}: 1</p>
                    <p>${phoenix.nombreEquipo}: 4</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>DEN wins 4-2</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Denver Nuggets/Phoenix Suns'">Detalles</button>
                </div>
            </div>
            <!-- Final Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${denver.nombreEquipo}: 1</p>
                    <p>${lakers.nombreEquipo}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>DEN wins 4-0</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Denver Nuggets/Los Angeles Lakers'">Detalles</button>
                </div>
            </div>
            <!-- 2 Semifinal Oeste-->
            <div class="group">
                <div class="team-info">
                    <p>${goldenState.nombreEquipo}: 6</p>
                    <p>${lakers.nombreEquipo}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>LAL wins 4-2</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Golden State Warriors/Los Angeles Lakers'">Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
            <!-- Final NBA -->
            <div class="group">
                <div class="team-info">
                    <p>${denver.nombreEquipo}: 1</p>
                    <p>${miami.nombreEquipo}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>DEN wins 4-1</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Denver Nuggets/Miami Heat'">Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
            <!-- 1 Semifinal Este-->
            <div class="group">
                <div class="team-info">
                    <p>${miami.nombreEquipo}: 8</p>
                    <p>${nyk.nombreEquipo}: 5</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>MIA wins 4-2</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Miami Heat/New York Knicks'">Detalles</button>
                </div>
            </div>
            <!-- Final Este-->
            <div class="group">
                <div class="team-info">
                    <p>${miami.nombreEquipo}: 8</p>
                    <p>${celtics.nombreEquipo}: 2</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>MIA wins 4-3</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Miami Heat/Boston Celtics'">Detalles</button>
                </div>
            </div>
            <!-- 2 Semifinal Este-->
            <div class="group">
                <div class="team-info">
                    <p>${sixters.nombreEquipo}: 3</p>
                    <p>${celtics.nombreEquipo}: 2</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>BOS wins 4-3</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Philadelphia 76ers/Boston Celtics'">Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
            <h2>Este</h2>
            <!-- 1 vs 8 Este-->
            <div class="group">
                <div class="team-info">
                    <p>${bucks.nombreEquipo}: 1</p>
                    <p>${miami.nombreEquipo}: 8</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>MIA wins 4-1</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Milwaukee Bucks/Miami Heat'">Detalles</button>
                </div>
            </div>
            <!-- 4 vs 5 Este-->
            <div class="group">
                <div class="team-info">
                    <p>${cavs.nombreEquipo}: 4</p>
                    <p>${nyk.nombreEquipo}: 5</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>NYK wins 4-1</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Cleveland Cavaliers/New York Knicks'">Detalles</button>
                </div>
            </div>
            <!-- 3 vs 6 Este-->
            <div class="group">
                <div class="team-info">
                    <p>${sixters.nombreEquipo}: 3</p>
                    <p>${nets.nombreEquipo}: 6</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>PHI wins 4-0</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Philadelphia 76ers/Brooklyn Nets'">Detalles</button>
                </div>
            </div>
            <!-- 2 vs 7 Este-->
            <div class="group">
                <div class="team-info">
                    <p>${celtics.nombreEquipo}: 2</p>
                    <p>${atlanta.nombreEquipo}: 7</p>
                </div>
                <div class="vs">
                    <p>VS</p>
                </div>
                <div class="result">
                    <p>BOS wins 4-2</p>
                    <button onClick="window.location.href='/temporada/2022-2023/partidos/Boston Celtics/Atlanta Hawks'">Detalles</button>
                </div>
            </div>
        </div>
    </div>
</Layaout:layaout>