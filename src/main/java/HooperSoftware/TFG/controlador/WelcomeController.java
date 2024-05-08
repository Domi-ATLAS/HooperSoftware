package HooperSoftware.TFG.controlador;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import jakarta.websocket.server.PathParam;


@RestController
public class WelcomeController {

    @GetMapping("/welcome")
    public ModelAndView welcome(Map<String, Object> model) {
        ModelAndView mv = new ModelAndView("home");
        return mv;
    }

    @GetMapping("/noticias")
    public ModelAndView noticias(Map<String, Object> model) {
        ModelAndView mv = new ModelAndView("noticias");
        return mv;
    }


    @GetMapping("/login")
    public String login(@PathParam("error") String error, Model model) {
        if (error != null) {
            List<String> errors = List.of("Lo sentimos pero el usuario y la contraseña no coinciden con los de ningún usuario registrado o habilitado");
            model.addAttribute("errors", errors);
        }
        return "login";
    }
}