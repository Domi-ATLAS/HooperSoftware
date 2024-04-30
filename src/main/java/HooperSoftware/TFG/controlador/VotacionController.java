package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.VotacionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class VotacionController {

    private final VotacionService votacionService;

    public VotacionController(VotacionService votacionService) {
        this.votacionService = votacionService;
    }

    @GetMapping("/allVotes")
    public ModelAndView showAllVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allVotes");
        mav.addObject("votes", votacionService.findAll());
        return mav;
    }
}