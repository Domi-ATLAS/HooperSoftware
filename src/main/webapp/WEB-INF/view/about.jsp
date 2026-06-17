<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="Layaout" tagdir="/WEB-INF/tags" %>

<Layaout:layaout title="Acerca del proyecto">
  <%-- Vista frontend: explicación del alcance técnico y funcional del TFG. --%>

  <section class="about-page">
    <div class="about-hero">
      <p class="eyebrow">Trabajo de Fin de Grado</p>
      <h1>HooperSoftware</h1>
      <p>
        Aplicación web NBA desarrollada con Spring Boot, JSP y JavaScript para
        consultar datos deportivos, gestionar usuarios, explorar equipos y
        simular escenarios de competición.
      </p>
    </div>

    <div class="about-grid">
      <article class="about-card">
        <h2>Objetivo</h2>
        <p>
          Centralizar información NBA en una plataforma visual, responsive y
          navegable, combinando consulta de datos, interacción de usuarios y
          herramientas de análisis deportivo.
        </p>
      </article>

      <article class="about-card">
        <h2>Tecnologías</h2>
        <ul>
          <li>Spring Boot para controladores, servicios y seguridad.</li>
          <li>JSP, JSTL y tags reutilizables para las vistas.</li>
          <li>JavaScript para filtros, chat, embeds y comportamiento interactivo.</li>
          <li>Iframes controlados con fallback para integrar contenido externo cuando el proveedor lo permite.</li>
          <li>Conexión a API externa para el marcador NBA en directo desde la sección de noticias.</li>
          <li>CSS propio con paleta NBA, responsive y componentes compartidos.</li>
        </ul>
      </article>
    </div>

    <section class="about-section">
      <h2>Módulos principales</h2>
      <div class="feature-grid">
        <div class="feature-card">
          <strong>Equipos NBA</strong>
          <p>Fichas por franquicia con identidad visual, clasificación y accesos relacionados.</p>
        </div>
        <div class="feature-card">
          <strong>Partidos y playoffs</strong>
          <p>Listados por partido, jornada, temporada y eliminatorias con filtros de búsqueda.</p>
        </div>
        <div class="feature-card">
          <strong>Jugadores y entrenadores</strong>
          <p>Consulta de plantillas, perfiles individuales y filtrado por equipo.</p>
        </div>
        <div class="feature-card">
          <strong>Transferencias</strong>
          <p>Movimientos entre equipos con detalle, precio, rondas de draft y filtros por fecha.</p>
        </div>
        <div class="feature-card">
          <strong>Votaciones</strong>
          <p>Votaciones en curso, oficiales e histórico agrupado por temporada y categoría.</p>
        </div>
        <div class="feature-card">
          <strong>Simulaciones</strong>
          <p>Trade machine, predicción de playoffs, análisis de plantilla, bracket, temporada, partido en vivo, GM y dinastía.</p>
        </div>
        <div class="feature-card">
          <strong>Usuarios y seguridad</strong>
          <p>Registro, login, perfil, edición de cuenta, cambio de contraseña y vistas por rol.</p>
        </div>
        <div class="feature-card">
          <strong>Chat NBA</strong>
          <p>Chat global autenticado con envío de mensajes, refresco periódico y protección CSRF.</p>
        </div>
        <div class="feature-card">
          <strong>Datos externos</strong>
          <p>Scraping/sincronización administrativa, marcador NBA mediante API y contenido embebido con iframe y fallback.</p>
        </div>
      </div>
    </section>

    <section class="about-section">
      <h2>Integración de datos NBA</h2>
      <div class="about-list">
        <p>
          Se incorporó un marcador en vivo conectado a una API externa para
          consultar partidos y resultados recientes desde la propia aplicación.
        </p>
        <p>
          También se trabajó en la obtención de datos mediante scraping y
          procesos de sincronización administrativos para alimentar la base de datos.
        </p>
        <p>
          Durante el desarrollo se probó la API de Ball Don't Lie, pero sus
          límites de llamadas condicionaron su uso continuado, por lo que se
          mantuvieron alternativas internas y mecanismos de sincronización.
        </p>
      </div>
    </section>

    <section class="about-section">
      <h2>Mejoras de experiencia</h2>
      <div class="about-list">
        <p>Interfaz unificada con layout común, navegación global y carrusel de equipos.</p>
        <p>Filtros declarativos reutilizables en listados de partidos, temporadas, playoffs y transferencias.</p>
        <p>Estados vacíos, dashboard de inicio, diseño responsive y documentación JSDoc en JavaScript.</p>
        <p>Análisis explicable por equipo con métricas de plantilla, confianza y recomendación deportiva.</p>
      </div>
    </section>
  </section>
</Layaout:layaout>
