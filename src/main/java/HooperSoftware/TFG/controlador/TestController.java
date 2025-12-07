package HooperSoftware.TFG.controlador;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/api/hello")
    public String hello() {
        return "{\"status\":\"ok\",\"who\":\"test-controller\"}";
    }
}
