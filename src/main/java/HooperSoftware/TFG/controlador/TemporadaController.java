package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;

import HooperSoftware.TFG.servicio.TemporadaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class TemporadaController {

    private TemporadaService temporadaService;

    public TemporadaController(TemporadaService temporadaService) {
        this.temporadaService = temporadaService;
    }

    @GetMapping("/allSeasons")
    public ModelAndView showAllSeasons() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allSeasons");
        mav.addObject("temporadas", temporadaService.findAll());
        return mav;
    }
    
    
}
