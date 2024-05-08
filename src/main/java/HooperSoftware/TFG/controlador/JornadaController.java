package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.JornadaService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JornadaController {

    private final JornadaService jornadaService;

    public JornadaController(JornadaService jornadaService) {
        this.jornadaService = jornadaService;
    }

    @GetMapping("/allGames/allJornadas")
    public ModelAndView showAllJornadasPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allJornada");
        mav.addObject("jornadas", jornadaService.findAll());
        return mav;
    }
}