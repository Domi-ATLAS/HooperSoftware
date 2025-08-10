package HooperSoftware.TFG.controlador;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.scraping.JugadorScraping;
import HooperSoftware.TFG.servicio.EntrenadorService;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.EstadisticasEntrenadorService;
import HooperSoftware.TFG.servicio.EstadisticasJugadorService;
import HooperSoftware.TFG.servicio.JugadorService;

@Controller
public class JugadorController {

    private final JugadorService jugadorService;
    private final EstadisticasJugadorService estadisticasJugadorService;
    private final JugadorScraping jugadorScraping;
    private final EntrenadorService entrenadorService;
    private final EstadisticasEntrenadorService estadisticasEntrenadorService;
    private final EquipoService equipoService;



    public JugadorController(JugadorService jugadorService, EstadisticasJugadorService estadisticasJugadorService, JugadorScraping jugadorScraping, EntrenadorService entrenadorService, EstadisticasEntrenadorService estadisticasEntrenadorService, EquipoService equipoService) {
        this.jugadorService = jugadorService;
        this.estadisticasJugadorService = estadisticasJugadorService;
        this.jugadorScraping = jugadorScraping;
        this.entrenadorService = entrenadorService;
        this.estadisticasEntrenadorService = estadisticasEntrenadorService;
        this.equipoService = equipoService;

    }

    @GetMapping("/allPlayers")
    public ModelAndView showAllPlayersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("jugadores/allPlayers");
        mav.addObject("players", jugadorService.findAll());
        mav.addObject("trainers", entrenadorService.findAll());
        mav.addObject("equipos", equipoService.findAll());

        return mav;
    }        


    @GetMapping("/allPlayers/{teamId}")
    public ModelAndView showAllPlayersPageTeam(
            @PathVariable Integer teamId,
            @RequestParam(required = false, defaultValue = "true") boolean jugadores,
            @RequestParam(required = false, defaultValue = "true") boolean entrenadores) {

        ModelAndView mav = new ModelAndView("jugadores/allPlayersTeam");

        if (jugadores) {
            mav.addObject("players", jugadorService.findByEquipo(teamId));
        } else {
            mav.addObject("players", Collections.emptyList());
        }

        if (entrenadores) {
            mav.addObject("trainers", entrenadorService.findByEquipoEntr(teamId));
        } else {
            mav.addObject("trainers", Collections.emptyList());
        }

        mav.addObject("equipos", equipoService.findAll());
        
        return mav;
    }


    @GetMapping("/player/{idJugador}")
    public ModelAndView showPlayerPage(@PathVariable("idJugador") Integer idJugador) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("jugadores/player");
        Jugador jugador = jugadorService.findJugadorById(idJugador);
        mav.addObject("player", jugador);
        mav.addObject("equipo", jugadorService.findEquipoByJugador(jugador.getNombreJugador()));
        mav.addObject("estadisticas", estadisticasJugadorService.findEstadisticasJugadorById(jugador.getEstadisticasJug().getIdEstJugador()));
        return mav;
    }


    @GetMapping("/trainer/{idEntrenador}")
    public ModelAndView showTrainerPage(@PathVariable("idEntrenador") Integer idEntrenador) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("jugadores/trainer");
        Entrenador entrenador = entrenadorService.findEntrById(idEntrenador);
        mav.addObject("trainer", entrenador);
        mav.addObject("equipo", entrenadorService.findEquipoByEntrenador(entrenador.getNombeEntrenador()));
        mav.addObject("estadisticas", estadisticasEntrenadorService.findEstadisticasEntrenadorById(entrenador.getEstadisticasEntr().getIdEstEntrenador()));
        return mav;
    }


    @GetMapping("/players")
    public ModelAndView showPlayersPage() throws IOException {
        ModelAndView mav = new ModelAndView("scraping/players");
        try {
            List<Jugador> jugadores = jugadorScraping.realizarScraping();
            mav.addObject("jugadores", jugadores);
        } catch (IOException e) {
            e.printStackTrace();
            mav.addObject("error", "Ocurrió un error al realizar el scraping de jugadores.");
        }
        return mav;
    }


}