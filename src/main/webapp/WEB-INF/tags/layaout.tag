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
            <button><img src="/images/bulls.png"></button>
            <button>Noticias</button>
            <button>Transferencias</button>
            <button>Partidos</button>
            <button>Play Offs</button>
            <button>Votaciones</button>
            <button>Perfil</button>
            <button>Buscador</button>
            <button>Sección 9</button>
        </div>
    </header>

    <div>
        <button onClick="window.location.href='/equipos/ChicagoBulls'"><img src="/images/bulls.png" alt="Imagen 1"></button>
        <img src="/images/boston.jpg" alt="Imagen 2">
        <button><img src="/images/pacers.jpg" alt="Imagen 3"></button>
        <button><img src="/images/bucks.png" alt="Imagen 4"></button>
        <button><img src="/images/pistons.png" alt="Imagen 5"></button>
        <button><img src="/images/cavs.jpg" alt="Imagen 6"></button>
        <button><img src="/images/raps.png" alt="Imagen 7"></button>
        <button><img src="/images/nets.png" alt="Imagen 8"></button>
        <button><img src="/images/knicks.jpg" alt="Imagen 9"></button>
        <button><img src="/images/six.png" alt="Imagen 10"></button>
        <button><img src="/images/wizz.png" alt="Imagen 11"></button>
        <button><img src="/images/hornets.png" alt="Imagen 12"></button>
        <button><img src="/images/atl.png" alt="Imagen 13"></button>
        <button><img src="/images/orlando.png" alt="Imagen 14"></button>
        <button><img src="/images/heats.png" alt="Imagen 15"></button>
        <button><img src="/images/kings.png" alt="Imagen 16"></button>
        <button><img src="/images/goldenstate.jpg" alt="Imagen 17"></button>
        <button><img src="/images/clippers.png" alt="Imagen 18"></button>
        <button><img src="/images/lakers.png" alt="Imagen 19"></button>
        <button><img src="/images/spurs.jpg" alt="Imagen 20"></button>
        <button><img src="/images/mavs.png" alt="Imagen 21"></button>
        <button><img src="/images/pel.png" alt="Imagen 22"></button>
        <button><img src="/images/thunder.jpg" alt="Imagen 23"></button>
        <button><img src="/images/suns.png" alt="Imagen 24"></button>
        <button><img src="/images/jazz.png" alt="Imagen 25"></button>
        <button><img src="/images/nuggets.png" alt="Imagen 26"></button>
        <button><img src="/images/trail.png" alt="Imagen 27"></button>
        <button><img src="/images/timber.jpg" alt="Imagen 28"></button>
        <button><img src="/images/rockets.png" alt="Imagen 29"></button>
        <button><img src="/images/memphs.jpg" alt="Imagen 30"></button>
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