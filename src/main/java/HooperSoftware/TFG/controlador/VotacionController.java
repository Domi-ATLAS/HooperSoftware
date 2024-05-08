package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.TemporadaService;
import HooperSoftware.TFG.servicio.VotacionService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class VotacionController {

    private final VotacionService votacionService;
    private final TemporadaService temporadaService;

    public VotacionController(VotacionService votacionService, TemporadaService temporadaService) {
        this.votacionService = votacionService;
        this.temporadaService = temporadaService;
    }

    @GetMapping("/allVotes")
    public ModelAndView showAllVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/allVotes");
        mav.addObject("votes", votacionService.findAll());
        mav.addObject("temporadas", temporadaService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/inCourse")
    public ModelAndView showInCourseVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/votesActivate");
        mav.addObject("votes", votacionService.findVotacionesEnCurso());
        mav.addObject("temporadas", temporadaService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/oficial")
    public ModelAndView showOficialVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/oficialVotes");
        mav.addObject("votes", votacionService.findVotacionesOficiales());
        mav.addObject("temporadas", temporadaService.findAll());
        return mav;
    }
}