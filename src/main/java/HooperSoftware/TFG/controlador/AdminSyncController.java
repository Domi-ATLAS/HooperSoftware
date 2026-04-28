package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.external.service.BalldontlieSyncService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin/sync")
public class AdminSyncController {

    private final BalldontlieSyncService service;

    public AdminSyncController(BalldontlieSyncService service) {
        this.service = service;
    }

    @PostMapping("/all")
    public String syncAll(@RequestParam int season) {

        try {
            int teams = service.syncTeams();
            int players = service.syncPlayersBySeason(season);
            int games = service.syncGamesBySeason(season);

            return "✅ Equipos: " + teams
                    + " | Jugadores: " + players
                    + " | Partidos (" + season + "): " + games;

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ ERROR: " + e.getMessage();
        }
    }
}
