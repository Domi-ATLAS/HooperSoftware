package HooperSoftware.TFG.dto;

public class PlayoffPredictionDTO {

    private int probPlayoffs;
    private int probFinales;
    private int probCampeon;

    private String tier;
    private String mensaje;

    public PlayoffPredictionDTO(
            int probPlayoffs,
            int probFinales,
            int probCampeon,
            String tier,
            String mensaje) {

        this.probPlayoffs = probPlayoffs;
        this.probFinales = probFinales;
        this.probCampeon = probCampeon;
        this.tier = tier;
        this.mensaje = mensaje;
    }

    public int getProbPlayoffs() { return probPlayoffs; }
    public int getProbFinales() { return probFinales; }
    public int getProbCampeon() { return probCampeon; }

    public String getTier() { return tier; }
    public String getMensaje() { return mensaje; }
}