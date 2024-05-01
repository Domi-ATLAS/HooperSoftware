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
        return mav;
    }

    @GetMapping("/equipos/LosAngelesLakers")
    public ModelAndView showLakersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("lakers");
        return mav;
    }

    @GetMapping("/equipos/MiamiHeat")
    public ModelAndView showHeatPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("heat");
        return mav;
    }

    @GetMapping("/equipos/BostonCeltics")
    public ModelAndView showCelticsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("celtics");
        return mav;
    }

    @GetMapping("/equipos/GoldenStateWarriors")
    public ModelAndView showWarriorsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("warriors");
        return mav;
    }

    @GetMapping("/equipos/HoustonRockets")
    public ModelAndView showRocketsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("rockets");
        return mav;
    }

    @GetMapping("/equipos/Philadelphia76ers")
    public ModelAndView show76ersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("76ers");
        return mav;
    }

    @GetMapping("/equipos/TorontoRaptors")
    public ModelAndView showRaptorsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("raptors");
        return mav;
    }

    @GetMapping("/equipos/DallasMavericks")
    public ModelAndView showMavericksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mavericks");
        return mav;
    }

    @GetMapping("/equipos/PortlandTrailBlazers")
    public ModelAndView showTrailBlazersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("trailBlazers");
        return mav;
    }

    @GetMapping("/equipos/DenverNuggets")
    public ModelAndView showNuggetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("nuggets");
        return mav;
    }

    @GetMapping("/equipos/UtahJazz")
    public ModelAndView showJazzPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("jazz");
        return mav;
    }

    @GetMapping("/equipos/IndianaPacers")
    public ModelAndView showPacersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pacers");
        return mav;
    }

    @GetMapping("/equipos/OklahomaCityThunder")
    public ModelAndView showThunderPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("thunder");
        return mav;
    }

    @GetMapping("/equipos/MilwaukeeBucks")
    public ModelAndView showBucksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("bucks");
        return mav;
    }

    @GetMapping("/equipos/MemphisGrizzlies")
    public ModelAndView showGrizzliesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("grizzlies");
        return mav;
    }

    @GetMapping("/equipos/PhoenixSuns")
    public ModelAndView showSunsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("suns");
        return mav;
    }

    @GetMapping("/equipos/SanAntonioSpurs")
    public ModelAndView showSpursPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("spurs");
        return mav;
    }

    @GetMapping("/equipos/SacramentoKings")
    public ModelAndView showKingsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("kings");
        return mav;
    }

    @GetMapping("/equipos/NewOrleansPelicans")
    public ModelAndView showPelicansPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pelicans");
        return mav;
    }

    @GetMapping("/equipos/MinnesotaTimberwolves")
    public ModelAndView showTimberwolvesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("timberwolves");
        return mav;
    }

    @GetMapping("/equipos/AtlantaHawks")
    public ModelAndView showHawksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("hawks");
        return mav;
    }

    @GetMapping("/equipos/CharlotteHornets")
    public ModelAndView showHornetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("hornets");
        return mav;
    }

    @GetMapping("/equipos/ClevelandCavaliers")
    public ModelAndView showCavaliersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("cavaliers");
        return mav;
    }

    @GetMapping("/equipos/DetroitPistons")
    public ModelAndView showPistonsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pistons");
        return mav;
    }

    @GetMapping("/equipos/NewYorkKnicks")
    public ModelAndView showKnicksPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("knicks");
        return mav;
    }

    @GetMapping("/equipos/OrlandoMagic")
    public ModelAndView showMagicPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("magic");
        return mav;
    }

    @GetMapping("/equipos/BrooklynNets")
    public ModelAndView showNetsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("nets");
        return mav;
    }

    @GetMapping("/equipos/WashingtonWizards")
    public ModelAndView showWizardsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("wizards");
        return mav;
    }

    @GetMapping("/equipos/LosAngelesClippers")
    public ModelAndView showClippersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("clippers");
        return mav;
    }
    
}