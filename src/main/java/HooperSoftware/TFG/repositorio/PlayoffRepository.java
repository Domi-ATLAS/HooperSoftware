package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Playoff;

@Repository
public interface PlayoffRepository extends CrudRepository<Playoff,Integer>{
    
    List<Playoff> findAll();

}
