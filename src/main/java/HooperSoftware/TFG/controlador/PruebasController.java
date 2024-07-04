package HooperSoftware.TFG.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PruebasController {

    @GetMapping("/prueba")
    public String pruebas(Model model) {
        model.addAttribute("mensaje", "Hola desde el controlador de pruebas!");
        return "prueba";
    }
}