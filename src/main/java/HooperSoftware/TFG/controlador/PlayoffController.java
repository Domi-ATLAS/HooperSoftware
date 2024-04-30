package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.PartidoService;
import HooperSoftware.TFG.servicio.PlayoffService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PlayoffController {

    private final PartidoService partidoService;
    private final PlayoffService playoffService;

    public PlayoffController(PartidoService service, PlayoffService playoffService) {
        this.partidoService = service;
        this.playoffService = playoffService;
    }

    @GetMapping("/playOffs23")
    public ModelAndView showPlayOffs23Page() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("playOffs23");
        mav.addObject("playOffs23", partidoService.findPlayOff23());
        return mav;
    }

    @GetMapping("/playOffs24")
    public ModelAndView showPlayOffs24Page() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("playOffs24");
        mav.addObject("playOffs24", partidoService.findPlayOff24());
        return mav;
    }

    @GetMapping("/allPlayOffs")
    public ModelAndView showAllPlayOffsPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("playOffs");
        mav.addObject("playOffsGames", playoffService.findAll());
        return mav;
    }

    @GetMapping("/playOffsGames")
    public ModelAndView showAllPlayOffsGamesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allPlayOffsGames");
        mav.addObject("playOffsGames", partidoService.findAllPlayOffGames());
        return mav;
    }
}