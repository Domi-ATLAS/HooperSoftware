package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Temporada;
import HooperSoftware.TFG.repositorio.TemporadaRepository;

@Service
public class TemporadaService {
    
    TemporadaRepository repository;

    TemporadaService(TemporadaRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Temporada> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Temporada findTemporadaById(Integer idTemporada){
        return repository.findTemporadaById(idTemporada);
    }

}
