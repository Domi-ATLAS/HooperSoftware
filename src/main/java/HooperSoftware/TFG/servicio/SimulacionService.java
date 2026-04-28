package HooperSoftware.TFG.servicio;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.entidad.Jugador;

@Service
public class SimulacionService {

    public TradeResult evaluarTrade(
            Jugador jugadorSale,
            Jugador jugadorLlega) {

        int score = 50;

        // experiencia
        if (jugadorLlega.getAnosNbaJug() != null
                && jugadorSale.getAnosNbaJug() != null) {

            score
                    += (jugadorLlega.getAnosNbaJug()
                    - jugadorSale.getAnosNbaJug()) * 2;
        }

        // all star value
        if (jugadorLlega.getAnosAllStarJug() != null
                && jugadorSale.getAnosAllStarJug() != null) {

            score
                    += (jugadorLlega.getAnosAllStarJug()
                    - jugadorSale.getAnosAllStarJug()) * 4;
        }

        // edad (más joven bonifica)
        if (jugadorLlega.getEdadJug() != null
                && jugadorSale.getEdadJug() != null) {

            if (jugadorLlega.getEdadJug()
                    < jugadorSale.getEdadJug()) {

                score += 8;
            }
        }

        // bonus si misma posición
        if (jugadorSale.getPosicion() != null
                && jugadorLlega.getPosicion() != null
                && jugadorSale.getPosicion()
                        .equalsIgnoreCase(
                                jugadorLlega.getPosicion()
                        )) {

            score += 10;
        }

        if (score > 100) {
            score = 100;
        }
        if (score < 0) {
            score = 0;
        }

        String evaluacion;
        String color;

        if (score >= 75) {
            evaluacion = "Excelente traspaso";
            color = "green";
        } else if (score >= 55) {
            evaluacion = "Traspaso equilibrado";
            color = "orange";
        } else {
            evaluacion = "Traspaso poco recomendable";
            color = "red";
        }

        return new TradeResult(
                score,
                evaluacion,
                color
        );
    }

    public static class TradeResult {

        private int score;
        private String evaluacion;
        private String color;

        public TradeResult(
                int score,
                String evaluacion,
                String color) {

            this.score = score;
            this.evaluacion = evaluacion;
            this.color = color;
        }

        public int getScore() {
            return score;
        }

        public String getEvaluacion() {
            return evaluacion;
        }

        public String getColor() {
            return color;
        }

    }

}
