package HooperSoftware.TFG.servicio;

import HooperSoftware.TFG.entidad.Jugador;

public class TradeSuggestionDTO {

    private Jugador jugador;
    private int score;

    public TradeSuggestionDTO(Jugador jugador, int score) {
        this.jugador = jugador;
        this.score = score;
    }

    public Jugador getJugador() {
        return jugador;
    }

    public int getScore() {
        return score;
    }
}