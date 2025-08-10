package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.TemporadaService;


@Controller
public class TemporadaController {

    private final TemporadaService temporadaService;
    private final EquipoService equipoService;


    public TemporadaController(TemporadaService temporadaService, EquipoService equipoService) {
        this.temporadaService = temporadaService;
        this.equipoService = equipoService;
    }

    @GetMapping("/allSeasons")
    public ModelAndView showAllSeasons() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allSeasons");
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }
    
    @GetMapping("/allSeasons/{teamId}")
    public ModelAndView showSeasonsByTeam(@PathVariable Integer teamId) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allSeasonsTeam");
        mav.addObject("temporadas", temporadaService.findTemporadasByTeam(teamId));
        mav.addObject("equipos", equipoService.findAll());
        mav.addObject("selectedTeamId", teamId);
        return mav;
    }
    
}
