package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.servicio.PartidoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class PartidoController {

    private final PartidoService partidoService;

    public PartidoController(PartidoService partidoService) {
        this.partidoService = partidoService;
    }

    @GetMapping("/allGames")
    public ModelAndView showAllGamesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allGames");
        mav.addObject("games", partidoService.findAll());
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