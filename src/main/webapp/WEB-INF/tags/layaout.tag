<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ tag description="Global Layout" %>
<%@ attribute name="title" required="true" rtexprvalue="true" description="Layaout to explore all, always" %>


<!DOCTYPE html>
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
            <button>Seccion 9</button>
        </div>
    </header>

    <div>
        <button onClick="window.location.href='/equipos/ChicagoBulls'"><img src="/images/bulls.png" alt="Imagen 1"></button>
        <button onClick="window.location.href='/equipos/BostonCeltics'"><img src="/images/boston.jpg" alt="Imagen 2"></button>
        <button onClick="window.location.href='/equipos/IndianaPacers'"><img src="/images/pacers.jpg" alt="Imagen 3"></button>
        <button onClick="window.location.href='/equipos/MilwaukeeBucks'"><img src="/images/bucks.png" alt="Imagen 4"></button>
        <button onClick="window.location.href='/equipos/DetroitPistons'"><img src="/images/pistons.png" alt="Imagen 5"></button>
        <button onClick="window.location.href='/equipos/ClevelandCavaliers'"><img src="/images/cavs.jpg" alt="Imagen 6"></button>
        <button onClick="window.location.href='/equipos/TorontoRaptors'"><img src="/images/raps.png" alt="Imagen 7"></button>
        <button onClick="window.location.href='/equipos/BrooklynNets'"><img src="/images/nets.png" alt="Imagen 8"></button>
        <button onClick="window.location.href='/equipos/NewYorkKnicks'"><img src="/images/knicks.jpg" alt="Imagen 9"></button>
        <button onClick="window.location.href='/equipos/Philadelphia76ers'"><img src="/images/six.png" alt="Imagen 10"></button>
        <button onClick="window.location.href='/equipos/WashingtonWizards'"><img src="/images/wizz.png" alt="Imagen 11"></button>
        <button onClick="window.location.href='/equipos/CharlotteHornets'"><img src="/images/hornets.png" alt="Imagen 12"></button>
        <button onClick="window.location.href='/equipos/AtlantaHawks'"><img src="/images/atl.png" alt="Imagen 13"></button>
        <button onClick="window.location.href='/equipos/OrlandoMagic'"><img src="/images/orlando.png" alt="Imagen 14"></button>
        <button onClick="window.location.href='/equipos/MiamiHeat'"><img src="/images/heats.png" alt="Imagen 15"></button>
        <button onClick="window.location.href='/equipos/SacramentoKings'"><img src="/images/kings.png" alt="Imagen 16"></button>
        <button onClick="window.location.href='/equipos/GoldenStateWarriors'"><img src="/images/goldenstate.jpg" alt="Imagen 17"></button>
        <button onClick="window.location.href='/equipos/LosAngelesClippers'"><img src="/images/clippers.png" alt="Imagen 18"></button>
        <button onClick="window.location.href='/equipos/LosAngelesLakers'"><img src="/images/lakers.png" alt="Imagen 19"></button>
        <button onClick="window.location.href='/equipos/SanAntonioSpurs'"><img src="/images/spurs.jpg" alt="Imagen 20"></button>
        <button onClick="window.location.href='/equipos/DallasMavericks'"><img src="/images/mavs.png" alt="Imagen 21"></button>
        <button onClick="window.location.href='/equipos/NewOrleansPelicans'"><img src="/images/pel.png" alt="Imagen 22"></button>
        <button onClick="window.location.href='/equipos/OklahomaCityThunder'"><img src="/images/thunder.jpg" alt="Imagen 23"></button>
        <button onClick="window.location.href='/equipos/PhoenixSuns'"><img src="/images/suns.png" alt="Imagen 24"></button>
        <button onClick="window.location.href='/equipos/UtahJazz'"><img src="/images/jazz.png" alt="Imagen 25"></button>
        <button onClick="window.location.href='/equipos/DenverNuggets'"><img src="/images/nuggets.png" alt="Imagen 26"></button>
        <button onClick="window.location.href='/equipos/PortlandTrailBlazers'"><img src="/images/trail.png" alt="Imagen 27"></button>
        <button onClick="window.location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/timber.jpg" alt="Imagen 28"></button>
        <button onClick="window.location.href='/equipos/HoustonRockets'"><img src="/images/rockets.png" alt="Imagen 29"></button>
        <button onClick="window.location.href='/equipos/MemphisGrizzlies'"><img src="/images/memphs.jpg" alt="Imagen 30"></button>
    </div>

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