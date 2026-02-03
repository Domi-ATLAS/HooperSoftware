package HooperSoftware.TFG.controlador;

@RestController
@RequestMapping("/admin/sync")
@PreAuthorize("hasAuthority('admin')")
public class AdminSyncController {

    private final BalldontlieSyncService syncService;

    public AdminSyncController(BalldontlieSyncService syncService) {
        this.syncService = syncService;
    }

    @PostMapping("/teams")
    public ResponseEntity<String> syncTeams() {
        int total = syncService.syncTeams();
        return ResponseEntity.ok("Equipos sincronizados: " + total);
    }
}
