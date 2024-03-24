package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Votacion;

@Repository
public interface VotacionRepository extends CrudRepository<Votacion,Integer>{
    
    List<Votacion> findAll();

}
