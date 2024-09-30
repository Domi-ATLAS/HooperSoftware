package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.entidad.Transferencia;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.TransferenciaService;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TransferenciaController {

    private final TransferenciaService transferenciaService;
    private final EquipoService equipoService;

    public TransferenciaController(TransferenciaService transferenciaService, EquipoService equipoService) {
        this.transferenciaService = transferenciaService;
        this.equipoService = equipoService;
    }

    @GetMapping("/allTranferences")
    public ModelAndView showAllTransferencesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("tranferencias/allTranferences");
        mav.addObject("transferences", transferenciaService.findAll());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allTranferences/{teamId}")
    public ModelAndView showAllTransferencesPageByTeam(@PathVariable Integer teamId) {
        ModelAndView mav = new ModelAndView();
        List<Transferencia> transferencias = transferenciaService.findAllTransferencesByTeamById(teamId);
        mav.setViewName("tranferencias/allTransferencesTeam");
        mav.addObject("transferencesOfTheTeam", transferencias);
        mav.addObject("selectedTeamId", teamId);
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    

    
}