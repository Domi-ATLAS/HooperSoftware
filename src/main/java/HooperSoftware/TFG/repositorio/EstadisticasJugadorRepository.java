package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.EstadisticasJugador;

@Repository
public interface EstadisticasJugadorRepository extends CrudRepository<EstadisticasJugador,Integer> {
    
    @Query("SELECT e FROM EstadisticasJugador e")
    List<EstadisticasJugador> findAll();

    @Query("SELECT e FROM EstadisticasJugador e WHERE e.idEstJugador = ?1")
    EstadisticasJugador findEstadisticasJugadorById(Integer idEstadisticasJugador);

}
