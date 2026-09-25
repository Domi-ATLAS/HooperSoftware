package HooperSoftware.TFG.dto;

public class GMTradeDTO {

    private String jugador;
    private String equipo;
    private Integer mejoraWins;

    public GMTradeDTO(
            String jugador,
            String equipo,
            Integer mejoraWins) {

        this.jugador = jugador;
        this.equipo = equipo;
        this.mejoraWins = mejoraWins;
    }

    public String getJugador() {
        return jugador;
    }

    public String getEquipo() {
        return equipo;
    }

    public Integer getMejoraWins() {
        return mejoraWins;
    }
}