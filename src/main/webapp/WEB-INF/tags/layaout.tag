<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ tag description="Global Layout" %>
<%@ attribute name="title" required="true" rtexprvalue="true" description="Layaout to explore all, always" %>


<!DOCTYPE html>
<style>
    header {
        position: fixed; /* Esto hace que el encabezado se mantenga en la misma posición incluso al desplazarse */
        top: 0; /* Esto coloca el encabezado en la parte superior de la página */
        left: 0; /* Esto alinea el encabezado a la izquierda */
        width: 100%; /* Esto asegura que el encabezado se extienda a lo largo de toda la página */
        z-index: 1000; /* Esto asegura que el encabezado siempre esté en la parte superior de otros elementos */
    }
    body {
        font-family: fantasy;
        font: Copperplate, Papyrus, fantasy;
        padding-top: 260px; 
        padding-bottom: 100px;
        text-shadow: 2px 2px 5px #54c791;
        background-color: #0c7da3; /* Color de fondo azulado */
    }
    footer {
        position: fixed; /* Esto hace que el pie de página se mantenga en la misma posición incluso al desplazarse */
        bottom: 0; /* Esto coloca el pie de página en la parte inferior de la página */
        width: 100%; /* Esto asegura que el pie de página se extienda a lo largo de toda la página */
        text-align: center; /* Esto centra el texto dentro del pie de página */
        z-index: 1000; /* Esto asegura que el pie de página siempre esté en la parte superior de otros elementos */
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
        background-color: #04AA6D;
        border: 4px;
        border-style: outset;
        border-color: black;
        font-family: fantasy;
        font: Copperplate, Papyrus, fantasy;
        text-shadow: 2px 2px 5px #0c7da3;
    }
    button:hover {background-color: #3e8e41}

    button:active {
    background-color: #3e8e41;
    box-shadow: 0 5px #666;
    transform: translateY(4px);
    }
</style>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <title>${title}</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <header>
        <div>
            <button><img src="/images/HS.png"></button>
            <button onClick="window.location.href='/noticias'">Noticias</button>
            <button onClick="window.location.href='/allTranferences'">Transferencias</button>
            <button onClick="window.location.href='/allGames'">Partidos</button>            
            <button onClick="window.location.href='/allPlayOffs'">Play Offs</button>
            <button onClick="window.location.href='/allVotes'">Votaciones</button>
            <button>Perfil</button>
            <button>Buscador</button>
            <button onClick="window.location.href='/allPlayers'">Jugadores | Entrenadores</button>
        </div>
    

        <div>
            <button onClick="window.location.href='/equipos/ChicagoBulls'"><img src="/images/bulls.png" alt="ChicagoBulls"></button>
            <button onClick="window.location.href='/equipos/BostonCeltics'"><img src="/images/boston.jpg" alt="BostonCeltics"></button>
            <button onClick="window.location.href='/equipos/IndianaPacers'"><img src="/images/pacers.jpg" alt="IndianaPacers"></button>
            <button onClick="window.location.href='/equipos/MilwaukeeBucks'"><img src="/images/bucks.png" alt="MilwaukeeBucks"></button>
            <button onClick="window.location.href='/equipos/DetroitPistons'"><img src="/images/pistons.png" alt="DetroitPistons"></button>
            <button onClick="window.location.href='/equipos/ClevelandCavaliers'"><img src="/images/cavs.jpg" alt="ClevelandCavaliers"></button>
            <button onClick="window.location.href='/equipos/TorontoRaptors'"><img src="/images/raps.png" alt="TorontoRaptors"></button>
            <button onClick="window.location.href='/equipos/BrooklynNets'"><img src="/images/nets.png" alt="BrooklynNets"></button>
            <button onClick="window.location.href='/equipos/NewYorkKnicks'"><img src="/images/knicks.jpg" alt="NewYorkKnicks"></button>
            <button onClick="window.location.href='/equipos/Philadelphia76ers'"><img src="/images/six.png" alt="Philadelphia76ers"></button>
            <button onClick="window.location.href='/equipos/WashingtonWizards'"><img src="/images/wizz.png" alt="WashingtonWizards"></button>
            <button onClick="window.location.href='/equipos/CharlotteHornets'"><img src="/images/hornets.png" alt="CharlotteHornets"></button>
            <button onClick="window.location.href='/equipos/AtlantaHawks'"><img src="/images/atl.png" alt="AtlantaHawks"></button>
            <button onClick="window.location.href='/equipos/OrlandoMagic'"><img src="/images/orlando.png" alt="OrlandoMagic"></button>
            <button onClick="window.location.href='/equipos/MiamiHeat'"><img src="/images/heats.png" alt="MiamiHeat"></button>
            <button onClick="window.location.href='/equipos/SacramentoKings'"><img src="/images/kings.png" alt="SacramentoKings"></button>
            <button onClick="window.location.href='/equipos/GoldenStateWarriors'"><img src="/images/goldenstate.jpg" alt="GoldenStateWarriors"></button>
            <button onClick="window.location.href='/equipos/LosAngelesClippers'"><img src="/images/clippers.png" alt="LosAngelesClippers"></button>
            <button onClick="window.location.href='/equipos/LosAngelesLakers'"><img src="/images/lakers.png" alt="LosAngelesLakers"></button>
            <button onClick="window.location.href='/equipos/SanAntonioSpurs'"><img src="/images/spurs.jpg" alt="SanAntonioSpurs"></button>
            <button onClick="window.location.href='/equipos/DallasMavericks'"><img src="/images/mavs.png" alt="DallasMavericks"></button>
            <button onClick="window.location.href='/equipos/NewOrleansPelicans'"><img src="/images/pel.png" alt="NewOrleansPelicans"></button>
            <button onClick="window.location.href='/equipos/OklahomaCityThunder'"><img src="/images/thunder.jpg" alt="OklahomaCityThunder"></button>
            <button onClick="window.location.href='/equipos/PhoenixSuns'"><img src="/images/suns.png" alt="PhoenixSuns"></button>
            <button onClick="window.location.href='/equipos/UtahJazz'"><img src="/images/jazz.png" alt="UtahJazz"></button>
            <button onClick="window.location.href='/equipos/DenverNuggets'"><img src="/images/nuggets.png" alt="DenverNuggets"></button>
            <button onClick="window.location.href='/equipos/PortlandTrailBlazers'"><img src="/images/trail.png" alt="PortlandTrailBlazers"></button>
            <button onClick="window.location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/timber.jpg" alt="MinnesotaTimberwolves"></button>
            <button onClick="window.location.href='/equipos/HoustonRockets'"><img src="/images/rockets.png" alt="HoustonRockets"></button>
            <button onClick="window.location.href='/equipos/MemphisGrizzlies'"><img src="/images/memphs.jpg" alt="MemphisGrizzlies"></button>
        </div>
    </header>

    <div class="content">
        <div class="doBody">
          <div class="theBody">
            <jsp:doBody />
          </div>
        </div>
    </div>

    <footer>
        <div>
            <p>Correo de contacto: hooperSoftware@gmail.com Tlf: 623 126 742</p>
        </div>
    </footer>
</body>
</html>