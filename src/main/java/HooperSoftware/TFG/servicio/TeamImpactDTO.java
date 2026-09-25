package HooperSoftware.TFG.servicio;

public class TeamImpactDTO {

    private double ratingAntes;
    private double ratingDespues;

    private int victoriasAntes;
    private int victoriasDespues;

    private int diferencia;

    public TeamImpactDTO(
            double ratingAntes,
            double ratingDespues,
            int victoriasAntes,
            int victoriasDespues,
            int diferencia) {

        this.ratingAntes = ratingAntes;
        this.ratingDespues = ratingDespues;
        this.victoriasAntes = victoriasAntes;
        this.victoriasDespues = victoriasDespues;
        this.diferencia = diferencia;
    }

    public double getRatingAntes() {
        return ratingAntes;
    }

    public double getRatingDespues() {
        return ratingDespues;
    }

    public int getVictoriasAntes() {
        return victoriasAntes;
    }

    public int getVictoriasDespues() {
        return victoriasDespues;
    }

    public int getDiferencia() {
        return diferencia;
    }
}