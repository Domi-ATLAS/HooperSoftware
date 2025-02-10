package HooperSoftware.TFG.controlador;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.TemporadaService;
import HooperSoftware.TFG.servicio.VotacionService;


@RestController
public class VotacionController {

    private final VotacionService votacionService;
    private final TemporadaService temporadaService;
    private final EquipoService equipoService;


    public VotacionController(VotacionService votacionService, TemporadaService temporadaService, EquipoService equipoService) {
        this.votacionService = votacionService;
        this.temporadaService = temporadaService;
        this.equipoService = equipoService;
    }

    @GetMapping("/allVotes")
    public ModelAndView showAllVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/allVotes");
        mav.addObject("votes", votacionService.findAll());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/inCourse")
    public ModelAndView showInCourseVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/votesActivate");
        mav.addObject("votes", votacionService.findVotacionesEnCurso());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/oficial")
    public ModelAndView showOficialVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/oficialVotes");
        mav.addObject("votes", votacionService.findVotacionesOficiales());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }
}