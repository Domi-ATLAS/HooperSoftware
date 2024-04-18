package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Playoff;

@Repository
public interface PlayoffRepository extends CrudRepository<Playoff,Integer>{
    
    @Query("SELECT p FROM Playoff p")  
    List<Playoff> findAll();

    @Query("SELECT p FROM Playoff p WHERE p.idPlayOff = ?1")
    Playoff findPlayOffById(Integer idPlayOff);

    @Query("SELECT p FROM Playoff p WHERE p.temporada = ?1")
    List<Playoff> findPlayOffByTemporada(String temporada);

    @Query("SELECT p FROM Playoff p WHERE p.campeonFinalNba = ?1")
    List<Playoff> findPlayOffByCampeonFinalNba(String campeonFinalNba);

    @Query("SELECT p FROM Playoff p WHERE p.campeonFinalEste = ?1")
    List<Playoff> findPlayOffByCampeonFinalEste(String campeonFinalEste);

    @Query("SELECT p FROM Playoff p WHERE p.campeonFinalOeste = ?1")
    List<Playoff> findPlayOffByCampeonFinalOeste(String campeonFinalOeste);

}
