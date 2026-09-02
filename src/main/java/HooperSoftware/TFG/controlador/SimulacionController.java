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
import HooperSoftware.TFG.servicio.ComparativaService;
import HooperSoftware.TFG.servicio.SimulacionService;

@Controller
@RequestMapping("/simulaciones")
public class SimulacionController {

    private final JugadorService jugadorService;
    private final EquipoService equipoService;
    private final SimulacionService simulacionService;
    private final ComparativaService comparativaService;

    @GetMapping("")
    public String homeSimulaciones() {

        return "simulaciones/home";
    }

    public SimulacionController(
            JugadorService jugadorService,
            EquipoService equipoService,
            SimulacionService simulacionService,
            ComparativaService comparativaService) {

        this.jugadorService = jugadorService;
        this.equipoService = equipoService;
        this.simulacionService = simulacionService;
        this.comparativaService = comparativaService;
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

    @GetMapping("/comparativa")
    public String comparativa(Model model) {

        cargarDatosComparativa(model);

        return "simulaciones/comparativa";
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

        Jugador jugador = jugadorService.findJugadorById(jugadorId);

        model.addAttribute(
                "gmTrades",
                simulacionService.buscarMejoresTrades(
                        jugadorId));

        model.addAttribute("jugadorSeleccionado", jugador);

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

    @PostMapping("/comparativa/temporadas")
    public String compararTemporadas(
            @RequestParam String temporadaA,
            @RequestParam String temporadaB,
            @RequestParam(required = false) List<Integer> equiposIncluidos,
            @RequestParam(required = false) Boolean incluirJugadores,
            @RequestParam(required = false) Boolean incluirPartidos,
            @RequestParam(required = false, defaultValue = "15") int limiteJugadores,
            Model model) {

        boolean usarJugadores = incluirJugadores != null;
        boolean usarPartidos = incluirPartidos != null;

        cargarDatosComparativa(model);
        model.addAttribute("temporadaA", temporadaA);
        model.addAttribute("temporadaB", temporadaB);
        model.addAttribute("equiposIncluidos", equiposIncluidos);
        model.addAttribute("incluirJugadores", usarJugadores);
        model.addAttribute("incluirPartidos", usarPartidos);
        model.addAttribute("limiteJugadores", limiteJugadores);
        model.addAttribute("comparativaTemporadas",
                comparativaService.compararTemporadas(
                        temporadaA,
                        temporadaB,
                        equiposIncluidos,
                        usarJugadores,
                        usarPartidos,
                        limiteJugadores));

        return "simulaciones/comparativa";
    }

    @PostMapping("/comparativa/plantilla")
    public String simularPlantillaComparativa(
            @RequestParam String temporada,
            @RequestParam Integer equipoReferenciaId,
            @RequestParam(required = false) List<Integer> jugadorIds,
            Model model) {

        cargarDatosComparativa(model);
        model.addAttribute("plantillaTemporada", temporada);
        model.addAttribute("plantillaEquipoReferenciaId", equipoReferenciaId);
        model.addAttribute("plantillaJugadorIds", jugadorIds);

        if (jugadorIds == null || jugadorIds.size() < 8 || jugadorIds.size() > 12) {
            model.addAttribute("plantillaError", "Selecciona entre 8 y 12 jugadores para simular una plantilla.");
            return "simulaciones/comparativa";
        }

        model.addAttribute("plantillaResultado",
                comparativaService.simularPlantilla(
                        temporada,
                        equipoReferenciaId,
                        jugadorIds));

        return "simulaciones/comparativa";
    }

    @PostMapping("/comparativa/traspaso")
    public String simularTraspasoComparativo(
            @RequestParam String temporada,
            @RequestParam Integer equipoId,
            @RequestParam Integer jugadorSaleId,
            @RequestParam Integer jugadorLlegaId,
            Model model) {

        cargarDatosComparativa(model);
        model.addAttribute("traspasoTemporada", temporada);
        model.addAttribute("traspasoEquipoId", equipoId);
        model.addAttribute("jugadorSaleId", jugadorSaleId);
        model.addAttribute("jugadorLlegaId", jugadorLlegaId);
        model.addAttribute("traspasoResultado",
                comparativaService.simularTraspaso(
                        temporada,
                        equipoId,
                        jugadorSaleId,
                        jugadorLlegaId));

        return "simulaciones/comparativa";
    }

    private void cargarDatosTablero(Model model) {
        model.addAttribute("jugadores", jugadorService.findAll());
        model.addAttribute("equipos", equipoService.findAll());
    }

    private void cargarDatosComparativa(Model model) {
        List<String> temporadas = comparativaService.findTemporadasDisponibles();
        model.addAttribute("temporadas", temporadas);
        model.addAttribute("equipos", equipoService.findAll());
        model.addAttribute("jugadores", jugadorService.findAll());

        if (!temporadas.isEmpty()) {
            model.addAttribute("defaultTemporadaA", temporadas.size() > 1 ? temporadas.get(1) : temporadas.get(0));
            model.addAttribute("defaultTemporadaB", temporadas.get(0));
        }
    }
}
