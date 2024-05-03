<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Equipos Playoffs 23">
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            border: 1px solid #000;
            margin: 10px 0;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .section {
            width: 19%;
        }
        .group {
            border: 1px solid #000;
            padding: 10px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .team-info {
            width: 40%;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .vs {
            color: red;
            width: 80%;
            text-align: left    ;
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
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
                    <button>Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
        </div>
        <div class="section">
            <h2>Este</h2>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
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
                    <button>Detalles</button>
                </div>
            </div>
        </div>
    </div>
</Layaout:layaout>