package HooperSoftware.TFG.servicio;


import java.util.List;

import org.springframework.stereotype.Service;

import HooperSoftware.TFG.entidad.Entrenador;
import HooperSoftware.TFG.repositorio.EntrenadorRepository;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EntrenadorService {


    EntrenadorRepository repository;

    EntrenadorService(EntrenadorRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Entrenador> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Entrenador findEntrById(Integer idEntrenador){
        return repository.findEntrById(idEntrenador);
    }

    @Transactional(readOnly = true)
    public Entrenador save (Entrenador entrenador){
        return repository.save(entrenador);
    }

    @Transactional
    public void deleteEntrenador(Integer id){
        repository.deleteById(id);
    }
    
}
