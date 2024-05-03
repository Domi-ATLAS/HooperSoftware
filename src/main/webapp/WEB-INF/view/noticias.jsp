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
                <h2>Titulo de la Noticia 1</h2>
                <p>Contenido de la Noticia 1...</p>
                <p>Fecha: 01/01/2022</p>
            </div>

            <div>
                <h2>Titulo de la Noticia 2</h2>
                <p>Contenido de la Noticia 2...</p>
                <p>Fecha: 02/01/2022</p>
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