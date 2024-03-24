package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Partido;

@Repository
public interface PartidoRepository extends CrudRepository<Partido,Integer> {

    List<Partido> findAll();
    
}
