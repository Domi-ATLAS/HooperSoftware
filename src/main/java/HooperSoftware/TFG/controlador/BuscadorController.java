package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.servicio.EntrenadorService;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.JugadorService;
import HooperSoftware.TFG.servicio.PartidoService;

@Controller
public class BuscadorController {

    private final EntrenadorService entrenadorService;
    private final EquipoService equipoService;
    private final PartidoService partidoService;
    private final JugadorService jugadorService;

    public BuscadorController(EntrenadorService entrenadorService, EquipoService equipoService, PartidoService partidoService, JugadorService jugadorService) {
        this.entrenadorService = entrenadorService;
        this.equipoService = equipoService;
        this.partidoService = partidoService;
        this.jugadorService = jugadorService;
    }

    @GetMapping("/buscador")
    public ModelAndView search(String queryString) {
        // Buscar en los diferentes servicios
        ModelAndView mav = new ModelAndView("buscador");
        mav.setViewName("buscador");
        var entrenadores = entrenadorService.findEquipoByEntrenador(queryString);  // Asumiendo que tienes un método searchByName
        var equipos = equipoService.findEquipoByNombre(queryString);            // Asumiendo que tienes un método searchByName
        var partidos = partidoService.findPartidoByTeam(queryString);          // Asumiendo que tienes un método searchByTerm
        var jugadores = jugadorService.findJugadorByNombre(queryString);         // Asumiendo que tienes un método searchByName
        

        // Agregar los resultados al modelo
        mav.addObject("query", queryString);
        mav.addObject("entrenadores", entrenadores);
        mav.addObject("equipos", equipos);
        mav.addObject("partidos", partidos);
        mav.addObject("jugadores", jugadores);

        return mav; // Devolver la vista buscador.jsp
    }
}
