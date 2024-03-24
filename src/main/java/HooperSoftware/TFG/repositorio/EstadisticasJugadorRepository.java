package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.EstadisticasJugador;

@Repository
public interface EstadisticasJugadorRepository extends CrudRepository<EstadisticasJugador,Integer> {
    
    List<EstadisticasJugador> findAll();

}
