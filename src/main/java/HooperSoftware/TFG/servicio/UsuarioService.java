package HooperSoftware.TFG.servicio;

import java.util.ArrayList;
import java.util.List;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import org.springframework.data.domain.Page;
import HooperSoftware.TFG.entidad.Usuario;
import HooperSoftware.TFG.repositorio.UsuarioRepository;

@Service
public class UsuarioService {

    UsuarioRepository repository;

    UsuarioService(UsuarioRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public Usuario findUsuarioByNombreUsuario(String nombreUsuario){
        return repository.findUsuarioByNombreUsuario(nombreUsuario);
    }


    @Transactional(readOnly = true)
    public Usuario findUsuarioByUsernameUsuario(String username){
        return repository.findUsuarioByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<Usuario> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Usuario save(Usuario usuario){
        return repository.save(usuario);
    }
    
    @Transactional
    public void deleteUsuario(String nombre){
        repository.deleteById(nombre);
    }

    @Transactional
    public void deleteUsuario(Usuario u){
        repository.delete(u);
    }

    public List<String> checkUsuarioRestrictions(Usuario u){
        List<String> errors = new ArrayList<String>();
        String pattern = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern2 = Pattern.compile(pattern);
        if(u.getUsername().contains(" ")){
            errors.add("El nombre de usuario no debe contener espacios en blanco");
        }
        if(u.getPassword().contains(" ")){
            errors.add("La contraseña no debe contener espacios en blanco");
        }
        if(exists(u.getUsername())){
            errors.add("Ya existe un usuario con ese nombre");
        }
        if(u.getUsername().contains("/")){
            errors.add("El nombre de usuario no debe contener el caracter /");
        }
        if(u.getUsername().length()<5 || u.getUsername().length()>30){
            errors.add("La longitud del nombre de usuario debe tener entre 5 y 30 caracteres");
        }
        if(u.getPassword().length()<4 || u.getPassword().length()>30){
            errors.add("La longitud de la contraseña debe tener entre 4 y 30 caracteres");
        }
        if(u.getNombreUsuario() ==null){
            errors.add("El nombre no puede estar vacío");
        }else{
            if(u.getNombreUsuario().length()<3 || u.getNombreUsuario().length()>30){
                errors.add("La longitud del nombre debe tener entre 3 y 30 caracteres");
            }
        }
        if(u.getCorreo()==null){
            errors.add("El correo no puede estar vacío");
        }else{
            Matcher matcher = pattern2.matcher(u.getCorreo());
            if(matcher.matches()==false){
                errors.add("El correo no es válido");
            }
            if (u.getCorreo().length()>50){
            errors.add("La longitud del correo debe tener menos de 50 caracteres"); 
            }
            if(findByMail(u.getCorreo())!=null){
                errors.add("Ya existe un usuario con ese correo");
            }
        }
        return errors;
    }

    @Transactional(readOnly = true)
    public boolean exists(String username) {
        return this.repository.existsById(username);
    }

    private Usuario findByMail(String correo) {
        return repository.findUsuarioByCorreo(correo);
    }


    public List<String> editUsuarioErrors(Usuario u){
        List<String> errors = new ArrayList<String>();
        String pattern = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern2 = Pattern.compile(pattern);
        if(u.getNombreUsuario() ==null){
            errors.add("El nombre no puede estar vacío");
        }else{
            if(u.getNombreUsuario().length()<3 || u.getNombreUsuario().length()>30){
                errors.add("La longitud del nombre debe tener entre 3 y 30 caracteres");
            }
        }
        if(u.getCorreo()==null){
            errors.add("El correo no puede estar vacío");
        }else{
            Matcher matcher = pattern2.matcher(u.getCorreo());
            if(matcher.matches()==false){
                errors.add("El correo no es válido");
            }
            if (u.getCorreo().length()>50){
            errors.add("La longitud del correo debe tener menos de 50 caracteres"); 
            }
            if(findByMail(u.getCorreo())!=null && findByMail(u.getCorreo()).getUsername()!=u.getUsername()){
                errors.add("Ya existe un usuario con ese correo");
            }
        }
        return errors;
    }


    public Page<Usuario> getAllAuthoritiesPageable(PageRequest of) {
        return this.repository.findAllByPage(of);
    }

    public Page<Usuario> getUsuarioByUsername(String name, PageRequest of) {
        return this.repository.findUsuariosByUsernameAndPage(name, of);
    }

}
