<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Perfil">
    <div class="block">

            
            <h1 class="title">Perfil de <c:out value="${usuario.getUsername()}"/></h1>
            <c:if test="${succes}">
                <div id="succes">
                    <div class="succes-notification">
                        <span>Perfil actualizado correctamente</span>
                        <button class="close-button">×</button>
                    </div>
                </div>
            </c:if>
            <p class="perfil">Nombre: <c:out value="${usuario.getNombreUsuario()}"/></p>
            <p class="perfil">Email: <c:out value="${usuario.getCorreo()}"/></p>
            <!-- <div class="block">
                <table class="statistics-table">
                    <thead>
                        <tr>
                            <th colspan="2">Estadísticas del jugador en partidas en solitario</th>
                        </tr>
                    </thead>
                    <tr>
                        <td>Número de partidas:</td>
                        <td class="left"><c:out value="${userGames}" /></td>
                    </tr>
                    <tr>
                        <td>Número de victorias:</td>
                        <td class="left"><c:out value="${userWins1}" /></td>
                    </tr>
                    <tr>
                        <td>Porcentaje de victorias:</td>
                        <td class="left"><c:out value="${uwr}"/>%</td>
                    </tr>
                    <tr>
                        <td>Victorias en un intento:</td>
                        <td class="left"><c:out value="${userWinsWithOneShift}" /></td>
                    </tr>
                    <tr>
                        <td>Victorias en dos intentos:</td>
                        <td class="left"><c:out value="${userWinsWithTwoShifts}" /></td>
                    </tr>
                    <tr>
                        <td>Victorias en tres intentos:</td>
                        <td class="left"><c:out value="${userWinsWithThreeShifts}" /></td>
                    </tr>
                    <tr>
                        <td>Victorias en cuatro intentos:</td>
                        <td class="left"><c:out value="${userWinsWithFourShifts}" /></td>
                    </tr>
                    <tr>
                        <td>Media de intentos para ganar:</td>
                        <td class="left"><c:out value="${userAverageShiftsToWin}" /></td>
                    </tr>
                </table>
            </div>
                <div class="block">
                    <table class="statistics-table">
                        <thead>
                            <th colspan="2">Estadísticas del jugador en partidas en línea</th>
                        </thead>
                        <tr>
                            <td>Número de partidas:</td>
                            <td class="left"><c:out value="${userOnlineGames}" /></td>
                        </tr>
                        <tr>
                            <td>Número de victorias:</td>
                            <td class="left"><c:out value="${userWins}" /></td>
                        </tr>
                        <tr>
                            <td>Número de victorias perfectas:</td>
                            <td class="left"><c:out value="${userPerfectWins}" /></td>
                        </tr>
                        <tr>
                            <td>Media de intentos para ganar :</td>
                            <td class="left"><c:out value="${userAverageOfShiftsToWinByPlayer1}" /></td>
                        </tr>
                        <tr>
                            <td>Tasa de victorias:</td>
                            <td class="left"><c:out value="${userWinRate}" /></td>
                        </tr>
                        <tr>
                            <td>Tasa de victorias perfectas:</td>
                            <td class="left"><c:out value="${perfectWinRate}" /></td>
                        </tr>
                    </table>
                </div> -->
            <div class="block">
                    <c:if test="${usuario.getUsername()==principal.getName()}">
                        <a href="/usuario/edit" class="buttom">Editar mi perfil</a>
                    </c:if>
                    <c:if test="${player.getUsername()==principal.getName()}">
                        <a href="/usuario/changePassword" class="buttom">Cambiar mi contraseña</a>
                    </c:if>
            </div>
        </div>
</Layaout:layaout>


