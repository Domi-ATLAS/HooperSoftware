package HooperSoftware.TFG.dto;

public class TeamStandingDTO {

    private String nombre;
    private String siglas;

    private int victorias;
    private int derrotas;
    private int victoriasRegistradas;
    private int diferenciaVictorias;

    public TeamStandingDTO(
            String nombre,
            String siglas,
            int victorias,
            int derrotas,
            int victoriasRegistradas) {

        this.nombre = nombre;
        this.siglas = siglas;
        this.victorias = victorias;
        this.derrotas = derrotas;
        this.victoriasRegistradas = victoriasRegistradas;
        this.diferenciaVictorias = victorias - victoriasRegistradas;
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

    public int getVictoriasRegistradas() {
        return victoriasRegistradas;
    }

    public int getDiferenciaVictorias() {
        return diferenciaVictorias;
    }
}
