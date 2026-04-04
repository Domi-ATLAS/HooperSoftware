package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.external.service.BalldontlieSyncService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
public class AdminSyncController {

    private final BalldontlieSyncService syncService;

    public AdminSyncController(BalldontlieSyncService syncService) {
        this.syncService = syncService;
    }

    @PostMapping("/sync/teams")
    public ResponseEntity<String> syncTeams() {
        int total = syncService.syncTeams();
        return ResponseEntity.ok("Equipos: " + total);
    }

    @PostMapping("/sync/players")
    public ResponseEntity<String> syncPlayers() {
        int total = syncService.syncPlayers();
        return ResponseEntity.ok("Jugadores: " + total);
    }

    @PostMapping("/sync/games")
    public ResponseEntity<String> syncGames() {
        int total = syncService.syncGames();
        return ResponseEntity.ok("Partidos: " + total);
    }
}
