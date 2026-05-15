package HooperSoftware.TFG.controlador;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.JugadorService;
import HooperSoftware.TFG.servicio.SimulacionService;

@Controller
@RequestMapping("/simulaciones")
public class SimulacionController {

    private final JugadorService jugadorService;
    private final EquipoService equipoService;
    private final SimulacionService simulacionService;

    public SimulacionController(
            JugadorService jugadorService,
            EquipoService equipoService,
            SimulacionService simulacionService) {

        this.jugadorService = jugadorService;
        this.equipoService = equipoService;
        this.simulacionService = simulacionService;
    }

    @GetMapping("")
    public String vistaSimulador(Model model) {

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones";
    }

    @PostMapping("")
    public String ejecutarTrade(
            @RequestParam Integer jugadorSaleId,
            @RequestParam Integer jugadorLlegaId,
            Model model) {

        List<Jugador> jugadores = jugadorService.findAll();

        Jugador sale = jugadorService.findJugadorById(jugadorSaleId);
        Jugador llega = jugadorService.findJugadorById(jugadorLlegaId);

        var wins = simulacionService.calcularWins(sale, llega);
        model.addAttribute("wins", wins);

        // 🚨 evitar mismo jugador
        if (sale.getIdJugador().equals(llega.getIdJugador())) {
            model.addAttribute("error", "No puedes tradear el mismo jugador");
            model.addAttribute("jugadores", jugadores);
            model.addAttribute("equipos", equipoService.findAll());
            return "simulaciones";
        }

        var resultado = simulacionService.evaluarTrade(sale, llega);
        var impacto = simulacionService.calcularImpactoTrade(sale, llega);

        model.addAttribute("jugadores", jugadores);
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("sale", sale);
        model.addAttribute("llega", llega);

        model.addAttribute("resultado", resultado);
        model.addAttribute("impacto", impacto);

        return "simulaciones";
    }

    @PostMapping("/sugerir")
    public String sugerenciasJugador(
            @RequestParam Integer jugadorBaseId,
            Model model) {

        Jugador base = jugadorService.findJugadorById(jugadorBaseId);

        var sugerencias = simulacionService.sugerirMejorTrade(base);

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());
        model.addAttribute("sugerencias", sugerencias);
        model.addAttribute("jugadorBaseId", jugadorBaseId);

        return "simulaciones";
    }

    @PostMapping("/equipo")
    public String sugerenciasEquipo(
            @RequestParam Integer equipoId,
            Model model) {

        Equipo equipo = equipoService.findEquipoById(equipoId);

        var sugerencias = simulacionService.sugerirParaEquipo(equipo);

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("equipoSeleccionado", equipo);
        model.addAttribute("sugerenciasEquipo", sugerencias);
        model.addAttribute("equipoId", equipoId);

        return "simulaciones";
    }

    // ================= PLAYOFF SIMULATION =================

    @PostMapping("/playoffs")
    public String simularPlayoffs(
            @RequestParam Integer equipoId,
            Model model) {

        Equipo equipo = equipoService.findEquipoById(equipoId);

        var prediccion = simulacionService.predecirPlayoffs(equipo);

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("equipoSeleccionado", equipo);
        model.addAttribute("playoff", prediccion);

        return "simulaciones";
    }

    @PostMapping("/bracket")
    public String simularBracket(Model model) {

        var bracket = simulacionService.simularBracketNBA();

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("bracket", bracket);

        return "simulaciones";
    }

    @PostMapping("/temporada")
    public String simularTemporada(Model model) {

        model.addAttribute(
                "seasonSimulation",
                simulacionService.simularTemporadaNBA());

        return "simulaciones";
    }
}