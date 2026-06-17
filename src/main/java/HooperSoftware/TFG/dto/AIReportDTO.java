package HooperSoftware.TFG.dto;

import java.util.List;

public class AIReportDTO {

    private final String equipo;
    private final String siglas;
    private final double rating;
    private final double edadMedia;
    private final double experienciaMedia;
    private final int allStars;
    private final int victoriasEstimadas;
    private final int confianza;
    private final String tier;
    private final String diagnostico;
    private final String recomendacion;
    private final List<String> factores;

    public AIReportDTO(
            String equipo,
            String siglas,
            double rating,
            double edadMedia,
            double experienciaMedia,
            int allStars,
            int victoriasEstimadas,
            int confianza,
            String tier,
            String diagnostico,
            String recomendacion,
            List<String> factores) {

        this.equipo = equipo;
        this.siglas = siglas;
        this.rating = rating;
        this.edadMedia = edadMedia;
        this.experienciaMedia = experienciaMedia;
        this.allStars = allStars;
        this.victoriasEstimadas = victoriasEstimadas;
        this.confianza = confianza;
        this.tier = tier;
        this.diagnostico = diagnostico;
        this.recomendacion = recomendacion;
        this.factores = factores;
    }

    public String getEquipo() {
        return equipo;
    }

    public String getSiglas() {
        return siglas;
    }

    public double getRating() {
        return rating;
    }

    public double getEdadMedia() {
        return edadMedia;
    }

    public double getExperienciaMedia() {
        return experienciaMedia;
    }

    public int getAllStars() {
        return allStars;
    }

    public int getVictoriasEstimadas() {
        return victoriasEstimadas;
    }

    public int getConfianza() {
        return confianza;
    }

    public String getTier() {
        return tier;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public String getRecomendacion() {
        return recomendacion;
    }

    public List<String> getFactores() {
        return factores;
    }
}
