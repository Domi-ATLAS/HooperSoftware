package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Equipo;

@Repository
public interface EquipoRepository extends CrudRepository<Equipo,Integer>{
    
    List<Equipo> findAll();

}
