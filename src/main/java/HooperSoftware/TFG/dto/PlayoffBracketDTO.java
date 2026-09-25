package HooperSoftware.TFG.dto;

import java.util.List;

public class PlayoffBracketDTO {

    private List<MatchDTO> primeraRonda;
    private List<MatchDTO> semifinales;
    private List<MatchDTO> finales;

    private String campeon;
    private String campeonSiglas;

    private String mvpFinals;

    public PlayoffBracketDTO(
            List<MatchDTO> primeraRonda,
            List<MatchDTO> semifinales,
            List<MatchDTO> finales,
            String campeon,
            String campeonSiglas,
            String mvpFinals) {

        this.primeraRonda = primeraRonda;
        this.semifinales = semifinales;
        this.finales = finales;
        this.campeon = campeon;
        this.campeonSiglas = campeonSiglas;
        this.mvpFinals = mvpFinals;
    }

    public List<MatchDTO> getPrimeraRonda() {
        return primeraRonda;
    }

    public List<MatchDTO> getSemifinales() {
        return semifinales;
    }

    public List<MatchDTO> getFinales() {
        return finales;
    }

    public String getCampeon() {
        return campeon;
    }

    public String getCampeonSiglas() {
        return campeonSiglas;
    }

    public String getMvpFinals() {
        return mvpFinals;
    }
}