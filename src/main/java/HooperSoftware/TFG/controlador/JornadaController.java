package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.JornadaService;

@Controller
public class JornadaController {

    private final JornadaService jornadaService;
    private final EquipoService equipoService;

    public JornadaController(JornadaService jornadaService, EquipoService equipoService) {
        this.jornadaService = jornadaService;
        this.equipoService = equipoService;
    }

    @GetMapping("/allGames/allJornadas")
    public ModelAndView showAllJornadasPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allJornada");
        mav.addObject("jornadas", jornadaService.findAll());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allGames/allJornadas/{teamId}")
    public ModelAndView showJornadasByTeam(@PathVariable Integer teamId) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("partidos/allJornadaTeam");
        mav.addObject("jornadas", jornadaService.findJornadasByTeam(teamId));
        mav.addObject("equipos", equipoService.findAll());
        mav.addObject("selectedTeamId", teamId);
        return mav;
    }
}
