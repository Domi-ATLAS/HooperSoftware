package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.PartidoService;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class PartidoController {

    private final PartidoService partidoService;
    private final EquipoService equipoService;

    public PartidoController(PartidoService partidoService, EquipoService equipoService) {
        this.partidoService = partidoService;
        this.equipoService = equipoService;
    }

    @GetMapping("/allGames")
    public ModelAndView showAllGamesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allGames");
        mav.addObject("games", partidoService.findAll());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allGames/{teamId}")
    public ModelAndView showAllGamesPageByTeam(@PathVariable Integer teamId) {
        ModelAndView mav = new ModelAndView();
        List<Partido> partidos = partidoService.findAllGamesByTeamById(teamId);
        mav.setViewName("partidos/allGamesTeam");
        mav.addObject("gamesOfTheTeam", partidos);
        mav.addObject("equipos", equipoService.findAll());
        mav.addObject("selectedTeamId", teamId);
        return mav;
}


    @GetMapping("/partido/{id}")
    public ModelAndView showGamePage(@PathVariable Integer id) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/partidoDetails");
        mav.addObject("game", partidoService.findPartidoById(id));
        mav.addObject("localJug", partidoService.findLocalTeamPlayersByPartidoId(id));
        mav.addObject("visitJug", partidoService.findVisitTeamPlayersByPartidoId(id));
        return mav;
    }
}