package HooperSoftware.TFG.external.service;

import HooperSoftware.TFG.entidad.Equipo;
import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.entidad.Jugador;
import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.external.dto.NbaSeasonSyncReport;
import HooperSoftware.TFG.repositorio.EquipoRepository;
import HooperSoftware.TFG.repositorio.EstadisticasJugadorRepository;
import HooperSoftware.TFG.repositorio.JugadorRepository;
import HooperSoftware.TFG.repositorio.PartidoRepository;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

/**
 * Importa datos NBA desde fuentes publicas de internet y los adapta a las entidades principales.
 */
@Service
public class NbaInternetSyncService {

    private static final String NBA_TEAM_STATS_URL = "https://stats.nba.com/stats/leaguedashteamstats"
            + "?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&LastNGames=0&LeagueID=00"
            + "&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N"
            + "&PerMode=Totals&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N"
            + "&Season=%s&SeasonSegment=&SeasonType=Regular%%20Season&ShotClockRange=&StarterBench="
            + "&TeamID=0&TwoWay=0&VsConference=&VsDivision=";

    private static final String NBA_PLAYER_STATS_URL = "https://stats.nba.com/stats/leaguedashplayerstats"
            + "?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear="
            + "&GameScope=&GameSegment=&Height=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base"
            + "&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=Totals&Period=0"
            + "&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=%s&SeasonSegment="
            + "&SeasonType=Regular%%20Season&ShotClockRange=&StarterBench=&TeamID=0&TwoWay=0"
            + "&VsConference=&VsDivision=&Weight=";

    private static final String NBA_ELO_GAMES_URL =
            "https://raw.githubusercontent.com/fivethirtyeight/data/master/nba-elo/nbaallelo.csv";

    private final RestTemplate restTemplate;
    private final EquipoRepository equipoRepository;
    private final JugadorRepository jugadorRepository;
    private final EstadisticasJugadorRepository estadisticasJugadorRepository;
    private final PartidoRepository partidoRepository;

    public NbaInternetSyncService(
            RestTemplate restTemplate,
            EquipoRepository equipoRepository,
            JugadorRepository jugadorRepository,
            EstadisticasJugadorRepository estadisticasJugadorRepository,
            PartidoRepository partidoRepository) {
        this.restTemplate = restTemplate;
        this.equipoRepository = equipoRepository;
        this.jugadorRepository = jugadorRepository;
        this.estadisticasJugadorRepository = estadisticasJugadorRepository;
        this.partidoRepository = partidoRepository;
    }

    public NbaSeasonSyncReport syncSeason(int season) {
        NbaSeasonSyncReport report = new NbaSeasonSyncReport(season);
        String nbaSeason = toNbaSeason(season);

        try {
            report.setTeams(syncTeams(nbaSeason));
        } catch (RuntimeException exception) {
            report.addWarning("equipos online no disponibles");
        }

        try {
            report.setPlayers(syncPlayers(nbaSeason));
        } catch (RuntimeException exception) {
            report.addWarning("jugadores online no disponibles");
        }

        try {
            GameSyncResult games = syncGamesFromFiveThirtyEight(season);
            report.setGames(games.games());
            if (report.getTeams() == 0) {
                report.setTeams(games.teams());
            }
        } catch (RuntimeException exception) {
            report.addWarning("partidos online no disponibles");
        }

        return report;
    }

    private int syncTeams(String nbaSeason) {
        Map<String, Object> body = requestJson(String.format(NBA_TEAM_STATS_URL, nbaSeason));
        NbaStatsTable table = NbaStatsTable.from(body);
        int saved = 0;

        for (java.util.List<?> row : table.rows()) {
            String abbreviation = table.string(row, "TEAM_ABBREVIATION");
            Equipo equipo = findOrCreateTeam(table.integer(row, "TEAM_ID"), abbreviation);

            equipo.setNombreEquipo(table.string(row, "TEAM_NAME"));
            equipo.setSiglas(abbreviation);
            equipo.setPartidosGanados(table.integer(row, "W"));
            equipo.setPartidosPerdidos(table.integer(row, "L"));
            equipo.setBalanceTemporada(table.decimal(row, "W_PCT"));
            equipo.setLogoEquipo("http");

            equipoRepository.save(equipo);
            saved++;
        }

        return saved;
    }

    private int syncPlayers(String nbaSeason) {
        Map<String, Object> body = requestJson(String.format(NBA_PLAYER_STATS_URL, nbaSeason));
        NbaStatsTable table = NbaStatsTable.from(body);
        int saved = 0;

        for (java.util.List<?> row : table.rows()) {
            Integer playerId = table.integer(row, "PLAYER_ID");
            String teamAbbreviation = table.string(row, "TEAM_ABBREVIATION");
            Equipo equipo = findOrCreateTeam(table.integer(row, "TEAM_ID"), teamAbbreviation);

            EstadisticasJugador stats = new EstadisticasJugador();
            stats.setIdEstJugador(playerId);
            stats.setPuntosTotales(table.integer(row, "PTS"));
            stats.setAsistenciasTotales(table.integer(row, "AST"));
            stats.setRebotesTotales(table.integer(row, "REB"));
            stats.setTaponesTotales(table.integer(row, "BLK"));
            stats.setRobosTotales(table.integer(row, "STL"));
            stats.setPartidosJugadosJug(table.integer(row, "GP"));
            stats.setPartidosGanadosJug(table.integer(row, "W"));
            stats.setPartidosPerdidosJug(table.integer(row, "L"));
            stats.setTriplesAnotados(table.integer(row, "FG3M"));
            stats.setTirosLibresAnotados(table.integer(row, "FTM"));
            stats.setTirosDeCampoAnotados(table.integer(row, "FGM"));
            stats.setMinutosTotales(table.integer(row, "MIN"));
            estadisticasJugadorRepository.save(stats);

            Jugador jugador = jugadorRepository.findJugadorById(playerId);
            if (jugador == null) {
                jugador = new Jugador();
                jugador.setIdJugador(playerId);
            }

            jugador.setNombreJugador(table.string(row, "PLAYER_NAME"));
            jugador.setPosicion(normalizePosition(table.string(row, "PLAYER_POSITION")));
            jugador.setEdadJug(table.integer(row, "AGE"));
            jugador.setRetirado(false);
            jugador.setHallOfFame(false);
            jugador.setFotoJugador("default-avatar.png");
            jugador.setEquipo(equipo);
            jugador.setEstadisticasJug(stats);

            jugadorRepository.save(jugador);
            saved++;
        }

        return saved;
    }

    private GameSyncResult syncGamesFromFiveThirtyEight(int season) {
        String csv = restTemplate.getForObject(NBA_ELO_GAMES_URL, String.class);
        int saved = 0;
        Map<String, TeamSeasonRecord> teams = new HashMap<>();

        try (CSVReader reader = new CSVReader(new StringReader(Objects.requireNonNull(csv)))) {
            String[] header = reader.readNext();
            Map<String, Integer> index = indexHeader(header);
            String[] row;

            while ((row = reader.readNext()) != null) {
                if (!String.valueOf(season).equals(row[index.get("year_id")])) {
                    continue;
                }
                if (!"0".equals(row[index.get("_iscopy")])) {
                    continue;
                }

                String localAbbreviation = row[index.get("team_id")];
                String localName = row[index.get("fran_id")];
                String visitorAbbreviation = row[index.get("opp_id")];
                String visitorName = row[index.get("opp_fran")];
                TeamSeasonRecord local = teams.get(localAbbreviation);
                TeamSeasonRecord visitor = teams.get(visitorAbbreviation);

                if (local == null) {
                    local = new TeamSeasonRecord(localAbbreviation, localName);
                    teams.put(localAbbreviation, local);
                }
                if (visitor == null) {
                    visitor = new TeamSeasonRecord(visitorAbbreviation, visitorName);
                    teams.put(visitorAbbreviation, visitor);
                }
                int localPoints = Integer.parseInt(row[index.get("pts")]);
                int visitorPoints = Integer.parseInt(row[index.get("opp_pts")]);
                local.registerGame(localPoints > visitorPoints);
                visitor.registerGame(visitorPoints > localPoints);
                Equipo localTeam = saveTeamSeasonRecord(local);
                Equipo visitorTeam = saveTeamSeasonRecord(visitor);

                Partido partido = new Partido();
                partido.setIdPartido(stablePositiveId(row[index.get("game_id")]));
                partido.setTemporada(toAppSeason(season));
                partido.setPlayOffSiONo("1".equals(row[index.get("is_playoffs")]));
                partido.setEquipoLocal(localTeam.getNombreEquipo());
                partido.setEquipoVisitante(visitorTeam.getNombreEquipo());
                partido.setResultadoTotal(row[index.get("pts")] + "-" + row[index.get("opp_pts")]);
                partido.setGanador("W".equals(row[index.get("game_result")])
                        ? localTeam.getNombreEquipo()
                        : visitorTeam.getNombreEquipo());
                partido.setFecha(new SimpleDateFormat("M/d/yyyy", Locale.US).parse(row[index.get("date_game")]));
                partido.setEquipoLocalTa(localTeam);
                partido.setEquipoVisitanteTa(visitorTeam);

                partidoRepository.save(partido);
                saved++;
            }
        } catch (IOException | CsvValidationException | ParseException exception) {
            throw new RuntimeException("No se pudo leer el CSV historico de partidos", exception);
        }

        return new GameSyncResult(saved, teams.size());
    }

    private Map<String, Object> requestJson(String url) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/125 Safari/537.36");
        headers.set("Accept", "application/json, text/plain, */*");
        headers.set("Referer", "https://www.nba.com/");
        headers.set("Origin", "https://www.nba.com");
        headers.set("x-nba-stats-origin", "stats");
        headers.set("x-nba-stats-token", "true");

        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), Map.class);
        return response.getBody();
    }

    private Equipo findOrCreateTeam(Integer nbaTeamId, String abbreviation) {
        Equipo equipo = equipoRepository.findEquipoBySiglas(abbreviation);

        if (equipo != null) {
            return equipo;
        }

        equipo = equipoRepository.findEquipoById(nbaTeamId);
        if (equipo != null) {
            return equipo;
        }

        Equipo nuevo = new Equipo();
        nuevo.setIdEquipo(nbaTeamId);
        nuevo.setSiglas(abbreviation);
        nuevo.setNombreEquipo(abbreviation);
        nuevo.setCiudad("");
        nuevo.setConferencia("");
        nuevo.setDivision("");
        nuevo.setAnoFundacion(0);
        nuevo.setAnosNba(0);
        nuevo.setTitulosNba(0);
        nuevo.setTitulosConferencia(0);
        nuevo.setPartidosGanados(0);
        nuevo.setPartidosPerdidos(0);
        nuevo.setBalanceTemporada(0.0);
        nuevo.setPosicion(0);
        nuevo.setEstadio("");
        nuevo.setLogoEquipo("http");
        return nuevo;
    }

    private String toNbaSeason(int season) {
        return (season - 1) + "-" + String.valueOf(season).substring(2);
    }

    private String toAppSeason(int season) {
        return (season - 1) + "-" + season;
    }

    private Map<String, Integer> indexHeader(String[] header) {
        Map<String, Integer> index = new HashMap<>();
        for (int i = 0; i < header.length; i++) {
            index.put(header[i], i);
        }
        return index;
    }

    private int stablePositiveId(String value) {
        return Math.abs(value.hashCode());
    }

    private Equipo saveTeamSeasonRecord(TeamSeasonRecord record) {
        Equipo equipo = findOrCreateTeam(stablePositiveId(record.abbreviation()), record.abbreviation());
        if (equipo.getNombreEquipo() == null
                || equipo.getNombreEquipo().isBlank()
                || equipo.getNombreEquipo().equals(record.abbreviation())) {
            equipo.setNombreEquipo(record.name());
        }
        equipo.setSiglas(record.abbreviation());
        equipo.setPartidosGanados(record.wins());
        equipo.setPartidosPerdidos(record.losses());
        equipo.setBalanceTemporada(record.games() == 0 ? 0.0 : record.wins() / (double) record.games());
        equipo.setLogoEquipo("http");
        return equipoRepository.save(equipo);
    }

    private String normalizePosition(String position) {
        if (position == null || position.isBlank()) {
            return "";
        }

        return switch (position) {
            case "G" -> "Base";
            case "F" -> "Alero";
            case "C" -> "Pivot";
            case "G-F", "F-G" -> "Escolta";
            case "F-C", "C-F" -> "Ala-pivot";
            default -> position;
        };
    }

    private record GameSyncResult(int games, int teams) {
    }

    private static class TeamSeasonRecord {

        private final String abbreviation;
        private final String name;
        private int wins;
        private int losses;

        TeamSeasonRecord(String abbreviation, String name) {
            this.abbreviation = abbreviation;
            this.name = name;
        }

        void registerGame(boolean win) {
            if (win) {
                wins++;
            } else {
                losses++;
            }
        }

        String abbreviation() {
            return abbreviation;
        }

        String name() {
            return name;
        }

        int wins() {
            return wins;
        }

        int losses() {
            return losses;
        }

        int games() {
            return wins + losses;
        }
    }

    private record NbaStatsTable(Map<String, Integer> headerIndex, java.util.List<java.util.List<?>> rows) {

        static NbaStatsTable from(Map<String, Object> body) {
            Object[] resultSets = ((java.util.List<?>) body.get("resultSets")).toArray();
            Map<?, ?> result = (Map<?, ?>) resultSets[0];
            java.util.List<?> headers = (java.util.List<?>) result.get("headers");
            java.util.List<?> rowSet = (java.util.List<?>) result.get("rowSet");
            java.util.List<java.util.List<?>> rows = new java.util.ArrayList<>();
            Map<String, Integer> index = new HashMap<>();

            for (int i = 0; i < headers.size(); i++) {
                index.put(String.valueOf(headers.get(i)), i);
            }

            for (Object row : rowSet) {
                rows.add((java.util.List<?>) row);
            }

            return new NbaStatsTable(index, rows);
        }

        String string(java.util.List<?> row, String column) {
            Integer index = headerIndex.get(column);
            if (index == null) {
                return "";
            }
            Object value = row.get(index);
            return value == null ? "" : String.valueOf(value);
        }

        Integer integer(java.util.List<?> row, String column) {
            Integer index = headerIndex.get(column);
            if (index == null) {
                return 0;
            }
            Object value = row.get(index);
            if (value == null || String.valueOf(value).isBlank()) {
                return 0;
            }
            return ((Number) value).intValue();
        }

        Double decimal(java.util.List<?> row, String column) {
            Integer index = headerIndex.get(column);
            if (index == null) {
                return 0.0;
            }
            Object value = row.get(index);
            if (value == null || String.valueOf(value).isBlank()) {
                return 0.0;
            }
            return ((Number) value).doubleValue();
        }
    }
}
