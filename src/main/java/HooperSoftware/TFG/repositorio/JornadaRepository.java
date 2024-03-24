package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Jornada;

@Repository
public interface JornadaRepository extends CrudRepository<Jornada,Integer>{
    
    List<Jornada> findAll();

}
