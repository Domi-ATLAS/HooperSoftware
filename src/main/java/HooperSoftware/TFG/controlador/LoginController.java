package HooperSoftware.TFG.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.servicio.UsuarioService;

import java.util.List;

@Controller
public class LoginController {
    
    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute("usuario") Usuario usuario, Model model) {
        Usuario existingUsuario = usuarioService.findUsuarioByNombreUsuario(usuario.getUsername());
        if (existingUsuario != null && passwordEncoder.matches(usuario.getPassword(), existingUsuario.getPassword())) {
            // Redirigir a la sección de noticias
            return "redirect:/noticias";
        } else {
            List<String> errors = List.of("Lo sentimos pero el usuario y la contraseña no coinciden con los de ningún usuario registrado o habilitado");
            model.addAttribute("errors", errors);
            return "login";
        }
    }
}