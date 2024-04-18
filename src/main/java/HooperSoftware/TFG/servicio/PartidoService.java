package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Partido;
import HooperSoftware.TFG.repositorio.PartidoRepository;

@Service
public class PartidoService {

    PartidoRepository  repository;

    PartidoService(PartidoRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public List<Partido> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Partido findPartidoById(Integer idPartido){
        return repository.findPartidoById(idPartido);
    }
    
    @Transactional(readOnly = true)
    public Partido save (Partido partido){
        return repository.save(partido);
    }

    @Transactional
    public void deletePartido(Integer id){
        repository.deleteById(id);
    }
    
}
