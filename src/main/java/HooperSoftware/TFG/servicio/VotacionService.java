package HooperSoftware.TFG.servicio;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import HooperSoftware.TFG.entidad.Votacion;
import HooperSoftware.TFG.repositorio.VotacionRepository;

@Service
public class VotacionService {

    VotacionRepository repository;

    VotacionService(VotacionRepository repo){
        this.repository = repo;
    }

    @Transactional(readOnly = true)
    public Votacion findVotacionById(Integer idVotacion){
        return repository.findVotacionById(idVotacion);
    }

    @Transactional(readOnly = true)
    public List<Votacion> findAll(){
        return repository.findAll();
    }

    @Transactional(readOnly = true)
    public Votacion save (Votacion votacion){
        return repository.save(votacion);
    }

    @Transactional
    public void deleteVotacion(Integer id){
        repository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<Votacion> findVotacionesEnCurso(){
        return repository.findVotacionesEnCurso();
    }

    @Transactional(readOnly = true)
    public List<Votacion> findVotacionesOficiales(){
        return repository.findVotacionesOficiales();
    }
    
}
