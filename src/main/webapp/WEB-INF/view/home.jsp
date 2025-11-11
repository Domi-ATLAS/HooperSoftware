<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Bienvenido">
  <div class="center-page">
    <div class="stack">
      <button class="btn" onclick="location.href='/login'">Iniciar sesión</button>
      <button class="btn" onclick="location.href='/new'">Registrarse</button>
      <button class="btn" onclick="location.href='/noticias'">Entrar sin cuenta</button>
    </div>
  </div>
</Layaout:layaout>
