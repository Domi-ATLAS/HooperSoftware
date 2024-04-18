package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.EstadisticasJugador;
import HooperSoftware.TFG.repositorio.EstadisticasJugadorRepository;

@Service
public class EstadisticasJugadorService {
    
    EstadisticasJugadorRepository repository;

    EstadisticasJugadorService(EstadisticasJugadorRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public EstadisticasJugador findEstadisticasJugadorById(Integer idEstadisticasJugador){
        return repository.findEstadisticasJugadorById(idEstadisticasJugador);
    }
    
    @Transactional(readOnly = true)
    public List<EstadisticasJugador> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public EstadisticasJugador save (EstadisticasJugador estadisticasJugador){
        return repository.save(estadisticasJugador);
    }

    @Transactional
    public void deleteEstadisticasJugador(Integer id){
        repository.deleteById(id);
    }
}
