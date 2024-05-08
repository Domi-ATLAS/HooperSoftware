package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Votacion;

@Repository
public interface VotacionRepository extends CrudRepository<Votacion,Integer>{
    
    @Query("SELECT v FROM Votacion v")
    List<Votacion> findAll();

    @Query("SELECT v FROM Votacion v WHERE v.idVotacion = ?1")
    Votacion findVotacionById(Integer idVotacion);

    @Query("SELECT v FROM Votacion v WHERE v.enCurso = true")
    List<Votacion> findVotacionesEnCurso();

    @Query("SELECT v FROM Votacion v WHERE v.oficial = true")
    List<Votacion> findVotacionesOficiales();
}