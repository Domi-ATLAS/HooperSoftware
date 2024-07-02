package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Usuario;

@Repository
public interface UsuarioRepository extends CrudRepository<Usuario,String>{
    
    @Query("SELECT u FROM Usuario u")
    List<Usuario> findAll();

    @Query("SELECT u FROM Usuario u WHERE u.nombreUsuario = ?1")
    Usuario findUsuarioByNombreUsuario(String nombreUsuario);

    @Query("SELECT u FROM Usuario u WHERE u.username = ?1")
    Usuario findUsuarioByNickName(String username);

}
