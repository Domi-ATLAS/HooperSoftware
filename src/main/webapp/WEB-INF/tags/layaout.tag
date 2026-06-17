<%@ tag description="Global Layout" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="true" rtexprvalue="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <%-- Cabecera compartida: carga estilos globales, JS de filtros y metadatos responsive. --%>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>${title}</title>

  <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
  <script src="<c:url value='/js/data_filters.js'/>" defer></script>
</head>

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<script>
// Acción administrativa global: sincroniza datos NBA para la temporada seleccionada.
/**
 * Lanza la sincronización administrativa de datos NBA para la temporada seleccionada.
 * @returns {void}
 */
function runNbaScraping() {

  if (!confirm('Actualizar datos NBA por temporada?')) return;

  const token = document.querySelector('meta[name="_csrf"]').content;
  const header = document.querySelector('meta[name="_csrf_header"]').content;

  const season = document.getElementById("seasonSelect").value;

  // Ruta de sincronizacion global
  fetch('/admin/sync/all?season=' + season, {
    method: 'POST',
    headers: { [header]: token }
  })
  .then(res => {
    if (!res.ok) throw new Error("Error " + res.status);
    return res.text();
  })
  .then(msg => {
    alert("Actualizacion completada: " + msg);
  })
  .catch(err => {
    alert("Error: " + err.message);
  });
}
</script>

<body>
<header class="site-header">
  <%-- Navegación principal: accesos de la aplicación y botones condicionados por seguridad. --%>
  <nav class="nav">
    <div class="nav-left">
      <a class="logo-btn"  onclick="location.href='/welcome'"><img src="/images/HS.png" alt="HS"></a>

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
      <button class="btn" onclick="location.href='/about'">Proyecto</button>

      <sec:authorize access="hasAuthority('admin')">
        <button class="btn" onclick="location.href='/simulaciones'">
          Simulaciones
        </button>
      </sec:authorize>

      <!-- Selector de temporada -->
      <sec:authorize access="hasAuthority('admin')">
        <select id="seasonSelect" class="btn">
          <option value="2024">2024</option>
          <option value="2023">2023</option>
          <option value="2022">2022</option>
          <option value="2021">2021</option>
          <option value="2020">2020</option>
          <option value="2019">2019</option>
          <option value="2018">2018</option>
          <option value="2017">2017</option>
          <option value="2016">2016</option>
          <option value="2015">2015</option>
          <option value="2014">2014</option>
          <option value="2013">2013</option>
          <option value="2012">2012</option>
          <option value="2011">2011</option>
          <option value="2010">2010</option>
          <option value="2009">2009</option>
          <option value="2008">2008</option>
          <option value="2007">2007</option>
          <option value="2006">2006</option>
          <option value="2005">2005</option>
          <option value="2004">2004</option>
          <option value="2003">2003</option>
          <option value="2002">2002</option>
          <option value="2001">2001</option>
          <option value="2000">2000</option>
          <option value="1999">1999</option>
          <option value="1998">1998</option>
        </select>
      </sec:authorize>

      <!-- Boton de actualizacion -->
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

   <%-- Carrusel horizontal de equipos: acceso rápido desde cualquier vista. --%>
   <div class="teams-strip">
      <button class="icon-btn" onclick="location.href='/equipos/ChicagoBulls'"><img src="/images/CHI.png" alt="ChicagoBulls"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BostonCeltics'"><img src="/images/BOS.png" alt="BostonCeltics"></button>
      <button class="icon-btn" onclick="location.href='/equipos/IndianaPacers'"><img src="/images/IND.png" alt="IndianaPacers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MilwaukeeBucks'"><img src="/images/MIL.png" alt="MilwaukeeBucks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DetroitPistons'"><img src="/images/DET.png" alt="DetroitPistons"></button>
      <button class="icon-btn" onclick="location.href='/equipos/ClevelandCavaliers'"><img src="/images/CLE.png" alt="ClevelandCavaliers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/TorontoRaptors'"><img src="/images/TOR.png" alt="TorontoRaptors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/BrooklynNets'"><img src="/images/BKN.png" alt="BrooklynNets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewYorkKnicks'"><img src="/images/NYK.png" alt="NewYorkKnicks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/Philadelphia76ers'"><img src="/images/PHI.png" alt="Philadelphia76ers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/WashingtonWizards'"><img src="/images/WAS.png" alt="WashingtonWizards"></button>
      <button class="icon-btn" onclick="location.href='/equipos/CharlotteHornets'"><img src="/images/CHA.png" alt="CharlotteHornets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/AtlantaHawks'"><img src="/images/atl.png" alt="AtlantaHawks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OrlandoMagic'"><img src="/images/ORL.png" alt="OrlandoMagic"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MiamiHeat'"><img src="/images/MIA.png" alt="MiamiHeat"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SacramentoKings'"><img src="/images/SAC.png" alt="SacramentoKings"></button>
      <button class="icon-btn" onclick="location.href='/equipos/GoldenStateWarriors'"><img src="/images/GSW.png" alt="GoldenStateWarriors"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesClippers'"><img src="/images/LAC.png" alt="LosAngelesClippers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/LosAngelesLakers'"><img src="/images/LAL.png" alt="LosAngelesLakers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/SanAntonioSpurs'"><img src="/images/SAS.png" alt="SanAntonioSpurs"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DallasMavericks'"><img src="/images/DAL.png" alt="DallasMavericks"></button>
      <button class="icon-btn" onclick="location.href='/equipos/NewOrleansPelicans'"><img src="/images/NOP.png" alt="NewOrleansPelicans"></button>
      <button class="icon-btn" onclick="location.href='/equipos/OklahomaCityThunder'"><img src="/images/OKC.png" alt="OklahomaCityThunder"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PhoenixSuns'"><img src="/images/PHX.png" alt="PhoenixSuns"></button>
      <button class="icon-btn" onclick="location.href='/equipos/UtahJazz'"><img src="/images/UTA.png" alt="UtahJazz"></button>
      <button class="icon-btn" onclick="location.href='/equipos/DenverNuggets'"><img src="/images/DEN.png" alt="DenverNuggets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/PortlandTrailBlazers'"><img src="/images/POR.png" alt="PortlandTrailBlazers"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/MIN.png" alt="MinnesotaTimberwolves"></button>
      <button class="icon-btn" onclick="location.href='/equipos/HoustonRockets'"><img src="/images/HOU.png" alt="HoustonRockets"></button>
      <button class="icon-btn" onclick="location.href='/equipos/MemphisGrizzlies'"><img src="/images/MEM.png" alt="MemphisGrizzlies"></button>
    </div>
</header>

<main class="site-main">
  <%-- Punto de inserción del contenido propio de cada JSP. --%>
  <div class="container">
    <jsp:doBody/>
  </div>
</main>

<footer class="site-footer">
  <p>Correo: hooperSoftware@gmail.com · Tlf: 623 126 742</p>
</footer>

<sec:authorize access="isAuthenticated()">

<%-- Chat global flotante: solo se renderiza para usuarios autenticados. --%>
<div id="chat-toggle">

    Chat NBA

</div>

<div id="chat-window">

    <div class="chat-header">

        Chat Global NBA

        <span id="chat-close" style="cursor:pointer;">X</span>

    </div>

    <div id="chat-messages">

        Cargando...

    </div>

    <form id="chat-form">

        <input
            type="text"
            id="chat-input"
            placeholder="Escribe un mensaje..."
            maxlength="300">

        <button type="submit">
            Enviar
        </button>

    </form>

</div>

<script>

// Abre el panel y carga los mensajes iniciales.
document
.getElementById("chat-toggle")
.addEventListener("click", () => {

    document
        .getElementById("chat-window")
        .style.display = "flex";

    cargarMensajes();

});

// Cierra el panel sin perder el estado del resto de la vista.
document
.getElementById("chat-close")
.addEventListener("click", () => {

    document
        .getElementById("chat-window")
        .style.display = "none";

});

// Recupera mensajes del backend y los pinta en orden cronológico visual.
/**
 * Carga los mensajes del chat global y actualiza el panel visible.
 * @returns {Promise<void>}
 */
async function cargarMensajes() {

    const response = await fetch("/chat/messages");

    const mensajes = await response.json();

    const container =
        document.getElementById("chat-messages");

    container.innerHTML = "";

    mensajes.reverse().forEach(m => {

        const div = document.createElement("div");

        div.style.padding = "10px";
        div.style.marginBottom = "10px";
        div.style.borderBottom = "1px solid #ddd";
        div.style.display = "flex";
        div.style.alignItems = "flex-start";
        div.style.gap = "10px";

        div.innerHTML =
            "<div class='chat-message-content'>" +

            "<b>" + m.username + "</b><br>" +

            m.mensaje +

            "</div>";

        container.appendChild(div);

    });

    container.scrollTop =
        container.scrollHeight;

}

// Envía un mensaje usando el token CSRF de la página.
/**
 * Envía un mensaje al chat global usando el token CSRF de la página.
 * @param {string} texto Texto escrito por el usuario.
 * @returns {Promise<void>}
 */
async function enviarMensaje(texto){

    const token =
        document
            .querySelector('meta[name="_csrf"]')
            .content;

    const header =
        document
            .querySelector('meta[name="_csrf_header"]')
            .content;

    const params =
        new URLSearchParams();

    params.append("mensaje", texto);

    await fetch("/chat/send",{

        method:"POST",

        headers:{
            [header]:token,
            "Content-Type":
            "application/x-www-form-urlencoded"
        },

        body:params

    });

    cargarMensajes();

}

// Refresco periódico solo mientras el chat está abierto.
setInterval(() => {

    const abierto =
        document
            .getElementById("chat-window")
            .style.display === "flex";

    if(abierto){

        cargarMensajes();

    }

},5000);

// Valida el formulario del chat y evita enviar mensajes vacíos.
document
.getElementById("chat-form")
.addEventListener("submit",
async function(e){

    e.preventDefault();

    const input =
        document.getElementById("chat-input");

    const texto =
        input.value.trim();

    if(texto===""){

        return;

    }

    await enviarMensaje(texto);

    input.value="";

});

</script>

</sec:authorize>
</body>
</html>
