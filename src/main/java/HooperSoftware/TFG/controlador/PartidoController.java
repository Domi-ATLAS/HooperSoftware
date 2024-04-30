package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.PartidoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PartidoController {

    private final PartidoService partidoService;

    public PartidoController(PartidoService partidoService) {
        this.partidoService = partidoService;
    }

    @GetMapping("/allGames")
    public ModelAndView showAllGamesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allGames");
        mav.addObject("games", partidoService.findAll());
        return mav;
    }
}