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

  <!-- CSS global -->
  <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<script>
  function runNbaScraping() {
    if (!confirm('Esto actualizará los datos NBA desde fuentes externas.\n¿Deseas continuar?')) {
      return;
    }

    fetch('/admin/scrape/nba/full', {
      method: 'POST',
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(res => {
      if (!res.ok) throw new Error('Error ' + res.status);
      return res.text();
    })
    .then(msg => {
      alert('Scraping iniciado correctamente.\n\n' + msg);
    })
    .catch(err => {
      alert('Error al ejecutar el scraping:\n' + err.message);
    });
  }
</script>
<body>
  <!-- Header principal -->
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
          <button class="btn" onclick="location.href='/allPlayers'">Simulaciones</button>
        </sec:authorize>
        <sec:authorize access="hasAuthority('admin')">
          <button class="btn btn-admin"
                  onclick="runNbaScraping()"
                  title="Actualizar datos NBA desde Basketball Reference">
             Actualizar datos NBA
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

    <!-- Cinta de equipos -->
    <div class="teams-strip">
      <button class="icon-btn" onclick="location.href='/equipos/ChicagoBulls'"><img src="/images/bulls.png" alt="ChicagoBulls"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BostonCeltics'"><img src="/images/boston.png" alt="BostonCeltics"></button>
      <button class="icon-btn" onclick="location.href='/equipos/IndianaPacers'"><img src="/images/pacers.png" alt="IndianaPacers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MilwaukeeBucks'"><img src="/images/bucks.png" alt="MilwaukeeBucks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DetroitPistons'"><img src="/images/pistons.png" alt="DetroitPistons"></button>
      <button class="icon-btn" onclick="location.href='/equipos/ClevelandCavaliers'"><img src="/images/cavs.png" alt="ClevelandCavaliers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/TorontoRaptors'"><img src="/images/raps.png" alt="TorontoRaptors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BrooklynNets'"><img src="/images/nets.png" alt="BrooklynNets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewYorkKnicks'"><img src="/images/knicks.png" alt="NewYorkKnicks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/Philadelphia76ers'"><img src="/images/six.png" alt="Philadelphia76ers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/WashingtonWizards'"><img src="/images/wizz.png" alt="WashingtonWizards"></button>
      <button class="icon-btn" onclick="location.href='/equipos/CharlotteHornets'"><img src="/images/hornets.png" alt="CharlotteHornets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/AtlantaHawks'"><img src="/images/atl.png" alt="AtlantaHawks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OrlandoMagic'"><img src="/images/orlando.png" alt="OrlandoMagic"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MiamiHeat'"><img src="/images/heat.png" alt="MiamiHeat"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SacramentoKings'"><img src="/images/kings.png" alt="SacramentoKings"></button>
      <button class="icon-btn" onclick="location.href='/equipos/GoldenStateWarriors'"><img src="/images/golden state.png" alt="GoldenStateWarriors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesClippers'"><img src="/images/clippers.png" alt="LosAngelesClippers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesLakers'"><img src="/images/lakers.png" alt="LosAngelesLakers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SanAntonioSpurs'"><img src="/images/spurs.png" alt="SanAntonioSpurs"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DallasMavericks'"><img src="/images/mavsss.png" alt="DallasMavericks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewOrleansPelicans'"><img src="/images/pel.png" alt="NewOrleansPelicans"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OklahomaCityThunder'"><img src="/images/thunder.png" alt="OklahomaCityThunder"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PhoenixSuns'"><img src="/images/suns.png" alt="PhoenixSuns"></button>
      <button class="icon-btn" onclick="location.href='/equipos/UtahJazz'"><img src="/images/jazz.png" alt="UtahJazz"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DenverNuggets'"><img src="/images/nuggets.png" alt="DenverNuggets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PortlandTrailBlazers'"><img src="/images/trail.png" alt="PortlandTrailBlazers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/timber.png" alt="MinnesotaTimberwolves"></button>
      <button class="icon-btn" onclick="location.href='/equipos/HoustonRockets'"><img src="/images/rockets.png" alt="HoustonRockets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MemphisGrizzlies'"><img src="/images/memphs.png" alt="MemphisGrizzlies"></button>
    </div>
  </header>

  <!-- Contenido -->
  <main class="site-main">
    <div class="container">
      <jsp:doBody/>
    </div>
  </main>

  <!-- Footer -->
  <footer class="site-footer">
    <p>Correo: hooperSoftware@gmail.com · Tlf: 623 126 742</p>
  </footer>
</body>
</html>
