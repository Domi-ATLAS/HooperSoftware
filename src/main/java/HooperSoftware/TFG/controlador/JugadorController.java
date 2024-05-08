package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.JugadorService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JugadorController {

    private final JugadorService jugadorService;

    public JugadorController(JugadorService jugadorService) {
        this.jugadorService = jugadorService;
    }

    @GetMapping("/allPlayers")
    public ModelAndView showAllPlayersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allPlayers");
        mav.addObject("players", jugadorService.findAll());
        return mav;
    }
}