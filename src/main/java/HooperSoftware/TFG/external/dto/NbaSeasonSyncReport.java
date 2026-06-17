package HooperSoftware.TFG.external.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Resume la sincronizacion de una temporada NBA para mostrar un resultado claro al administrador.
 */
public class NbaSeasonSyncReport {

    private final int season;
    private int teams;
    private int players;
    private int games;
    private boolean usedStaticBackup;
    private final List<String> warnings = new ArrayList<>();

    public NbaSeasonSyncReport(int season) {
        this.season = season;
    }

    public int getSeason() {
        return season;
    }

    public int getTeams() {
        return teams;
    }

    public void setTeams(int teams) {
        this.teams = teams;
    }

    public int getPlayers() {
        return players;
    }

    public void setPlayers(int players) {
        this.players = players;
    }

    public int getGames() {
        return games;
    }

    public void setGames(int games) {
        this.games = games;
    }

    public boolean isUsedStaticBackup() {
        return usedStaticBackup;
    }

    public List<String> getWarnings() {
        return warnings;
    }

    public void addWarning(String warning) {
        usedStaticBackup = true;
        warnings.add(warning);
    }

    public String toAdminMessage() {
        StringBuilder message = new StringBuilder();
        message.append("Temporada ")
                .append(season - 1)
                .append("-")
                .append(season)
                .append(" | Equipos: ")
                .append(teams)
                .append(" | Jugadores: ")
                .append(players)
                .append(" | Partidos: ")
                .append(games);

        if (usedStaticBackup) {
            message.append(" | Backup estatico conservado");
        }

        if (!warnings.isEmpty()) {
            message.append(" | Avisos: ").append(String.join(" / ", warnings));
        }

        return message.toString();
    }
}
