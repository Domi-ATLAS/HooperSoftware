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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

    private static final String BALLDONTLIE_STATS_URL =
            "https://api.balldontlie.io/v1/stats?seasons[]=%d&per_page=100%s";

    private static final String[] GITHUB_PLAYER_BOX_SCORE_URLS = {
            "https://raw.githubusercontent.com/NocturneBear/NBA-Data-2010-2024/main/regular_season_box_scores_2010_2024_part_1.csv",
            "https://raw.githubusercontent.com/NocturneBear/NBA-Data-2010-2024/main/regular_season_box_scores_2010_2024_part_2.csv",
            "https://raw.githubusercontent.com/NocturneBear/NBA-Data-2010-2024/main/regular_season_box_scores_2010_2024_part_3.csv"
    };

    private static final String BASKETBALL_REFERENCE_TOTALS_URL =
            "https://www.basketball-reference.com/leagues/NBA_%d_totals.html";

    @Value("${balldontlie.api-key:}")
    private String balldontlieApiKey;

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

    @Transactional
    public NbaSeasonSyncReport syncSeason(int season) {
        NbaSeasonSyncReport report = new NbaSeasonSyncReport(season);
        String nbaSeason = toNbaSeason(season);

        try {
            report.setTeams(syncTeams(nbaSeason));
        } catch (RuntimeException exception) {
            report.addWarning("equipos online no disponibles");
        }

        try {
            int players = syncPlayers(season, nbaSeason);
            if (players == 0) {
                throw new RuntimeException("NBA Stats no devolvio jugadores para la temporada");
            }
            report.setPlayers(players);
        } catch (RuntimeException exception) {
            try {
                report.setPlayers(syncPlayersFromBalldontlie(season));
                report.addWarning("jugadores cargados desde balldontlie por fallo de NBA Stats");
            } catch (RuntimeException fallbackException) {
                try {
                    report.setPlayers(syncPlayersFromGithubCsv(season));
                    report.addWarning("jugadores cargados desde CSV publico por fallo de NBA Stats y balldontlie");
                } catch (RuntimeException csvException) {
                    try {
                        report.setPlayers(syncPlayersFromBasketballReference(season));
                        report.addWarning("jugadores cargados desde Basketball Reference por fallo de NBA Stats, balldontlie y CSV publico");
                    } catch (RuntimeException basketballReferenceException) {
                        report.addWarning("jugadores online no disponibles: "
                                + fallbackException.getMessage()
                                + " / CSV: "
                                + csvException.getMessage()
                                + " / Basketball Reference: "
                                + basketballReferenceException.getMessage());
                    }
                }
            }
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

    private int syncPlayers(int season, String nbaSeason) {
        Map<String, Object> body = requestJson(String.format(NBA_PLAYER_STATS_URL, nbaSeason));
        NbaStatsTable table = NbaStatsTable.from(body);
        int saved = 0;

        for (java.util.List<?> row : table.rows()) {
            Integer playerId = seasonalPlayerId(season, table.integer(row, "PLAYER_ID"));
            String teamAbbreviation = table.string(row, "TEAM_ABBREVIATION");
            Equipo equipo = equipoRepository.save(findOrCreateTeam(table.integer(row, "TEAM_ID"), teamAbbreviation));

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
            applyEmptyStatsDefaults(stats);
            estadisticasJugadorRepository.save(stats);

            Jugador jugador = jugadorRepository.findJugadorById(playerId);
            if (jugador == null) {
                jugador = new Jugador();
                jugador.setIdJugador(playerId);
            }

            jugador.setNombreJugador(table.string(row, "PLAYER_NAME"));
            String normalizedPosition = normalizePosition(table.string(row, "PLAYER_POSITION"));
            if (!normalizedPosition.isBlank()) {
                jugador.setPosicion(normalizedPosition);
            }
            jugador.setEdadJug(table.integer(row, "AGE"));
            applyPlayerDefaults(jugador);
            jugador.setTemporadaJugador(toAppSeason(season));
            jugador.setEquipo(equipo);
            jugador.setEstadisticasJug(stats);

            jugadorRepository.save(jugador);
            saved++;
        }

        return saved;
    }

    private int syncPlayersFromBalldontlie(int season) {
        if (balldontlieApiKey == null || balldontlieApiKey.isBlank()) {
            throw new RuntimeException("API key balldontlie no configurada");
        }

        Map<Integer, PlayerImport> imports = new java.util.LinkedHashMap<>();
        String cursor = "";
        boolean hasNext = true;

        while (hasNext) {
            ResponseEntity<Map> response = restTemplate.exchange(
                    String.format(BALLDONTLIE_STATS_URL, season, cursor.isBlank() ? "" : "&cursor=" + cursor),
                    HttpMethod.GET,
                    balldontlieEntity(),
                    Map.class);
            Map<?, ?> body = response.getBody();

            if (body == null) {
                throw new RuntimeException("respuesta vacia de balldontlie");
            }

            java.util.List<?> data = (java.util.List<?>) body.get("data");
            Map<?, ?> meta = (Map<?, ?>) body.get("meta");

            if (data == null || data.isEmpty()) {
                break;
            }

            for (Object item : data) {
                Map<?, ?> statData = (Map<?, ?>) item;
                Map<?, ?> playerData = (Map<?, ?>) statData.get("player");
                Map<?, ?> teamData = (Map<?, ?>) statData.get("team");

                if (playerData == null || teamData == null) {
                    continue;
                }

                Integer playerId = seasonalPlayerId(season, integerValue(playerData.get("id")));
                PlayerImport playerImport = imports.computeIfAbsent(playerId, PlayerImport::new);

                playerImport.name = (stringValue(playerData.get("first_name")) + " "
                        + stringValue(playerData.get("last_name"))).trim();
                playerImport.position = normalizePosition(stringValue(playerData.get("position")));
                playerImport.teamId = integerValue(teamData.get("id"));
                playerImport.teamAbbreviation = stringValue(teamData.get("abbreviation"));
                playerImport.teamName = stringValue(teamData.get("full_name"));
                if (playerImport.teamName.isBlank()) {
                    playerImport.teamName = (stringValue(teamData.get("city")) + " "
                            + stringValue(teamData.get("name"))).trim();
                }
                playerImport.addStats(statData);
            }

            Object nextCursor = meta == null ? null : meta.get("next_cursor");
            hasNext = nextCursor != null && !String.valueOf(nextCursor).isBlank();
            cursor = hasNext ? String.valueOf(nextCursor) : "";
        }

        int saved = 0;
        for (PlayerImport playerImport : imports.values()) {
            Equipo equipo = equipoRepository.save(findOrCreateTeam(playerImport.teamId, playerImport.teamAbbreviation));
            if (equipo.getNombreEquipo() == null
                    || equipo.getNombreEquipo().isBlank()
                    || equipo.getNombreEquipo().equals(playerImport.teamAbbreviation)) {
                equipo.setNombreEquipo(playerImport.teamName);
                equipoRepository.save(equipo);
            }

            EstadisticasJugador stats = estadisticasJugadorRepository
                    .findById(playerImport.id)
                    .orElseGet(EstadisticasJugador::new);
            stats.setIdEstJugador(playerImport.id);
            playerImport.copyStatsTo(stats);
            estadisticasJugadorRepository.save(stats);

            Jugador jugador = jugadorRepository.findJugadorById(playerImport.id);
            if (jugador == null) {
                jugador = new Jugador();
                jugador.setIdJugador(playerImport.id);
            }
            jugador.setNombreJugador(playerImport.name);
            if (!playerImport.position.isBlank()) {
                jugador.setPosicion(playerImport.position);
            }
            applyPlayerDefaults(jugador);
            jugador.setTemporadaJugador(toAppSeason(season));
            jugador.setEquipo(equipo);
            jugador.setEstadisticasJug(stats);
            jugadorRepository.save(jugador);
            saved++;
        }

        return saved;
    }

    private int syncPlayersFromGithubCsv(int season) {
        Map<Integer, PlayerImport> imports = new java.util.LinkedHashMap<>();
        String seasonLabel = toNbaSeason(season);

        for (String url : GITHUB_PLAYER_BOX_SCORE_URLS) {
            String csv = restTemplate.getForObject(url, String.class);

            try (CSVReader reader = new CSVReader(new StringReader(Objects.requireNonNull(csv)))) {
                String[] header = reader.readNext();
                Map<String, Integer> index = indexHeader(header);
                String[] row;

                while ((row = reader.readNext()) != null) {
                    if (!seasonLabel.equals(csvString(row, index, "season_year"))) {
                        continue;
                    }

                    Integer playerId = seasonalPlayerId(season, csvInteger(row, index, "personId"));
                    PlayerImport playerImport = imports.computeIfAbsent(playerId, PlayerImport::new);
                    playerImport.name = csvString(row, index, "personName");
                    playerImport.position = normalizePosition(csvString(row, index, "position"));
                    playerImport.teamId = csvInteger(row, index, "teamId");
                    playerImport.teamAbbreviation = csvString(row, index, "teamTricode");
                    playerImport.teamCity = csvString(row, index, "teamCity");
                    playerImport.teamName = (playerImport.teamCity + " " + csvString(row, index, "teamName")).trim();
                    playerImport.jerseyNumber = csvInteger(row, index, "jerseyNum");
                    playerImport.addGithubStats(row, index);
                }
            } catch (IOException | CsvValidationException exception) {
                throw new RuntimeException("No se pudo leer el CSV publico de jugadores", exception);
            }
        }

        int saved = 0;
        for (PlayerImport playerImport : imports.values()) {
            Equipo equipo = equipoRepository.save(findOrCreateTeam(playerImport.teamId, playerImport.teamAbbreviation));
            if (!playerImport.teamName.isBlank()) {
                equipo.setNombreEquipo(playerImport.teamName);
            }
            if (!playerImport.teamCity.isBlank()) {
                equipo.setCiudad(playerImport.teamCity);
            }
            equipo.setSiglas(playerImport.teamAbbreviation);
            equipoRepository.save(equipo);

            EstadisticasJugador stats = estadisticasJugadorRepository
                    .findById(playerImport.id)
                    .orElseGet(EstadisticasJugador::new);
            stats.setIdEstJugador(playerImport.id);
            playerImport.copyStatsTo(stats);
            estadisticasJugadorRepository.save(stats);

            Jugador jugador = jugadorRepository.findJugadorById(playerImport.id);
            if (jugador == null) {
                jugador = new Jugador();
                jugador.setIdJugador(playerImport.id);
            }
            jugador.setNombreJugador(playerImport.name);
            if (!playerImport.position.isBlank()) {
                jugador.setPosicion(playerImport.position);
            }
            applyPlayerDefaults(jugador);
            jugador.setTemporadaJugador(toAppSeason(season));
            if (playerImport.jerseyNumber > 0) {
                jugador.setDorsal(playerImport.jerseyNumber);
                jugador.setDorsales(String.valueOf(playerImport.jerseyNumber));
            }
            jugador.setEquipo(equipo);
            jugador.setEstadisticasJug(stats);
            jugadorRepository.save(jugador);
            saved++;
        }

        if (saved == 0) {
            throw new RuntimeException("CSV publico sin jugadores para la temporada " + seasonLabel);
        }

        return saved;
    }

    private int syncPlayersFromBasketballReference(int season) {
        String url = String.format(BASKETBALL_REFERENCE_TOTALS_URL, season);
        Map<Integer, PlayerImport> imports = new java.util.LinkedHashMap<>();

        try {
            Document document = Jsoup.connect(url)
                    .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/125 Safari/537.36")
                    .timeout(15000)
                    .get();

            for (Element row : document.select("#totals_stats tbody tr")) {
                if (row.hasClass("thead")) {
                    continue;
                }

                String playerKey = row.selectFirst("[data-stat=name_display]") == null
                        ? ""
                        : row.selectFirst("[data-stat=name_display]").attr("data-append-csv");
                String playerName = text(row, "name_display");
                String teamAbbreviation = text(row, "team_name_abbr");

                if (playerName.isBlank()
                        || "League Average".equalsIgnoreCase(playerName)
                        || teamAbbreviation.isBlank()
                        || "TOT".equals(teamAbbreviation)) {
                    continue;
                }

            Integer playerId = stablePositiveId(season + "-" + (playerKey.isBlank() ? playerName : playerKey));
                PlayerImport playerImport = imports.computeIfAbsent(playerId, PlayerImport::new);
                playerImport.name = playerName;
                playerImport.position = normalizePosition(text(row, "pos"));
                playerImport.teamId = stablePositiveId("team-" + teamAbbreviation);
                playerImport.teamAbbreviation = teamAbbreviation;
                playerImport.teamName = teamAbbreviation;
                playerImport.addBasketballReferenceStats(row);
                Integer age = integerText(row, "age");
                if (age > 0) {
                    playerImport.age = age;
                }
            }
        } catch (IOException exception) {
            throw new RuntimeException("No se pudo leer Basketball Reference", exception);
        }

        int saved = 0;
        for (PlayerImport playerImport : imports.values()) {
            Equipo equipo = equipoRepository.save(findOrCreateTeam(playerImport.teamId, playerImport.teamAbbreviation));

            EstadisticasJugador stats = estadisticasJugadorRepository
                    .findById(playerImport.id)
                    .orElseGet(EstadisticasJugador::new);
            stats.setIdEstJugador(playerImport.id);
            playerImport.copyStatsTo(stats);
            estadisticasJugadorRepository.save(stats);

            Jugador jugador = jugadorRepository.findJugadorById(playerImport.id);
            if (jugador == null) {
                jugador = new Jugador();
                jugador.setIdJugador(playerImport.id);
            }
            jugador.setNombreJugador(playerImport.name);
            if (!playerImport.position.isBlank()) {
                jugador.setPosicion(playerImport.position);
            }
            if (playerImport.age > 0) {
                jugador.setEdadJug(playerImport.age);
            }
            applyPlayerDefaults(jugador);
            jugador.setTemporadaJugador(toAppSeason(season));
            jugador.setEquipo(equipo);
            jugador.setEstadisticasJug(stats);
            jugadorRepository.save(jugador);
            saved++;
        }

        if (saved == 0) {
            throw new RuntimeException("sin jugadores encontrados para " + season);
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

    private HttpEntity<String> balldontlieEntity() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", balldontlieApiKey);
        headers.set("Accept", "application/json");
        return new HttpEntity<>(headers);
    }

    private void applyPlayerDefaults(Jugador jugador) {
        if (jugador.getRetirado() == null) {
            jugador.setRetirado(false);
        }
        if (jugador.getHallOfFame() == null) {
            jugador.setHallOfFame(false);
        }
        if (jugador.getFotoJugador() == null || jugador.getFotoJugador().isBlank()) {
            jugador.setFotoJugador("default-avatar.png");
        }
        if (jugador.getDorsal() == null) {
            jugador.setDorsal(0);
        }
        if (jugador.getDorsales() == null) {
            jugador.setDorsales("");
        }
        if (jugador.getUniversidad() == null) {
            jugador.setUniversidad("");
        }
        if (jugador.getPaisNacimiento() == null) {
            jugador.setPaisNacimiento("");
        }
        if (jugador.getCiudadNacimiento() == null) {
            jugador.setCiudadNacimiento("");
        }
        if (jugador.getAlturaJug() == null) {
            jugador.setAlturaJug("");
        }
        if (jugador.getPesoJug() == null) {
            jugador.setPesoJug("");
        }
        if (jugador.getTrayectoriaJug() == null) {
            jugador.setTrayectoriaJug("");
        }
        if (jugador.getAnoDraft() == null) {
            jugador.setAnoDraft(0);
        }
        if (jugador.getEdadJug() == null) {
            jugador.setEdadJug(0);
        }
        if (jugador.getAnosAllStarJug() == null) {
            jugador.setAnosAllStarJug(0);
        }
        if (jugador.getAnosNbaJug() == null) {
            jugador.setAnosNbaJug(0);
        }
        if (jugador.getAnosOtraLigaJug() == null) {
            jugador.setAnosOtraLigaJug(0);
        }
        if (jugador.getPosicion() == null) {
            jugador.setPosicion("");
        }
    }

    private void applyEmptyStatsDefaults(EstadisticasJugador stats) {
        if (stats.getPuntosTotales() == null) {
            stats.setPuntosTotales(0);
        }
        if (stats.getAsistenciasTotales() == null) {
            stats.setAsistenciasTotales(0);
        }
        if (stats.getRebotesTotales() == null) {
            stats.setRebotesTotales(0);
        }
        if (stats.getTaponesTotales() == null) {
            stats.setTaponesTotales(0);
        }
        if (stats.getRobosTotales() == null) {
            stats.setRobosTotales(0);
        }
        if (stats.getPartidosJugadosJug() == null) {
            stats.setPartidosJugadosJug(0);
        }
        if (stats.getPartidosGanadosJug() == null) {
            stats.setPartidosGanadosJug(0);
        }
        if (stats.getPartidosPerdidosJug() == null) {
            stats.setPartidosPerdidosJug(0);
        }
        if (stats.getTriplesAnotados() == null) {
            stats.setTriplesAnotados(0);
        }
        if (stats.getTirosLibresAnotados() == null) {
            stats.setTirosLibresAnotados(0);
        }
        if (stats.getTirosDeCampoAnotados() == null) {
            stats.setTirosDeCampoAnotados(0);
        }
        if (stats.getMinutosTotales() == null) {
            stats.setMinutosTotales(0);
        }
        if (stats.getTitulosGanadoNbaJug() == null) {
            stats.setTitulosGanadoNbaJug(0);
        }
        if (stats.getTitulosPerdidosNbaJug() == null) {
            stats.setTitulosPerdidosNbaJug(0);
        }
        if (stats.getTitulosGanadoConferenciaJug() == null) {
            stats.setTitulosGanadoConferenciaJug(0);
        }
        if (stats.getTitulosPerdidosConferenciaJug() == null) {
            stats.setTitulosPerdidosConferenciaJug(0);
        }
    }

    private Integer integerValue(Object value) {
        if (value == null || String.valueOf(value).isBlank()) {
            return 0;
        }
        if (value instanceof Number number) {
            return number.intValue();
        }
        return (int) Math.round(Double.parseDouble(String.valueOf(value)));
    }

    private Integer minutesValue(Object value) {
        if (value == null || String.valueOf(value).isBlank()) {
            return 0;
        }
        if (value instanceof Number number) {
            return number.intValue();
        }

        String text = String.valueOf(value);
        if (text.contains(":")) {
            return integerValue(text.substring(0, text.indexOf(":")));
        }

        return integerValue(text);
    }

    private String csvString(String[] row, Map<String, Integer> index, String column) {
        Integer position = index.get(column);
        if (position == null || position >= row.length) {
            return "";
        }
        return row[position] == null ? "" : row[position].trim();
    }

    private Integer csvInteger(String[] row, Map<String, Integer> index, String column) {
        String value = csvString(row, index, column);
        if (value.isBlank()) {
            return 0;
        }
        try {
            return (int) Math.round(Double.parseDouble(value));
        } catch (NumberFormatException exception) {
            return 0;
        }
    }

    private Integer csvMinutes(String[] row, Map<String, Integer> index, String column) {
        String value = csvString(row, index, column);
        if (value.isBlank()) {
            return 0;
        }
        if (value.contains(":")) {
            return integerValue(value.substring(0, value.indexOf(":")));
        }
        return csvInteger(row, index, column);
    }

    private String text(Element row, String dataStat) {
        Element cell = row.selectFirst("[data-stat=" + dataStat + "]");
        return cell == null ? "" : cell.text().trim();
    }

    private Integer integerText(Element row, String dataStat) {
        String value = text(row, dataStat);
        if (value.isBlank()) {
            return 0;
        }
        try {
            return (int) Math.round(Double.parseDouble(value));
        } catch (NumberFormatException exception) {
            return 0;
        }
    }

    private String stringValue(Object value) {
        return value == null ? "" : String.valueOf(value);
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
        return Math.floorMod(value.hashCode(), Integer.MAX_VALUE);
    }

    private int seasonalPlayerId(int season, Integer sourcePlayerId) {
        return stablePositiveId("player-" + season + "-" + sourcePlayerId);
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
            case "PG" -> "Base";
            case "SG" -> "Escolta";
            case "SF" -> "Alero";
            case "PF" -> "Ala-pivot";
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

    private class PlayerImport {

        private final Integer id;
        private String name = "";
        private String position = "";
        private Integer teamId = 0;
        private String teamAbbreviation = "";
        private String teamCity = "";
        private String teamName = "";
        private int jerseyNumber;
        private int age;
        private int points;
        private int assists;
        private int rebounds;
        private int blocks;
        private int steals;
        private int games;
        private int wins;
        private int losses;
        private int threes;
        private int freeThrows;
        private int fieldGoals;
        private int minutes;

        PlayerImport(Integer id) {
            this.id = id;
        }

        void addStats(Map<?, ?> statData) {
            points += integerValue(statData.get("pts"));
            assists += integerValue(statData.get("ast"));
            rebounds += integerValue(statData.get("reb"));
            blocks += integerValue(statData.get("blk"));
            steals += integerValue(statData.get("stl"));
            threes += integerValue(statData.get("fg3m"));
            freeThrows += integerValue(statData.get("ftm"));
            fieldGoals += integerValue(statData.get("fgm"));
            minutes += minutesValue(statData.get("min"));
            games++;
            registerResult(statData);
        }

        void addGithubStats(String[] row, Map<String, Integer> index) {
            points += csvInteger(row, index, "points");
            assists += csvInteger(row, index, "assists");
            rebounds += csvInteger(row, index, "reboundsTotal");
            blocks += csvInteger(row, index, "blocks");
            steals += csvInteger(row, index, "steals");
            threes += csvInteger(row, index, "threePointersMade");
            freeThrows += csvInteger(row, index, "freeThrowsMade");
            fieldGoals += csvInteger(row, index, "fieldGoalsMade");
            minutes += csvMinutes(row, index, "minutes");
            games++;
        }

        void addBasketballReferenceStats(Element row) {
            points += integerText(row, "pts");
            assists += integerText(row, "ast");
            rebounds += integerText(row, "trb");
            blocks += integerText(row, "blk");
            steals += integerText(row, "stl");
            games = Math.max(games, integerText(row, "games"));
            threes += integerText(row, "fg3");
            freeThrows += integerText(row, "ft");
            fieldGoals += integerText(row, "fg");
            minutes += integerText(row, "mp");
        }

        void copyStatsTo(EstadisticasJugador stats) {
            stats.setPuntosTotales(points);
            stats.setAsistenciasTotales(assists);
            stats.setRebotesTotales(rebounds);
            stats.setTaponesTotales(blocks);
            stats.setRobosTotales(steals);
            stats.setPartidosJugadosJug(games);
            stats.setPartidosGanadosJug(wins);
            stats.setPartidosPerdidosJug(losses);
            stats.setTriplesAnotados(threes);
            stats.setTirosLibresAnotados(freeThrows);
            stats.setTirosDeCampoAnotados(fieldGoals);
            stats.setMinutosTotales(minutes);
            applyEmptyStatsDefaults(stats);
        }

        private void registerResult(Map<?, ?> statData) {
            Map<?, ?> gameData = (Map<?, ?>) statData.get("game");
            if (gameData == null || teamId == null) {
                return;
            }

            Integer homeTeamId = integerValue(gameData.get("home_team_id"));
            Integer visitorTeamId = integerValue(gameData.get("visitor_team_id"));
            Integer homeScore = integerValue(gameData.get("home_team_score"));
            Integer visitorScore = integerValue(gameData.get("visitor_team_score"));

            if (homeScore.equals(visitorScore)) {
                return;
            }

            boolean isHome = teamId.equals(homeTeamId);
            boolean isVisitor = teamId.equals(visitorTeamId);

            if ((isHome && homeScore > visitorScore) || (isVisitor && visitorScore > homeScore)) {
                wins++;
            } else if (isHome || isVisitor) {
                losses++;
            }
        }
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
