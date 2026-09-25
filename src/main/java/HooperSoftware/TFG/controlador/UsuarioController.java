package HooperSoftware.TFG.controlador;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import java.nio.file.Path;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import HooperSoftware.TFG.components.ChangePasswordForm;
import HooperSoftware.TFG.entidad.Authorities;
import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.entidad.VotoUsuario;
import HooperSoftware.TFG.servicio.AuthoritiesService;
import HooperSoftware.TFG.servicio.EquipoService;
import HooperSoftware.TFG.servicio.UsuarioService;
import HooperSoftware.TFG.servicio.VotoUsuarioService;

@Controller
public class UsuarioController {

    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    UsuarioService UsuarioService;

    AuthoritiesService authoritiesService;

    EquipoService equipoService;

    VotoUsuarioService votoUsuarioService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        binder.registerCustomEditor(LocalDate.class, new CustomDateEditor(dateFormat, true));
    }

    public UsuarioController(UsuarioService UsuarioService, AuthoritiesService authoritiesService, EquipoService equipoService, VotoUsuarioService votoUsuarioService) {
        this.UsuarioService = UsuarioService;
        this.authoritiesService = authoritiesService;
        this.equipoService = equipoService;
        this.votoUsuarioService = votoUsuarioService;
    }

    @GetMapping("/new")
    public ModelAndView createUsuario() {
        Usuario u = new Usuario();
        ModelAndView result = new ModelAndView("perfil/createUsuario");
        result.addObject("usuario", u);
        result.addObject(
                "equipos",
                equipoService.findAll());
        return result;
    }

    @PostMapping("/new")
    public ModelAndView saveNewUsuario(
            Usuario u,
            @RequestParam(name = "avatar", required = false) MultipartFile avatar) {

        u.setEnabled(true);
        u.setPassword(passwordEncoder.encode(u.getPassword()));
        u.setFechaRegistro(LocalDate.now());

        u.setVotosEmitidos(0);

        u.setMensajesEnviados(0);

        if (avatar != null && !avatar.isEmpty()) {
            u.setFoto(saveAvatarFile(u.getUsername(), avatar));
        }

        UsuarioService.save(u);

        Authorities a = new Authorities();
        a.setAuthority("user");
        a.setUsuario(u);
        a.setId(this.authoritiesService.findMaxId() + 1);

        authoritiesService.save(a);

        return new ModelAndView(
                "redirect:/login?registered=true&username="
                + u.getUsername());
    }

    @GetMapping("/profile")
    public ModelAndView redirectProfile(String username, Principal principal) {
        if (principal == null || principal.getName() == null || principal.getName().equals("")) {
            return new ModelAndView("redirect:/login");
        }
        return new ModelAndView("redirect:/profile/" + principal.getName());
    }

    @GetMapping("/profile/{username}")
    public ModelAndView showProfile(@PathVariable("username") String username, @RequestParam(name = "succes", required = false) Boolean succes, Principal principal) {
        if (principal == null || principal.getName() == null || principal.getName().equals("")) {
            return new ModelAndView("redirect:/login");
        }

        ModelAndView result = new ModelAndView("perfil/profile");
        String authority = authoritiesService.findByUsername(principal.getName()).getAuthority();
        if (!authority.equals("admin") && !principal.getName().equals(username)) {
            return new ModelAndView("redirect:/");
        }
        Usuario u = UsuarioService.findUsuarioByUsernameUsuario(username);
        result.addObject("usuario", u);
        result.addObject("principal", principal);
        result.addObject("authority", authority);
        if (succes != null && succes) {
            result.addObject("succes", true);
        }
        List<VotoUsuario> votos
                = votoUsuarioService.findByUsername(username);

        result.addObject("votos", votos);
        return result;
    }

    @GetMapping("/edit")
    public ModelAndView editProfile(Principal principal) {

        if (principal == null) {
            return new ModelAndView("redirect:/login");
        }

        ModelAndView result
                = new ModelAndView("perfil/edit");

        Usuario u
                = UsuarioService.findUsuarioByUsernameUsuario(
                        principal.getName());

        result.addObject("usuario", u);

        result.addObject(
                "equipos",
                equipoService.findAll());

        return result;
    }

    @PostMapping("/edit")
    public ModelAndView saveEditProfile(
            Usuario u,
            @RequestParam("avatar") MultipartFile avatar,
            Principal principal) {

        Usuario usuario
                = UsuarioService.findUsuarioByUsernameUsuario(
                        principal.getName());

        usuario.setNombreUsuario(
                u.getNombreUsuario());

        usuario.setCorreo(
                u.getCorreo());

        usuario.setNumeroTelefono(
                u.getNumeroTelefono());

        usuario.setEquipoFavorito(
                u.getEquipoFavorito());

        if (!avatar.isEmpty()) {
            usuario.setFoto(saveAvatarFile(principal.getName(), avatar));
        }

        UsuarioService.save(usuario);

        return new ModelAndView(
                "redirect:/profile/" + principal.getName());
    }

    private String saveAvatarFile(String username, MultipartFile avatar) {
        try {
            String originalName = avatar.getOriginalFilename();
            String extension = originalName != null && originalName.contains(".")
                    ? originalName.substring(originalName.lastIndexOf(".")).toLowerCase(Locale.ROOT)
                    : "";
            Set<String> allowedExtensions = Set.of(".png", ".jpg", ".jpeg", ".webp");

            if (!allowedExtensions.contains(extension)) {
                throw new IllegalArgumentException("Formato de imagen no permitido");
            }

            String safeUsername = username.replaceAll("[^a-zA-Z0-9_-]", "_");
            String fileName = safeUsername + extension;
            Path sourcePath = Paths.get("src/main/resources/static/uploads/avatars", fileName);
            Path runtimePath = Paths.get("target/classes/static/uploads/avatars", fileName);

            Files.createDirectories(sourcePath.getParent());
            Files.copy(avatar.getInputStream(), sourcePath, StandardCopyOption.REPLACE_EXISTING);

            Files.createDirectories(runtimePath.getParent());
            Files.copy(sourcePath, runtimePath, StandardCopyOption.REPLACE_EXISTING);

            return fileName;
        } catch (Exception e) {
            throw new IllegalArgumentException("No se pudo guardar la foto de perfil", e);
        }
    }

    @GetMapping("/changePassword")
    public ModelAndView changePassword(Principal principal) {
        if (principal == null) {
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
    public ModelAndView saveNewPassword(ChangePasswordForm form, Principal principal) {
        Usuario usuario = UsuarioService.findUsuarioByUsernameUsuario(principal.getName());
        List<String> errors = new ArrayList<>();
        if (!passwordEncoder.matches(form.getOldPassword(), usuario.getPassword())) {
            errors.add("La contraseña antigua no es correcta");
        }
        if (form.getNewPassword().contains(" ")) {
            errors.add("La contraseña no debe contener espacios en blanco");
        }
        if (form.getNewPassword().length() < 4 || form.getNewPassword().length() > 30) {
            errors.add("La longitud de la contraseña debe tener entre 4 y 30 caracteres");
        }
        if (!errors.isEmpty()) {
            ModelAndView result = new ModelAndView("perfil/changePassword");
            result.addObject("errors", errors);
            return result;
        }
        usuario.setPassword(passwordEncoder.encode(form.getNewPassword()));
        UsuarioService.save(usuario);
        ModelAndView result = new ModelAndView("redirect:/profile/" + principal.getName());
        result.addObject("succes", true);
        return result;
    }
}
