package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.EstadisticasEntrenador;

@Repository
public interface EstadisticasEntrenadorRepository extends CrudRepository<EstadisticasEntrenador,Integer>{
    
    List<EstadisticasEntrenador> findAll();

}
