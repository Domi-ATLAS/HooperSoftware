package HooperSoftware.TFG.controlador;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.components.ChangePasswordForm;
import HooperSoftware.TFG.entidad.Authorities;
import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.servicio.AuthoritiesService;
import HooperSoftware.TFG.servicio.UsuarioService;

@Controller
public class UsuarioController {

    PasswordEncoder passwordEncoder= new BCryptPasswordEncoder();
    
    UsuarioService UsuarioService;

    AuthoritiesService authoritiesService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        binder.registerCustomEditor(LocalDate.class, new CustomDateEditor(dateFormat, true));
    }

    public UsuarioController(UsuarioService UsuarioService, AuthoritiesService authoritiesService) {
        this.UsuarioService = UsuarioService;
        this.authoritiesService = authoritiesService;
    }



    @GetMapping("/new")
    public ModelAndView createUsuario(){
        Usuario u = new Usuario();
        ModelAndView result = new ModelAndView("perfil/createUsuario");
        result.addObject("usuario", u);
        return result;
    }


    @PostMapping("/new")
    public ModelAndView saveNewUsuario(Usuario u){
        List<String> errors = this.UsuarioService.checkUsuarioRestrictions(u);
        if(!errors.isEmpty()){
            ModelAndView result = new ModelAndView("perfil/createUsuario");
            result.addObject("errors", errors);
            System.out.println(errors);
            return result;
        }
        u.setEnabled(true);
        u.setPassword(passwordEncoder.encode(u.getPassword()));
        UsuarioService.save(u);
        Authorities a = new Authorities();
        a.setAuthority("user");
        a.setUsuario(u);
        a.setId(this.authoritiesService.findMaxId()+1);
        authoritiesService.save(a);
        ModelAndView result =new ModelAndView("redirect:/");
        result.addObject("succes",true);
        return result;
    }




    @GetMapping("/profile")
    public ModelAndView redirectProfile(String username,Principal principal){
        ModelAndView result = new ModelAndView("redirect:/perfil/profile/"+principal.getName());
        if(principal==null || principal.getName()==null || principal.getName().equals("")){
            result = new ModelAndView("redirect:/login");
        }
        return result;
    }

    @GetMapping("/profile/{username}")
    public ModelAndView showProfile(@PathVariable("username") String username,@RequestParam(name="succes",required = false) Boolean succes,Principal principal){ 
        ModelAndView result = new ModelAndView("perfil/profile");
        String authority = authoritiesService.findByUsername(principal.getName()).getAuthority();
        if(principal==null || principal.getName()==null || principal.getName().equals("")){
            result = new ModelAndView("redirect:/login");
            return result;
        }else if(!authority.equals("admin") && !principal.getName().equals(username)){
            result = new ModelAndView("redirect:/");
            return result;
        }
        Usuario u = UsuarioService.findUsuarioByUsernameUsuario(username);
        result.addObject("usuario", u);
        result.addObject("principal", principal);
        if(succes!=null && succes){
            result.addObject("succes", true);
        }
        return result;
    }    

    @GetMapping("/edit")
    public ModelAndView editProfile(Principal principal){
        if(principal==null){
            ModelAndView result = new ModelAndView("redirect:/login");
            return result;
        }
        ModelAndView result = new ModelAndView("perfil/edit");
        Usuario u = UsuarioService.findUsuarioByUsernameUsuario(principal.getName());
        result.addObject("usuario", u);
        return result;
    }

    @PostMapping("/edit")
    public ModelAndView saveEditProfile(Usuario u, Principal principal){
        Usuario usuario = UsuarioService.findUsuarioByUsernameUsuario(principal.getName());
        usuario.setNombreUsuario(u.getNombreUsuario());
        usuario.setCorreo(u.getCorreo());
        List<String> errors = this.UsuarioService.editUsuarioErrors(usuario);
        if(!errors.isEmpty()){
            ModelAndView result = new ModelAndView("perfil/edit");
            result.addObject("errors", errors);
            return result;
        }
        UsuarioService.save(usuario);
        ModelAndView result =new ModelAndView("redirect:/perfil/profile/"+principal.getName());
        result.addObject("succes",true);
        return result;
    }

    @GetMapping("/changePassword")
    public ModelAndView changePassword(Principal principal){
        if(principal==null){
            ModelAndView result = new ModelAndView("redirect:/login");
            return result;
        }
        ModelAndView result = new ModelAndView("perfil/changePassword");
        Usuario u = UsuarioService.findUsuarioByUsernameUsuario(principal.getName());
        result.addObject("usuario", u);
        ChangePasswordForm changePasswordForm = new ChangePasswordForm();
        result.addObject("changePasswordForm", changePasswordForm);
        return result;
    }

    @PostMapping("/changePassword")
    public ModelAndView saveNewPassword(ChangePasswordForm form, Principal principal){
        Usuario usuario = UsuarioService.findUsuarioByUsernameUsuario(principal.getName());
        List<String> errors = new ArrayList<>();
        if (!passwordEncoder.matches(form.getOldPassword(), usuario.getPassword())) {
            errors.add("La contraseña antigua no es correcta");
        }
        if(form.getNewPassword().contains(" ")){
            errors.add("La contraseña no debe contener espacios en blanco");
        }
        if(form.getNewPassword().length()<4 || form.getNewPassword().length()>30){
            errors.add("La longitud de la contraseña debe tener entre 4 y 30 caracteres");
        }
        if(!errors.isEmpty()){
            ModelAndView result = new ModelAndView("perfil/changePassword");
            result.addObject("errors", errors);
            return result;
        }
        usuario.setPassword(passwordEncoder.encode(form.getNewPassword()));
        UsuarioService.save(usuario);
        ModelAndView result =new ModelAndView("redirect:/perfil/profile/"+principal.getName());
        result.addObject("succes",true);
        return result;
    }
}