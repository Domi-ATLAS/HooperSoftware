<%@ tag description="Global Layout" %>
<%@ attribute name="title" required="true" rtexprvalue="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>${title}</title>

  <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script>
function runNbaScraping() {

  if (!confirm('Actualizar datos NBA por temporada?')) return;

  const token = document.querySelector('meta[name="_csrf"]').content;
  const header = document.querySelector('meta[name="_csrf_header"]').content;

  const season = document.getElementById("seasonSelect").value;

  // ✅ CORREGIDO: /all en lugar de /full
  fetch('/admin/sync/all?season=' + season, {
    method: 'POST',
    headers: { [header]: token }
  })
  .then(res => {
    if (!res.ok) throw new Error("Error " + res.status);
    return res.text();
  })
  .then(msg => {
    alert("✅ " + msg);
  })
  .catch(err => {
    alert("❌ Error: " + err.message);
  });
}
</script>

<body>
<header class="site-header">
  <nav class="nav">
    <div class="nav-left">
      <a class="logo-btn" href="/"><img src="/images/HS.png" alt="HS"></a>

      <button class="btn" onclick="location.href='/noticias'">Noticias</button>
      <button class="btn" onclick="location.href='/allTranferences'">Transferencias</button>
      <button class="btn" onclick="location.href='/allGames'">Partidos</button>
      <button class="btn" onclick="location.href='/allPlayOffs'">Play Offs</button>
      <button class="btn" onclick="location.href='/allVotes'">Votaciones</button>

      <sec:authorize access="isAuthenticated()">
        <button class="btn" onclick="location.href='/profile'">Perfil</button>
      </sec:authorize>

      <button class="btn" onclick="location.href='/buscador'">Buscador</button>
      <button class="btn" onclick="location.href='/allPlayers'">Jugadores | Entrenadores</button>

      <sec:authorize access="hasAuthority('admin')">
        <button class="btn" onclick="location.href='/simulaciones'">
          Simulaciones
        </button>
      </sec:authorize>

      <!-- 🔥 SELECTOR DE TEMPORADA -->
      <sec:authorize access="hasAuthority('admin')">
        <select id="seasonSelect" class="btn">
          <option value="2024">2024</option>
          <option value="2023">2023</option>
          <option value="2022">2022</option>
        </select>
      </sec:authorize>

      <!-- 🔥 BOTÓN -->
      <sec:authorize access="hasAuthority('admin')">
        <button class="btn btn-admin"
                onclick="runNbaScraping()"
                title="Actualizar datos NBA">
           Actualizar NBA
        </button>
      </sec:authorize>

    </div>

    <div class="nav-right">
      <sec:authorize access="!isAuthenticated()">
        <button class="btn" onclick="location.href='/login'">Iniciar sesión</button>
        <button class="btn" onclick="location.href='/new'">Registrarse</button>
      </sec:authorize>

      <sec:authorize access="isAuthenticated()">
        <a class="btn" href="/logout">Cerrar sesión</a>
      </sec:authorize>
    </div>
  </nav>

  <!-- equipos (sin tocar) -->
  <div class="teams-strip">
    <!-- lo de equipos lo dejamos igual -->
  </div>
</header>

<main class="site-main">
  <div class="container">
    <jsp:doBody/>
  </div>
</main>

<footer class="site-footer">
  <p>Correo: hooperSoftware@gmail.com · Tlf: 623 126 742</p>
</footer>
</body>
</html>