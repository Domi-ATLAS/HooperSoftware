package HooperSoftware.TFG.repositorio;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Authorities;



@Repository
public interface AuthoritiesRepository extends CrudRepository<Authorities, Integer>{
    
    @Query("SELECT MAX(a.id) FROM Authorities a")
    Integer findMaxId();

    @Query("SELECT a FROM Authorities a WHERE a.usuario.username = ?1")
    Authorities findByUsername(String nickName);

}