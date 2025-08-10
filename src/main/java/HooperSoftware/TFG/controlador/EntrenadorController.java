package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.EntrenadorService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EntrenadorController {

    private final EntrenadorService entrenadorService;

    public EntrenadorController(EntrenadorService entrenadorService) {
        this.entrenadorService = entrenadorService;
    }

    @GetMapping("/allCoaches")
    public ModelAndView showAllCoachesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allTrainers");
        mav.addObject("coaches", entrenadorService.findAll());
        return mav;
    }
}