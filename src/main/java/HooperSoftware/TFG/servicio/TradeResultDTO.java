package HooperSoftware.TFG.servicio;

public class TradeResultDTO {

    private int score;
    private String evaluacion;
    private String color;

    public TradeResultDTO(int score, String evaluacion, String color) {
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