package HooperSoftware.TFG.controlador;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.entidad.Categoria;
import HooperSoftware.TFG.entidad.Votacion;
import HooperSoftware.TFG.entidad.VotoUsuario;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.TemporadaService;
import HooperSoftware.TFG.servicio.UsuarioService;
import HooperSoftware.TFG.servicio.VotacionService;
import HooperSoftware.TFG.servicio.VotoUsuarioService;

@RestController
public class VotacionController {

    private final VotacionService votacionService;
    private final TemporadaService temporadaService;
    private final EquipoService equipoService;

    private final VotoUsuarioService votoUsuarioService;

    private final UsuarioService usuarioService;

    public VotacionController(VotacionService votacionService, TemporadaService temporadaService, EquipoService equipoService, VotoUsuarioService votoUsuarioService, UsuarioService usuarioService) {
        this.votacionService = votacionService;
        this.temporadaService = temporadaService;
        this.equipoService = equipoService;
        this.votoUsuarioService = votoUsuarioService;
        this.usuarioService = usuarioService;
    }

    @GetMapping("/allVotes")
    public ModelAndView showAllVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/allVotes");
        mav.addObject("votes", votacionService.findAll());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/inCourse")
    public ModelAndView showInCourseVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/votesActivate");
        mav.addObject("votes", votacionService.findVotacionesEnCurso());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/allVotes/oficial")
    public ModelAndView showOficialVotesPage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("votaciones/oficialVotes");
        mav.addObject("votes", votacionService.findVotacionesOficiales());
        mav.addObject("temporadas", temporadaService.findAll());
        mav.addObject("categorias", votacionService.findAllCategorias());
        mav.addObject("equipos", equipoService.findAll());
        return mav;
    }

    @GetMapping("/vote/{id}")
    public ModelAndView showVote(
            @PathVariable Integer id) {

        ModelAndView mav
                = new ModelAndView(
                        "votaciones/vote");

        List<Object[]> resultados
                = votoUsuarioService.contarVotosPorOpcion(id);

        mav.addObject("resultados", resultados);

        Votacion votacion
                = votacionService.findVotacionById(id);

        String[] opciones
                = votacion.getOpcionesVotacion()
                        .split(",");
        mav.addObject(
                "votacion",
                votacion);
        mav.addObject(
                "opciones",
                opciones);

        return mav;
    }

    @PostMapping("/vote/{id}")
    public ModelAndView votar(
            @PathVariable Integer id,
            @RequestParam String opcion,
            Principal principal) {

        if (principal == null) {
            return new ModelAndView("redirect:/login");
        }

        if (votoUsuarioService.yaHaVotado(
                principal.getName(),
                id)) {

            return new ModelAndView(
                    "redirect:/vote/" + id);
        }

        VotoUsuario voto = new VotoUsuario();

        voto.setUsername(principal.getName());
        voto.setIdVotacion(id);
        voto.setOpcionElegida(opcion);

        votoUsuarioService.save(voto);

        Usuario usuario
                = usuarioService.findUsuarioByUsernameUsuario(
                        principal.getName());

        if (usuario.getVotosEmitidos() == null) {
            usuario.setVotosEmitidos(0);
        }

        usuario.setVotosEmitidos(
                usuario.getVotosEmitidos() + 1);

        usuarioService.save(usuario);

        Votacion votacion
                = votacionService.findVotacionById(id);

        if (votacion.getTotalVotos() == null) {
            votacion.setTotalVotos(0);
        }

        votacion.setTotalVotos(
                votacion.getTotalVotos() + 1);

        votacionService.save(votacion);

        return new ModelAndView(
                "redirect:/vote/" + id);
    }

    @PreAuthorize("hasAuthority('admin')")
    @PostMapping("/allVotes/new")
    public ModelAndView createVote(
            @RequestParam Categoria categoria,
            @RequestParam String opcionesVotacion,
            @RequestParam String temporada,
            @RequestParam(required = false) String jornada,
            @RequestParam(required = false) String ganador,
            @RequestParam(required = false) Integer duracionVotacion,
            @RequestParam(required = false, defaultValue = "true") Boolean enCurso,
            @RequestParam(required = false, defaultValue = "false") Boolean oficial,
            @RequestParam(required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecha) {

        Votacion votacion = new Votacion();
        votacion.setIdVotacion(votacionService.findNextId());
        votacion.setCategotiaVotacion(categoria);
        votacion.setOpcionesVotacion(normalizeOptions(opcionesVotacion));
        votacion.setTemporada(temporada);
        votacion.setJornada(jornada);
        votacion.setGanador(ganador);
        votacion.setDuracionVotacion(duracionVotacion);
        votacion.setEnCurso(enCurso);
        votacion.setOficial(oficial);
        votacion.setFecha(fecha != null ? fecha : new Date());
        votacion.setTotalVotos(0);

        votacionService.save(votacion);
        return new ModelAndView("redirect:/allVotes");
    }

    private String normalizeOptions(String opciones) {
        return opciones == null ? "" : opciones.replace("\r\n", ",").replace("\n", ",").trim();
    }
}
