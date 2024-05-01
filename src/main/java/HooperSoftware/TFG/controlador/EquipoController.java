package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.servicio.EquipoService;

@Controller
public class EquipoController {

    private final EquipoService equipoService;

    public EquipoController(EquipoService equipoService) {
        this.equipoService = equipoService;
    }
    
    @GetMapping("/equipos/ChicagoBulls")
    public ModelAndView showBullsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/bulls");
        mav.addObject("chicagoBulls", equipoService.findEquipoById(6));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(6));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(6));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/LosAngelesLakers")
    public ModelAndView showLakersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/lakers");
        mav.addObject("team", equipoService.findEquipoById(23));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(23));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(23));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/MiamiHeat")
    public ModelAndView showHeatPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/heat");
        mav.addObject("team", equipoService.findEquipoById(13));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(13));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(13));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/BostonCeltics")
    public ModelAndView showCelticsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/celtics");
        mav.addObject("team", equipoService.findEquipoById(1));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(1));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(1));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/GoldenStateWarriors")
    public ModelAndView showWarriorsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/warriors");
        mav.addObject("team", equipoService.findEquipoById(21));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(21));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(21));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/HoustonRockets")
    public ModelAndView showRocketsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/rockets");
        mav.addObject("team", equipoService.findEquipoById(27));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(27));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(27));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/Philadelphia76ers")
    public ModelAndView show76ersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/sixters");
        mav.addObject("team", equipoService.findEquipoById(4));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(4));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(4));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/TorontoRaptors")
    public ModelAndView showRaptorsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/raptors");
        mav.addObject("team", equipoService.findEquipoById(5));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(5));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(5));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/DallasMavericks")
    public ModelAndView showMavericksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/mavericks");
        mav.addObject("team", equipoService.findEquipoById(26));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(26));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(26));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/PortlandTrailBlazers")
    public ModelAndView showTrailBlazersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/trail");
        mav.addObject("team", equipoService.findEquipoById(19));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(19));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(19));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/DenverNuggets")
    public ModelAndView showNuggetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/nuggets");
        mav.addObject("team", equipoService.findEquipoById(16));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(16));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(16));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/UtahJazz")
    public ModelAndView showJazzPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/jazz");
        mav.addObject("team", equipoService.findEquipoById(20));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(20));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(20));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/IndianaPacers")
    public ModelAndView showPacersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/pacers");
        mav.addObject("team", equipoService.findEquipoById(9));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(9));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(9));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/OklahomaCityThunder")
    public ModelAndView showThunderPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/thunder");
        mav.addObject("team", equipoService.findEquipoById(18));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(18));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(18));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/MilwaukeeBucks")
    public ModelAndView showBucksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/bucks");
        mav.addObject("team", equipoService.findEquipoById(10));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(10));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(10));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/MemphisGrizzlies")
    public ModelAndView showGrizzliesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/grizzlies");
        mav.addObject("team", equipoService.findEquipoById(28));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(28));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(28));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/PhoenixSuns")
    public ModelAndView showSunsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/suns");
        mav.addObject("team", equipoService.findEquipoById(24));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(24));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(24));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/SanAntonioSpurs")
    public ModelAndView showSpursPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/spurs");
        mav.addObject("team", equipoService.findEquipoById(30));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(30));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(30));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/SacramentoKings")
    public ModelAndView showKingsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/kings");
        mav.addObject("team", equipoService.findEquipoById(25));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(25));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(25));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/NewOrleansPelicans")
    public ModelAndView showPelicansPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/nola");
        mav.addObject("team", equipoService.findEquipoById(29));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(29));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(29));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/MinnesotaTimberwolves")
    public ModelAndView showTimberwolvesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/timberwolves");
        mav.addObject("team", equipoService.findEquipoById(17));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(17));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(17));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }

    @GetMapping("/equipos/AtlantaHawks")
    public ModelAndView showHawksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/hawks");
        mav.addObject("team", equipoService.findEquipoById(11));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(11));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(11));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/CharlotteHornets")
    public ModelAndView showHornetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/hornets");
        mav.addObject("team", equipoService.findEquipoById(12));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(12));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(12));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/ClevelandCavaliers")
    public ModelAndView showCavaliersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/cavaliers");
        mav.addObject("team", equipoService.findEquipoById(7));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(7));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(7));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/DetroitPistons")
    public ModelAndView showPistonsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/pistons");
        mav.addObject("team", equipoService.findEquipoById(8));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(8));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(8));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/NewYorkKnicks")
    public ModelAndView showKnicksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/knicks");
        mav.addObject("team", equipoService.findEquipoById(3));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(3));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(3));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/OrlandoMagic")
    public ModelAndView showMagicPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/magic");
        mav.addObject("team", equipoService.findEquipoById(14));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(14));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(14));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/BrooklynNets")
    public ModelAndView showNetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/nets");
        mav.addObject("team", equipoService.findEquipoById(2));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(2));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(2));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/WashingtonWizards")
    public ModelAndView showWizardsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/wizards");
        mav.addObject("team", equipoService.findEquipoById(15));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(15));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(15));
        mav.addObject("clasificacion", equipoService.findClasificacionEste());
        return mav;
    }

    @GetMapping("/equipos/LosAngelesClippers")
    public ModelAndView showClippersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("equipos/clippers");
        mav.addObject("team", equipoService.findEquipoById(22));
        mav.addObject("jugadores", equipoService.findJugadoresPorEquipo(22));
        mav.addObject("entrenadores", equipoService.findEntrenadoresPorEquipo(22));
        mav.addObject("clasificacion", equipoService.findClasificacionOeste());
        return mav;
    }
    
}