package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Usuario;

@Repository
public interface UsuarioRepository extends CrudRepository<Usuario,String>{
    
    List<Usuario> findAll();

}
