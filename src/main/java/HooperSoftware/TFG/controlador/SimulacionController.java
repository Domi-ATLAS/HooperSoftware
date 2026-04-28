package HooperSoftware.TFG.controlador;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.servicio.JugadorService;
import HooperSoftware.TFG.servicio.SimulacionService;

@Controller
public class SimulacionController {

    private final JugadorService jugadorService;
    private final SimulacionService simulacionService;

    public SimulacionController(
            JugadorService jugadorService,
            SimulacionService simulacionService) {

        this.jugadorService = jugadorService;
        this.simulacionService = simulacionService;
    }

    @GetMapping("/simulaciones")
    public String vistaSimulador(Model model) {

        List<Jugador> jugadores
                = jugadorService.findAll();

        model.addAttribute(
                "jugadores",
                jugadores
        );

        return "simulaciones";
    }

    @PostMapping("/simulaciones")
    public String ejecutarTrade(
            @RequestParam Integer jugadorSaleId,
            @RequestParam Integer jugadorLlegaId,
            Model model) {

        List<Jugador> jugadores
                = jugadorService.findAll();

        Jugador sale
                = jugadorService.findJugadorById(
                        jugadorSaleId
                );

        Jugador llega
                = jugadorService.findJugadorById(
                        jugadorLlegaId
                );

        var resultado
                = simulacionService.evaluarTrade(
                        sale,
                        llega
                );

        model.addAttribute(
                "jugadores",
                jugadores
        );

        model.addAttribute(
                "sale",
                sale
        );

        model.addAttribute(
                "llega",
                llega
        );

        model.addAttribute(
                "resultado",
                resultado
        );

        return "simulaciones";
    }

}
