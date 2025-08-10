package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Temporada;


@Repository
public interface TemporadaRepository extends CrudRepository<Temporada,Integer>{

    @Query("SELECT t FROM Temporada t")
    List<Temporada> findAll();

    @Query("SELECT t FROM Temporada t WHERE t.idTemporada = ?1")
    Temporada findTemporadaById(Integer idTemporada);
    
    @Query("SELECT DISTINCT t FROM Temporada t JOIN t.jornadas j JOIN j.partidos p WHERE p.equipoLocalTa.id = :teamId OR p.equipoVisitanteTa.id = :teamId")
    List<Temporada> findTemporadasByTeam(@Param("teamId") Integer teamId);
}
