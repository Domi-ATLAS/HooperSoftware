package HooperSoftware.TFG.dto;

public class MatchDTO {

    private String team1;
    private String team1Siglas;

    private String team2;
    private String team2Siglas;

    private String winner;
    private String winnerSiglas;

    private int wins1;
    private int wins2;

    public MatchDTO(
            String team1,
            String team1Siglas,
            String team2,
            String team2Siglas,
            String winner,
            String winnerSiglas,
            int wins1,
            int wins2) {

        this.team1 = team1;
        this.team1Siglas = team1Siglas;

        this.team2 = team2;
        this.team2Siglas = team2Siglas;

        this.winner = winner;
        this.winnerSiglas = winnerSiglas;

        this.wins1 = wins1;
        this.wins2 = wins2;
    }

    public String getTeam1() {
        return team1;
    }

    public String getTeam1Siglas() {
        return team1Siglas;
    }

    public String getTeam2() {
        return team2;
    }

    public String getTeam2Siglas() {
        return team2Siglas;
    }

    public String getWinner() {
        return winner;
    }

    public String getWinnerSiglas() {
        return winnerSiglas;
    }

    public int getWins1() {
        return wins1;
    }

    public int getWins2() {
        return wins2;
    }
}