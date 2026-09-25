package HooperSoftware.TFG.dto;

public class LiveGameSimulationDTO {

    private String equipo1;
    private String siglas1;

    private String equipo2;
    private String siglas2;

    private int q1a;
    private int q1b;

    private int q2a;
    private int q2b;

    private int q3a;
    private int q3b;

    private int finalA;
    private int finalB;

    private String ganador;
    private String mvp;

    private Integer probabilidadA;
    private Integer probabilidadB;

    private String momentum;

   public LiveGameSimulationDTO(
        String equipo1,
        String siglas1,
        String equipo2,
        String siglas2,
        int q1a,
        int q1b,
        int q2a,
        int q2b,
        int q3a,
        int q3b,
        int finalA,
        int finalB,
        String ganador,
        String mvp,
        Integer probabilidadA,
        Integer probabilidadB,
        String momentum) {

        this.equipo1 = equipo1;
        this.siglas1 = siglas1;

        this.equipo2 = equipo2;
        this.siglas2 = siglas2;

        this.q1a = q1a;
        this.q1b = q1b;

        this.q2a = q2a;
        this.q2b = q2b;

        this.q3a = q3a;
        this.q3b = q3b;

        this.finalA = finalA;
        this.finalB = finalB;

        this.ganador = ganador;
        this.mvp = mvp;

        this.probabilidadA = probabilidadA;
this.probabilidadB = probabilidadB;

this.momentum = momentum;
    }

    public String getEquipo1() {
        return equipo1;
    }

    public String getSiglas1() {
        return siglas1;
    }

    public String getEquipo2() {
        return equipo2;
    }

    public String getSiglas2() {
        return siglas2;
    }

    public int getQ1a() {
        return q1a;
    }

    public int getQ1b() {
        return q1b;
    }

    public int getQ2a() {
        return q2a;
    }

    public int getQ2b() {
        return q2b;
    }

    public int getQ3a() {
        return q3a;
    }

    public int getQ3b() {
        return q3b;
    }

    public int getFinalA() {
        return finalA;
    }

    public int getFinalB() {
        return finalB;
    }

    public String getGanador() {
        return ganador;
    }

    public String getMvp() {
        return mvp;
    }

    public Integer getProbabilidadA() {
        return probabilidadA;
    }

    public Integer getProbabilidadB() {
        return probabilidadB;
    }

    public String getMomentum() {
        return momentum;
    }

}
