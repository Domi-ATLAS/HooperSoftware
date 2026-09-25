package HooperSoftware.TFG.servicio;

import HooperSoftware.TFG.dto.ComparativaDTO;
import HooperSoftware.TFG.dto.ComparativaScenarioDTO;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.repositorio.EquipoRepository;
import HooperSoftware.TFG.repositorio.JugadorRepository;
import HooperSoftware.TFG.repositorio.PartidoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ComparativaService {

    private final JugadorRepository jugadorRepository;
    private final PartidoRepository partidoRepository;
    private final EquipoRepository equipoRepository;

    public ComparativaService(
            JugadorRepository jugadorRepository,
            PartidoRepository partidoRepository,
            EquipoRepository equipoRepository) {
        this.jugadorRepository = jugadorRepository;
        this.partidoRepository = partidoRepository;
        this.equipoRepository = equipoRepository;
    }

    @Transactional(readOnly = true)
    public List<String> findTemporadasDisponibles() {
        Set<String> temporadas = new LinkedHashSet<>();
        for (int year = 2024; year >= 1998; year--) {
            temporadas.add(toSeasonLabel(year));
        }
        return temporadas.stream()
                .filter(temporada -> temporada != null && !temporada.isBlank())
                .toList();
    }

    private String toSeasonLabel(int endYear) {
        return (endYear - 1) + "-" + endYear;
    }

    @Transactional(readOnly = true)
    public ComparativaDTO compararTemporadas(
            String temporadaA,
            String temporadaB,
            List<Integer> equiposIncluidos,
            boolean incluirJugadores,
            boolean incluirPartidos,
            int limiteJugadores) {

        List<Jugador> jugadoresA = incluirJugadores
                ? filtrarJugadores(jugadorRepository.findByTemporadaJugador(temporadaA), equiposIncluidos)
                : List.of();
        List<Jugador> jugadoresB = incluirJugadores
                ? filtrarJugadores(jugadorRepository.findByTemporadaJugador(temporadaB), equiposIncluidos)
                : List.of();
        List<Partido> partidosA = incluirPartidos
                ? filtrarPartidos(partidoRepository.findByTemporada(temporadaA), equiposIncluidos)
                : List.of();
        List<Partido> partidosB = incluirPartidos
                ? filtrarPartidos(partidoRepository.findByTemporada(temporadaB), equiposIncluidos)
                : List.of();

        ComparativaDTO dto = new ComparativaDTO();
        dto.setTemporadaA(temporadaA);
        dto.setTemporadaB(temporadaB);
        dto.setTemporadaATotals(calcularTotales(jugadoresA, partidosA));
        dto.setTemporadaBTotals(calcularTotales(jugadoresB, partidosB));
        dto.setChartRows(crearChartRows(dto.getTemporadaATotals(), dto.getTemporadaBTotals()));
        dto.setTeamRows(crearTeamRows(jugadoresA, jugadoresB, partidosA, partidosB, equiposIncluidos));
        dto.setPlayerRows(crearPlayerRows(jugadoresA, jugadoresB, limiteJugadores));
        dto.setResumen(crearResumenTemporadas(dto));

        return dto;
    }

    @Transactional(readOnly = true)
    public ComparativaScenarioDTO simularPlantilla(
            String temporada,
            Integer equipoReferenciaId,
            List<Integer> jugadorIds) {

        Equipo equipo = equipoRepository.findEquipoById(equipoReferenciaId);
        List<Jugador> plantillaNueva = findJugadoresByIds(jugadorIds);
        List<Jugador> plantillaReferencia = jugadorRepository
                .findByTemporadaJugadorAndEquipoId(temporada, equipoReferenciaId);

        ComparativaScenarioDTO dto = crearScenarioBase(
                "Nueva plantilla",
                temporada,
                equipo,
                plantillaReferencia,
                plantillaNueva);

        dto.setResumen("La plantilla seleccionada se proyecta a "
                + dto.getVictoriasSimuladas()
                + " victorias frente a "
                + dto.getVictoriasReferencia()
                + " victorias estimadas del equipo de referencia.");

        return dto;
    }

    @Transactional(readOnly = true)
    public ComparativaScenarioDTO simularTraspaso(
            String temporada,
            Integer equipoId,
            Integer jugadorSaleId,
            Integer jugadorLlegaId) {

        Equipo equipo = equipoRepository.findEquipoById(equipoId);
        Jugador sale = jugadorRepository.findJugadorById(jugadorSaleId);
        Jugador llega = jugadorRepository.findJugadorById(jugadorLlegaId);
        List<Jugador> referencia = jugadorRepository.findByTemporadaJugadorAndEquipoId(temporada, equipoId);
        List<Jugador> simulada = new ArrayList<>(referencia);

        simulada.removeIf(jugador -> jugador.getIdJugador().equals(jugadorSaleId));
        if (llega != null) {
            simulada.add(llega);
        }

        ComparativaScenarioDTO dto = crearScenarioBase(
                "Traspaso sobre temporada",
                temporada,
                equipo,
                referencia,
                simulada);

        String saleName = sale == null ? "jugador saliente" : sale.getNombreJugador();
        String llegaName = llega == null ? "jugador entrante" : llega.getNombreJugador();
        dto.setResumen("Se compara la temporada original de "
                + dto.getEquipoReferencia()
                + " con el escenario en el que sale "
                + saleName
                + " y entra "
                + llegaName
                + ".");

        return dto;
    }

    private ComparativaScenarioDTO crearScenarioBase(
            String titulo,
            String temporada,
            Equipo equipo,
            List<Jugador> referencia,
            List<Jugador> simulada) {

        ComparativaScenarioDTO dto = new ComparativaScenarioDTO();
        double ratingReferencia = calcularRatingPlantilla(referencia);
        double ratingSimulado = calcularRatingPlantilla(simulada);

        dto.setTitulo(titulo);
        dto.setTemporada(temporada);
        dto.setEquipoReferencia(equipo == null ? "Equipo seleccionado" : equipo.getNombreEquipo());
        dto.setJugadores(simulada.size());
        dto.setRatingReferencia(redondear(ratingReferencia));
        dto.setRatingSimulado(redondear(ratingSimulado));
        dto.setVictoriasReferencia(convertirRatingVictorias(ratingReferencia));
        dto.setVictoriasSimuladas(convertirRatingVictorias(ratingSimulado));
        dto.setDiferenciaVictorias(dto.getVictoriasSimuladas() - dto.getVictoriasReferencia());
        dto.setPuntosReferencia(calcularPuntosPlantilla(referencia));
        dto.setPuntosSimulados(calcularPuntosPlantilla(simulada));
        dto.setDefensaReferencia(calcularDefensaPlantilla(referencia));
        dto.setDefensaSimulada(calcularDefensaPlantilla(simulada));
        dto.setJugadoresSeleccionados(simulada.stream()
                .map(this::nombreJugadorConTemporada)
                .toList());

        return dto;
    }

    private List<Jugador> filtrarJugadores(List<Jugador> jugadores, List<Integer> equiposIncluidos) {
        if (equiposIncluidos == null || equiposIncluidos.isEmpty()) {
            return jugadores;
        }

        return jugadores.stream()
                .filter(jugador -> jugador.getEquipo() != null)
                .filter(jugador -> equiposIncluidos.contains(jugador.getEquipo().getIdEquipo()))
                .toList();
    }

    private List<Partido> filtrarPartidos(List<Partido> partidos, List<Integer> equiposIncluidos) {
        if (equiposIncluidos == null || equiposIncluidos.isEmpty()) {
            return partidos;
        }

        return partidos.stream()
                .filter(partido -> equipoIncluido(partido.getEquipoLocalTa(), equiposIncluidos)
                        || equipoIncluido(partido.getEquipoVisitanteTa(), equiposIncluidos))
                .toList();
    }

    private boolean equipoIncluido(Equipo equipo, List<Integer> equiposIncluidos) {
        return equipo != null && equiposIncluidos.contains(equipo.getIdEquipo());
    }

    private ComparativaDTO.SeasonTotals calcularTotales(List<Jugador> jugadores, List<Partido> partidos) {
        ComparativaDTO.SeasonTotals totals = new ComparativaDTO.SeasonTotals();

        totals.setJugadores(jugadores.size());
        totals.setPartidos(partidos.size());
        totals.setPuntos(jugadores.stream().mapToInt(jugador -> stat(jugador).getPuntosTotales()).sum());
        totals.setAsistencias(jugadores.stream().mapToInt(jugador -> stat(jugador).getAsistenciasTotales()).sum());
        totals.setRebotes(jugadores.stream().mapToInt(jugador -> stat(jugador).getRebotesTotales()).sum());
        totals.setRobos(jugadores.stream().mapToInt(jugador -> stat(jugador).getRobosTotales()).sum());
        totals.setTapones(jugadores.stream().mapToInt(jugador -> stat(jugador).getTaponesTotales()).sum());
        totals.setTriples(jugadores.stream().mapToInt(jugador -> stat(jugador).getTriplesAnotados()).sum());
        totals.setPuntosPorJugador(redondear(dividir(totals.getPuntos(), Math.max(1, totals.getJugadores()))));
        totals.setPuntosPorPartido(redondear(dividir(puntosPartidos(partidos), Math.max(1, totals.getPartidos()))));

        return totals;
    }

    private List<ComparativaDTO.ChartRow> crearChartRows(
            ComparativaDTO.SeasonTotals a,
            ComparativaDTO.SeasonTotals b) {

        List<ComparativaDTO.ChartRow> rows = new ArrayList<>();
        rows.add(chart("Jugadores", a.getJugadores(), b.getJugadores()));
        rows.add(chart("Partidos", a.getPartidos(), b.getPartidos()));
        rows.add(chart("Puntos", a.getPuntos(), b.getPuntos()));
        rows.add(chart("Asistencias", a.getAsistencias(), b.getAsistencias()));
        rows.add(chart("Rebotes", a.getRebotes(), b.getRebotes()));
        rows.add(chart("Robos", a.getRobos(), b.getRobos()));
        rows.add(chart("Tapones", a.getTapones(), b.getTapones()));
        rows.add(chart("Triples", a.getTriples(), b.getTriples()));
        rows.add(chart("Pts/jugador", a.getPuntosPorJugador(), b.getPuntosPorJugador()));
        rows.add(chart("Pts/partido", a.getPuntosPorPartido(), b.getPuntosPorPartido()));
        return rows;
    }

    private ComparativaDTO.ChartRow chart(String label, double rawA, double rawB) {
        double max = Math.max(1, Math.max(rawA, rawB));
        return new ComparativaDTO.ChartRow(
                label,
                redondear(rawA * 100 / max),
                redondear(rawB * 100 / max),
                formatear(rawA),
                formatear(rawB));
    }

    private List<ComparativaDTO.TeamCompareRow> crearTeamRows(
            List<Jugador> jugadoresA,
            List<Jugador> jugadoresB,
            List<Partido> partidosA,
            List<Partido> partidosB,
            List<Integer> equiposIncluidos) {

        List<Equipo> equipos = equipoRepository.findAll().stream()
                .filter(equipo -> equiposIncluidos == null
                        || equiposIncluidos.isEmpty()
                        || equiposIncluidos.contains(equipo.getIdEquipo()))
                .sorted(Comparator.comparing(Equipo::getNombreEquipo, Comparator.nullsLast(String::compareTo)))
                .toList();

        return equipos.stream()
                .map(equipo -> new ComparativaDTO.TeamCompareRow(
                        equipo.getNombreEquipo(),
                        countPlayersByTeam(jugadoresA, equipo),
                        countPlayersByTeam(jugadoresB, equipo),
                        sumPointsByTeam(jugadoresA, equipo),
                        sumPointsByTeam(jugadoresB, equipo),
                        countGamesByTeam(partidosA, equipo),
                        countGamesByTeam(partidosB, equipo)))
                .filter(row -> row.getJugadoresA() > 0
                        || row.getJugadoresB() > 0
                        || row.getPartidosA() > 0
                        || row.getPartidosB() > 0)
                .limit(24)
                .toList();
    }

    private List<ComparativaDTO.PlayerCompareRow> crearPlayerRows(
            List<Jugador> jugadoresA,
            List<Jugador> jugadoresB,
            int limite) {

        Map<String, Jugador> porNombreB = jugadoresB.stream()
                .collect(Collectors.toMap(
                        jugador -> normalize(jugador.getNombreJugador()),
                        jugador -> jugador,
                        (primero, repetido) -> primero,
                        LinkedHashMap::new));

        return jugadoresA.stream()
                .filter(jugador -> porNombreB.containsKey(normalize(jugador.getNombreJugador())))
                .sorted(Comparator.comparingInt((Jugador jugador) -> stat(jugador).getPuntosTotales()).reversed())
                .limit(Math.max(5, Math.min(50, limite)))
                .map(jugadorA -> {
                    Jugador jugadorB = porNombreB.get(normalize(jugadorA.getNombreJugador()));
                    EstadisticasJugador statsA = stat(jugadorA);
                    EstadisticasJugador statsB = stat(jugadorB);
                    return new ComparativaDTO.PlayerCompareRow(
                            jugadorA.getNombreJugador(),
                            nombreEquipo(jugadorA),
                            nombreEquipo(jugadorB),
                            statsA.getPuntosTotales(),
                            statsB.getPuntosTotales(),
                            statsA.getAsistenciasTotales(),
                            statsB.getAsistenciasTotales(),
                            statsA.getRebotesTotales(),
                            statsB.getRebotesTotales());
                })
                .toList();
    }

    private String crearResumenTemporadas(ComparativaDTO dto) {
        int diffPlayers = dto.getTemporadaBTotals().getJugadores() - dto.getTemporadaATotals().getJugadores();
        int diffGames = dto.getTemporadaBTotals().getPartidos() - dto.getTemporadaATotals().getPartidos();
        int diffPoints = dto.getTemporadaBTotals().getPuntos() - dto.getTemporadaATotals().getPuntos();

        return "La comparativa enfrenta "
                + dto.getTemporadaA()
                + " y "
                + dto.getTemporadaB()
                + ". Diferencia detectada: "
                + diffPlayers
                + " jugadores, "
                + diffGames
                + " partidos y "
                + diffPoints
                + " puntos totales.";
    }

    private List<Jugador> findJugadoresByIds(List<Integer> ids) {
        if (ids == null) {
            return List.of();
        }

        return ids.stream()
                .filter(Objects::nonNull)
                .distinct()
                .map(jugadorRepository::findJugadorById)
                .filter(Objects::nonNull)
                .limit(12)
                .toList();
    }

    private double calcularRatingPlantilla(List<Jugador> jugadores) {
        if (jugadores == null || jugadores.isEmpty()) {
            return 0;
        }

        double total = 0;
        for (Jugador jugador : jugadores) {
            EstadisticasJugador stats = stat(jugador);
            double games = Math.max(1, stats.getPartidosJugadosJug());
            double ataque = dividir(stats.getPuntosTotales(), games) * 1.15
                    + dividir(stats.getAsistenciasTotales(), games) * 1.8
                    + dividir(stats.getTriplesAnotados(), games) * 1.1;
            double defensa = dividir(stats.getRebotesTotales(), games) * 1.1
                    + dividir(stats.getRobosTotales(), games) * 2.4
                    + dividir(stats.getTaponesTotales(), games) * 2.6;
            total += ataque + defensa;
        }

        return Math.min(100, total / jugadores.size() * 3.2);
    }

    private int convertirRatingVictorias(double rating) {
        return Math.max(15, Math.min(70, (int) Math.round(rating * 0.62)));
    }

    private int calcularPuntosPlantilla(List<Jugador> jugadores) {
        return jugadores.stream()
                .mapToInt(jugador -> stat(jugador).getPuntosTotales())
                .sum();
    }

    private int calcularDefensaPlantilla(List<Jugador> jugadores) {
        return jugadores.stream()
                .mapToInt(jugador -> stat(jugador).getRebotesTotales()
                        + stat(jugador).getRobosTotales() * 2
                        + stat(jugador).getTaponesTotales() * 2)
                .sum();
    }

    private int countPlayersByTeam(List<Jugador> jugadores, Equipo equipo) {
        return (int) jugadores.stream()
                .filter(jugador -> mismaFranquicia(jugador.getEquipo(), equipo))
                .count();
    }

    private int sumPointsByTeam(List<Jugador> jugadores, Equipo equipo) {
        return jugadores.stream()
                .filter(jugador -> mismaFranquicia(jugador.getEquipo(), equipo))
                .mapToInt(jugador -> stat(jugador).getPuntosTotales())
                .sum();
    }

    private int countGamesByTeam(List<Partido> partidos, Equipo equipo) {
        return (int) partidos.stream()
                .filter(partido -> mismaFranquicia(partido.getEquipoLocalTa(), equipo)
                        || mismaFranquicia(partido.getEquipoVisitanteTa(), equipo)
                        || mismoNombre(partido.getEquipoLocal(), equipo.getNombreEquipo())
                        || mismoNombre(partido.getEquipoVisitante(), equipo.getNombreEquipo()))
                .count();
    }

    private int puntosPartidos(List<Partido> partidos) {
        return partidos.stream()
                .mapToInt(this::puntosPartido)
                .sum();
    }

    private int puntosPartido(Partido partido) {
        if (partido.getResultadoTotal() == null || !partido.getResultadoTotal().contains("-")) {
            return 0;
        }

        String[] partes = partido.getResultadoTotal().split("-");
        if (partes.length != 2) {
            return 0;
        }

        return parseInt(partes[0]) + parseInt(partes[1]);
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException exception) {
            return 0;
        }
    }

    private boolean mismaFranquicia(Equipo a, Equipo b) {
        if (a == null || b == null) {
            return false;
        }
        return Objects.equals(a.getIdEquipo(), b.getIdEquipo())
                || mismoNombre(a.getNombreEquipo(), b.getNombreEquipo())
                || mismoNombre(a.getSiglas(), b.getSiglas());
    }

    private boolean mismoNombre(String a, String b) {
        return normalize(a).equals(normalize(b));
    }

    private String nombreJugadorConTemporada(Jugador jugador) {
        String temporada = jugador.getTemporadaJugador() == null || jugador.getTemporadaJugador().isBlank()
                ? "Base"
                : jugador.getTemporadaJugador();
        return jugador.getNombreJugador() + " - " + nombreEquipo(jugador) + " - " + temporada;
    }

    private String nombreEquipo(Jugador jugador) {
        return jugador.getEquipo() == null ? "Sin equipo" : jugador.getEquipo().getNombreEquipo();
    }

    private EstadisticasJugador stat(Jugador jugador) {
        EstadisticasJugador stats = jugador.getEstadisticasJug();
        if (stats == null) {
            stats = new EstadisticasJugador();
        }
        stats.setPuntosTotales(valor(stats.getPuntosTotales()));
        stats.setAsistenciasTotales(valor(stats.getAsistenciasTotales()));
        stats.setRebotesTotales(valor(stats.getRebotesTotales()));
        stats.setRobosTotales(valor(stats.getRobosTotales()));
        stats.setTaponesTotales(valor(stats.getTaponesTotales()));
        stats.setTriplesAnotados(valor(stats.getTriplesAnotados()));
        stats.setPartidosJugadosJug(valor(stats.getPartidosJugadosJug()));
        return stats;
    }

    private int valor(Integer value) {
        return value == null ? 0 : value;
    }

    private double dividir(double value, double divisor) {
        return divisor == 0 ? 0 : value / divisor;
    }

    private double redondear(double value) {
        return Math.round(value * 10.0) / 10.0;
    }

    private String formatear(double value) {
        if (Math.floor(value) == value) {
            return String.valueOf((int) value);
        }
        return String.valueOf(redondear(value));
    }

    private String normalize(String value) {
        return value == null ? "" : value.trim().toLowerCase();
    }
}
