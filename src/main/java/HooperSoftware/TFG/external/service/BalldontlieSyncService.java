package HooperSoftware.TFG.external.service;

import HooperSoftware.TFG.external.entity.ExternalGame;
import HooperSoftware.TFG.external.entity.ExternalPlayer;
import HooperSoftware.TFG.external.entity.ExternalTeam;
import HooperSoftware.TFG.external.repository.ExternalGameRepository;
import HooperSoftware.TFG.external.repository.ExternalPlayerRepository;
import HooperSoftware.TFG.external.repository.ExternalTeamRepository;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class BalldontlieSyncService {

    private static final String API_KEY = "c23ce05e-4f8c-4ef7-89c8-5e92822fdb16";

    private final RestTemplate rest = new RestTemplate();
    private final ExternalTeamRepository teamRepo;
    private final ExternalPlayerRepository playerRepo;
    private final ExternalGameRepository gameRepo;

    public BalldontlieSyncService(
            ExternalTeamRepository teamRepo,
            ExternalPlayerRepository playerRepo,
            ExternalGameRepository gameRepo) {
        this.teamRepo = teamRepo;
        this.playerRepo = playerRepo;
        this.gameRepo = gameRepo;
    }

    // =========================
    // 🔵 TEAMS
    // =========================
    public int syncTeams() {

        String url = "https://api.balldontlie.io/v1/teams";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<Map> response = rest.exchange(
                url,
                HttpMethod.GET,
                entity,
                Map.class
        );

        Map<String, Object> body = response.getBody();

        List<Map<String, Object>> data
                = (List<Map<String, Object>>) body.get("data");

        int count = 0;

        for (Map<String, Object> t : data) {

            Long id = Long.valueOf(t.get("id").toString());

            if (teamRepo.existsById(id)) {
                continue;
            }

            ExternalTeam team = new ExternalTeam();
            team.setId(id);
            team.setAbbreviation((String) t.get("abbreviation"));
            team.setCity((String) t.get("city"));
            team.setName((String) t.get("name"));
            team.setConference((String) t.get("conference"));
            team.setDivision((String) t.get("division"));

            teamRepo.save(team);
            count++;
        }

        return count;
    }

    // =========================
    // 🟢 PLAYERS
    // =========================
    public int syncPlayers() {

        int totalSaved = 0;
        int page = 1;
        boolean hasNext = true;

        while (hasNext) {
            try {

                String url = "https://api.balldontlie.io/v1/players?page=" + page + "&per_page=100";

                HttpHeaders headers = new HttpHeaders();
                headers.set("Authorization", API_KEY);

                HttpEntity<String> entity = new HttpEntity<>(headers);

                ResponseEntity<Map> response = rest.exchange(
                        url,
                        HttpMethod.GET,
                        entity,
                        Map.class
                );

                Map<String, Object> body = response.getBody();

                List<Map<String, Object>> data
                        = (List<Map<String, Object>>) body.get("data");

                Map<String, Object> meta
                        = (Map<String, Object>) body.get("meta");

                for (Map<String, Object> p : data) {

                    Long playerId = Long.valueOf(p.get("id").toString());

                    if (playerRepo.existsById(playerId)) {
                        continue;
                    }

                    Map<String, Object> teamMap
                            = (Map<String, Object>) p.get("team");

                    Long teamId = Long.valueOf(teamMap.get("id").toString());

                    Optional<ExternalTeam> teamOpt = teamRepo.findById(teamId);
                    if (teamOpt.isEmpty()) {
                        continue;
                    }

                    ExternalPlayer player = new ExternalPlayer();
                    player.setId(playerId);
                    player.setFirstName((String) p.get("first_name"));
                    player.setLastName((String) p.get("last_name"));
                    player.setPosition((String) p.get("position"));
                    player.setTeam(teamOpt.get());

                    playerRepo.save(player);
                    totalSaved++;
                }

                Number nextPageNum = (Number) meta.get("next_page");
                Integer nextPage = nextPageNum != null ? nextPageNum.intValue() : null;

                hasNext = nextPage != null;
                page = hasNext ? nextPage : 0;

                Thread.sleep(1000);

            } catch (Exception e) {
                System.out.println("Error en página: " + page);
                e.printStackTrace();
                hasNext = false;
            }
        }

        return totalSaved;
    }

    // =========================
    // 🔴 GAMES
    // =========================
    public int syncGames() {

        int totalSaved = 0;
        int page = 1;
        boolean hasNext = true;

        while (hasNext) {
            try {

                String url = "https://api.balldontlie.io/v1/games?page=" + page + "&per_page=100";

                HttpHeaders headers = new HttpHeaders();
                headers.set("Authorization", API_KEY);

                HttpEntity<String> entity = new HttpEntity<>(headers);

                ResponseEntity<Map> response = rest.exchange(
                        url,
                        HttpMethod.GET,
                        entity,
                        Map.class
                );

                Map<String, Object> body = response.getBody();

                List<Map<String, Object>> data
                        = (List<Map<String, Object>>) body.get("data");

                Map<String, Object> meta
                        = (Map<String, Object>) body.get("meta");

                for (Map<String, Object> g : data) {

                    Long gameId = Long.valueOf(g.get("id").toString());

                    if (gameRepo.existsById(gameId)) {
                        continue;
                    }

                    Map<String, Object> homeTeamMap
                            = (Map<String, Object>) g.get("home_team");

                    Map<String, Object> visitorTeamMap
                            = (Map<String, Object>) g.get("visitor_team");

                    Long homeTeamId = Long.valueOf(homeTeamMap.get("id").toString());
                    Long visitorTeamId = Long.valueOf(visitorTeamMap.get("id").toString());

                    Optional<ExternalTeam> homeTeamOpt = teamRepo.findById(homeTeamId);
                    Optional<ExternalTeam> visitorTeamOpt = teamRepo.findById(visitorTeamId);

                    if (homeTeamOpt.isEmpty() || visitorTeamOpt.isEmpty()) {
                        continue;
                    }

                    ExternalGame game = new ExternalGame();
                    game.setId(gameId);

                    String dateStr = (String) g.get("date");
                    game.setDate(java.time.LocalDate.parse(dateStr.substring(0, 10)));

                    game.setHomeScore((Integer) g.get("home_team_score"));
                    game.setVisitorScore((Integer) g.get("visitor_team_score"));

                    game.setHomeTeam(homeTeamOpt.get());
                    game.setVisitorTeam(visitorTeamOpt.get());

                    gameRepo.save(game);
                    totalSaved++;
                }

                Number nextPageNum = (Number) meta.get("next_page");
                Integer nextPage = nextPageNum != null ? nextPageNum.intValue() : null;

                hasNext = nextPage != null;
                page = hasNext ? nextPage : 0;

                Thread.sleep(1000);

            } catch (Exception e) {
                System.out.println("Error en página: " + page);
                e.printStackTrace();
                hasNext = false;
            }
        }

        return totalSaved;
    }
}
