package HooperSoftware.TFG.servicio;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.dto.DynastyResultDTO;
import HooperSoftware.TFG.dto.GMTradeDTO;
import HooperSoftware.TFG.dto.LiveGameSimulationDTO;
import HooperSoftware.TFG.dto.MatchDTO;
import HooperSoftware.TFG.dto.PlayoffBracketDTO;
import HooperSoftware.TFG.dto.PlayoffPredictionDTO;
import HooperSoftware.TFG.dto.SeasonSimulationDTO;
import HooperSoftware.TFG.dto.SeriesResultDTO;
import HooperSoftware.TFG.dto.TeamStandingDTO;
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
            evaluacion = "🔥 GRAN TRADE";
            color = "green";
        } else if (score >= 50) {
            evaluacion = "👌 Trade equilibrado";
            color = "orange";
        } else {
            evaluacion = "❌ Mala decisión";
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

            momentum = "🔥 Dominio absoluto";

        } else if (diferencia >= 10) {

            momentum = "📈 Equipo en gran momento";

        } else {

            momentum = "⚖ Partido muy igualado";
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

        String mensaje = generarMensajeIA(diff, tierAntes, tierDespues);

        return new WinsPredictionDTO(
                winsAntes,
                winsDespues,
                diff,
                tierAntes,
                tierDespues,
                mensaje);
    }

    // ================= IA =================
    private String generarMensajeIA(int diff, String antes, String despues) {

        if (diff >= 8) {
            return "🚀 Trade élite: cambia completamente el equipo";
        }
        if (diff >= 4) {
            return "📈 Mejora clara: el equipo sube de nivel";
        }
        if (diff >= 1) {
            return "👍 Ligera mejora";
        }
        if (diff == 0) {
            return "⚖️ No cambia el rendimiento";
        }
        if (diff >= -3) {
            return "⚠️ Riesgo leve";
        }
        return "❌ Empeora claramente el equipo";
    }

    private String calcularTier(int wins) {

        if (wins >= 55) {
            return "🏆 Contender";
        }
        if (wins >= 45) {
            return "🔥 Playoff";
        }
        if (wins >= 35) {
            return "⚖️ Medio";
        }
        return "❌ Tanking";
    }

    private int convertirRatingAWins(double rating) {
        int wins = (int) (rating * 1.5);
        return Math.max(15, Math.min(65, wins));
    }

    // ================= HELPERS =================
    private double calcularRatingEquipo(List<Jugador> jugadores) {

        if (jugadores.isEmpty()) {
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
            tier = "Contender 🏆";
            mensaje = "Equipo candidato serio al anillo.";
        } else if (rating >= 70) {
            tier = "Playoff fuerte 🔥";
            mensaje = "Equipo competitivo, peligro en playoffs.";
        } else if (rating >= 55) {
            tier = "Play-in ⚖️";
            mensaje = "Puede entrar en playoffs pero sin garantías.";
        } else {
            tier = "Lotería ❌";
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
                break; // ✅ FIX
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
                    derrotas));

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
            momentum = "🔥 Dominio absoluto";
        } else if (diferenciaMarcador >= 10) {
            momentum = "💪 Partido controlado";
        } else {
            momentum = "⚡ Final ajustado";
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
                        "Año " + ano +
                                " → Campeón NBA");

                titulos++;

            } else if (wins >= 55) {

                temporadas.add(
                        "Año " + ano +
                                " → Final Conferencia");

            } else if (wins >= 50) {

                temporadas.add(
                        "Año " + ano +
                                " → Semifinal Conferencia");

            } else {

                temporadas.add(
                        "Año " + ano +
                                " → " + wins + "-82");
            }
        }

        int dynastyScore = Math.min(
                100,
                titulos * 30 +
                        victorias / 5);

        return new DynastyResultDTO(
                equipo.getNombreEquipo(),
                equipo.getSiglas(),
                temporadas,
                titulos,
                victorias,
                dynastyScore);
    }
}
