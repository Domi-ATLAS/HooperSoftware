package HooperSoftware.TFG.servicio;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Clasificacion;
import HooperSoftware.TFG.repositorio.ClasificacionRepository;


@Service
public class ClasificacionService{

    ClasificacionRepository repository;

    ClasificacionService(ClasificacionRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public Clasificacion findClasificacionByTemporada(String temporada){
        return repository.findClasificacionByTemporada(temporada);
    }
    
}
