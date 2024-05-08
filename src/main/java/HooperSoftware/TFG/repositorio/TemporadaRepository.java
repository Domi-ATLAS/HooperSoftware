package HooperSoftware.TFG.repositorio;

import org.springframework.stereotype.Repository;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import HooperSoftware.TFG.entidad.Temporada;


@Repository
public interface TemporadaRepository extends CrudRepository<Temporada,Integer>{

    @Query("SELECT t FROM Temporada t")
    List<Temporada> findAll();

    @Query("SELECT t FROM Temporada t WHERE t.idTemporada = ?1")
    Temporada findTemporadaById(Integer idTemporada);
    
}
