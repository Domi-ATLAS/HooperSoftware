package HooperSoftware.TFG.dto;

public class TeamStandingDTO {

    private String nombre;
    private String siglas;

    private int victorias;
    private int derrotas;

    public TeamStandingDTO(
            String nombre,
            String siglas,
            int victorias,
            int derrotas) {

        this.nombre = nombre;
        this.siglas = siglas;
        this.victorias = victorias;
        this.derrotas = derrotas;
    }

    public String getNombre() {
        return nombre;
    }

    public String getSiglas() {
        return siglas;
    }

    public int getVictorias() {
        return victorias;
    }

    public int getDerrotas() {
        return derrotas;
    }
}