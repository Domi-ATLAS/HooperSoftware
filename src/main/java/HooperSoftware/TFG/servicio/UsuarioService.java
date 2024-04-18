package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

}
