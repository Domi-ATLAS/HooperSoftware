package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Entrenador;

@Repository
public interface EntrenadorRepository extends CrudRepository<Entrenador,Integer>{
    
    List<Entrenador> findAll();

}
