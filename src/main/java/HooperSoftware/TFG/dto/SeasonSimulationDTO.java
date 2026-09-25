package HooperSoftware.TFG.dto;

import java.util.List;

public class SeasonSimulationDTO {

    private List<TeamStandingDTO> standings;

    private String campeon;
    private String campeonSiglas;

    private String mvp;

    public SeasonSimulationDTO(
            List<TeamStandingDTO> standings,
            String campeon,
            String campeonSiglas,
            String mvp) {

        this.standings = standings;
        this.campeon = campeon;
        this.campeonSiglas = campeonSiglas;
        this.mvp = mvp;
    }

    public List<TeamStandingDTO> getStandings() {
        return standings;
    }

    public String getCampeon() {
        return campeon;
    }

    public String getCampeonSiglas() {
        return campeonSiglas;
    }

    public String getMvp() {
        return mvp;
    }
}