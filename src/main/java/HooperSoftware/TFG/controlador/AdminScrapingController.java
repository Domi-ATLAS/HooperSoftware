package HooperSoftware.TFG.controlador;

import HooperSoftware.TFG.scraper.NbaScrapingService;
import HooperSoftware.TFG.scraper.dto.NbaTeamScrapeDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/scrape")
public class AdminScrapingController {

    private final NbaScrapingService scrapingService;

    public AdminScrapingController(NbaScrapingService scrapingService) {
        this.scrapingService = scrapingService;
    }

    @PostMapping("/nba/full")
    @PreAuthorize("hasAuthority('admin')")
    public ResponseEntity<?> scrapeAllNbaData() {

        List<NbaTeamScrapeDTO> teams = scrapingService.scrapeTeams();

        return ResponseEntity.ok(
                "Equipos NBA scrapeados correctamente: " + teams.size()
        );
    }
}
