package HooperSoftware.TFG.controlador;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Partido;

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

    public BuscadorController(
            EntrenadorService entrenadorService,
            EquipoService equipoService,
            PartidoService partidoService,
            JugadorService jugadorService) {

        this.entrenadorService = entrenadorService;
        this.equipoService = equipoService;
        this.partidoService = partidoService;
        this.jugadorService = jugadorService;
    }

    @GetMapping("/buscador")
    public ModelAndView search(
            @RequestParam(value = "query", required = false) String query) {

        ModelAndView mav = new ModelAndView("buscador");

        if (query == null || query.trim().isBlank()) {

            mav.addObject("searched", false);
            mav.addObject("query", "");

            mav.addObject("entrenadores", Collections.emptyList());
            mav.addObject("equipos", Collections.emptyList());
            mav.addObject("jugadores", Collections.emptyList());
            mav.addObject("partidos", Collections.emptyList());

            return mav;
        }

        String like = "%" + query.trim() + "%";

        List<Entrenador> entrenadores = Collections.emptyList();
        List<Equipo> equipos = Collections.emptyList();
        List<Jugador> jugadores = Collections.emptyList();
        List<Partido> partidos = Collections.emptyList();

        try {

            entrenadores = entrenadorService.findEntrByNombre(like);

            if (entrenadores.isEmpty()) {
                entrenadores
                        = entrenadorService.findEntrByEquipoTrayectoria(query.trim());
            }

        } catch (Exception e) {
        }

        try {
            equipos = equipoService.findEquipoByNombre(like);
        } catch (Exception e) {
        }

        try {
            jugadores = jugadorService.findJugadorByNombre(like);
        } catch (Exception e) {
        }

        try {
            partidos = partidoService.findPartidoByTeam(like);

            if (partidos.size() > 8) {
                partidos = partidos.subList(0, 8);
            }

        } catch (Exception e) {
        }

        mav.addObject("searched", true);
        mav.addObject("query", query);

        mav.addObject("entrenadores", entrenadores);
        mav.addObject("equipos", equipos);
        mav.addObject("jugadores", jugadores);
        mav.addObject("partidos", partidos);

        return mav;
    }

    // ---------------- AUTOCOMPLETE ----------------
    @GetMapping("/buscador/autocomplete")
    @ResponseBody
    public List<String> autocomplete(
            @RequestParam("term") String term) {

        List<String> resultados = new ArrayList<>();

        if (term == null || term.length() < 2) {
            return resultados;
        }

        String like = "%" + term.trim() + "%";

        try {
            equipoService.findEquipoByNombre(like)
                    .stream()
                    .limit(4)
                    .forEach(e
                            -> resultados.add(
                            e.getNombreEquipo() + " (Equipo)"
                    ));
        } catch (Exception e) {
        }

        try {
            jugadorService.findJugadorByNombre(like)
                    .stream()
                    .limit(5)
                    .forEach(j
                            -> resultados.add(
                            j.getNombreJugador() + " (Jugador)"
                    ));
        } catch (Exception e) {
        }

        try {
            entrenadorService.findEntrByNombre(like)
                    .stream()
                    .limit(4)
                    .forEach(t
                            -> resultados.add(
                            t.getNombeEntrenador() + " (Entrenador)"
                    ));
        } catch (Exception e) {
        }

        return resultados;
    }

}
