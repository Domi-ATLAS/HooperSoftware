<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ tag description="Global Layout" %>
<%@ attribute name="title" required="true" rtexprvalue="true" description="Layaout to explore all, always" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
 <style>
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        body {
            font-family: fantasy;
            font: Copperplate, Papyrus, fantasy;
            padding-top: 260px; 
            padding-bottom: 100px;
            background-color: #ffffff;
        }
        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            z-index: 1000;
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
        }
        button:hover {background-color: #5276be}
        button:active {
            background-color: #5276be;
            box-shadow: 0 5px #666;
            transform: translateY(4px);
        }
        .left-buttons, .right-buttons {
            display: flex;
            gap: 10px;
        }
         #secondary-header {
            top: 70px; /* Adjust this value to match the height of your primary header */
        }
    </style>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <title>${title}</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <header id="primary-header">
        <div class="left-buttons">
            <button><img src="/images/HS.png"></button>
            <button onClick="window.location.href='/noticias'">Noticias</button>
            <button onClick="window.location.href='/allTranferences'">Transferencias</button>
            <button onClick="window.location.href='/allGames'">Partidos</button>            
            <button onClick="window.location.href='/allPlayOffs'">Play Offs</button>
            <button onClick="window.location.href='/allVotes'">Votaciones</button>
            <sec:authorize access="isAuthenticated()">
                <button onClick="window.location.href='/profile'">Perfil</button>
            </sec:authorize>
            <button>Buscador</button>
            <button onClick="window.location.href='/allPlayers'">Jugadores | Entrenadores</button>
              <sec:authorize access="hasAuthority('admin')">
                <button onClick="window.location.href='/allPlayers'">Simulaciones</button>
            </sec:authorize>    
        </div>
        <div class="right-buttons">
            <sec:authorize access="!isAuthenticated()">
                <button onClick="window.location.href='/login'">Iniciar Sesion</button>
                <button onClick="window.location.href='/new'">Registrarse</button>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
            <button><a class="cerrar-link" href="/logout"><i class="fas fa-sign-in-alt"></i> Cerrar sesi&oacute;n</a></button>
            </sec:authorize>
        </div>
    

        
    </header>
<header id="secondary-header">
    <div >
            <button onClick="window.location.href='/equipos/ChicagoBulls'"><img src="/images/bulls.png" alt="ChicagoBulls"></button>
            <button onClick="window.location.href='/equipos/BostonCeltics'"><img src="/images/boston.png" alt="BostonCeltics"></button>
            <button onClick="window.location.href='/equipos/IndianaPacers'"><img src="/images/pacers.png" alt="IndianaPacers"></button>
            <button onClick="window.location.href='/equipos/MilwaukeeBucks'"><img src="/images/bucks.png" alt="MilwaukeeBucks"></button>
            <button onClick="window.location.href='/equipos/DetroitPistons'"><img src="/images/pistons.png" alt="DetroitPistons"></button>
            <button onClick="window.location.href='/equipos/ClevelandCavaliers'"><img src="/images/cavs.png" alt="ClevelandCavaliers"></button>
            <button onClick="window.location.href='/equipos/TorontoRaptors'"><img src="/images/raps.png" alt="TorontoRaptors"></button>
            <button onClick="window.location.href='/equipos/BrooklynNets'"><img src="/images/nets.png" alt="BrooklynNets"></button>
            <button onClick="window.location.href='/equipos/NewYorkKnicks'"><img src="/images/knicks.png" alt="NewYorkKnicks"></button>
            <button onClick="window.location.href='/equipos/Philadelphia76ers'"><img src="/images/six.png" alt="Philadelphia76ers"></button>
            <button onClick="window.location.href='/equipos/WashingtonWizards'"><img src="/images/wizz.png" alt="WashingtonWizards"></button>
            <button onClick="window.location.href='/equipos/CharlotteHornets'"><img src="/images/hornets.png" alt="CharlotteHornets"></button>
            <button onClick="window.location.href='/equipos/AtlantaHawks'"><img src="/images/atl.png" alt="AtlantaHawks"></button>
            <button onClick="window.location.href='/equipos/OrlandoMagic'"><img src="/images/orlando.png" alt="OrlandoMagic"></button>
            <button onClick="window.location.href='/equipos/MiamiHeat'"><img src="/images/heat.png" alt="MiamiHeat"></button>
            <button onClick="window.location.href='/equipos/SacramentoKings'"><img src="/images/kings.png" alt="SacramentoKings"></button>
            <button onClick="window.location.href='/equipos/GoldenStateWarriors'"><img src="/images/golden state.png" alt="GoldenStateWarriors"></button>
            <button onClick="window.location.href='/equipos/LosAngelesClippers'"><img src="/images/clippers.png" alt="LosAngelesClippers"></button>
            <button onClick="window.location.href='/equipos/LosAngelesLakers'"><img src="/images/lakers.png" alt="LosAngelesLakers"></button>
            <button onClick="window.location.href='/equipos/SanAntonioSpurs'"><img src="/images/spurs.png" alt="SanAntonioSpurs"></button>
            <button onClick="window.location.href='/equipos/DallasMavericks'"><img src="/images/mavsss.png" alt="DallasMavericks"></button>
            <button onClick="window.location.href='/equipos/NewOrleansPelicans'"><img src="/images/pel.png" alt="NewOrleansPelicans"></button>
            <button onClick="window.location.href='/equipos/OklahomaCityThunder'"><img src="/images/thunder.png" alt="OklahomaCityThunder"></button>
            <button onClick="window.location.href='/equipos/PhoenixSuns'"><img src="/images/suns.png" alt="PhoenixSuns"></button>
            <button onClick="window.location.href='/equipos/UtahJazz'"><img src="/images/jazz.png" alt="UtahJazz"></button>
            <button onClick="window.location.href='/equipos/DenverNuggets'"><img src="/images/nuggets.png" alt="DenverNuggets"></button>
            <button onClick="window.location.href='/equipos/PortlandTrailBlazers'"><img src="/images/trail.png" alt="PortlandTrailBlazers"></button>
            <button onClick="window.location.href='/equipos/MinnesotaTimberwolves'"><img src="/images/timber.png" alt="MinnesotaTimberwolves"></button>
            <button onClick="window.location.href='/equipos/HoustonRockets'"><img src="/images/rockets.png" alt="HoustonRockets"></button>
            <button onClick="window.location.href='/equipos/MemphisGrizzlies'"><img src="/images/memphs.png" alt="MemphisGrizzlies"></button>
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