<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Bienvenido">
    <style>
        body {
            background-color: #ffffff; /* Color de fondo azulado */
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
            display: inline-block;
            padding: 2px 2px;
            font-size: 24px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #000000;
            background-color: #1D428A;
            border: 4px;
            border-style: outset;
            border-color: black;
            font-family: fantasy;
            font: Copperplate, Papyrus, fantasy;
        }
        button:hover {background-color: #5276be}
    
        button:active {
        background-color: #5276be;
        box-shadow: 0 5px #666;
        transform: translateY(4px);
        }
    </style>
    <div class="button-group">
        <button onClick="window.location.href='/login'">Iniciar Sesion</button>
        <button onClick="window.location.href='/new'">Registrarse</button>
        <button onClick="window.location.href='/noticias'">Entrar sin cuenta</button>
    </div>
</Layaout:layaout>