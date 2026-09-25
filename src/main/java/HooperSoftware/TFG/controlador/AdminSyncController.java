package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.external.dto.NbaSeasonSyncReport;
import HooperSoftware.TFG.external.service.NbaInternetSyncService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/sync")
public class AdminSyncController {

    private final NbaInternetSyncService service;

    public AdminSyncController(NbaInternetSyncService service) {
        this.service = service;
    }

    @PostMapping("/all")
    public String syncAll(@RequestParam int season) {
        return runSync(season);
    }

    @GetMapping("/all")
    public String syncAllFromBrowser(@RequestParam int season) {
        return runSync(season);
    }

    private String runSync(int season) {
        try {
            NbaSeasonSyncReport report = service.syncSeason(season);
            return report.toAdminMessage();
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }
}
