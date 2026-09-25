package HooperSoftware.TFG.controlador;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.servicio.ClasificacionService;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.PartidoService;
import HooperSoftware.TFG.servicio.PlayoffService;
import HooperSoftware.TFG.servicio.TemporadaService;

@Controller
public class PlayoffController {

    private final PartidoService partidoService;
    private final PlayoffService playoffService;
    private final EquipoService equipoService;
    private final TemporadaService temporadaService;
    private final ClasificacionService clasificacionService;

    public PlayoffController(PartidoService service, PlayoffService playoffService, EquipoService equipoService, TemporadaService temporadaService, ClasificacionService clasificacionService) {
        this.partidoService = service;
        this.playoffService = playoffService;
        this.equipoService = equipoService;
        this.temporadaService = temporadaService;
        this.clasificacionService = clasificacionService;
    }

    @GetMapping("/playOffsGames/2022-2023")
    public ModelAndView showPlayOffs23Page() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/playOffs23");
        mav.addObject("partidosPlayOffs23", partidoService.findPlayOff23());
        mav.addObject("equiposPlayOffs23", playoffService.findPlayoffByTemporada("2022-2023"));

        mav.addObject("denver", equipoService.findEquipoById(16));
        mav.addObject("timberwolves", equipoService.findEquipoById(17));
        mav.addObject("phoenix", equipoService.findEquipoById(24));
        mav.addObject("clippers", equipoService.findEquipoById(22));
        mav.addObject("sacramento", equipoService.findEquipoById(25));
        mav.addObject("goldenState", equipoService.findEquipoById(21));
        mav.addObject("memphis", equipoService.findEquipoById(28));
        mav.addObject("lakers", equipoService.findEquipoById(23));

        mav.addObject("bucks", equipoService.findEquipoById(10));
        mav.addObject("miami", equipoService.findEquipoById(13));
        mav.addObject("cavs", equipoService.findEquipoById(7));
        mav.addObject("nyk", equipoService.findEquipoById(3));
        mav.addObject("sixters", equipoService.findEquipoById(4));
        mav.addObject("nets", equipoService.findEquipoById(2));
        mav.addObject("celtics", equipoService.findEquipoById(1));
        mav.addObject("atlanta", equipoService.findEquipoById(11));
        return mav;
    }

    @GetMapping("/playOffs24")
    public ModelAndView showPlayOffs24Page() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("playOffs24");
        mav.addObject("playOffs24", partidoService.findPlayOff24());
        return mav;
    }

    @GetMapping("/allPlayOffs")
    public ModelAndView showAllPlayOffsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/playOffs");
        mav.addObject("playOffsGames", playoffService.findAll());
        return mav;
    }

    @GetMapping("/playOffsGames")
    public ModelAndView showAllPlayOffsGamesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allPlayOffsGames");
        mav.addObject("playOffsGames", partidoService.findAllPlayOffGames());
        mav.addObject("temporadas", temporadaService.findAll());
        return mav;
    }


    @GetMapping("/playOffsGames/{temporada}")
    public ModelAndView showAllPlayOffsGamesPage(@PathVariable String temporada) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/cuadrantePlayOffs");
        List<Equipo> equipos = playoffService.findEquiposByPlayOffs(temporada);
        List<Equipo> equiposOeste = equipos.stream()
                                            .filter(e -> "Oeste".equals(e.getConferencia()))
                                            .sorted(Comparator.comparing(Equipo::getBalanceTemporada, Comparator.nullsFirst(Double::compareTo)).reversed())
                                            .collect(Collectors.toList());
        List<Equipo> equiposEste = equipos.stream()
                                            .filter(e -> "Este".equals(e.getConferencia()))
                                            .sorted(Comparator.comparing(Equipo::getBalanceTemporada, Comparator.nullsFirst(Double::compareTo)).reversed())
                                            .collect(Collectors.toList());
        mav.addObject("playOffsGames", partidoService.findPlayOffGamesByTemporada(temporada));
        mav.addObject("temporada", temporada);  
        mav.addObject("clasificacion", clasificacionService.findClasificacionByTemporada(temporada));
        mav.addObject("equiposEste", equiposEste);
        mav.addObject("equiposOeste", equiposOeste);
        mav.addObject("playoff", playoffService.findPlayoffByTemporada(temporada));
        return mav;
    }


    @GetMapping("/temporada/{temporadaPlayoff}/partidos/{equipoLocal}/{equipoVisitante}")
    public ModelAndView getPartidos(@PathVariable String temporadaPlayoff, @PathVariable String equipoLocal, @PathVariable String equipoVisitante) {
        ModelAndView mav = new ModelAndView("partidos/seriesPartidos");
        List<Partido> partidos = partidoService.findSeriesPartidos(equipoLocal, equipoVisitante, temporadaPlayoff);
        mav.addObject("partidos", partidos);
        return mav;
    }
}
