package HooperSoftware.TFG.controlador;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/embed")
public class EmbedController {

    private final RestTemplate rest = new RestTemplate();

    @GetMapping(value = "/standings", produces = MediaType.TEXT_HTML_VALUE)
    public ResponseEntity<String> standings() {
        String url = "https://www.nba.com/standings";
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (compatible; HooperSoftware/1.0)");
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> resp = rest.exchange(url, HttpMethod.GET, entity, String.class);

        // Opcional: reescritura básica para proteger links relativos (simple ejemplo)
        String body = resp.getBody();
        if (body == null) body = "<html><body>Error al obtener la página</body></html>";

        // EJEMPLO simple: convertir recursos relativos src="/..." a src="https://www.nba.com/..."
        body = body.replaceAll("(?i)href\\s*=\\s*\"/(?!/)", "href=\"https://www.nba.com/");
        body = body.replaceAll("(?i)src\\s*=\\s*\"/(?!/)", "src=\"https://www.nba.com/");

        HttpHeaders out = new HttpHeaders();
        out.setContentType(MediaType.TEXT_HTML);
        // No debemos copiar las cabeceras de la respuesta de nba.com (p.ej. X-Frame-Options)
        return new ResponseEntity<>(body, out, HttpStatus.OK);
    }
}
