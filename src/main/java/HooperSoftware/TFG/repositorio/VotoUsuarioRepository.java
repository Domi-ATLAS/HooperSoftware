package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import HooperSoftware.TFG.entidad.VotoUsuario;

public interface VotoUsuarioRepository
        extends CrudRepository<VotoUsuario, Integer> {

    @Query("""
           SELECT v
           FROM VotoUsuario v
           WHERE v.username = ?1
           AND v.idVotacion = ?2
           """)
    VotoUsuario findVotoUsuario(
            String username,
            Integer idVotacion);

    @Query("""
        SELECT v.opcionElegida, COUNT(v)
        FROM VotoUsuario v
        WHERE v.idVotacion = ?1
        GROUP BY v.opcionElegida
        """)
    List<Object[]> contarVotosPorOpcion(Integer idVotacion);

    List<VotoUsuario> findByUsername(String username);
}
