package HooperSoftware.TFG.servicio;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.dto.AIReportDTO;
import HooperSoftware.TFG.dto.DynastyResultDTO;
import HooperSoftware.TFG.dto.GMTradeDTO;
import HooperSoftware.TFG.dto.LiveGameSimulationDTO;
import HooperSoftware.TFG.dto.LineupAnalysisDTO;
import HooperSoftware.TFG.dto.LineupAnalysisDTO.LineupPickDTO;
import HooperSoftware.TFG.dto.LineupAnalysisDTO.LineupRecommendationDTO;
import HooperSoftware.TFG.dto.LineupAnalysisDTO.SlotSuggestionDTO;
import HooperSoftware.TFG.dto.LineupAnalysisDTO.TeamFitDTO;
import HooperSoftware.TFG.dto.MatchDTO;
import HooperSoftware.TFG.dto.PlayoffBracketDTO;
import HooperSoftware.TFG.dto.PlayoffPredictionDTO;
import HooperSoftware.TFG.dto.SeasonSimulationDTO;
import HooperSoftware.TFG.dto.SeriesResultDTO;
import HooperSoftware.TFG.dto.TeamStandingDTO;
import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;

@Service
public class SimulacionService {

    private final JugadorService jugadorService;
    private final EquipoService equipoService;

    public SimulacionService(JugadorService jugadorService, EquipoService equipoService) {
        this.jugadorService = jugadorService;
        this.equipoService = equipoService;
    }

    // ================= TRADE =================
    public TradeResultDTO evaluarTrade(Jugador sale, Jugador llega) {

        int score = 50;

        score += (llega.getAnosAllStarJug() - sale.getAnosAllStarJug()) * 5;
        score += (llega.getAnosNbaJug() - sale.getAnosNbaJug()) * 2;

        if (llega.getEdadJug() < sale.getEdadJug()) {
            score += 10;
        }

        if (llega.getPosicion().equalsIgnoreCase(sale.getPosicion())) {
            score += 10;
        }

        score = Math.max(0, Math.min(100, score));

        String evaluacion;
        String color;

        if (score >= 70) {
            evaluacion = "Gran trade";
            color = "green";
        } else if (score >= 50) {
            evaluacion = "Trade equilibrado";
            color = "orange";
        } else {
            evaluacion = "Mala decisión";
            color = "red";
        }

        return new TradeResultDTO(score, evaluacion, color);
    }

    // ================= IMPACTO =================
    public TeamImpactDTO calcularImpactoTrade(Jugador sale, Jugador llega) {

        Equipo equipo = sale.getEquipo();

        if (equipo == null || equipo.getJugadores() == null) {
            return new TeamImpactDTO(0, 0, 0, 0, 0);
        }

        List<Jugador> plantilla = new ArrayList<>(equipo.getJugadores());

        double ratingAntes = calcularRatingEquipo(plantilla);

        plantilla.removeIf(j -> j.getIdJugador().equals(sale.getIdJugador()));
        plantilla.add(llega);

        double ratingDespues = calcularRatingEquipo(plantilla);

        int victoriasAntes = convertirRatingAWins(ratingAntes);
        int victoriasDespues = convertirRatingAWins(ratingDespues);

        int diferencia = victoriasDespues - victoriasAntes;

        int probabilidadA;
        int probabilidadB;

        if (victoriasDespues > victoriasAntes) {

            probabilidadA = 50 + diferencia;
            probabilidadB = 100 - probabilidadA;

        } else {

            probabilidadB = 50 + diferencia;
            probabilidadA = 100 - probabilidadB;
        }

        probabilidadA = Math.max(1, Math.min(99, probabilidadA));
        probabilidadB = Math.max(1, Math.min(99, probabilidadB));

        String momentum;

        if (diferencia >= 20) {

            momentum = "Dominio absoluto";

        } else if (diferencia >= 10) {

            momentum = "Equipo en gran momento";

        } else {

            momentum = "Partido muy igualado";
        }

        return new TeamImpactDTO(
                ratingAntes,
                ratingDespues,
                victoriasAntes,
                victoriasDespues,
                diferencia);
    }

    // ================= WINS PREDICTION =================
    public WinsPredictionDTO calcularWins(Jugador sale, Jugador llega) {

        Equipo equipo = sale.getEquipo();

        if (equipo == null || equipo.getJugadores() == null) {
            return new WinsPredictionDTO(0, 0, 0, "N/A", "N/A", "Sin datos");
        }

        List<Jugador> plantilla = new ArrayList<>(equipo.getJugadores());

        double ratingAntes = calcularRatingEquipo(plantilla);

        plantilla.removeIf(j -> j.getIdJugador().equals(sale.getIdJugador()));
        plantilla.add(llega);

        double ratingDespues = calcularRatingEquipo(plantilla);

        int winsAntes = convertirRatingAWins(ratingAntes);
        int winsDespues = convertirRatingAWins(ratingDespues);

        int diff = winsDespues - winsAntes;

        String tierAntes = calcularTier(winsAntes);
        String tierDespues = calcularTier(winsDespues);

        String mensaje = generarMensajeEvaluacion(diff, tierAntes, tierDespues);

        return new WinsPredictionDTO(
                winsAntes,
                winsDespues,
                diff,
                tierAntes,
                tierDespues,
                mensaje);
    }

    // ================= EVALUACION =================
    private String generarMensajeEvaluacion(int diff, String antes, String despues) {

        if (diff >= 8) {
            return "Trade élite: cambia completamente el equipo";
        }
        if (diff >= 4) {
            return "Mejora clara: el equipo sube de nivel";
        }
        if (diff >= 1) {
            return "Ligera mejora";
        }
        if (diff == 0) {
            return "No cambia el rendimiento";
        }
        if (diff >= -3) {
            return "Riesgo leve";
        }
        return "Empeora claramente el equipo";
    }

    private String calcularTier(int wins) {

        if (wins >= 55) {
            return "Contender";
        }
        if (wins >= 45) {
            return "Playoff";
        }
        if (wins >= 35) {
            return "Medio";
        }
        return "Tanking";
    }

    private int convertirRatingAWins(double rating) {
        int wins = (int) (rating * 1.5);
        return Math.max(15, Math.min(65, wins));
    }

    // ================= HELPERS =================
    private double calcularRatingEquipo(List<Jugador> jugadores) {

        if (jugadores == null || jugadores.isEmpty()) {
            return 0;
        }

        double total = 0;

        for (Jugador j : jugadores) {

            double ratingJugador = (j.getAnosAllStarJug() * 5)
                    + (j.getAnosNbaJug() * 2)
                    - (j.getEdadJug() * 0.5);

            total += ratingJugador;
        }

        return total / jugadores.size();
    }

    // ================= SUGERENCIAS =================
    public List<TradeSuggestionDTO> sugerirMejorTrade(Jugador base) {

        List<Jugador> todos = jugadorService.findAll();
        List<TradeSuggestionDTO> sugerencias = new ArrayList<>();

        for (Jugador j : todos) {
            if (!j.getIdJugador().equals(base.getIdJugador())) {
                int score = calcularFit(base, j);
                sugerencias.add(new TradeSuggestionDTO(j, score));
            }
        }

        sugerencias.sort(Comparator.comparingInt(TradeSuggestionDTO::getScore).reversed());

        return sugerencias.subList(0, Math.min(5, sugerencias.size()));
    }

    public List<TradeSuggestionDTO> sugerirParaEquipo(Equipo equipo) {

        List<Jugador> todos = jugadorService.findAll();
        List<TradeSuggestionDTO> sugerencias = new ArrayList<>();

        for (Jugador j : todos) {
            if (j.getEquipo() != null
                    && !j.getEquipo().getIdEquipo().equals(equipo.getIdEquipo())) {

                int score = calcularFitEquipo(equipo, j);
                sugerencias.add(new TradeSuggestionDTO(j, score));
            }
        }

        sugerencias.sort(Comparator.comparingInt(TradeSuggestionDTO::getScore).reversed());

        return sugerencias.subList(0, Math.min(5, sugerencias.size()));
    }

    private int calcularFit(Jugador a, Jugador b) {
        int score = 50;

        if (!a.getPosicion().equalsIgnoreCase(b.getPosicion())) {
            score += 15;
        }

        score += (b.getAnosAllStarJug() - a.getAnosAllStarJug()) * 5;
        score -= Math.abs(b.getEdadJug() - a.getEdadJug());

        return Math.max(0, Math.min(100, score));
    }

    private int calcularFitEquipo(Equipo equipo, Jugador j) {
        int score = 50;

        if (j.getEdadJug() < 28) {
            score += 10;
        }

        score += j.getAnosAllStarJug() * 4;
        score += j.getAnosNbaJug();

        return Math.max(0, Math.min(100, score));
    }

    // ================= PLAYOFF PREDICTION =================
    public PlayoffPredictionDTO predecirPlayoffs(Equipo equipo) {

        if (equipo == null || equipo.getJugadores() == null) {
            return new PlayoffPredictionDTO(0, 0, 0, "Desconocido", "Sin datos");
        }

        double rating = calcularRatingEquipo(equipo.getJugadores());

        int probPlayoffs = (int) Math.min(100, rating * 1.5);
        int probFinales = (int) Math.min(100, rating);
        int probCampeon = (int) Math.min(100, rating * 0.6);

        String tier;
        String mensaje;

        if (rating >= 85) {
            tier = "Contender";
            mensaje = "Equipo candidato serio al anillo.";
        } else if (rating >= 70) {
            tier = "Playoff fuerte";
            mensaje = "Equipo competitivo, peligro en playoffs.";
        } else if (rating >= 55) {
            tier = "Play-in";
            mensaje = "Puede entrar en playoffs pero sin garantías.";
        } else {
            tier = "Lotería";
            mensaje = "Equipo en reconstrucción.";
        }

        return new PlayoffPredictionDTO(
                probPlayoffs,
                probFinales,
                probCampeon,
                tier,
                mensaje);
    }

    // ================= BRACKET PLAYOFFS =================
    public PlayoffBracketDTO simularBracketNBA() {

        List<Equipo> equipos = jugadorService.findAll().stream()
                .map(Jugador::getEquipo)
                .filter(e -> e != null)
                .distinct()
                .collect(Collectors.toList());

        // ordenar por "rating"
        equipos.sort((a, b) -> Double.compare(
                calcularRatingEquipo(b.getJugadores()),
                calcularRatingEquipo(a.getJugadores())));

        // coger top 8
        equipos = new ArrayList<>(equipos.subList(0, Math.min(8, equipos.size())));

        List<MatchDTO> primeraRonda = new ArrayList<>();
        List<Equipo> ganadoresR1 = new ArrayList<>();

        // emparejamientos 1vs8, 2vs7...
        for (int i = 0; i < equipos.size() / 2; i++) {

            Equipo e1 = equipos.get(i);
            Equipo e2 = equipos.get(equipos.size() - 1 - i);

            SeriesResultDTO serie = simularSerie(e1, e2);
            Equipo ganador = serie.getGanador();

            primeraRonda.add(new MatchDTO(
                    e1.getNombreEquipo(),
                    e1.getSiglas(),
                    e2.getNombreEquipo(),
                    e2.getSiglas(),
                    ganador.getNombreEquipo(),
                    ganador.getSiglas(),
                    serie.getWinsA(),
                    serie.getWinsB()));
            ganadoresR1.add(ganador);
        }

        // SEMIS
        List<MatchDTO> semifinales = new ArrayList<>();
        List<Equipo> ganadoresSemis = new ArrayList<>();

        for (int i = 0; i < ganadoresR1.size(); i += 2) {

            if (i + 1 >= ganadoresR1.size()) {
                break; //  FIX
            }
            Equipo g1 = ganadoresR1.get(i);
            Equipo g2 = ganadoresR1.get(i + 1);

            SeriesResultDTO serie = simularSerie(g1, g2);
            Equipo ganador = serie.getGanador();

            semifinales.add(new MatchDTO(g1.getNombreEquipo(),
                    g1.getSiglas(),
                    g2.getNombreEquipo(),
                    g2.getSiglas(),
                    ganador.getNombreEquipo(),
                    ganador.getSiglas(),
                    serie.getWinsA(),
                    serie.getWinsB()));

            ganadoresSemis.add(ganador);
        }

        // FINAL
        if (ganadoresSemis.size() < 2) {

            return new PlayoffBracketDTO(
                    primeraRonda,
                    semifinales,
                    List.of(),
                    "Sin campeón",
                    "",
                    "N/A");
        }

        Equipo final1 = ganadoresSemis.get(0);
        Equipo final2 = ganadoresSemis.get(1);

        SeriesResultDTO serie = simularSerie(final1, final2);
        Equipo campeon = serie.getGanador();

        List<MatchDTO> finales = List.of(
                new MatchDTO(
                        final1.getNombreEquipo(), final1.getSiglas(),
                        final2.getNombreEquipo(), final2.getSiglas(),
                        campeon.getNombreEquipo(), campeon.getSiglas(),
                        serie.getWinsA(), serie.getWinsB()));

        // MVP random del equipo campeón
        String mvp = "Jugador estrella de " + campeon.getNombreEquipo();

        return new PlayoffBracketDTO(
                primeraRonda,
                semifinales,
                finales,
                campeon.getNombreEquipo(),
                campeon.getSiglas(),
                mvp);
    }

    // ================= SIMULACIÓN DE SERIE =================
    private SeriesResultDTO simularSerie(Equipo a, Equipo b) {

        double ratingA = calcularRatingEquipo(a.getJugadores());
        double ratingB = calcularRatingEquipo(b.getJugadores());

        int winsA = 0;
        int winsB = 0;

        Random random = new Random();

        while (winsA < 4 && winsB < 4) {

            double probA = ratingA / (ratingA + ratingB);

            if (random.nextDouble() < probA) {
                winsA++;
            } else {
                winsB++;
            }
        }

        Equipo ganador = winsA > winsB ? a : b;

        return new SeriesResultDTO(
                ganador,
                winsA,
                winsB);
    }

    // ================= TEMPORADA COMPLETA NBA =================
    public SeasonSimulationDTO simularTemporadaNBA() {

        List<Equipo> equipos = jugadorService.findAll().stream()
                .map(Jugador::getEquipo)
                .filter(e -> e != null)
                .distinct()
                .collect(Collectors.toList());

        List<TeamStandingDTO> standings = new ArrayList<>();

        Equipo mejorEquipo = null;
        double mejorRating = 0;

        for (Equipo equipo : equipos) {

            double rating = calcularRatingEquipo(equipo.getJugadores());

            int victorias = (int) ((rating / 100.0) * 82);
            victorias = Math.max(15, Math.min(70, victorias));
            int derrotas = 82 - victorias;

            standings.add(new TeamStandingDTO(
                    equipo.getNombreEquipo(),
                    equipo.getSiglas(),
                    victorias,
                    derrotas,
                    valorSeguro(equipo.getPartidosGanados())));

            if (rating > mejorRating) {
                mejorRating = rating;
                mejorEquipo = equipo;
            }
        }

        standings.sort((a, b) -> Integer.compare(b.getVictorias(), a.getVictorias()));

        String mvp = "Superstar de " + mejorEquipo.getNombreEquipo();

        return new SeasonSimulationDTO(
                standings,
                mejorEquipo.getNombreEquipo(),
                mejorEquipo.getSiglas(),
                mvp);
    }

    // ================= LIVE GAME SIMULATION =================
    public LiveGameSimulationDTO simularPartidoLive(
            Integer equipo1Id,
            Integer equipo2Id) {

        Equipo a = equipoService.findEquipoById(equipo1Id);
        Equipo b = equipoService.findEquipoById(equipo2Id);

        System.out.println("Equipo A = " + a);
        System.out.println("Equipo B = " + b);
        Random random = new Random();

        int q1a = 20 + random.nextInt(16);
        int q1b = 20 + random.nextInt(16);

        int q2a = q1a + 20 + random.nextInt(16);
        int q2b = q1b + 20 + random.nextInt(16);

        int q3a = q2a + 20 + random.nextInt(16);
        int q3b = q2b + 20 + random.nextInt(16);

        int finalA = q3a + 20 + random.nextInt(16);
        int finalB = q3b + 20 + random.nextInt(16);

        String ganador = finalA >= finalB
                ? a.getNombreEquipo()
                : b.getNombreEquipo();

        String mvp = "Superstar de " + ganador;

        double ratingA = calcularRatingEquipo(a.getJugadores());
        double ratingB = calcularRatingEquipo(b.getJugadores());

        int probabilidadA = (int) ((ratingA / (ratingA + ratingB)) * 100);

        int probabilidadB = 100 - probabilidadA;

        int diferenciaMarcador = Math.abs(finalA - finalB);

        String momentum;

        if (diferenciaMarcador >= 20) {
            momentum = "Dominio absoluto";
        } else if (diferenciaMarcador >= 10) {
            momentum = "Partido controlado";
        } else {
            momentum = "Final ajustado";
        }
        return new LiveGameSimulationDTO(
                a.getNombreEquipo(),
                a.getSiglas(),
                b.getNombreEquipo(),
                b.getSiglas(),
                q1a,
                q1b,
                q2a,
                q2b,
                q3a,
                q3b,
                finalA,
                finalB,
                ganador,
                mvp,
                probabilidadA,
                probabilidadB,
                momentum);
    }
    // ================= GM TRADE SIMULATION =================

    public List<GMTradeDTO> buscarMejoresTrades(
            Integer jugadorId) {

        Jugador base = jugadorService.findJugadorById(jugadorId);

        return jugadorService.findAll().stream()
                .filter(j -> !j.getIdJugador()
                .equals(base.getIdJugador()))
                .filter(j -> j.getEquipo() != null)
                .map(j -> {

                    int mejora = new Random().nextInt(10);

                    return new GMTradeDTO(
                            j.getNombreJugador(),
                            j.getEquipo().getNombreEquipo(),
                            mejora);
                })
                .sorted((a, b) -> b.getMejoraWins()
                .compareTo(a.getMejoraWins()))
                .limit(5)
                .toList();
    }

    public DynastyResultDTO simularDinastia(
            Integer equipoId) {

        Equipo equipo = equipoService.findEquipoById(equipoId);

        Random random = new Random();

        List<String> temporadas = new ArrayList<>();

        int titulos = 0;
        int victorias = 0;

        for (int ano = 1; ano <= 5; ano++) {

            int wins = 35 + random.nextInt(31);

            victorias += wins;

            if (wins >= 60) {

                temporadas.add(
                        "Año " + ano
                        + " → Campeón NBA");

                titulos++;

            } else if (wins >= 55) {

                temporadas.add(
                        "Año " + ano
                        + " → Final Conferencia");

            } else if (wins >= 50) {

                temporadas.add(
                        "Año " + ano
                        + " → Semifinal Conferencia");

            } else {

                temporadas.add(
                        "Año " + ano
                        + " → " + wins + "-82");
            }
        }

        int dynastyScore = Math.min(
                100,
                titulos * 30
                + victorias / 5);

        return new DynastyResultDTO(
                equipo.getNombreEquipo(),
                equipo.getSiglas(),
                temporadas,
                titulos,
                victorias,
                dynastyScore);
    }

    // ================= INFORME DE EQUIPO =================
    public AIReportDTO generarInformeEquipo(Integer equipoId) {

        Equipo equipo = equipoService.findEquipoById(equipoId);
        List<Jugador> plantilla = equipo.getJugadores() == null
                ? List.of()
                : equipo.getJugadores();

        if (plantilla.isEmpty()) {
            return new AIReportDTO(
                    equipo.getNombreEquipo(),
                    equipo.getSiglas(),
                    0,
                    0,
                    0,
                    0,
                    15,
                    25,
                    "Sin datos",
                    "No hay jugadores suficientes para construir un diagnóstico fiable.",
                    "Completar datos de plantilla antes de tomar decisiones.",
                    List.of("Plantilla sin jugadores asociados en la base de datos."));
        }

        double rating = calcularRatingEquipo(plantilla);
        double edadMedia = plantilla.stream()
                .map(Jugador::getEdadJug)
                .filter(v -> v != null)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0);
        double experienciaMedia = plantilla.stream()
                .map(Jugador::getAnosNbaJug)
                .filter(v -> v != null)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0);
        int allStars = plantilla.stream()
                .map(Jugador::getAnosAllStarJug)
                .filter(v -> v != null)
                .mapToInt(Integer::intValue)
                .sum();

        int victorias = convertirRatingAWins(rating);
        String tier = calcularTier(victorias);
        int confianza = calcularConfianza(plantilla, rating);

        List<String> factores = new ArrayList<>();
        factores.add("Rating de plantilla estimado: " + redondear(rating));
        factores.add("Edad media: " + redondear(edadMedia) + " años");
        factores.add("Experiencia media NBA: " + redondear(experienciaMedia) + " años");
        factores.add("Historial All-Star acumulado: " + allStars);

        return new AIReportDTO(
                equipo.getNombreEquipo(),
                equipo.getSiglas(),
                redondear(rating),
                redondear(edadMedia),
                redondear(experienciaMedia),
                allStars,
                victorias,
                confianza,
                tier,
                construirDiagnostico(victorias, edadMedia, allStars),
                construirRecomendacion(victorias, edadMedia, allStars),
                factores);
    }

    private int calcularConfianza(List<Jugador> plantilla, double rating) {
        int confianza = 45;
        confianza += Math.min(25, plantilla.size() * 2);
        if (rating > 0) {
            confianza += 20;
        }

        long jugadoresConDatos = plantilla.stream()
                .filter(j -> j.getEdadJug() != null
                && j.getAnosNbaJug() != null
                && j.getAnosAllStarJug() != null)
                .count();

        confianza += (int) Math.min(10, jugadoresConDatos);
        return Math.max(25, Math.min(95, confianza));
    }

    private String construirDiagnostico(int victorias, double edadMedia, int allStars) {
        if (victorias >= 55 && allStars >= 6) {
            return "Los datos muestran un núcleo candidato al título con talento diferencial y rendimiento alto.";
        }
        if (victorias >= 45) {
            return "El análisis clasifica al equipo como competitivo, con opciones claras de playoff.";
        }
        if (edadMedia < 26 && victorias < 40) {
            return "Los datos muestran un proyecto joven: margen de crecimiento, pero rendimiento inmediato limitado.";
        }
        return "El análisis sitúa al equipo en zona media y apunta a mejorar talento o equilibrio de plantilla.";
    }

    private String construirRecomendacion(int victorias, double edadMedia, int allStars) {
        if (victorias >= 55) {
            return "Mantener el bloque principal y buscar piezas complementarias de bajo riesgo.";
        }
        if (victorias >= 45) {
            return "Priorizar un refuerzo con experiencia para elevar el techo competitivo.";
        }
        if (edadMedia < 26) {
            return "Desarrollar jóvenes y evitar traspasos que reduzcan potencial futuro.";
        }
        if (allStars == 0) {
            return "Buscar una estrella o activo diferencial para cambiar el techo del equipo.";
        }
        return "Reequilibrar plantilla por posición y edad antes de competir por playoff.";
    }

    // ================= TABLERO DE ENCAJE =================
    public LineupAnalysisDTO analizarTablero(
            Map<String, Integer> seleccionSlots,
            Integer jugadorBaseId,
            Integer equipoObjetivoId) {

        List<Jugador> todos = jugadorService.findAll();
        Map<String, Jugador> seleccionadosPorSlot = new LinkedHashMap<>();

        for (Map.Entry<String, Integer> entry : seleccionSlots.entrySet()) {
            if (entry.getValue() != null) {
                Jugador jugador = jugadorService.findJugadorById(entry.getValue());
                if (jugador != null) {
                    seleccionadosPorSlot.put(entry.getKey(), jugador);
                }
            }
        }

        Jugador jugadorBase = jugadorBaseId == null ? null : jugadorService.findJugadorById(jugadorBaseId);
        Equipo equipoObjetivo = equipoObjetivoId == null ? null : equipoService.findEquipoById(equipoObjetivoId);

        List<Jugador> seleccionados = new ArrayList<>(seleccionadosPorSlot.values());
        if (jugadorBase != null && seleccionados.stream().noneMatch(j -> j.getIdJugador().equals(jugadorBase.getIdJugador()))) {
            seleccionados.add(jugadorBase);
        }

        int ratingOfensivo = limitarPorcentaje((int) Math.round(promedio(seleccionados.stream()
                .mapToInt(this::calcularRatingJugador)
                .boxed()
                .toList())));
        int spacing = limitarPorcentaje((int) Math.round(promedio(seleccionados.stream()
                .mapToInt(this::estimarTiro)
                .boxed()
                .toList())));
        int defensa = limitarPorcentaje((int) Math.round(promedio(seleccionados.stream()
                .mapToInt(this::calcularDefensaJugador)
                .boxed()
                .toList())));
        int equilibrio = calcularEquilibrio(seleccionadosPorSlot);

        List<LineupPickDTO> picks = seleccionadosPorSlot.entrySet().stream()
                .map(entry -> new LineupPickDTO(
                entry.getKey(),
                entry.getValue().getNombreJugador(),
                nombreEquipo(entry.getValue()),
                posicionLegible(entry.getValue()),
                calcularRatingJugador(entry.getValue()),
                estimarTiro(entry.getValue())))
                .toList();

        Set<Integer> idsSeleccionados = seleccionados.stream()
                .map(Jugador::getIdJugador)
                .collect(Collectors.toSet());

        List<LineupRecommendationDTO> companeros = todos.stream()
                .filter(j -> j.getIdJugador() != null && !idsSeleccionados.contains(j.getIdJugador()))
                .sorted(Comparator.comparingInt((Jugador j) -> calcularEncajeCompanero(j, seleccionados, equipoObjetivo)).reversed())
                .limit(5)
                .map(j -> new LineupRecommendationDTO(
                j.getNombreJugador(),
                nombreEquipo(j),
                posicionLegible(j),
                calcularEncajeCompanero(j, seleccionados, equipoObjetivo),
                construirMotivoCompanero(j, seleccionados, equipoObjetivo)))
                .toList();

        List<LineupRecommendationDTO> rivales = todos.stream()
                .filter(j -> j.getIdJugador() != null && !idsSeleccionados.contains(j.getIdJugador()))
                .sorted(Comparator.comparingInt((Jugador j) -> calcularVentajaContra(j, seleccionados)).reversed())
                .limit(5)
                .map(j -> new LineupRecommendationDTO(
                j.getNombreJugador(),
                nombreEquipo(j),
                posicionLegible(j),
                calcularVentajaContra(j, seleccionados),
                construirMotivoRival(j, seleccionados)))
                .toList();

        List<TeamFitDTO> equipos = equipoService.findAll().stream()
                .sorted(Comparator.comparingInt((Equipo e) -> calcularEncajeEquipo(e, jugadorBase, seleccionados)).reversed())
                .limit(5)
                .map(e -> new TeamFitDTO(
                e.getNombreEquipo(),
                e.getSiglas(),
                calcularEncajeEquipo(e, jugadorBase, seleccionados),
                construirMotivoEquipo(e, jugadorBase, seleccionados)))
                .toList();

        List<SlotSuggestionDTO> sugerencias = construirSugerenciasCasillas(
                seleccionSlots,
                todos,
                idsSeleccionados,
                seleccionados,
                equipoObjetivo);

        return new LineupAnalysisDTO(
                construirResumenTablero(seleccionados, equipoObjetivo, ratingOfensivo, spacing, defensa, equilibrio),
                ratingOfensivo,
                spacing,
                defensa,
                equilibrio,
                picks,
                companeros,
                rivales,
                equipos,
                sugerencias);
    }

    private List<SlotSuggestionDTO> construirSugerenciasCasillas(
            Map<String, Integer> seleccionSlots,
            List<Jugador> todos,
            Set<Integer> idsSeleccionados,
            List<Jugador> seleccionados,
            Equipo equipoObjetivo) {

        List<SlotSuggestionDTO> sugerencias = new ArrayList<>();
        Set<Integer> usados = new HashSet<>(idsSeleccionados);

        for (Map.Entry<String, Integer> entry : seleccionSlots.entrySet()) {
            if (entry.getValue() != null) {
                continue;
            }

            Jugador candidato = todos.stream()
                    .filter(j -> j.getIdJugador() != null && !usados.contains(j.getIdJugador()))
                    .filter(j -> encajaEnSlot(j, entry.getKey()))
                    .max(Comparator.comparingInt(j -> calcularEncajeCompanero(j, seleccionados, equipoObjetivo)))
                    .orElse(null);

            if (candidato == null) {
                sugerencias.add(new SlotSuggestionDTO(
                        entry.getKey(),
                        null,
                        "Sin candidato",
                        "Sin equipo",
                        0,
                        "No hay jugadores disponibles para esa posición."));
                continue;
            }

            usados.add(candidato.getIdJugador());
            int encaje = calcularEncajeCompanero(candidato, seleccionados, equipoObjetivo);
            sugerencias.add(new SlotSuggestionDTO(
                    entry.getKey(),
                    candidato.getIdJugador(),
                    candidato.getNombreJugador(),
                    nombreEquipo(candidato),
                    encaje,
                    "Cubre la posición " + entry.getKey() + " con buen rating y tiro estimado."));
        }

        return sugerencias;
    }

    private String construirResumenTablero(
            List<Jugador> seleccionados,
            Equipo equipoObjetivo,
            int ratingOfensivo,
            int spacing,
            int defensa,
            int equilibrio) {

        if (seleccionados.isEmpty()) {
            return "Selecciona uno o varios jugadores para calcular el encaje de la pista.";
        }

        String equipo = equipoObjetivo == null
                ? "sin equipo objetivo fijado"
                : "pensando en " + equipoObjetivo.getNombreEquipo();

        return "El quinteto tiene rating ofensivo " + ratingOfensivo
                + "%, spacing " + spacing
                + "%, defensa " + defensa
                + "% y equilibrio " + equilibrio
                + "% " + equipo + ".";
    }

    private int calcularEncajeCompanero(Jugador candidato, List<Jugador> seleccionados, Equipo equipoObjetivo) {
        int score = calcularRatingJugador(candidato) / 2;
        score += estimarTiro(candidato) / 3;
        score += Math.min(15, valorSeguro(candidato.getAnosNbaJug()));

        if (seleccionados.stream().noneMatch(j -> mismaFamiliaPosicion(j, candidato))) {
            score += 12;
        }
        if (equipoObjetivo != null && equipoNecesitaPosicion(equipoObjetivo, candidato.getPosicion())) {
            score += 14;
        }
        if (valorSeguro(candidato.getAnosAllStarJug()) > 0) {
            score += 8;
        }

        return limitarPorcentaje(score);
    }

    private int calcularVentajaContra(Jugador rival, List<Jugador> seleccionados) {
        int tiroMedio = seleccionados.isEmpty()
                ? 55
                : (int) Math.round(promedio(seleccionados.stream().mapToInt(this::estimarTiro).boxed().toList()));
        int ventajaFisica = Math.max(0, 32 - valorSeguro(rival.getEdadJug()));
        int experienciaRival = Math.max(0, 12 - valorSeguro(rival.getAnosNbaJug()));
        int score = tiroMedio + ventajaFisica + experienciaRival - valorSeguro(rival.getAnosAllStarJug()) * 2;
        return limitarPorcentaje(score);
    }

    private int calcularEncajeEquipo(Equipo equipo, Jugador jugadorBase, List<Jugador> seleccionados) {
        List<Jugador> plantilla = equipo.getJugadores() == null ? List.of() : equipo.getJugadores();
        int score = 45;

        Jugador referencia = jugadorBase != null
                ? jugadorBase
                : seleccionados.stream().findFirst().orElse(null);

        if (referencia != null && equipoNecesitaPosicion(equipo, referencia.getPosicion())) {
            score += 25;
        }

        double ratingEquipo = calcularRatingEquipo(plantilla);
        if (ratingEquipo < 28) {
            score += 14;
        } else if (ratingEquipo < 38) {
            score += 8;
        }

        if (plantilla.size() < 12) {
            score += 8;
        }

        return limitarPorcentaje(score);
    }

    private String construirMotivoCompanero(Jugador jugador, List<Jugador> seleccionados, Equipo equipoObjetivo) {
        if (equipoObjetivo != null && equipoNecesitaPosicion(equipoObjetivo, jugador.getPosicion())) {
            return "Encaja porque cubre una posición con poca profundidad en " + equipoObjetivo.getNombreEquipo() + ".";
        }
        if (seleccionados.stream().noneMatch(j -> mismaFamiliaPosicion(j, jugador))) {
            return "Aporta una posición complementaria al grupo seleccionado.";
        }
        if (estimarTiro(jugador) >= 70) {
            return "Mejora el tiro exterior y abre espacio para el resto.";
        }
        return "Aporta equilibrio por rating, experiencia y producción estimada.";
    }

    private String construirMotivoRival(Jugador rival, List<Jugador> seleccionados) {
        if (seleccionados.isEmpty()) {
            return "Comparación favorable por tiro estimado y experiencia relativa.";
        }
        return "El grupo seleccionado proyecta buen porcentaje de tiro frente a su perfil defensivo estimado.";
    }

    private String construirMotivoEquipo(Equipo equipo, Jugador jugadorBase, List<Jugador> seleccionados) {
        Jugador referencia = jugadorBase != null
                ? jugadorBase
                : seleccionados.stream().findFirst().orElse(null);

        if (referencia != null && equipoNecesitaPosicion(equipo, referencia.getPosicion())) {
            return "La plantilla tiene margen en la posición " + posicionLegible(referencia) + ".";
        }
        if (equipo.getJugadores() == null || equipo.getJugadores().size() < 12) {
            return "La plantilla tiene poca profundidad y puede absorber rotación.";
        }
        return "Encaje por equilibrio de rating, experiencia y necesidad competitiva.";
    }

    private int calcularEquilibrio(Map<String, Jugador> seleccionadosPorSlot) {
        if (seleccionadosPorSlot.isEmpty()) {
            return 0;
        }

        long slotsCorrectos = seleccionadosPorSlot.entrySet().stream()
                .filter(entry -> encajaEnSlot(entry.getValue(), entry.getKey()))
                .count();

        int base = (int) Math.round((slotsCorrectos * 100.0) / seleccionadosPorSlot.size());
        int bonus = seleccionadosPorSlot.size() >= 5 ? 8 : 0;
        return limitarPorcentaje(base + bonus);
    }

    private boolean equipoNecesitaPosicion(Equipo equipo, String posicion) {
        if (equipo == null || equipo.getJugadores() == null || posicion == null) {
            return false;
        }

        long jugadoresPosicion = equipo.getJugadores().stream()
                .filter(j -> mismaFamiliaPosicion(j.getPosicion(), posicion))
                .count();

        return jugadoresPosicion < 2;
    }

    private boolean encajaEnSlot(Jugador jugador, String slot) {
        return jugador != null && mismaFamiliaPosicion(jugador.getPosicion(), slot);
    }

    private boolean mismaFamiliaPosicion(Jugador a, Jugador b) {
        return a != null && b != null && mismaFamiliaPosicion(a.getPosicion(), b.getPosicion());
    }

    private boolean mismaFamiliaPosicion(String a, String b) {
        String pa = normalizarPosicion(a);
        String pb = normalizarPosicion(b);
        return pa.equals(pb)
                || (pa.equals("SG") && pb.equals("SF"))
                || (pa.equals("SF") && pb.equals("SG"))
                || (pa.equals("PF") && pb.equals("C"))
                || (pa.equals("C") && pb.equals("PF"));
    }

    private String normalizarPosicion(String posicion) {
        if (posicion == null) {
            return "";
        }

        String p = posicion.toUpperCase();
        if (p.contains("POINT") || p.equals("PG") || p.contains("BASE")) {
            return "PG";
        }
        if (p.contains("SHOOTING") || p.equals("SG") || p.contains("ESCOLTA")) {
            return "SG";
        }
        if (p.contains("SMALL") || p.equals("SF") || p.contains("ALERO")) {
            return "SF";
        }
        if (p.contains("POWER") || p.equals("PF") || p.contains("ALA")) {
            return "PF";
        }
        if (p.contains("CENTER") || p.equals("C") || p.contains("PIVOT")) {
            return "C";
        }
        return p;
    }

    private String posicionLegible(Jugador jugador) {
        String posicion = jugador == null ? null : jugador.getPosicion();
        return posicion == null || posicion.isBlank() ? "Sin posición" : posicion;
    }

    private int calcularRatingJugador(Jugador jugador) {
        if (jugador == null) {
            return 0;
        }

        EstadisticasJugador stats = jugador.getEstadisticasJug();
        int score = 34;
        score += Math.min(18, valorSeguro(jugador.getAnosAllStarJug()) * 2);
        score += Math.min(14, valorSeguro(jugador.getAnosNbaJug()));
        score += Math.max(0, 31 - Math.abs(27 - valorSeguro(jugador.getEdadJug()))) / 4;

        if (stats != null) {
            score += Math.min(16, valorSeguro(stats.getPuntosTotales()) / 2500);
            score += Math.min(9, valorSeguro(stats.getAsistenciasTotales()) / 1200);
            score += Math.min(9, valorSeguro(stats.getRebotesTotales()) / 1500);
        }

        return limitarPorcentaje(score);
    }

    private int estimarTiro(Jugador jugador) {
        if (jugador == null) {
            return 0;
        }

        EstadisticasJugador stats = jugador.getEstadisticasJug();
        int tiro = 42 + Math.min(12, valorSeguro(jugador.getAnosAllStarJug()));

        if (stats != null) {
            tiro += Math.min(24, valorSeguro(stats.getTriplesAnotados()) / 180);
            tiro += Math.min(10, valorSeguro(stats.getTirosDeCampoAnotados()) / 1400);
            tiro += Math.min(8, valorSeguro(stats.getTirosLibresAnotados()) / 1000);
        }

        return limitarPorcentaje(tiro);
    }

    private int calcularDefensaJugador(Jugador jugador) {
        if (jugador == null) {
            return 0;
        }

        EstadisticasJugador stats = jugador.getEstadisticasJug();
        int defensa = 36 + Math.min(12, valorSeguro(jugador.getAnosNbaJug()) / 2);

        if (stats != null) {
            defensa += Math.min(18, valorSeguro(stats.getRebotesTotales()) / 1200);
            defensa += Math.min(18, valorSeguro(stats.getTaponesTotales()) / 130);
            defensa += Math.min(12, valorSeguro(stats.getRobosTotales()) / 230);
        }

        String posicion = normalizarPosicion(jugador.getPosicion());
        if (posicion.equals("PF") || posicion.equals("C")) {
            defensa += 8;
        }
        if (valorSeguro(jugador.getAnosAllStarJug()) > 0) {
            defensa += 5;
        }

        return limitarPorcentaje(defensa);
    }

    private double promedio(List<Integer> valores) {
        if (valores == null || valores.isEmpty()) {
            return 0;
        }
        return valores.stream().mapToInt(Integer::intValue).average().orElse(0);
    }

    private int valorSeguro(Integer valor) {
        return valor == null ? 0 : valor;
    }

    private int limitarPorcentaje(int valor) {
        return Math.max(0, Math.min(99, valor));
    }

    private String nombreEquipo(Jugador jugador) {
        if (jugador == null || jugador.getEquipo() == null) {
            return "Sin equipo";
        }
        return jugador.getEquipo().getNombreEquipo();
    }

    private double redondear(double valor) {
        return Math.round(valor * 10.0) / 10.0;
    }
}
