package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.TransferenciaService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TransferenciaController {

    private final TransferenciaService transferenciaService;

    public TransferenciaController(TransferenciaService transferenciaService) {
        this.transferenciaService = transferenciaService;
    }

    @GetMapping("/allTransferences")
    public ModelAndView showAllTransferencesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("allTransferences");
        mav.addObject("transferences", transferenciaService.findAll());
        return mav;
    }
}