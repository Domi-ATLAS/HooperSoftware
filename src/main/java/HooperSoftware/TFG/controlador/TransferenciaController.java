package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.servicio.TransferenciaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TransferenciaController {

    private final TransferenciaService transferenciaService;

    public TransferenciaController(TransferenciaService transferenciaService) {
        this.transferenciaService = transferenciaService;
    }

    @GetMapping("/allTranferences")
    public ModelAndView showAllTransferencesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("tranferencias/allTranferences");
        mav.addObject("transferences", transferenciaService.findAll());
        return mav;
    }
}