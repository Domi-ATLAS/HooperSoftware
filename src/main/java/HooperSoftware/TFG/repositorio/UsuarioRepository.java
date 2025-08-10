package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
    Usuario findUsuarioByUsername(String username);

    @Query("SELECT u FROM Usuario u WHERE u.correo = ?1")
    Usuario findUsuarioByCorreo(String correo);

    @Query("select u from Usuario u")
    Page<Usuario> findAllByPage(PageRequest of);

    @Query("SELECT u FROM Usuario u WHERE u.username LIKE %?1%")
    Page<Usuario> findUsuariosByUsernameAndPage(String name, PageRequest of);

}