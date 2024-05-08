<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<Layaout:layaout title="Noticias de Baloncesto">
    <style>
        .container {
            display: flex;
        }
        .noticias {
            flex: 70%;
            padding: 10px;
        }
        .derecha {
            flex: 30%;
            padding: 10px;
            border-left: 1px solid #000;
        }
        .marcador, .chat {
            padding: 10px;
        }
    </style>

    <div class="container">
        <div class="noticias">
            <h1>Noticias</h1>
            
            <div>
                <h2>Niveles de los playoffs de la NBA de 2024: ¿Cómo se comparan los ocho equipos restantes?</h2>
                <p>Kevin Pelton, insider de la NBA de ESPN, coloca a los ocho equipos restantes de los playoffs en cinco niveles. ¿Cuántos están en el Nivel 1?</p>
                <p>Fecha: 06/05/2024</p>
            </div>

            <div>
                <h2>MVP de la NBA 2024: ¿Luke podrá ganarle el premio a Jokic y SGA?</h2>
                <p>A medida que avanzan los playoffs de la NBA, se espera que pronto se anuncie premio al Jugador Más Valioso de la NBA 2023-24. Los finalistas de esta temporada son el pívot de los Denver Nuggets, Nikola Jokic, el base de los Dallas Mavericks, Luka Doncic, y el base de los Oklahoma City Thunder, Shai Gilgeous-Alexander.</p>
                <p>Fecha: 02/05/2024</p>
            </div>

            <!-- Agrega más noticias de la misma manera -->
        </div>

        <div class="derecha">
            <div class="marcador">
                <!-- Aquí irá el marcador en el futuro -->
                <h2>Marcador</h2>
                <p>Marcador en construcción...</p>
            </div>

            <div class="chat">
                <!-- Aquí irá el chat en el futuro -->
                <h2>Chat</h2>
                <p>Chat en construcción...</p>
            </div>
        </div>
    </div>
</Layaout:layaout>