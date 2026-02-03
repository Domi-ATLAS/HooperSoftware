package HooperSoftware.TFG.external.service;

import org.springframework.stereotype.Service;

@Service
public class BalldontlieSyncService {

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

    public int syncTeams() {
        String url = "https://api.balldontlie.io/v1/teams";
        Map<String, Object> response = rest.getForObject(url, Map.class);

        List<Map<String, Object>> data
                = (List<Map<String, Object>>) response.get("data");

        for (Map<String, Object> t : data) {
            ExternalTeam team = new ExternalTeam();
            team.setId(Long.valueOf(t.get("id").toString()));
            team.setAbbreviation((String) t.get("abbreviation"));
            team.setCity((String) t.get("city"));
            team.setName((String) t.get("name"));
            team.setConference((String) t.get("conference"));
            team.setDivision((String) t.get("division"));
            teamRepo.save(team);
        }
        return data.size();
    }
}
