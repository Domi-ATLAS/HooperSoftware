package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.servicio.EstadisticasJugadorService;
import HooperSoftware.TFG.servicio.JugadorService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class JugadorController {

    private final JugadorService jugadorService;
    private final EstadisticasJugadorService estadisticasJugadorService;

    public JugadorController(JugadorService jugadorService, EstadisticasJugadorService estadisticasJugadorService) {
        this.jugadorService = jugadorService;
        this.estadisticasJugadorService = estadisticasJugadorService;
    }

    @GetMapping("/allPlayers")
    public ModelAndView showAllPlayersPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("jugadores/allPlayers");
        mav.addObject("players", jugadorService.findAll());
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
}