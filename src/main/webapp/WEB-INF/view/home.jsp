<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Bienvenido">
    <style>
        body {
            background-color: #0c7da3; /* Color de fondo azulado */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .button-group {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 1.2em;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #6495ed;
            color: white;
        }
    </style>
    <div class="button-group">
        <button>Iniciar Sesion</button>
        <button>Registrarse</button>
        <button onClick="window.location.href='/noticias'">Entrar sin cuenta</button>
    </div>
</Layaout:layaout>