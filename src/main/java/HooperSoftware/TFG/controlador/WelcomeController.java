package HooperSoftware.TFG.controlador;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class WelcomeController {

    @GetMapping("/welcome")
    public ModelAndView welcome(Map<String, Object> model) {
        ModelAndView mv = new ModelAndView("home");
        return mv;
    }
}