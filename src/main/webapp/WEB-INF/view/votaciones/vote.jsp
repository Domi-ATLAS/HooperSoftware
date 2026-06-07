<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Votación">

    <div class="sim-container">

        <h1>${votacion.categotiaVotacion}</h1>

        <p>
            Temporada:
            ${votacion.temporada}
        </p>

        <p>
            Jornada:
            ${votacion.jornada}
        </p>

        <p>
            Total votos:
            ${votacion.totalVotos}
        </p>

        <hr>

        <h3>Opciones</h3>

        <form action="/vote/${votacion.idVotacion}" method="post">

            <c:forEach var="opcion"
                    items="${opciones}">

                <div style="margin:10px 0;">

                    <input
                        type="radio"
                        name="opcion"
                        value="${opcion}"
                        required>

                    ${opcion}

                </div>

            </c:forEach>

            <input type="hidden"
                name="${_csrf.parameterName}"
                value="${_csrf.token}" />

            <br>

            <button class="search-btn">
                Votar
            </button>

        </form>
        <hr>

        <h2>Resultados actuales</h2>

        <c:forEach items="${resultados}" var="resultado">

            <p>
                ${resultado[0]}
                -
                ${resultado[1]} votos
            </p>

        </c:forEach>

    </div>

</Layaout:layaout>