package HooperSoftware.TFG.servicio;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.dto.PlayoffPredictionDTO;
import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.Jugador;

@Service
public class SimulacionService {

    private final JugadorService jugadorService;

    public SimulacionService(JugadorService jugadorService) {
        this.jugadorService = jugadorService;
    }

    // ================= TRADE =================

    public TradeResultDTO evaluarTrade(Jugador sale, Jugador llega) {

        int score = 50;

        score += (llega.getAnosAllStarJug() - sale.getAnosAllStarJug()) * 5;
        score += (llega.getAnosNbaJug() - sale.getAnosNbaJug()) * 2;

        if (llega.getEdadJug() < sale.getEdadJug()) score += 10;

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

        return new TeamImpactDTO(
                ratingAntes,
                ratingDespues,
                victoriasAntes,
                victoriasDespues,
                diferencia
        );
    }

    // ================= WINS PREDICTION =================

    public WinsPredictionDTO calcularWins(Jugador sale, Jugador llega) {

        Equipo equipo = sale.getEquipo();

        if (equipo == null || equipo.getJugadores() == null) {
            return new WinsPredictionDTO(0,0,0,"N/A","N/A","Sin datos");
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
                mensaje
        );
    }

    // ================= IA =================

    private String generarMensajeIA(int diff, String antes, String despues) {

        if (diff >= 8) return "🚀 Trade élite: cambia completamente el equipo";
        if (diff >= 4) return "📈 Mejora clara: el equipo sube de nivel";
        if (diff >= 1) return "👍 Ligera mejora";
        if (diff == 0) return "⚖️ No cambia el rendimiento";
        if (diff >= -3) return "⚠️ Riesgo leve";
        return "❌ Empeora claramente el equipo";
    }

    private String calcularTier(int wins) {

        if (wins >= 55) return "🏆 Contender";
        if (wins >= 45) return "🔥 Playoff";
        if (wins >= 35) return "⚖️ Medio";
        return "❌ Tanking";
    }

    private int convertirRatingAWins(double rating) {
        int wins = (int) (rating * 1.5);
        return Math.max(15, Math.min(65, wins));
    }

    // ================= HELPERS =================

    private double calcularRatingEquipo(List<Jugador> jugadores) {

        if (jugadores.isEmpty()) return 0;

        double total = 0;

        for (Jugador j : jugadores) {

            double ratingJugador =
                    (j.getAnosAllStarJug() * 5)
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
            if (j.getEquipo() != null &&
                !j.getEquipo().getIdEquipo().equals(equipo.getIdEquipo())) {

                int score = calcularFitEquipo(equipo, j);
                sugerencias.add(new TradeSuggestionDTO(j, score));
            }
        }

        sugerencias.sort(Comparator.comparingInt(TradeSuggestionDTO::getScore).reversed());

        return sugerencias.subList(0, Math.min(5, sugerencias.size()));
    }

    private int calcularFit(Jugador a, Jugador b) {
        int score = 50;

        if (!a.getPosicion().equalsIgnoreCase(b.getPosicion())) score += 15;

        score += (b.getAnosAllStarJug() - a.getAnosAllStarJug()) * 5;
        score -= Math.abs(b.getEdadJug() - a.getEdadJug());

        return Math.max(0, Math.min(100, score));
    }

    private int calcularFitEquipo(Equipo equipo, Jugador j) {
        int score = 50;

        if (j.getEdadJug() < 28) score += 10;

        score += j.getAnosAllStarJug() * 4;
        score += j.getAnosNbaJug();

        return Math.max(0, Math.min(100, score));
    }

    // ================= PLAYOFF PREDICTION =================

public PlayoffPredictionDTO predecirPlayoffs(Equipo equipo) {

    if (equipo == null || equipo.getJugadores() == null) {
        return new PlayoffPredictionDTO(0,0,0,"Desconocido","Sin datos");
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
            mensaje
    );
}
}