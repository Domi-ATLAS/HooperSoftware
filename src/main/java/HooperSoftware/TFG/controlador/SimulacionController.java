package HooperSoftware.TFG.controlador;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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

    @GetMapping("")
    public String homeSimulaciones() {

        return "simulaciones/home";
    }

    public SimulacionController(
            JugadorService jugadorService,
            EquipoService equipoService,
            SimulacionService simulacionService) {

        this.jugadorService = jugadorService;
        this.equipoService = equipoService;
        this.simulacionService = simulacionService;
    }

    @GetMapping("/trade")
    public String trade(Model model) {

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones/trade";
    }

    @GetMapping("/playoffs")
    public String playoffs(Model model) {

        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones/playoffs";
    }

    @GetMapping("/bracket")
    public String bracket(Model model) {

        return "simulaciones/bracket";
    }

    @GetMapping("/season")
    public String season() {

        return "simulaciones/season";
    }

    @GetMapping("/live")
    public String live(Model model) {

        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones/live";
    }

    @GetMapping("/gm")
    public String gm(Model model) {

        model.addAttribute("jugadores", jugadorService.findAll());

        return "simulaciones/gm";
    }

    @GetMapping("/dynasty")
    public String dynasty(Model model) {

        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones/dynasty";
    }

    @GetMapping({"/ai", "/analisis"})
    public String analisisEquipo(Model model) {

        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones/ai";
    }

    @GetMapping("/tablero")
    public String tablero(Model model) {

        cargarDatosTablero(model);

        return "simulaciones/tablero";
    }

    //ANTIGUO TRADE SIMULATOR
    /*  @GetMapping("")
    public String vistaSimulador(Model model) {

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        return "simulaciones";
    } */
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
            return "simulaciones/trade";
        }

        var resultado = simulacionService.evaluarTrade(sale, llega);
        var impacto = simulacionService.calcularImpactoTrade(sale, llega);

        model.addAttribute("jugadores", jugadores);
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("sale", sale);
        model.addAttribute("llega", llega);

        model.addAttribute("resultado", resultado);
        model.addAttribute("impacto", impacto);

        return "simulaciones/trade";
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

        return "simulaciones/trade";
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

        return "simulaciones/trade";
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

        return "simulaciones/playoffs";
    }

    @PostMapping("/bracket")
    public String simularBracket(Model model) {

        var bracket = simulacionService.simularBracketNBA();

        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());

        model.addAttribute("bracket", bracket);

        return "simulaciones/bracket";
    }

    @PostMapping("/temporada")
    public String simularTemporada(Model model) {

        model.addAttribute(
                "seasonSimulation",
                simulacionService.simularTemporadaNBA());

        return "simulaciones/season";
    }

    @PostMapping("/live")
    public String simularPartidoLive(
            @RequestParam Integer equipo1Id,
            @RequestParam Integer equipo2Id,
            Model model) {
        if (equipo1Id.equals(equipo2Id)) {

            model.addAttribute("errorLive",
                    "No puedes enfrentar el mismo equipo");

            model.addAttribute("equipos", equipoService.findAll());
            model.addAttribute("jugadores", jugadorService.findAll());

            return "simulaciones/live";
        }
        model.addAttribute(
                "liveGame",
                simulacionService.simularPartidoLive(
                        equipo1Id,
                        equipo2Id));

        model.addAttribute("equipos", equipoService.findAll());
        model.addAttribute("jugadores", jugadorService.findAll());

        System.out.println("ID1 = " + equipo1Id);
        System.out.println("ID2 = " + equipo2Id);

        return "simulaciones/live";
    }

    @PostMapping("/gm")
    public String gmAssistant(
            @RequestParam Integer jugadorId,
            Model model) {

        model.addAttribute(
                "gmTrades",
                simulacionService.buscarMejoresTrades(
                        jugadorId));

        model.addAttribute(
                "jugadores",
                jugadorService.findAll());

        model.addAttribute(
                "equipos",
                equipoService.findAll());

        return "simulaciones/gm";
    }

    @PostMapping("/dynasty")
    public String dynasty(
            @RequestParam Integer equipoId,
            Model model) {

        model.addAttribute(
                "dynasty",
                simulacionService.simularDinastia(
                        equipoId));

        model.addAttribute(
                "equipos",
                equipoService.findAll());

        model.addAttribute(
                "jugadores",
                jugadorService.findAll());

        return "simulaciones/dynasty";
    }

    @PostMapping({"/ai", "/analisis"})
    public String generarInformeEquipo(
            @RequestParam Integer equipoId,
            Model model) {

        model.addAttribute("equipos", equipoService.findAll());
        model.addAttribute("equipoId", equipoId);
        model.addAttribute("informeAnalisis", simulacionService.generarInformeEquipo(equipoId));

        return "simulaciones/ai";
    }

    @PostMapping("/tablero")
    public String analizarTablero(
            @RequestParam(required = false) Integer jugadorBaseId,
            @RequestParam(required = false) Integer equipoObjetivoId,
            @RequestParam(required = false) Integer baseId,
            @RequestParam(required = false) Integer escoltaId,
            @RequestParam(required = false) Integer aleroId,
            @RequestParam(required = false) Integer alaPivotId,
            @RequestParam(required = false) Integer pivotId,
            Model model) {

        Map<String, Integer> seleccionSlots = new LinkedHashMap<>();
        seleccionSlots.put("Base", baseId);
        seleccionSlots.put("Escolta", escoltaId);
        seleccionSlots.put("Alero", aleroId);
        seleccionSlots.put("Ala-pivot", alaPivotId);
        seleccionSlots.put("Pivot", pivotId);

        cargarDatosTablero(model);
        model.addAttribute("jugadorBaseId", jugadorBaseId);
        model.addAttribute("equipoObjetivoId", equipoObjetivoId);
        model.addAttribute("baseId", baseId);
        model.addAttribute("escoltaId", escoltaId);
        model.addAttribute("aleroId", aleroId);
        model.addAttribute("alaPivotId", alaPivotId);
        model.addAttribute("pivotId", pivotId);
        model.addAttribute("analisisTablero",
                simulacionService.analizarTablero(
                        seleccionSlots,
                        jugadorBaseId,
                        equipoObjetivoId));

        return "simulaciones/tablero";
    }

    private void cargarDatosTablero(Model model) {
        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());
    }
}
