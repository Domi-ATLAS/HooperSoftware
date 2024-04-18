package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.EstadisticasEntrenador;
import HooperSoftware.TFG.repositorio.EstadisticasEntrenadorRepository;

@Service
public class EstadisticasEntrenadorService {
    
    EstadisticasEntrenadorRepository repository;

    EstadisticasEntrenadorService(EstadisticasEntrenadorRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public EstadisticasEntrenador findEstadisticasEntrenadorById(Integer idEstadisticasEntrenador){
        return repository.findEstadisticasEntrenadorById(idEstadisticasEntrenador);
    }

    @Transactional(readOnly = true)
    public List<EstadisticasEntrenador> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public EstadisticasEntrenador save (EstadisticasEntrenador estadisticasEntrenador){
        return repository.save(estadisticasEntrenador);
    }

    @Transactional
    public void deleteEstadisticasEntrenador(Integer id){
        repository.deleteById(id);
    }
    
    
}
