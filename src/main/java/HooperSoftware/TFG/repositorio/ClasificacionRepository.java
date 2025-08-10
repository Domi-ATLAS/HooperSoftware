package HooperSoftware.TFG.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import HooperSoftware.TFG.entidad.Clasificacion;

@Repository
public interface  ClasificacionRepository extends CrudRepository<Clasificacion, String>{

    @Query("SELECT c FROM Clasificacion c WHERE c.temporada = ?1")
    Clasificacion findClasificacionByTemporada(String temporada);

    @Query("SELECT c FROM Clasificacion c")
    List<Clasificacion> findAll();
    
}
