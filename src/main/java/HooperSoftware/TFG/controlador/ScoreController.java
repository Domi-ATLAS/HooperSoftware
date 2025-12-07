package HooperSoftware.TFG.controlador;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Consulta la API pública balldontlie para obtener los partidos de hoy
 * (y opcionalmente de mañana) y devolverlos en un formato simple para el front.
 *
 * GET /api/nba/scores
 */
@RestController
public class ScoreController {

    private static final Logger log = LoggerFactory.getLogger(ScoreController.class);

    // clave que pones en application.properties
    @Value("${balldontlie.api-key:}")
    private String apiKey;

    private final RestTemplate rest = new RestTemplate();
    private final ObjectMapper mapper = new ObjectMapper();

    // tu zona horaria
    private final ZoneId ZONE = ZoneId.of("Europe/Madrid");

    @GetMapping("/api/nba/scores")
    public ResponseEntity<?> getScores() {
        try {
            if (apiKey == null || apiKey.isBlank()) {
                log.error("No se ha configurado balldontlie.api-key");
                return ResponseEntity.status(500)
                        .body(Map.of("error", "Falta configurar balldontlie.api-key en application.properties"));
            }

            // hoy (en tu zona horaria)
            LocalDate today = LocalDate.now(ZONE);
            // si quieres incluir también mañana, descomenta esta línea y lo que va con 'tomorrow'
            // LocalDate tomorrow = today.plusDays(1);

            List<JsonNode> allGames = new ArrayList<>();

            // base de la URL (v1 de balldontlie)
            String base = "https://api.balldontlie.io/v1/games?per_page=100&dates[]=";

            // si quieres solo hoy:
            String[] dates = { today.toString() };

            // si quisieras hoy + mañana:
            // String[] dates = { today.toString(), tomorrow.toString() };

            log.info("Consultando balldontlie para fechas: {}", (Object) dates);

            // cabeceras con la API key
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", apiKey);
            HttpEntity<Void> entity = new HttpEntity<>(headers);

            for (String d : dates) {
                String url = base + d;
                ResponseEntity<String> response = rest.exchange(
                        url,
                        HttpMethod.GET,
                        entity,
                        String.class
                );

                if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
                    log.warn("Respuesta no OK de balldontlie para {}: {}", d, response.getStatusCode());
                    continue;
                }

                JsonNode root = mapper.readTree(response.getBody());
                JsonNode data = root.path("data");
                if (data.isArray()) {
                    data.forEach(allGames::add);
                }
            }

            List<GameOutput> out = new ArrayList<>();
            for (JsonNode g : allGames) {
                GameOutput go = new GameOutput();
                go.id = g.path("id").asLong();
                go.date = g.path("date").asText();
                go.status = g.path("status").asText();       // e.g. "Final", "Scheduled", "In Progress"
                go.season = g.path("season").asInt();
                go.home_team = g.path("home_team").path("full_name").asText();
                go.visitor_team = g.path("visitor_team").path("full_name").asText();
                go.home_score = g.path("home_team_score").asInt();
                go.visitor_score = g.path("visitor_team_score").asInt();
                out.add(go);
            }

            // ordenamos por fecha/hora textual
            out.sort((a, b) -> a.date.compareTo(b.date));

            log.info("Devolviendo {} partidos", out.size());
            return ResponseEntity.ok(out);

        } catch (Exception e) {
            log.error("Error obteniendo marcadores de balldontlie", e);
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage()));
        }
    }

    // DTO simple para el JSON de salida
    static class GameOutput {
        public long id;
        public String date;
        public String status;
        public int season;
        public String home_team;
        public String visitor_team;
        public int home_score;
        public int visitor_score;
    }
}
